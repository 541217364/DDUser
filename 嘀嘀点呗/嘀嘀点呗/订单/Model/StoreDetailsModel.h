//
//  StoreDetailsModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/9.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"



@interface StoreDetailsModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * store_name;

@property (nonatomic, copy)NSArray<Optional> * store_phone;

@property (nonatomic, copy)NSString<Optional> * store_lng;

@property (nonatomic, copy)NSString<Optional> * store_lat;

@property (nonatomic, copy)NSString<Optional> * store_image;



@end
