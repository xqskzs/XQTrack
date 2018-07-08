//
//  XQTrackModel.h
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/6.
//  Copyright © 2018年 小强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQTrackModel : NSObject<NSCoding>

@property(nonatomic,copy)NSString * timeStr;

@property(nonatomic,copy)NSString * message;

@property(nonatomic,copy)NSString * className;

@end
