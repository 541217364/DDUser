//
//  EvalutModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/25.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvalutModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * comment;

@property (nonatomic, copy)NSString<Optional> * order_id;

@property (nonatomic, copy)NSString<Optional> * add_time;

@property (nonatomic, copy)NSArray<Optional> * pic;

@property (nonatomic, copy)NSString<Optional> * score;

@property (nonatomic, copy)NSString<Optional> * deliver_score;

@property (nonatomic, copy)NSArray<Optional>  *goods;

@property (nonatomic, copy)NSString<Optional> *store_pic;

@property (nonatomic, copy)NSString<Optional> *merchant_reply;

@property (nonatomic, copy)NSString<Optional> *store_id;

@end
