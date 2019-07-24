//
//  PersonalMessageCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/28.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalMessageCell : UITableViewCell

@property(nonatomic,strong)UILabel *userNameLabel;

@property(nonatomic,strong)UIImageView *userImage;

@property(nonatomic,strong)UILabel *contentLabel;


//数据
-(void)desginCellWithIndexpath:(NSIndexPath *)indexpath;

@end
