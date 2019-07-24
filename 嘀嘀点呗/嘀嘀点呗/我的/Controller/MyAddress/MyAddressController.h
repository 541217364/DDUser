//
//  MyAddressController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/13.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressController : ShareVC<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mytableView;

@end
