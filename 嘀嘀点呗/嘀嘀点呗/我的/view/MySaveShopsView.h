//
//  MySaveShopsView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/8.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchScrollViewExtent.h"

@protocol HideViewDelegate<NSObject>

//滚动到顶部
- (void)clickHideView:(NSString *)viewType;

-(void)clickCellAtIndexPath:(NSIndexPath *)indexpath withShopID:(NSString *)shopID;

@end




@interface MySaveShopsView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *mytablView;

@property(nonatomic,strong)TouchScrollViewExtent *myscrollView;

@property(nonatomic,strong)UIView *hide_view;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,assign)id<HideViewDelegate>delegate;

-(void)loadDatasource;

@end
