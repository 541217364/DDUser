//
//  ProductGoodsModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/30.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

#import "ProductOrderGoodModel.h"

@interface ProductGoodsModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * productName;

@property (nonatomic, copy)NSString<Optional> * count;

@property (nonatomic, copy)NSString<Optional> * productId;

@property (nonatomic, copy)NSArray<Optional> * productParam;

@property (nonatomic, copy)ProductOrderGoodModel<Optional> * infos;

@end
