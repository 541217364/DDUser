//
//  CityListModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/10.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface CityListModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * city;

@property (nonatomic, copy)NSString<Optional> * lat;

@property (nonatomic, copy)NSString<Optional> * lon;


@end
