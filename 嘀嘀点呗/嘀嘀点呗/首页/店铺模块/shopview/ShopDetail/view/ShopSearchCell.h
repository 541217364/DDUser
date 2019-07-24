//
//  ShopSearchCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopSearchCell : UITableViewCell<CAAnimationDelegate>

@property(nonatomic,strong)UIImageView *headimageView;

@property(nonatomic,strong)UILabel *namelabel;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *salecount;

@property(nonatomic,strong)UILabel *oldpricelabel;

@property(nonatomic,strong)UILabel *pricelabel;

@property(nonatomic,strong)UIView *countView;

@property(nonatomic,strong)UILabel *numlabel;

@property(nonatomic,assign)int count;

@property(nonatomic)BOOL isPlay;//判断是否播放动画

@end
