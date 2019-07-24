//
//  TouchScrollViewExtent.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/3/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "TouchScrollViewExtent.h"

@implementation TouchScrollViewExtent


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([self panBack:gestureRecognizer]) {
        
        return NO;
    }
    
    return YES;
}


- (BOOL)panBack:(UIGestureRecognizer*)gestureRecognizer {
    
    int location_X = 100;
    if (gestureRecognizer ==self.panGestureRecognizer) {
        
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*)gestureRecognizer;
        
        CGPoint point = [pan translationInView:self];
        
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible== state) {
            
            CGPoint location = [gestureRecognizer locationInView:self];
            if (point.x > 0 && location.x < location_X && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return
    NO
    ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
