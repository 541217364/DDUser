//
//  QualityStoreView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/29.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "QualityStoreView.h"

@implementation QualityStoreView


-(instancetype)init {
    
    self=[super init];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;

        _picimgView=[[UIImageView alloc]init];
       
        [self addSubview:_picimgView];
       
        [_picimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(70, 70));
            
            make.left.top.mas_equalTo(0);
            
        }];
        
        _storetitle=[[UILabel alloc]init];
       
        _storetitle.textAlignment=NSTextAlignmentCenter;
      
        [self addSubview:_storetitle];
        
        [_storetitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.picimgView.mas_bottom).offset(5);
            
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(70,15));
            
        }];
        
        _storetip=[[UILabel alloc]init];
        
        _storetip.textAlignment=NSTextAlignmentCenter;
        
        [self addSubview:_storetip];
        
        _storetip.layer.borderColor=TR_COLOR_RGBACOLOR_A(224, 90, 50,1).CGColor;
        
        _storetip.layer.borderWidth=0.5;
        
        
        
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
