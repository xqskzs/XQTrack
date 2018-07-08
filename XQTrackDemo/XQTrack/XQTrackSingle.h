//
//  XQTrackSingle.h
//  PlusEV
//
//  Created by 小强 on 2018/7/5.
//  Copyright © 2018年 小强. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MutableBlock)(id obj, ...);
@interface XQTrackSingle : NSObject

@property(nonatomic,strong)UIView * eventView;

@property(nonatomic,strong)MutableBlock uploadDataBlock;//将跟踪记录传到服务器，传完成功删除当前存在的记录，实现在这个block中，如果可变参数block不会用，前面有示范，实在不行换成你定制的block。

+ (instancetype)shareInstance;

@end
