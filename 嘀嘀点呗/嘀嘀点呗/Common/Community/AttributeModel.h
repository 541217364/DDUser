//
//  AttributeModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/28.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface AttributeModel : JSONModel


@property (nonatomic, copy)NSString<Optional> * specId;

@property (nonatomic, copy)NSString<Optional> * goodId;

@property (nonatomic, copy)NSString<Optional> * attributeId;

@property (nonatomic, copy)NSString<Optional> * atttip;

@property (nonatomic, copy)NSString<Optional> * attributename;

@property (nonatomic, copy)NSString<Optional> * attributenum;


@end
