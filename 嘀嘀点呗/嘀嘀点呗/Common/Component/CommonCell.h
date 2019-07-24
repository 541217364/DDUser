//
//  CommonCell.h
//  ELoanIos
//
//  Created by administrator on 14-9-4.
//  Copyright (c) 2014年 研信科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CommonCellType) {
    type1 = 0, 
    type2,
    type3,
    type4,
    type5,
    type6,
    type7,
    type8
};

#define CommonCellHeight 44
#define AccessoryLength 18

@protocol CommonCellDelegate<NSObject>
@optional
- (void)CommonCellClick:(TRButton *)btn withRow:(int)row;
@end

//常用的cell
@interface CommonCell : UITableViewCell

@property (nonatomic) int cell_row;

@property (nonatomic,assign) id  <CommonCellDelegate >cell_delegate;

@property (nonatomic, strong) UIImageView *imv;

@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UILabel *contentLB;

@property (nonatomic, strong) UIImageView *accessoryImv;


@property (nonatomic, strong) TRButton *btn1;

@property (nonatomic, strong) TRButton *btn2;

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UILabel *label2;

@property (nonatomic, strong) UILabel *label3;

@property (nonatomic, strong) UILabel *label4;

@property (nonatomic, strong) UILabel *label5;

- (id)initWithType:(CommonCellType)type reuseIdentifier:(NSString *)identifier;

- (void) refreshData:(id)data;

@end
