//
//  WeixinModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/3.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface WeixinModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * openid;

@property (nonatomic, copy)NSString<Optional> * nickname;

//@property (nonatomic, copy)NSString<Optional> * sex;

@property (nonatomic, copy)NSString<Optional> * province;

@property (nonatomic, copy)NSString<Optional> * city;

@property (nonatomic, copy)NSString<Optional> * country;

@property (nonatomic, copy)NSString<Optional> * headimgurl;

@property (nonatomic, copy)NSString<Optional> * unionid;

@property (nonatomic, copy)NSArray<Optional> * privilege;



@end
