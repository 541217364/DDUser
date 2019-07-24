//
//  SeachGoodsValueView.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachGoodsValueView : UIView

@property (nonatomic, copy) void (^selectValueBlock) (NSString *value);

- (void)getHistoryData;

@end
