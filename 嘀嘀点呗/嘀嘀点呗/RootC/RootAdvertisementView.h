//
//  RootAdvertisementView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

#import "AdvertModel.h"

@interface RootAdvertisementView : UIView

@property(nonatomic,strong)UIImageView *myimageView;

@property(nonatomic,strong)UIView *mymovieView;

@property(nonatomic,strong)UIButton *returnBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

@property (nonatomic, retain)AVPlayerLayer *playerLayer; //提供播放层

@property (nonatomic, retain)AVPlayer *player; //存储播放器对象

@property(nonatomic,strong)AdvertModel *model;


@property(nonatomic,strong)NSString *filePath;



-(void)show;

@end
