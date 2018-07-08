//
//  XQTrackHandle.h
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/4.
//  Copyright © 2018年 小强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XQTrackHandle : NSObject

+ (NSString *)getPhoneIdentifier;

+ (void)printSortAllKeys:(NSDictionary *)dic message:(NSString *)message;

+ (NSString *)strDate:(NSDate *)date;

+ (void)savaData:(NSObject *)object message:(NSString *)msg;

+ (CGSize)sizeWithStr:(NSString *)str withMaxWidth:(CGFloat)maxWidth withFont:(CGFloat)fontSize;
@end
