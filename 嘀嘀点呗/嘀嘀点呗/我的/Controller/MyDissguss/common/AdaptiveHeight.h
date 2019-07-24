//
//  AdaptiveHeight.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AdaptiveHeight : NSObject
+(instancetype)shareAdaptive;
-(CGFloat)CalculationHeihtWithtext:(UIFont *)font withString:(NSString *)textString withwidth:(CGFloat)contentWidth;
@end
