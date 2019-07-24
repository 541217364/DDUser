//
//  BootPageView.m
//  嘀嘀侠
//
//  Created by 周启磊 on 2018/2/7.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "BootPageView.h"

@implementation BootPageView
{
    
    UIPageControl *pageControll;
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark 布局界面

-(void)designViewWithFrame:(CGRect)Frame {
    _myscrollView = [[UIScrollView alloc]init];
    _myscrollView.backgroundColor = [UIColor clearColor];
    _myscrollView.frame = CGRectMake(0, 0, Frame.size.width, Frame.size.height);
    _myscrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    _myscrollView.bounces = NO;
    _myscrollView.delegate = self;
    _myscrollView.showsVerticalScrollIndicator = NO;
    _myscrollView.showsHorizontalScrollIndicator = NO;
    _myscrollView.pagingEnabled = YES;
    [self addSubview:_myscrollView];
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
         imageView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"leadpage%d",i + 1]];
        [_myscrollView addSubview:imageView];
        if (i != 4) {
            UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftBtn.frame = CGRectMake(SCREEN_WIDTH -60, 30, 50, 50);
            leftBtn.backgroundColor = [UIColor clearColor];
            [imageView addSubview:leftBtn];
            [leftBtn addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 4) {
            UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            openBtn.frame = CGRectMake(50, SCREEN_HEIGHT -200, SCREEN_WIDTH -100, 200);
            openBtn.backgroundColor = [UIColor clearColor];
            [imageView addSubview:openBtn];
            [openBtn addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
        }
       
    }
    
    
    pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60) /2, SCREEN_HEIGHT- 60, 60, 20)];
    pageControll.pageIndicatorTintColor = [UIColor whiteColor];
    pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    [pageControll addTarget:self action:@selector(clickPageControll:) forControlEvents:UIControlEventValueChanged];
    pageControll.numberOfPages = 5;
    pageControll.currentPage = 0;
    [self addSubview:pageControll];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [pageControll setCurrentPage:scrollView.contentOffset.x / SCREEN_WIDTH];
    
}


-(void)handleClick{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ISFIRSTLOGINAPP"];
    [self removeFromSuperview];
}

-(void)clickPageControll:(UIPageControl *)pageControll{
    
    [_myscrollView setContentOffset:CGPointMake(SCREEN_WIDTH * pageControll.currentPage, 0) animated:YES];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
}

@end
