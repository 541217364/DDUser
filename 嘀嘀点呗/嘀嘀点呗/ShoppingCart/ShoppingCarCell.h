//
//  ShoppingCarCell.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/3.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCapacityView.h"
#import "StoreDataModel.h"
#import "GoodsShopModel.h"


@interface ShoppingCarCell : UITableViewCell

@property (nonatomic, strong) StoreDataModel *model;

@property (nonatomic, strong) UILabel *storeNamelabel;

@property (nonatomic, strong) UIImageView *storePicImgView;

@property (nonatomic, strong) UIImageView *rightImgView;

@property (nonatomic, strong) UIButton *clearbtn;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *packpricelabel;

@property (nonatomic, strong) UILabel *activitylabel;

@property (nonatomic, strong) CustomCapacityView *customCapacityView;

@property (nonatomic, strong) UIButton *ordernbtn;

@property (nonatomic, strong) UILabel *totlelabel;

@property (nonatomic, strong) UILabel *titlelabel2;

@property (nonatomic, strong) NSArray *activitys;

@property (nonatomic, copy) void (^ selectclearloadlistBlock)(GoodsShopModel *model);

- (void) storeDataForPrice;

- (void)LoadStoreShoppingGoods:(NSArray *)goods;

@end
