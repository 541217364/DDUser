//
//  GoodsItemCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/17.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsItemCellDelegate<NSObject>

//选择规格操作
-(void)addFoodType:(NSArray *)typeArray;

//点击添加商品  数字

-(void)clickCountView:(NSString *)clickType withIndexpath:(NSIndexPath *)indexpath;

@end


@interface GoodsItemCell : UICollectionViewCell<CAAnimationDelegate>

@property(nonatomic,strong) UIImageView *goodImageV;

@property(nonatomic,strong) UILabel *discountlabel;

@property(nonatomic,strong) UILabel *namelabel;

@property(nonatomic,strong) UILabel *stokelabel;

@property(nonatomic,strong) UILabel *saleCountlabel;

@property(nonatomic,strong) UILabel *nowPricelabel;

@property(nonatomic,strong)UIButton *selectTypeBtn;

@property(nonatomic,strong)UIButton *plusNumBtn;

@property(nonatomic,strong)UILabel *goodsNumlabel;

@property(nonatomic,strong)UILabel *seckillpricelabel;

@property(nonatomic,strong)ProductItem *model;

@property(nonatomic,assign)NSIndexPath *indexpath;

@property(nonatomic)BOOL isPlay;//判断是否播放动画

@property(nonatomic,assign)id<GoodsItemCellDelegate>delegate;

-(void)parseDatasourceWithModel:(ProductItem *)model;

@end
