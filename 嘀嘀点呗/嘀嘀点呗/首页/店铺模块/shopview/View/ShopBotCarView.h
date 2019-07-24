//
//  ShopBotCarView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopBotCarViewDelegate<NSObject>

//点击去结算
-(void)clicksettmentaction:(NSArray *)dataArray;


@end


@interface ShopBotCarView : UIView

@property(nonatomic,strong)UIImageView *shopimageV;

@property(nonatomic,strong)UILabel *pricelable;

@property(nonatomic,strong)UIButton *settmentBtn;

@property(nonatomic,strong)StoreModel *model;

@property(nonatomic,assign)id <ShopBotCarViewDelegate>delegate;

-(void)getGoodsCountAction;

-(void)handleSettlement;



@end
