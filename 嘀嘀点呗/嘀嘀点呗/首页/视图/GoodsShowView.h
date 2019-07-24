//
//  GoodsShowView.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/2.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTouchTableView.h"


@interface GoodsShowView : UIView

@property (nonatomic, strong) UITableView *mytableView;

- (void) loadGoodsPics:(NSArray *)pics  withData:(NSArray *)dataArray;

@end
