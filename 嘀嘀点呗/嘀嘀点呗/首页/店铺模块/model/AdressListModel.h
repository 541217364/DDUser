//
//  AdressListModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/12.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface AdressListModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * adress_id;

@property (nonatomic, copy)NSString<Optional> * phone;

@property (nonatomic, copy)NSString<Optional> * adress;

@property (nonatomic, copy)NSString<Optional> * detail;

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * sex;

@property (nonatomic, copy)NSString<Optional> * lng;

@property (nonatomic, copy)NSString<Optional> * lat;

@property (nonatomic, copy)NSString<Optional> * often_label;

@property (nonatomic, copy)NSString<Optional> * is_deliver;



@end
