//
//  ShopBottomView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BusinessCell.h"
#import "CJTStarView.h"
#import "EvaluateCell.h"
#import "StoreInfo.h"
#import "StoreCommentModel.h"
#import "JJPhotoManeger.h"
#import "GoodsItemCell.h"
#import "GoodsItemReusableView.h"
@protocol ScrollOfChooseDelegate<NSObject>

//滚动到顶部
- (void)scrollToTopView;

-(void)tableViewSelectIndexpath:(NSIndexPath *)indexpath WithDatasource:(NSDictionary *)datasource WithDataArray:(NSArray *)dataArray;

-(void)addchoosefoodtype:(NSArray *)typearray;

-(void)addGoodsToShopAction:(NSArray *)datasource;

-(void)taplistMoveScale:(CGFloat)scale;


@end

@interface ShopBottomView : UIView<UITableViewDelegate,UITableViewDataSource,GoodsItemCellDelegate,JJPhotoDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GoodsItemReusableViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UITableView *leftTab;

@property(nonatomic,strong)UICollectionView *rightCollection;

@property (nonatomic, assign) id<ScrollOfChooseDelegate> delegate;

@property(nonatomic,strong)NSMutableDictionary *myIndexDic;


@property(nonatomic)BOOL  canScroll;

@property(nonatomic ,strong)UITableView *commentScrollView;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)NSMutableArray *nameDataArray;

@property(nonatomic,strong)NSMutableArray *commentArray;

@property(nonatomic,strong)NSMutableDictionary *titleDic;

@property(nonatomic,strong)NSString *shop_ID;

@property(nonatomic,strong)NSString *shop_Name;

@property(nonatomic,strong)StoreModel *model;

@property (nonatomic, strong) NSNumber *page;

@property (nonatomic, strong) UIButton *moveTopbtn;



-(void)changescrolltype;

-(void)parseDasourceWith:(NSDictionary *)result;

-(void)parseShopCommentList:(NSDictionary *)result;

-(void)loadDataSource;

-(NSMutableArray *)reportAddGoodsCountAction;

-(void)scrollToAimSection:(NSInteger)is_mandatory;

@end
