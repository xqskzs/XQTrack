//
//  XQTrackSingle.m
//  PlusEV
//
//  Created by 小强 on 2018/7/5.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "XQTrackSingle.h"
static XQTrackSingle * instance = nil;
@implementation XQTrackSingle
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (instancetype)init
{
    if(self = [super init])
    {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)appDidEnterBackground
{
    if(_uploadDataBlock)
        _uploadDataBlock(nil);//可变参数block最后一个参数需要nil来作为结束
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
