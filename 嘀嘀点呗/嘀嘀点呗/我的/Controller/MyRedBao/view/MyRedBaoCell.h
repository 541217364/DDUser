//
//  MyRedBaoCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedBaoModel.h"
@interface MyRedBaoCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *moneyLabel;

@property(nonatomic,strong)UILabel *moneycountLabel;

@property(nonatomic,strong)UILabel *phoneLabel;

@property(nonatomic,strong)UIButton *goStoreBtn;


-(void)parseWithDataModel:(NSString *)title withModel:(RedBaoModel *)model;

-(void)parseWithtitle:(NSString *)title withModel:(ShopDis *)model;

@end
