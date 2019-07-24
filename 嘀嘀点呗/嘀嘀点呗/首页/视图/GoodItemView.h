//
//  GoodItemView.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreSeachModel.h"
#import "GoodShopManagement.h"

@interface GoodItemView : UIView

@property (nonatomic, strong) UIImageView *goodImgView;

@property (nonatomic, strong) UILabel *goodnamelabel;

@property (nonatomic, strong) UILabel *goodSalelabel;

@property (nonatomic, strong) UILabel *pricelabel;

@property (nonatomic, strong) UIButton *plusbtn;

@property (nonatomic, strong) UILabel *numlabel;

@property (nonatomic, strong) UIButton *minusbtn;

@property (nonatomic, strong) GoodItem *item;

@property (nonatomic, strong) StoreSeachModel *seachmodel;

@property (nonatomic, strong) UIButton *specbtn;

@end
