//
//  SeachbarCustom.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SeachbarCustom.h"

@interface SeachbarCustom ()<UITextFieldDelegate>


@property (nonatomic, strong) UIImageView *seachimgview;

@end

@implementation SeachbarCustom

- (instancetype)init {
    
    self=[super init];
    
    if (self) {
        
        
        self.backgroundColor=[UIColor whiteColor];
        
        self.layer.cornerRadius=5;
        
        self.layer.masksToBounds=YES;
        
        __weak typeof(self) weakSelf=self;

        _seachimgview=[[UIImageView alloc]init];
      
        [self addSubview:_seachimgview];
        
        [_seachimgview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(5);
            
            make.size.mas_equalTo(CGSizeMake(20,20));
            
        }];
        
        _seachtext=[[UITextField alloc]init];
        
        [self addSubview:_seachtext];
        
        [_seachtext mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.seachimgview.mas_right).offset(5);
            
            make.top.equalTo(weakSelf.seachimgview.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width-35,20));
            
        }];
                
    }
    
    return self;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSString *seachStr= textField.text;
    
    _SeachStringBlock(self,seachStr);
    
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
