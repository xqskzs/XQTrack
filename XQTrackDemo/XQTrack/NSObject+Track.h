//
//  NSObject+Track.h
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/5.
//  Copyright © 2018年 小强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Track)

@property(nonatomic,assign)BOOL isNeedTrack;//给view设置此属性时，它的所有子类也会被设置，可以参考UIView+Track分类

@property(nonatomic,copy)NSString * trackMessage;//用来描述被追踪的对象的信息，以便记录到数据库好识别用户进入或者操作哪个页面做了什么（这里默认存入了对象的类名）

//查看对象的属性和方法名(不包含类的，仅供开发者统一浏览）
-(NSDictionary *)ivarList;
-(NSDictionary *)propertyList;
-(NSDictionary *)methodList;
@end
