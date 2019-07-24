//
//  BusDetailView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/3/26.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollOfChooseViewDelegate<NSObject>

//滚动到顶部
- (void)scrollToTopView;

@end

@interface BusDetailView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrollView;

@property(nonatomic,strong)UIScrollView *topScrollView;

@property(nonatomic,strong)UITableView *leftTab;

@property(nonatomic,strong)UITableView *rightTab;

@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,assign)NSInteger number;

@property(nonatomic,strong)UIView *busiView;

@property(nonatomic,strong)UITableView *disgussView;

@property (nonatomic, assign) id<ScrollOfChooseViewDelegate> delegate;



@property(nonatomic,assign)BOOL canscroll;

-(void)changescrolltype;
@end
