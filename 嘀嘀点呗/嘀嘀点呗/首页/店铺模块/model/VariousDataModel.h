//
//  VariousDataModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/5.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "JSONModel.h"


@protocol TypeItem


@end


@protocol SortItem


@end


@protocol SonItem


@end


@protocol CategoryItem


@end

@protocol AdverItem


@end

@protocol SliderItem


@end

@protocol BannerItem


@end



@interface TypeItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * type_url;

@end


@interface SortItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * sort_url;

@end


@interface SonItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * cat_name;

@property (nonatomic, copy)NSString<Optional> * cat_url;

@end


@interface CategoryItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * cat_name;

@property (nonatomic, copy)NSString<Optional> * cat_url;

@property (nonatomic, copy)NSArray<Optional> * son_list;

@end



@interface AdverItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * url;

@property (nonatomic, copy)NSString<Optional> * pic;

@property (nonatomic, copy)NSString<Optional> * sort;

@property (nonatomic, copy)NSString<Optional> * province_id;

@property (nonatomic, copy)NSString<Optional> * complete;

@property (nonatomic, copy)NSString<Optional> * city_id;

@property (nonatomic, copy)NSString<Optional> * img_count;

@end


@interface SliderItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * url;

@property (nonatomic, copy)NSString<Optional> * pic;

@property (nonatomic, copy)NSString<Optional> * cat;

@end


@interface BannerItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * url;

@property (nonatomic, copy)NSString<Optional> * pic;

@property (nonatomic, copy)NSString<Optional> * sort;

@property (nonatomic, copy)NSString<Optional> * province_id;

@property (nonatomic, copy)NSString<Optional> * complete;

@property (nonatomic, copy)NSString<Optional> * city_id;

@property (nonatomic, copy)NSString<Optional> * img_count;

@property (nonatomic, copy)NSString<Optional> * redirection;

@property (nonatomic, copy)NSString<Optional> * type;

@end




@interface VariousDataModel : JSONModel

@property (nonatomic, copy)NSArray<Optional,BannerItem> * banner_list;

@property (nonatomic, copy)NSArray<Optional,SliderItem> * slider_list;

@property (nonatomic, copy)NSArray<Optional,AdverItem> * adver_list;

@property (nonatomic, copy)NSArray<Optional,CategoryItem> * category_list;

@property (nonatomic, copy)NSArray<Optional,SortItem> * sort_list;

@property (nonatomic, copy)NSArray<Optional,TypeItem> * type_list;

@property (nonatomic, copy)NSString<Optional> * search_words;


@end
