//
//  StoreGoodsCell.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/4.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreGoodsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodPic;

@property (nonatomic, strong) UILabel     *goodnamelabel;

@property (nonatomic, strong) UILabel     *introducelabel;

@property (nonatomic, strong) UILabel     *salelabel;

@property (nonatomic, strong) UILabel     *pricelabel;

@property (nonatomic, strong) UIButton    *minusbtn;

@property (nonatomic, strong) UIButton    *plusbtn;

@property (nonatomic, strong) UILabel     *numberlabel;

@property (nonatomic, strong) UIButton *specificationbtn;

@end
