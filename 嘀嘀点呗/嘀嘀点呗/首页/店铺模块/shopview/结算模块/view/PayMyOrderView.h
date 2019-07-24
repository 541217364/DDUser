//
//  PayMyOrderView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayOrderTypeCell.h"

@protocol PayMyOrderViewDelegate<NSObject>


-(void)clickReturnToTop;

-(void)clickPayMyOrder:(NSString *)payType;

@end


@interface PayMyOrderView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mytable;

@property(nonatomic,strong)UILabel *payTimeLabel;

@property(nonatomic,strong)UILabel *paymentBtn;

@property(nonatomic,strong)UIButton *payBtn;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,assign)id<PayMyOrderViewDelegate>delegate;


-(void)designViewWithdatasour:(NSArray *)datasource;


- (void)loadMinusStarTime:(NSString *)startime;

@end
