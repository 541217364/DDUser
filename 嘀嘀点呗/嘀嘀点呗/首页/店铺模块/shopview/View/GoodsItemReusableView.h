//
//  GoodsItemReusableView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/25.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeShowsItem.h"

@protocol GoodsItemReusableViewDelegate<NSObject>

//刷新界面
-(void)reloadViewData;

@end

@interface GoodsItemReusableView : UICollectionReusableView

@property(nonatomic,strong)UILabel *mytitleLabel;

@property(nonatomic,strong)NSString *mytitle;

@property(nonatomic,strong)UIView  *shopDisView;

@property(nonatomic,strong)TimeShowsItem  *timeShowItem;

@property(nonatomic,assign)id<GoodsItemReusableViewDelegate>delegate;

-(void)shopDiscountListView;

@end
