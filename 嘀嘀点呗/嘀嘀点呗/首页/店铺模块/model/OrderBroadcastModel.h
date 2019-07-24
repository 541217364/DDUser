//
//  OrderBroadcastModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/28.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface OrderBroadcastModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* expect_use_time;

@property (nonatomic, strong) NSString<Optional>* is_pick_in_store;

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* order_id;

@property (nonatomic, strong) NSString<Optional>* pic_info;

@property (nonatomic, strong) NSString<Optional>* status;

@property (nonatomic, strong) NSString<Optional>*status_des;

@property (nonatomic, strong) NSString<Optional>*store_img;

@end
