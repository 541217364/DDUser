//
//  MyRefreshHeader.m
//  送小宝
//
//  Created by xgy on 2017/4/14.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "MyRefreshHeader.h"
#import "UIImage+GIF.h"
@implementation MyRefreshHeader


#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    self.mj_h =  IS_RETAINING_SCREEN ? 110 :90;
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
    UIView *hideV = [[UIView alloc]init];
    hideV.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:224 / 255.0 blue:254 / 235.0 alpha:1];
    self.hideView = hideV;
    
    [self addSubview:hideV];
    
    
    
    UIImageView *logo = [[UIImageView alloc] init];
    
           NSString *path = [[NSBundle mainBundle] pathForResource:@"浮动云背景" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_animatedGIFWithData:data];

          logo.image = image;
            
        
 
 
    logo.contentMode = UIViewContentModeScaleAspectFit;
    self.logo = logo;
    [self.hideView addSubview:logo];
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 140));
    }];
    
    UIImageView *rider = [[UIImageView alloc] init];
    NSString *riderpath = [[NSBundle mainBundle] pathForResource:@"骑车动画" ofType:@"gif"];
    NSData *riderdata = [NSData dataWithContentsOfFile:riderpath];
    UIImage *riderimage = [UIImage sd_animatedGIFWithData:riderdata];
    rider.image = riderimage;
    
    rider.contentMode = UIViewContentModeScaleAspectFit;
    self.rider = rider;
    [logo addSubview:rider];
    
    [rider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    
    
//    // 设置正在刷新状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=90; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sy%zd", i]];
//            [idleImages addObject:image];
//
//        
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
//    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=90; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sy%zd", i]];
//            [refreshingImages addObject:image];
//
//        
//    }
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    //[self setImages:refreshingImages forState:MJRefreshStateRefreshing];
//    
//   [self setImages:refreshingImages duration:2 forState:MJRefreshStateRefreshing];
//    [self setTitle:@"亲,没有更多数据了哦～" forState:MJRefreshStateNoMoreData];
////
//    [self setTitle:@"正在加载中.." forState:MJRefreshStateRefreshing];
//
//    [self setTitle:@" " forState:MJRefreshStateIdle];
//
//
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}

-(void)placeSubviews{
    [super placeSubviews];
    
    self.hideView.bounds = CGRectMake(0, 0, self.bounds.size.width, 600);
    
    CGFloat height = IS_RETAINING_SCREEN ? -160 : -180;
    
    self.hideView.center = CGPointMake(self.mj_w * 0.5, height);


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
