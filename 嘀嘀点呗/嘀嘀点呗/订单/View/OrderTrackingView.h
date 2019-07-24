//
//  OrderTrackingView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/6/13.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"

@interface OrderTrackingView : UIView

-(void)handleWithOrderListModel:(OrderListModel *)model;

- (void)loadstatus:(NSArray *)status;

@end
