//
//  UIViewController+Track.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/4.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "UIViewController+Track.h"
#import <objc/message.h>
#import "XQTrackData.h"

@implementation UIViewController (Track)

+ (void)load {
    Method m1 = class_getInstanceMethod([UIViewController class], @selector(xq_viewDidAppear:));
    Method m2 = class_getInstanceMethod([UIViewController class], @selector(viewDidAppear:));
    
    method_exchangeImplementations(m1, m2);
    
    Method m3 = class_getInstanceMethod([UIViewController class], @selector(xq_viewWillDisappear:));
    Method m4 = class_getInstanceMethod([UIViewController class], @selector(viewWillDisappear:));
    
    method_exchangeImplementations(m3, m4);
}

- (void)xq_viewDidAppear:(BOOL)animated {

    [self xq_viewDidAppear:animated];
    // 标记一次页面访问的开始
    if(self.isNeedTrack)
        [self comein];
}

- (void)xq_viewWillDisappear:(BOOL)animated {
    [self xq_viewWillDisappear:animated];
    // 标记一次页面访问的结束
    if(self.isNeedTrack)
        [self leave];
}

- (void)comein
{
    [XQTrackHandle savaData:self message:@"进入了"];
}

- (void)leave
{
    [XQTrackHandle savaData:self message:@"离开了"];
}
@end
