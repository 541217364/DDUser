//
//  MyCollectionItemCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyCollectionItemCell.h"

@implementation MyCollectionItemCell

-(UIImageView *)imagesView{
    if (_imagesView == nil) {
        _imagesView = [[UIImageView alloc]init];
        _imagesView.contentMode = UIViewContentModeScaleAspectFill;
        _imagesView.backgroundColor = [UIColor clearColor];
    }
    return _imagesView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = TR_Font_Gray(15);
        _titleLabel.backgroundColor = [UIColor clearColor];
       
    }
    return _titleLabel;
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imagesView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)designCellWithTitle:(NSString *)title WithImagePath:(NSString *)imageUrl{
   
    __weak typeof(self) weakSelf = self;
//    [self.imagesView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
    self.imagesView.image = [UIImage imageNamed:imageUrl];
    CGSize size = self.imagesView.image.size;
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(size.width, size.height));
    }];
    
    self.titleLabel.text = title;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.imagesView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(weakSelf.bounds.size.width);
    }];
}

@end
