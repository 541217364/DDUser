//
//  EvaluateCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvalutModel.h"
#import "CJTStarView.h"
#import "StoreCommentModel.h"
#import "JJPhotoManeger.h"


@interface EvaluateCell : UITableViewCell<JJPhotoDelegate>

@property(nonatomic,strong)UIImageView *bussinessimage;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,assign)NSInteger labelcount; // 用户点赞选择的label

@property(nonatomic,strong)UILabel *starL;

@property(nonatomic,strong)CJTStarView *starView ;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *photosView ;

@property(nonatomic,strong)UIView *bottomView ;

@property(nonatomic,strong)UIView *disgussView ;

@property(nonatomic,strong)EvalutModel *evaModel;

@property(nonatomic)BOOL isFromPerson;

-(void)handleWithModel:(EvalutModel *)model;

-(void)designViewWith:(StoreCommentModel *)model;
@end
