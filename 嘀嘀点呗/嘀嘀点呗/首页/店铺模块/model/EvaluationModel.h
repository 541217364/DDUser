//
//  EvaluationModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/7.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "JSONModel.h"


@interface EvaluationItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * add_ip;

@property (nonatomic, copy)NSString<Optional> * add_time;

@property (nonatomic, copy)NSString<Optional> * add_time_hi;

@property (nonatomic, copy)NSString<Optional> * anonymous;

@property (nonatomic, copy)NSString<Optional> * avatar;

@property (nonatomic, copy)NSString<Optional> * comment;

@property (nonatomic, copy)NSArray<Optional> * goods;

@property (nonatomic, copy)NSString<Optional> * mer_id;

@property (nonatomic, copy)NSString<Optional> * merchant_reply_content;

@property (nonatomic, copy)NSString<Optional> * merchant_reply_time;

@property (nonatomic, copy)NSString<Optional> * nickname;

@property (nonatomic, copy)NSString<Optional> * order_id;

@property (nonatomic, copy)NSString<Optional> * order_type;

@property (nonatomic, copy)NSString<Optional> * parent_id;

@property (nonatomic, copy)NSString<Optional> * pic;

@property (nonatomic, copy)NSString<Optional> * pigcms_id;

@property (nonatomic, copy)NSString<Optional> * score;

@property (nonatomic, copy)NSString<Optional> * status;

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * uid;

@end


@interface EvaluationModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * all_count;

@property (nonatomic, copy)NSString<Optional> * count;

@property (nonatomic, copy)NSString<Optional> * good_count;

@property (nonatomic, copy)NSArray<Optional> * list;

@property (nonatomic, copy)NSString<Optional> * now;

@property (nonatomic, copy)NSString<Optional> * page;

@property (nonatomic, copy)NSString<Optional> * total;

@property (nonatomic, copy)NSString<Optional> * wrong_count;


@end
