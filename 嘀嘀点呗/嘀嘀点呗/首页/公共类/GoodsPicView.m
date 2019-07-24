//
//  GoodsPicView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "GoodsPicView.h"

@implementation GoodsPicView

- (instancetype)init {
    
    self=[super init];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;

        _goodPic=[[UIImageView alloc]init];
        [self addSubview:_goodPic];
        [_goodPic mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.mas_equalTo(0);
            
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width,weakSelf.frame.size.width));

            
        }];
        
        _goodname=[[UILabel alloc]init];
    
        [self addSubview:_goodname];
        [_goodname mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            
            make.top.equalTo(weakSelf.goodPic.mas_bottom).offset(5);
            
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width,20));
            
        }];
        
        _pricelabel=[[UILabel alloc]init];
        _pricelabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_pricelabel];
        
        [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.goodname.mas_bottom).offset(5);
            
            make.left.mas_equalTo(0);
            
            make.height.mas_equalTo(20);
            
            make.width.equalTo(weakSelf.mas_width);
            
        }];
        
        
        
        
        
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
