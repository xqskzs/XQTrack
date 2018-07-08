//
//  XQTrackModel.m
//  XQTrackDemo
//
//  Created by 小强 on 2018/7/6.
//  Copyright © 2018年 小强. All rights reserved.
//

#import "XQTrackModel.h"
@implementation XQTrackModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.timeStr forKey:@"timeStr"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.className forKey:@"className"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.timeStr = [aDecoder decodeObjectForKey:@"timeStr"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.className = [aDecoder decodeObjectForKey:@"className"];
    }
    return self;
}

@end
