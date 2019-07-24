//
//  ChangeUserPasswordView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/3.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ChangeUserPasswordView.h"

@implementation ChangeUserPasswordView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    NSArray *titleArray = @[@"当前密码:",@"新密码:",@"确认新密码:"];
    
    if (self) {
        
        for (int i = 0; i < titleArray.count; i ++) {
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.text = titleArray[i];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = TR_Font_Gray(15);
            titleLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(20 + 60 * i);
                make.size.mas_equalTo(CGSizeMake(frame.size.width - 20, 20));
            }];
            
            
            UITextField *tempTF = [[UITextField alloc]init];
            tempTF.backgroundColor = [UIColor clearColor];
            tempTF.textColor = [UIColor blackColor];
            tempTF.font = TR_Font_Gray(15);
            tempTF.textAlignment = NSTextAlignmentLeft;
            tempTF.tag = 1000+i;
            [self addSubview:tempTF];
            [tempTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(titleLabel.mas_bottom);
                 make.size.mas_equalTo(CGSizeMake(frame.size.width - 20, 20));
            }];
            
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor blackColor];
            if (i == 0) {
              lineView.backgroundColor = [UIColor orangeColor];
            }
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(tempTF.mas_bottom).offset(1);
                make.size.mas_equalTo(CGSizeMake(frame.size.width - 20, 1));
            }];
            
        }
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.backgroundColor = [UIColor orangeColor];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius = 5.0f;
        sureBtn.layer.masksToBounds = YES;
        sureBtn.titleLabel.font = TR_Font_Gray(15);
        [self addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(changeUserPassword:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
           make.size.mas_equalTo(CGSizeMake(frame.size.width - 20, 30));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.text = @"密码长度必须8-12位，必须包含数字，字母，符号两种以上的元素";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = TR_Font_Gray(14);
        titleLabel.numberOfLines = 0;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10 );
            make.bottom.mas_equalTo(sureBtn.mas_top).offset(-10);
            make.size.mas_equalTo(CGSizeMake(frame.size.width - 20, 40));
        }];
        
    }
    return self;
}



-(void)changeUserPassword:(UIButton *)sender{
    
    UITextField *originTF = [self viewWithTag:1000];
    UITextField *newTF = [self viewWithTag:1001];
    UITextField *sureNewTF = [self viewWithTag:1002];
    
    if (originTF.text.length == 0 || ![originTF.text isEqualToString:self.originPassword]) {
        
        TR_Message(@"原始密码有误");
        
        return;
    }
    
    if (newTF.text.length == 0) {
        TR_Message(@"新密码未输入");
        return;
    }
    
    if (sureNewTF.text.length == 0 || ![sureNewTF.text isEqualToString:newTF.text]) {
        TR_Message(@"未确定新密码或不匹配");
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(changeUserPasswordSuccess:withNewPass:)]) {
        [self.delegate changeUserPasswordSuccess:self.originPassword withNewPass:newTF.text];
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
