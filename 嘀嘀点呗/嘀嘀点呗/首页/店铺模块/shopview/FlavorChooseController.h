//
//  FlavorChooseController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlavorChooseController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITextView *flvorTextV;//口味描述
@property(nonatomic,copy)NSString *contentS;
@property(nonatomic,copy)NSMutableSet * myset;
@property(nonatomic,strong)UITableView *mytableView;
@end
