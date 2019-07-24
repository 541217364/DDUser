//
//  ShopEvaluationCell.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/4.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTStarView.h"
@interface ShopEvaluationCell : UITableViewCell

@property (nonatomic, strong) UIImageView *storePicImgview;

@property (nonatomic, strong) UILabel *usernamelabel;

@property (nonatomic, strong) UILabel *evaluationtimelabel;

@property (nonatomic, strong) CJTStarView *fwstarRating;

@property (nonatomic, strong) CJTStarView *storestarRating;

@property (nonatomic, strong) UILabel *reviewContentlabel;

@property (nonatomic, strong) UIImageView *helpimgView;

@property (nonatomic, strong) UIView *replybackView;

@property (nonatomic, strong) UILabel *replylabel;

@end
