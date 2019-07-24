//
//  SpecAttributeView.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/21.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodShopManagement.h"

@interface SpecAttributeView : UIView

@property (nonatomic, strong) NSDictionary *storeDict;

- (void)loadGoodId:(NSString *)gooid  goodName:(NSString *)goodname withGoodPrice:(NSString *)price  goodData:(NSDictionary *)dict;

- (void)showInView;

@end
