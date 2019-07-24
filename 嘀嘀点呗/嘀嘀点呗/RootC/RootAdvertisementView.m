//
//  RootAdvertisementView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "RootAdvertisementView.h"

#import "PersonalWebController.h"

// 广告显示的时间
static int const showtime = 4;

@implementation RootAdvertisementView


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
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.myimageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        self.myimageView.hidden = YES;
        
        [self addSubview:self.myimageView];
        
        self.mymovieView = [[UIView alloc]initWithFrame:self.bounds];
        
        self.mymovieView.hidden = YES;
        
        [self addSubview:self.mymovieView];
        
        UIButton *contBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        contBtn.frame = CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100);
        
        [contBtn addTarget:self action:@selector(gotoWeb:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:contBtn];
        
        
        
        
        
        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        self.returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW - 24, btnH, btnW, btnH)];
        [_returnBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_returnBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _returnBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _returnBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _returnBtn.layer.cornerRadius = 4;
        
        [self addSubview:self.returnBtn];
        
    }
    return self;
}





- (void)show
{
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    
    if (self.model == nil) {
        
        return;
    }
    
    if ([self.model.type isEqualToString:@"2"]) {
        //播放视频
        
        self.myimageView.hidden = YES;
        
        self.mymovieView.hidden = NO;
        
        self.returnBtn.hidden = YES;
        
        [self playWithVideolink:self.filePath];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        [self startTimer];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ANIMATIONDURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.returnBtn.hidden = NO;
            
        });
        
        
        
        
    }
    
    if ([self.model.type isEqualToString:@"1"]) {
        
        //广告图
        
        self.myimageView.hidden = NO;
        
        self.mymovieView.hidden = YES;
        
        self.returnBtn.hidden = NO;
        
        
        self.myimageView.image =[UIImage imageWithContentsOfFile:self.filePath];
        
        
        [self startTimer];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        
    }
    
    
}

// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}




-(void)playWithVideolink:(NSString *)videolink{
    
    
    //2.文件的url
    NSURL * url = [NSURL fileURLWithPath:videolink];
    
    //3.根据url创建播放器(player本身不能显示视频)
    AVPlayer * player = [AVPlayer playerWithURL:url];
    
    //4.根据播放器创建一个视图播放的图层
    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    layer.videoGravity = AVLayerVideoGravityResize;
    
    //5.设置图层的大小
    layer.frame = self.bounds;
    
    //6.添加到控制器的view的图层上面
    [self.mymovieView.layer addSublayer:layer];
    
    //7.开始播放
    [player play];
    
}


- (void)countDown
{
    _count --;
    [_returnBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    
    if (_count == 0) {
        
        [self dismiss];
    }
}




// 移除广告页面
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}



- (AVPlayerItem *)createPlayerItemWithURL:(NSString *)url {
    //创建视频管理对象
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    return playerItem;
}



-(void)gotoWeb:(UIButton *)sender{
    
    if (self.model.adver_link.length > 0) {
        
        [self dismiss];
        
        PersonalWebController *webvc=[[PersonalWebController alloc]init];
        webvc.weburl= self.model.adver_link;
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
        
        [APP_Delegate.rootViewController.viewControllers[APP_Delegate.rootViewController.selectedIndex] pushViewController:webvc animated:YES];
    }
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
