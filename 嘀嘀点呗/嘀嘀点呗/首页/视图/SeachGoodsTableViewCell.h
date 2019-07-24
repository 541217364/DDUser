//
//  SeachGoodsTableViewCell.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityEhibitionView.h"
#import "CJTStarView.h"

@interface SeachGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picimgView;

@property (nonatomic, strong) UILabel *storenamelabel;

@property (nonatomic, strong) UILabel *tiplabel;

@property (nonatomic, strong) CJTStarView *starRatingView;

@property (nonatomic, strong) UILabel *salelabel;

@property (nonatomic, strong) UILabel *pricePeilabel;

@property (nonatomic, strong) UILabel *distanceMiniutslabel;

@property (nonatomic, strong) UIImageView *peiTipImgview;

@property (nonatomic, strong) ActivityEhibitionView *activityEhibitintView;

@property (nonatomic, strong) UIButton *activityBtn;

@end
