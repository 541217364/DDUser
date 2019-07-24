//
//  TimeShowsItem.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/9/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "TimeShowsItem.h"

@interface TimeShowsItem ()

@property (nonatomic, strong) NSTimer *countTimer;

@end


@implementation TimeShowsItem

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self designView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismiss) name:@"TimeShowsItemDiss" object:nil];
    }
    return self;
}



-(void)designView{
    
    CGFloat btnWidth = 20.0f;
    CGFloat spare    = 10.0f;
    
    for (int i = 0; i < 4; i ++) {
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.layer.cornerRadius = 5.0f;
        titleLable.layer.masksToBounds = YES;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = TR_Font_Gray(14);
        titleLable.adjustsFontSizeToFitWidth = YES;
        titleLable.tag = 1000 + i;
        titleLable.text = @"00";
        titleLable.frame = CGRectMake((btnWidth + spare) * i, 0, btnWidth, btnWidth);
        titleLable.backgroundColor = [UIColor colorWithHexValue:0xFF333333 alpha:1];
        titleLable.textColor = [UIColor whiteColor];
        [self addSubview:titleLable];
        
        if (i != 3) {
            UILabel *spareLable = [[UILabel alloc]init];
            spareLable.frame = CGRectMake((btnWidth + spare) * i + btnWidth, 0, spare, btnWidth);
            spareLable.text = @":";
            spareLable.textAlignment = NSTextAlignmentCenter;
            spareLable.textColor = [UIColor blackColor];
            [self addSubview:spareLable];
        }
        
    }
    
    [self startTimer];
    
}





// 定时器倒计时
- (void)startTimer
{
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}




- (void)dismiss
{
    [self.countTimer invalidate];
     self.countTimer = nil;
    
}




-(void)countDown{
    
    for (int i = 0; i < 4; i ++) {
        UILabel *titleLable = [self viewWithTag:1000 + i];
        titleLable.text =  [NSString stringWithFormat:@"%02ld",[titleLable.text integerValue] + 1] ;
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TimeShowsItemDiss" object:nil];
}

@end
