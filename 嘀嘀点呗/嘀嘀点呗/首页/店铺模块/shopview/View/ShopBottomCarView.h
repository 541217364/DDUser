//
//  ShopBottomCarView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsChooseModel.h"


@protocol ClickSettlementDelegate<NSObject>

//点击去结算
-(void)clicksettmentaction:(NSArray *)dataArray;


@end

@interface ShopBottomCarView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *pricelable;

@property(nonatomic,strong)UILabel *peisonglabel;

@property(nonatomic,strong)UITableView *mytable;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)UIView *bacview;

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *moneycountlabel;

@property(nonatomic,strong)UIButton *settmentBtn;

@property(nonatomic,strong)UIView *hideContentView;


@property(nonatomic) BOOL  hideView;

@property(nonatomic) BOOL  hideAll;

@property(nonatomic,strong)UILabel *titleDetailLabel;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)NSMutableDictionary *dataDic;

@property(nonatomic,strong)StoreModel *model;


@property(nonatomic,assign)id<ClickSettlementDelegate>delegate;


-(void)getGoodsCountAction;

-(void)handleSettlement;

-(void)changefootviewithDatasource:(NSArray *)tempArray;

-(void)addbackview;

@end
