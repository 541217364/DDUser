//
//  MyCollectionHeadView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyCollectionHeadView.h"

@implementation MyCollectionHeadView
-(UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.numberOfLines = 0;
       _titleLable.font = TR_Font_Gray(20);
        _titleLable.backgroundColor = [UIColor clearColor];
       
    }
    return _titleLable;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLable];
       
    }
    return self;
}

-(void)designViewWithTitle:(NSString *)titile{
    self.titleLable.text = titile;
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-2);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
}
@end
