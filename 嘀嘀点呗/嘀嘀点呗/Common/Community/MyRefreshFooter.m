//
//  MyRefreshFooter.m
//  送小宝
//
//  Created by xgy on 2017/4/14.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "MyRefreshFooter.h"

@implementation MyRefreshFooter

#pragma mark - 重写方法
#pragma mark 基本设置
#pragma mark - 重写方法
#pragma mark 基本设置

- (void)prepare
{
    [super prepare];
    

//    // 设置正在刷新状态的动画图片
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//
//    for (NSUInteger i = 1; i<=40; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"shouye%lu.png",(unsigned long)i]];
//        [refreshingImages addObject:image];
//    }
//
//    [self setImages:refreshingImages duration:5 forState:MJRefreshStateRefreshing];
    [self setTitle:@"亲,没有更多数据了哦～" forState:MJRefreshStateNoMoreData];

    //[self setTitle:@"正在加载中.." forState:MJRefreshStateRefreshing];

//    [self setTitle:@" " forState:MJRefreshStateIdle];
//
//
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
