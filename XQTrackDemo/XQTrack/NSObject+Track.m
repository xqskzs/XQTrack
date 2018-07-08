//
//  NSObject+Track.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/5.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "NSObject+Track.h"
#import <objc/message.h>
#import <objc/runtime.h>


@implementation NSObject (Track)
+ (void)load {
    Method m1 = class_getInstanceMethod([NSObject class], @selector(xq_init));
    Method m2 = class_getInstanceMethod([NSObject class], @selector(init));

    method_exchangeImplementations(m1, m2);
}

- (void)xq_init
{
    [self xq_init];//在这里面写代码携带信息出去很难，但是在这里打上断点，可以看到你做了什么操作之后会创建哪些对象，一目了然。或者可以放一int变量记录创建了多少个对象
}

static const char XQNeedTrackKey = '\0';
- (void)setIsNeedTrack:(BOOL)isNeedTrack
{
    objc_setAssociatedObject(self, &XQNeedTrackKey, @(isNeedTrack), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isNeedTrack
{
    return [objc_getAssociatedObject(self, &XQNeedTrackKey) boolValue];
}

static const char XQTrackMessageKey = '\0';
- (void)setTrackMessage:(NSString *)trackMessage
{
    objc_setAssociatedObject(self, &XQTrackMessageKey, trackMessage, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)trackMessage
{
    return objc_getAssociatedObject(self, &XQTrackMessageKey);
}

static long long ivarNum = 0;
-(NSDictionary *)ivarList
{
    NSMutableDictionary * ivars = [[NSMutableDictionary alloc] init];
    if([self superclass])
    {
        ivars = [NSMutableDictionary dictionaryWithDictionary:[self.superclass ivarList]];
    }
    ivarNum ++;
    [ivars setObject:@(ivarNum) forKey:[NSString stringWithFormat:@"%@ -----------------> ivarList: ",[NSString stringWithUTF8String:object_getClassName(self)]]];
    unsigned int outCount, i;
    Ivar * ivarNames = class_copyIvarList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        Ivar ivar = ivarNames[i];
        const char* char_f = ivar_getName(ivar);
        NSString * ivarName = [NSString stringWithUTF8String:char_f];
        ivarNum++;
        [ivars setObject:@(ivarNum) forKey:ivarName];
    }
    free(ivarNames);
    
    return ivars;
}

static long long proNum = 0;
-(NSDictionary *)propertyList
{
    NSMutableDictionary * props = [[NSMutableDictionary alloc] init];
    if([self superclass])
    {
        props = [NSMutableDictionary dictionaryWithDictionary:[self.superclass propertyList]];
    }
    proNum ++;
    [props setObject:@(proNum) forKey:[NSString stringWithFormat:@"%@ -----------------> propertyList: ",[NSString stringWithUTF8String:object_getClassName(self)]]];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        proNum++;
        [props setObject:@(proNum) forKey:propertyName];
    }
    free(properties);
    
    return props;
}

static long long selNum = 0;
-(NSDictionary *)methodList
{
    NSMutableDictionary * sels = [[NSMutableDictionary alloc] init];
   
    if([self superclass])
    {
        sels = [NSMutableDictionary dictionaryWithDictionary:[self.superclass methodList]];
    }
    selNum ++;

    [sels setObject:@(selNum) forKey:[NSString stringWithFormat:@"%@ -----------------> methodList: ",[NSString stringWithUTF8String:object_getClassName(self)]]];
   
    unsigned int mothCout_f =0;
    Method * mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        SEL sel = method_getName(temp_f);
        const char* name_s =sel_getName(sel);
        NSString * methodName = [NSString stringWithUTF8String:name_s];
        if(/*[self respondsToSelector:sel] && */![[methodName substringToIndex:1] isEqualToString:@"_"])//带下划线的基本都是私有方法，也有不带也是但没法判断（如果你想看可以打开，但由于方法太多，一个数组放不下，无法打印全，所以我过滤了部分私有方法 和 子类没有实现的方法）
        {
            selNum++;
            [sels setObject:@(selNum) forKey:methodName];
        }
    }
    free(mothList_f);
    
    return sels;
}

@end
