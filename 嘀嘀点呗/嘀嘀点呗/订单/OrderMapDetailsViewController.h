//
//  OrderMapDetailsViewController.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/4.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShareUI.h"
#import "OrderListModel.h"

@interface OrderMapDetailsViewController : ShareVC

@property (nonatomic, assign) CLLocationCoordinate2D buyercoor;

@property (nonatomic, assign) CLLocationCoordinate2D storecoor;

@property (nonatomic, assign) CLLocationCoordinate2D qscoor;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *state;

/*刷新上一层界面block*/
@property (copy,nonatomic) void (^ReloadViewBlock) (void);

@end
