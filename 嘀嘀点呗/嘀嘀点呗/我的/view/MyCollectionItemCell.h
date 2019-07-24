//
//  MyCollectionItemCell.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionItemCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imagesView;

@property(nonatomic,strong)UILabel *titleLabel;

-(void)designCellWithTitle:(NSString *)title WithImagePath:(NSString *)imageUrl;
@end
