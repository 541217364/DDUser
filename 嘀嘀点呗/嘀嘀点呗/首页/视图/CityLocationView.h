//
//  CityLocationView.h
//  送小宝
//
//  Created by xgy on 2017/4/7.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddCityNameBlock)(NSString *cityname);


@interface CityLocationView : UIView

@property (nonatomic, copy) AddCityNameBlock addcityNameBlock;

@property (nonatomic, copy) NSString *citystr;

@end
