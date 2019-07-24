//
//  MyRedBaoTablView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchScrollViewExtent.h"

@protocol HideRedViewDelegate<NSObject>

//滚动到顶部
- (void)clickHideRedView:(NSString *)viewType;

@end



@interface MyRedBaoTablView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)NSString *titleName;

@property(nonatomic,strong)UITableView *mytablView;

@property(nonatomic,strong)TouchScrollViewExtent *myscrollView;

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)NSMutableArray *shopDicData;

@property(nonatomic,assign)id<HideRedViewDelegate>delegate;

-(void)designViewWith:(NSString *)viewType;

@end
