//
//  BusinessDetailView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/9.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeChooseView.h"
#import "TasteNotesView.h"
#import "BusinessCell.h"
#import "LocationChooseView.h"
#import "PayMyOrderView.h"
#import "GoodsChooseModel.h"
#import "OrderGoodsModel.h"
#import "ModifyAddressViewController.h"

@protocol ReturnTopViewDelegate<NSObject>


-(void)clickReturnBtn:(NSInteger)is_mandatory;

@end




@interface BusinessDetailView : UIView<UITableViewDelegate,UITableViewDataSource,PayMyOrderViewDelegate,ChooseTimeDoneDelegate,SelectLocationDelegate,ChooseDescriptionDelegate,ChooseTypeDelegate>

@property(nonatomic,strong)UIScrollView *bottomscrollview;

@property(nonatomic,strong)UIView * topView;

@property(nonatomic,strong)UIView * centerView;

@property(nonatomic,strong)UIView * bottomView;

@property(nonatomic,assign)NSInteger isclick;//判断是否点击 外卖配送 到店自取

@property(nonatomic,strong)UILabel *locationL;

@property(nonatomic,strong)UILabel *personL;

@property(nonatomic,strong)UILabel *takemileL;

@property(nonatomic,strong)UILabel *sendLabel;

@property(nonatomic,strong)UILabel *taketype;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)UILabel *DiscountL;

@property(nonatomic,strong)UITableView *foodListTable;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UIButton *DiscountLBtn;

@property(nonatomic,assign)int countnumber;

@property(nonatomic,assign)BOOL timeOpen;//判断时间选择的视图是否打开

@property(nonatomic,strong)TimeChooseView *timeChooseView;

@property(nonatomic,strong)TasteNotesView *tastNoteView; //口味备注界面

@property(nonatomic,assign)BOOL tastNoteOPen; // 口味备注界面是否打开

@property(nonatomic,strong)UIView *blackView;

@property(nonatomic,strong)UIView *takeView;


@property(nonatomic,strong)LocationChooseView *locationChooseView;

@property(nonatomic)BOOL locationOPen;//判断地址选择界面是否打开

@property(nonatomic,strong)PayMyOrderView *payPersonOrder;

@property(nonatomic)BOOL payOrderOpen; //支付界面是否开

//中间视图的属性
@property(nonatomic,strong)UIImageView *titleImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)id<ReturnTopViewDelegate>delegate;

@property(nonatomic,strong)UserAddressModel *locationItem;

@property(nonatomic,strong)StoreModel *model;


-(void)addDatasourceToView:(NSArray *)datasource;

@end
