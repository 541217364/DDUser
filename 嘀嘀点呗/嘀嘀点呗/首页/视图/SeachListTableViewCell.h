//
//  SeachListTableViewCell.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCapacityView.h"
#import "StoreSeachModel.h"


@interface SeachListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picimgView;

@property (nonatomic, strong) UILabel *storenamelabel;

@property (nonatomic, strong) UILabel *tiplabel;

@property (nonatomic, strong) UILabel *salelabel;

@property (nonatomic, strong) UILabel *pricePeilabel;

@property (nonatomic, strong) UIImageView *peiTipImgview;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *arrowBtn;

@property (nonatomic, strong) CustomCapacityView *customCapacityView;

@property (nonatomic, strong) UIButton *morebtn;

@property (nonatomic, strong) NSString *seachstr;

@property (nonatomic, strong) StoreSeachModel *model;

@property (nonatomic, strong) UILabel *closelabel;


- (void) loadsetGoodsItem:(NSArray *) goodsData  isyes:(BOOL) isyes;

@end
