//
//  XQTrackData.h
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/6.
//  Copyright © 2018年 小强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XQTrackModel.h"

@interface XQTrackData : NSObject
+ (instancetype)sharedInstance;
- (void)refreshPath;

/**
 *  插入一条数据
 */
- (BOOL)queryTrackModel:(XQTrackModel *)trackModel;

/**
 *  返回当前所有数据
 */
- (NSArray *)trackModels;

/**
 *  删除当前之前的数据
 */
- (BOOL)deleteTrack;

@end
