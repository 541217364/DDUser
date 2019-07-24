//
//  OrderStarView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CountNumBlock)(CGFloat countnum);

@interface OrderStarView : UIView

@property(nonatomic)CGFloat selectCount;

@property (nonatomic, copy) CountNumBlock countBlock;

@end
