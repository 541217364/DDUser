//
//  TouchTableViewExtent.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/3.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "TouchTableViewExtent.h"

@implementation TouchTableViewExtent


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([[otherGestureRecognizer view] isKindOfClass:[UIScrollView class]]) {
        
        return NO;
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
