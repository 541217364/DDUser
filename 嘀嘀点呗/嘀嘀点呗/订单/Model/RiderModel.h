//
//  RiderModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/9.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface RiderModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * lines; //购买数量

@property (nonatomic, copy)NSString<Optional> * from_site; //购买数量

@property (nonatomic, copy)NSString<Optional> * aim_site; //购买数量


@end
