//
//  ShopGoodItemView.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsShopModel.h"
#import "StoreDataModel.h"

@protocol ShopGoodItemdelegate<NSObject>

- (void)loadshopGood:(GoodsShopModel *)model;

@end


@interface ShopGoodItemView : UIView

@property (nonatomic, strong) UIImageView *picImgView;

@property (nonatomic, strong) UILabel *goodNamelabel;

@property (nonatomic, strong) UILabel *pricelabel;

@property (nonatomic, strong) UILabel *attbrutelabel;

@property (nonatomic, strong) UIButton *minusbtn;

@property (nonatomic, strong) UIButton *plusbtn;

@property (nonatomic, strong) UILabel *numlabel;

@property (nonatomic, assign) id<ShopGoodItemdelegate> delegate;

- (void) loadStoreData:(StoreDataModel *)smodel  andGoodData:(GoodsShopModel *)gmodel;


@end
