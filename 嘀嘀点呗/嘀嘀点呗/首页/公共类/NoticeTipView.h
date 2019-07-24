//
//  NoticeTipView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/9/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSInteger index);


@interface NoticeTipView : UIView

@property(nonatomic,copy)ClickBlock clickBlock;

-(void)show;

-(void)showWithTitle:(NSString *)title withDescrip:(NSString *)descrip withBtn:(NSArray *)btnArray;

@end
