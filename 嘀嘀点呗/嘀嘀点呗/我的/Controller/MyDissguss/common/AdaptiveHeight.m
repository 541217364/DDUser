//
//  AdaptiveHeight.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "AdaptiveHeight.h"

@implementation AdaptiveHeight
+(instancetype)shareAdaptive {
    static AdaptiveHeight * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AdaptiveHeight alloc]init];
    });
    return manager;
}

-(CGFloat)CalculationHeihtWithtext:(UIFont *)font withString:(NSString *)textString withwidth:(CGFloat)contentWidth{
    NSDictionary *attributes = @{NSFontAttributeName : font};
    CGFloat height = [textString boundingRectWithSize:CGSizeMake(contentWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
    
    return height;
}
@end
