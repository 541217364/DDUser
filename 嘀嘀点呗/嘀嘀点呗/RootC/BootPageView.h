//
//  BootPageView.h
//  嘀嘀侠
//
//  Created by 周启磊 on 2018/2/7.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BootPageView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *myscrollView;

-(void)designViewWithFrame:(CGRect)Frame;

@end
