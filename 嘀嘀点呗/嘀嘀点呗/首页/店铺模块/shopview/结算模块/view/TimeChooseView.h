//
//  TimeChooseView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/12.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTimeDoneDelegate<NSObject>


-(void)chooseTimeSuccess:(NSString *)chooseTime isfirstTime:(BOOL)isfirsttime;

@end




@interface TimeChooseView : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *leftTabview;

@property(nonatomic,strong)UITableView *rightTabview;

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,assign)id<ChooseTimeDoneDelegate>delegate;

-(void)addDatasourceToView:(NSArray *)deliver_time_list;



@end
