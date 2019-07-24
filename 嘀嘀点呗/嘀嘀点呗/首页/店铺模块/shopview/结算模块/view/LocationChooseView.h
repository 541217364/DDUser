//
//  LocationChooseView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationItemCell.h"
#import "UserAddressModel.h"

@protocol SelectLocationDelegate<NSObject>


-(void)clickCellInCorrecSite:(UserAddressModel *)model;

-(void)addNewLocation;

-(void)fixMyLocation:(UserAddressModel *)model;

@end

@interface LocationChooseView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mytableView;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)id<SelectLocationDelegate>delegate;

-(void)startNetWork:(NSString *)shopID;

@end
