//
//  ActivityEhibitionView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/22.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ActivityEhibitionView.h"

@interface ActivityEhibitionView ()

@property (nonatomic, strong) UILabel *tiplabel;


@end

@implementation ActivityEhibitionView

- (instancetype)init {
    
    self =[super init];
    
    if (self) {
        
        
        _tiplabel =[[UILabel alloc]init];
        
        _tiplabel.layer.cornerRadius=4;
        
        [self addSubview:_tiplabel];
      
        __weak typeof(self) weakSelf=self;

        [_tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.mas_equalTo(CGSizeMake(15,15));
            
            make.top.left.mas_equalTo(0);
        }];
        
        _titlelabel=[[UILabel alloc]init];
        
        [self addSubview:_titlelabel];
       
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.tiplabel.mas_right).offset(10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(15);
            
        }];
        
        
    }
    return self;
}

-(void)setMyType:(NSString *)myType {
    
    if ([myType isEqualToString:@"system_minus"]) {
        
        _tiplabel.backgroundColor=TR_COLOR_RGBACOLOR_A(252,108,97,1);
        
        _tiplabel.text=@"减";
        
        
    }
    
    if ([myType isEqualToString:@"system_newuser"]) {
        
        _tiplabel.backgroundColor=TR_COLOR_RGBACOLOR_A(138,199,111,1);
        
        _tiplabel.text=@"首";
        
    }
    
    if ([myType isEqualToString:@"delivery"]) {
        
        _tiplabel.backgroundColor=TR_COLOR_RGBACOLOR_A(138,199,111,1);
        
        _tiplabel.text=@"惠";
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
