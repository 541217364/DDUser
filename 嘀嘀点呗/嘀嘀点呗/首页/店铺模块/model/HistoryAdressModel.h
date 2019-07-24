//
//  HistoryAdressModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface HistoryAdressModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* address;

@property (nonatomic, assign) double lat;

@property (nonatomic, assign) double lng;


@end
