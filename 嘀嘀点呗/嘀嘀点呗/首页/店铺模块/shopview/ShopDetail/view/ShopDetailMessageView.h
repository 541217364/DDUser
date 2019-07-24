//
//  ShopDetailMessageView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/17.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreInfo.h"
#import "ShopTypeDetailView.h"
#import "CommoditySpecificationModel.h"
#import "DBManagement.h"
#import "SpecAttuributrModel.h"
#import "DBGoodSpecModel.h"

@protocol ShopDetailMessageViewDelegate<NSObject>

-(void)returnTopViewAction;

@end




@interface ShopDetailMessageView : UIView

@property (nonatomic,strong)UIImageView *shopimageView;

@property(nonatomic,strong)UIScrollView *bottomScroll;

@property(nonatomic,strong)UILabel *namelabel;

@property(nonatomic,strong)UILabel *salecount;

@property(nonatomic,strong)UILabel *pricelabel;

@property(nonatomic,strong)UILabel *oldpricelabel;

@property(nonatomic,strong)UIView *countView;

@property(nonatomic,strong)UILabel *numlabel;

@property(nonatomic,strong)UIButton *selectTypeBtn;

@property(nonatomic,strong)UIView *goodsSpcView; //规格视图

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,assign)int count;

@property(nonatomic,strong)UILabel *commentLabel;

@property(nonatomic,assign)id<ShopDetailMessageViewDelegate>delegate;

@property(nonatomic,strong)StoreModel *ShopModel;

@property(nonatomic,strong)ProductItem * model;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)NSString *shop_ID;

@property(nonatomic,strong)NSString *shop_Name;

@property(nonatomic,strong)NSDictionary *testDic;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)SpecAttuributrModel *sepModel;


-(void)designViewWithShopMessage:(NSArray *)contentArray;

-(void)startAnimalWithRect:(CGRect)rect;


@end
