//
//  BusinessCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreInfo.h"
@protocol ChooseTypeDelegate<NSObject>

//选择规格操作
-(void)addFoodType:(NSArray *)typeArray;

//点击添加商品  数字

-(void)clickCountView:(NSString *)clickType withIndexpath:(NSIndexPath *)indexpath;

@end

@interface BusinessCell : UITableViewCell<CAAnimationDelegate>

@property(nonatomic,strong)UIImageView *headimageView;

@property(nonatomic,strong)UILabel *namelabel;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *salecount;

@property(nonatomic,strong)UILabel *oldpricelabel;

@property(nonatomic,strong)UILabel *pricelabel;

@property(nonatomic,strong)UIView *countView;

@property(nonatomic,strong)UILabel *numlabel;

@property(nonatomic,strong)UILabel *selectCountLabel;

@property(nonatomic,strong)ProductItem *model;

@property(nonatomic,assign)int count;

@property(nonatomic)BOOL isPlay;//判断是否播放动画

@property(nonatomic,assign)NSIndexPath *indexpath;

@property (nonatomic, assign) id<ChooseTypeDelegate> delegate;


-(void)designCountWithOutData;


-(void)designCountWithData:(NSString *)countGoods;

-(void)parseDatasourceWithModel:(ProductItem *)model;



@end
