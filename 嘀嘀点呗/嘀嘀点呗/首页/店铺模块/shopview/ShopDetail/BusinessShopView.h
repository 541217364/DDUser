//
//  BusinessShopView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchScrollViewExtent.h"
#import "ShopBottomView.h"
#import "ShopDetailMessageView.h"
#import "ShopSearchView.h"
#import "StoreModel.h"
#import "StoreInfo.h"
#import "ShopBottomCarView.h"
#import "BusinessDetailView.h"
#import "BusinessCell.h"
#import "GoodsItemCell.h"
#import "ShopBotCarView.h"

@protocol ChangeShopViewDelegate<NSObject>


-(void)backView;

@end




@interface BusinessShopView : UIView<UIScrollViewDelegate,ScrollOfChooseDelegate,ReturnTopViewDelegate,ShopDetailMessageViewDelegate,ShopBotCarViewDelegate>

@property(nonatomic,strong)TouchScrollViewExtent *contentScroll;

@property(nonatomic,strong)UILabel *titleName;

@property(nonatomic,strong)UIView *topTitleView;

@property(nonatomic,strong)UIImageView *bacgroundimage;

@property(nonatomic,strong)UIImageView *headimage;


@property(nonatomic,strong)UILabel *namelabel;

@property(nonatomic,strong)UILabel *pinpailabel;

@property(nonatomic,strong)UILabel *zhuansonglabel;

@property(nonatomic,strong)UILabel *qisonglabel;

@property(nonatomic,strong)UILabel *julilabel;

@property(nonatomic,strong)ShopBottomView *bottomContentView;

@property (nonatomic, assign) BOOL canScroll;

@property(nonatomic,strong)ShopDetailMessageView *shopDetailView;

@property(nonatomic,assign)BOOL isShowShopDetailView; //是否打开了店铺详情界面

@property(nonatomic,strong)ShopSearchView *shopSearchView;

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIButton *saveBtn;

@property(nonatomic,strong)UIButton *searchBtn;

@property(nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,assign)BOOL isShowShopSearchView; //是否打开了店铺搜索界面

@property(nonatomic,strong)ShopBotCarView *shopbotcar;

@property(nonatomic,strong)BusinessDetailView *settmentView;

@property(nonatomic,assign)BOOL isShowSetmentView; //是否打开了结算界面

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,assign)BOOL isShowShopDetail;//选规格界面

@property(nonatomic,strong)StoreModel *model;


@property(nonatomic,strong)id<ChangeShopViewDelegate>delegate;

-(void)startnetworkingwith:(NSString *)shopID;

- (void)loadAgainDataOrderId:(NSString *)orderid withStoreID:(NSString *)shopID;

-(void)designBottomView;






@end
