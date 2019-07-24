//
//  HomeTableViewCell.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/18.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTStarView.h"
#import "ActivityEhibitionView.h"
#import "StoreModel.h"
#import "CustomCapacityView.h"


@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picimgView;

@property (nonatomic, strong) UILabel *storenamelabel;

@property (nonatomic, strong) UIImageView *tipimageView;

@property (nonatomic, strong) UILabel *salelabel;

@property (nonatomic, strong) UILabel *pricePeilabel;

@property (nonatomic, strong) UIImageView *peiTipImgview;

@property (nonatomic, strong) ActivityEhibitionView *activityEhibitintView;

@property (nonatomic, strong) UIButton *arrowBtn;

@property (nonatomic, strong) CustomCapacityView *customCapacityView;

@property (nonatomic, strong) UILabel *closelabel;

@property (nonatomic, strong) UILabel *tipNumberlabel;

@property (nonatomic, strong) UIImageView *shopTypeimageV;

- (void)setstartnum:(NSInteger )startnum;

- (void) loadcommodityPics:(NSArray *)array;

- (void)selectActivitys:(NSArray *)array;

- (void)removeActivitys;

@end
