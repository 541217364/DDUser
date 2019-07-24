//
//  DBGoodSpecModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface DBGoodSpecModel : JSONModel

@property (nonatomic, copy)NSString<Optional> *goodId;

@property (nonatomic, copy)NSString<Optional> *specId;

@property (nonatomic, copy)NSString<Optional> *specname;

@property (nonatomic, copy)NSString<Optional> *specprice;

@property (nonatomic, copy)NSString<Optional> * pickprice;

@property (nonatomic, copy)NSString<Optional> * specnum;

@property (nonatomic, copy)NSString<Optional> * attribute;



@end
