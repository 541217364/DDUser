//
//  OrderManagementViewController.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/5.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ShareUI.h"

@interface OrderManagementViewController : ShareVC

@property(nonatomic,strong)UITableView *mytableView;

@property(nonatomic,strong)NSMutableArray *datasource;
@end
