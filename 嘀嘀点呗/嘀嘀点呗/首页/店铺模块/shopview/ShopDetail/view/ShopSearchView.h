//
//  ShopSearchView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCell.h"
#import "StoreInfo.h"
#import "SpecAttributeView.h"
#import "StoreSeachModel.h"
#import "GoodDataModel.h"
#import "DBManagement.h"
#import "DDShop_DB.h"
@interface ShopSearchView : UIView<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,ChooseTypeDelegate>


@property(nonatomic,strong)UITableView *mytable;

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)NSString *shopID;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic ,strong)NSMutableArray *nameArray;

@property(nonatomic,strong)NSMutableArray *chooseArray;

@property(nonatomic,strong)StoreModel *shopModel;

@property(nonatomic)BOOL   isShowType;

-(void)updataView;

@end
