//
//  SeachbarCustom.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SeachbarCustom;


@interface SeachbarCustom : UIView

@property (nonatomic, strong) UITextField *seachtext;


@property (nonatomic, copy) void (^SeachStringBlock) (SeachbarCustom *seacustom,NSString *string);

@end
