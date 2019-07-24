//
//  MyRefreshOrderHeader.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/6/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyRefreshOrderHeader.h"

@implementation MyRefreshOrderHeader

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
    // 设置正在刷新状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dingdan%zd", i]];
            [idleImages addObject:image];

    }
    [self setImages:idleImages forState:MJRefreshStateIdle];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dingdan%zd", i]];
            [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
