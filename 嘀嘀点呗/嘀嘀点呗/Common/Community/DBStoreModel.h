//
//  DBStoreModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface DBStoreModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * storename;

@property (nonatomic, copy)NSString<Optional> * activity;

@property (nonatomic, copy)NSString<Optional> * sendprice;

@property (nonatomic, copy)NSString<Optional> * storeimg;

@end
