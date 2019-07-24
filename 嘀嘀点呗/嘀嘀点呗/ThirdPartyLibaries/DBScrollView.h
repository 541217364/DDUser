//
//  DBScrollView.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/24.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *myscrollView;

- (void) setScrollViewData:(NSArray *)array;

@property (nonatomic, copy) void(^ LoadDataBlock)(NSArray *data,NSInteger number);

@end
