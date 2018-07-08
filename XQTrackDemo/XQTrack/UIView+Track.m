//
//  UIView+Track.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/4.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "UIView+Track.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "XQTrackSingle.h"
#import "XQTrackData.h"

@implementation UIView (Track)

+ (void)load {
    Method m1 = class_getInstanceMethod([UIView class], @selector(xq_hitTest:withEvent:));
    Method m2 = class_getInstanceMethod([UIView class], @selector(hitTest:withEvent:));
    
    method_exchangeImplementations(m1, m2);
}

- (UIView *)xq_hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView * v = [self xq_hitTest:point withEvent:event];
    
    if(v && v.isNeedTrack)
    {
        if([XQTrackSingle shareInstance].eventView != v)
        {
            [XQTrackSingle shareInstance].eventView = v;
//            NSLog(@"++++++++++++++++%@",[v class]);
            [self saveEvent];
        }
    }
    return v;
}

static const char XQEventViewKey = '\0';
- (void)setEventView:(UIView *)eventView
{
    objc_setAssociatedObject(self, &XQEventViewKey,
                             eventView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)eventView
{
    return objc_getAssociatedObject(self, &XQEventViewKey);
}

- (void)setIsNeedTrack:(BOOL)isNeedTrack
{
    if(self.userInteractionEnabled && !self.hidden && self.alpha > 0.1)
    {
        [super setIsNeedTrack:isNeedTrack];
        for (UIView * v in self.subviews) {
            if(v.userInteractionEnabled && !v.hidden && v.alpha > 0.1)
            {
                [v setIsNeedTrack:isNeedTrack];
            }
        }
    }
}
//此处将用户触发的事件对应的view如果被标记isNeedTrack = YES 就会记录到数据库
- (void)saveEvent
{
    [XQTrackHandle savaData:[XQTrackSingle shareInstance].eventView message:@"操作了控件"];
}

@end
