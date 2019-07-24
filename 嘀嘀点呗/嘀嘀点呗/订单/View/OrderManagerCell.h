//
//  OrderManagerCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "OrderTrackingView.h"
@class OrderManagerCell;

@protocol OrderManagerCelldelegate<NSObject>

- (void)orderManagerCell:(OrderManagerCell *)cell selectOrderModel:(OrderListModel *)model andclickbtn:(UIButton *)clickbtn;

- (void)nextstore:(OrderListModel *)model;

@end


@interface OrderManagerCell : UITableViewCell

typedef enum 
{
    //配送中 默认
    orderTypeDistributioning = 0,
    //配送完成
    orderTypeDistributionDone = 1,
    //quxiao
    orderTypeCancelDone = 2,
    //退款完成
    orderTypeRefundDone = 3,
    //用户未支付
    orderTypeUserNotPay = 4,
    //商家未接单
    orderTypeBuessinessNot=5,
    //安排骑手
    orderTypeQSDone=6,
    //骑手取货
    orderTypeQSTakeDone=7,
    //未评价
    orderTypeNoCommentDone=8,
    //评价
    orderTypeCommentDone=9,
    
    orderTypeStore=10,

    
} OrdercellType;


@property(nonatomic,assign)OrdercellType OrderType;

@property(nonatomic,strong)UIView *bottomV;

@property(nonatomic,strong)UILabel *stateLabel;

@property(nonatomic,strong)UIImageView *busphoto;

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UILabel *titleLabel;

@property (nonatomic, strong) UILabel *stateMsgLabel;

@property (nonatomic, assign) id<OrderManagerCelldelegate> delegate;

@property (nonatomic, strong) UIButton *orderStateListbtn;

@property (nonatomic, strong) UIImageView *arrowImgView;

- (void)setOrderState:(NSString *)state andOrderModel:(OrderListModel *)model;

@end
