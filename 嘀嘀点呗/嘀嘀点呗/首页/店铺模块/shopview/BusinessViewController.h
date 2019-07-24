//
//  BusinessViewController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"
#import "BusDetailView.h"
#import "BusinessShopView.h"
@interface BusinessViewController : ShareVC<ChangeShopViewDelegate>

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)BusinessShopView *shopView;

@property (nonatomic, copy) NSString *storeID;

@property (nonatomic, strong) NSString *orderid;


@end
