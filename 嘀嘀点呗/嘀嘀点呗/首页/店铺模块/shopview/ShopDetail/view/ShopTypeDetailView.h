//
//  ShopTypeDetailView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/17.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsChooseModel.h"

@protocol AddGoodsToShopCarDelegate<NSObject>


-(void)addGoodsToShopCar:(NSArray *)tempArray;

-(void)reportSelectDataSource:(NSArray *)dataSource;



@end



@interface ShopTypeDetailView : UIView

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UIScrollView *contentView;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UIButton *addShopCar;

@property(nonatomic,strong)UIView *countView;

@property(nonatomic,strong)UILabel *numlabel;

@property(nonatomic,strong)NSString *shopImages;

@property(nonatomic,assign)int count;

@property(nonatomic,strong)NSDictionary *testDic;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,assign)id<AddGoodsToShopCarDelegate>delegate;

-(void)designViewWithDatasource:(NSArray *)datasource;

-(void)reportDatasourcetoTopView;

-(void)designViewWithDatasource:(NSString *)goodsID withGoodsCount:(NSString *)goodscount withGoodsName:(NSString *)goodsName;


@end
