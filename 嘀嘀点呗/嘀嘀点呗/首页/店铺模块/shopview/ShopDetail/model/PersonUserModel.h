//
//  PersonUserModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/6/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface PersonUserModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * phone;

@property (nonatomic, copy)NSString<Optional> * nickname;

@property (nonatomic, copy)NSString<Optional> * avatar;

@property (nonatomic, copy)NSString<Optional> * collection;

@property (nonatomic, copy)NSString<Optional> * cash_coupon;

@property (nonatomic, copy)NSString<Optional> * coupon;


@end
