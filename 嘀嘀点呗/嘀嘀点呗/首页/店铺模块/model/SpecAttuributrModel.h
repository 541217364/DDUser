//
//  SpecAttuributrModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/21.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"


@protocol SpecDataModel


@end

@protocol SpecDataItem


@end

@protocol AttuributrModel


@end


@interface AttuributrModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* goods_id;

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* id_;

@property (nonatomic, strong) NSArray<Optional>* val;




@end

@interface SpecDataItem : JSONModel

@property (nonatomic, strong) NSString<Optional>* sid;

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* id_;

@property (nonatomic, strong) NSString<Optional>* price;

@property (nonatomic, strong) NSString<Optional>* packing_charge;

@property (nonatomic, strong) NSString<Optional>* specnum;

@property (nonatomic, strong) NSString<Optional>*stock_num;


@end



@interface SpecDataModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* goods_id;

@property (nonatomic, strong) NSString<Optional>* store_id;

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* id_;

@property (nonatomic, strong) NSArray<Optional,SpecDataItem>* list;


@end


@interface SpecAttuributrModel : JSONModel

@property (nonatomic, strong) NSArray<Optional,AttuributrModel>* properties_list;

@property (nonatomic, strong) NSArray<Optional,SpecDataModel>* spec_list;


@end




