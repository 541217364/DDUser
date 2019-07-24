//
//  AdvertModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/19.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface AdvertModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * type; //广告类型 type类型 0为空 1图片 2视频

@property (nonatomic, copy)NSString<Optional> * adver_link;  //广告链接

@property (nonatomic, copy)NSString<Optional> * link;  //广告内容

@end
