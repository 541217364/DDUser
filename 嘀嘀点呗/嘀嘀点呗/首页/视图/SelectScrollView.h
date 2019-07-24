//
//  SelectScrollView.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/2.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsShowView.h"
#import "ShopEvaluationView.h"





@interface SelectScrollView : UIView

@property (nonatomic, strong) UIScrollView *myscrollView;

@property (nonatomic, strong) GoodsShowView *goodshowView;

@property (nonatomic, strong) ShopEvaluationView *shopEvaluationView;

@end
