//
//  MyCollectionHeadView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionHeadView : UICollectionReusableView

@property(nonatomic,strong)UILabel *titleLable;

-(void)designViewWithTitle:(NSString *)titile;

@end
