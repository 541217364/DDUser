//
//  StoreCommentModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface ShopTypeModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * cat_id;

@property (nonatomic, copy)NSString<Optional> * cat_name;

@property (nonatomic, copy)NSString<Optional> * is_mandatory_sort_id;

@end


@interface StoreCommentModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * add_ip;

@property (nonatomic, copy)NSString<Optional> * add_time;

@property (nonatomic, copy)NSString<Optional> * add_time_hi;

@property (nonatomic, copy)NSString<Optional> * anonymous;

@property (nonatomic, copy)NSString<Optional> * avatar;

@property (nonatomic, copy)NSString<Optional> * comment;

@property (nonatomic, copy)NSString<Optional> * deliver_comment;

@property (nonatomic, copy)NSArray<Optional> * goods;

@property (nonatomic, copy)NSString<Optional> * deliver_uid;

@property (nonatomic, copy)NSString<Optional> * mer_id;

@property (nonatomic, copy)NSString<Optional> * merchant_reply_content;

@property (nonatomic, copy)NSString<Optional> * merchant_reply_time;

@property (nonatomic, copy)NSString<Optional> * nickname;

@property (nonatomic, copy)NSString<Optional> * order_id;

@property (nonatomic, copy)NSString<Optional> * order_type;

@property (nonatomic, copy)NSString<Optional> * parent_id;


@property (nonatomic, copy)NSArray * pic;

@property (nonatomic, copy)NSString<Optional> * pigcms_id;

@property (nonatomic, copy)NSString<Optional> * score;

@property (nonatomic, copy)NSString<Optional> * send_score;

@property (nonatomic, copy)NSString<Optional> * shop_label;

@property (nonatomic, copy)NSString<Optional> * status;

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * uid;

//@property (nonatomic, strong)id  pic_url;

@end
