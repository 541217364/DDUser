//
//  LocationItemCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/22.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAddressModel.h"
@interface LocationItemCell : UITableViewCell

@property(nonatomic,strong)UILabel *typeLocationLabel;

@property(nonatomic,strong)UILabel *locationLabel;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *userPhoneLabel;

@property(nonatomic,strong)UIButton *designBtn;

@property(nonatomic,strong)NSIndexPath *indexpath;

-(void)designViewWithMode:(UserAddressModel *)model;

@end
