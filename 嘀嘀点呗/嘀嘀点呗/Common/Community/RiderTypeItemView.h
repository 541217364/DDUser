//
//  RiderTypeItemView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderMapDetailsViewController.h"

@interface RiderTypeItemView : UIView

@property(nonatomic,strong)UIScrollView *myscrollView;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic)BOOL  isShowView;

@property(nonatomic,strong)NSMutableArray *datasource;


-(void)addDatatoView;



@end
