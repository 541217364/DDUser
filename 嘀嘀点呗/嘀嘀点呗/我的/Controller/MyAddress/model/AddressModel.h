//
//  AddressModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface AddressModel : JSONModel
@property (nonatomic, copy)NSString<Optional> * adress_id;
@property (nonatomic, copy)NSString<Optional> * phone;
@property (nonatomic, copy)NSString<Optional> * province_txt;
@property (nonatomic, copy)NSString<Optional> * city_txt;
@property (nonatomic, copy)NSString<Optional> * area_tx;
@property (nonatomic, copy)NSString<Optional> * adress;
@property (nonatomic, copy)NSString<Optional> * detail;
@property (nonatomic, copy)NSString<Optional> * defaults;
@property (nonatomic, copy)NSString<Optional> * name;
@property (nonatomic, copy)NSString<Optional> * zipcode;
@property (nonatomic, copy)NSString<Optional> * lng;
@property (nonatomic, copy)NSString<Optional> * lat;
@property (nonatomic, copy)NSString<Optional> * is_deliver;
@property (nonatomic, copy)NSString<Optional> * distance;
@end
