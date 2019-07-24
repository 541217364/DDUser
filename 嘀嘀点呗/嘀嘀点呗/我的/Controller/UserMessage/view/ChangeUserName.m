//
//  ChangeUserName.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ChangeUserName.h"

#define SpareWidth 10
@implementation ChangeUserName

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
      
        __weak typeof(self) weakSelf = self;
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.text = @"用户名:";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = TR_Font_Gray(14);
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(frame.size.width - 2 * SpareWidth, 20));
        }];
        
        
        self.userNameTextField = [[UITextField alloc]init];
        self.userNameTextField.textColor = [UIColor blackColor];
        self.userNameTextField.font = TR_Font_Gray(14);
        self.userNameTextField.text = [Singleton shareInstance].userInfo.nickname;
        [self addSubview:self.userNameTextField];
        [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(SpareWidth /2 );
            make.size.mas_equalTo(CGSizeMake(frame.size.width - 2 * SpareWidth, 20));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.userNameTextField.mas_bottom).offset(1);
            make.size.mas_equalTo(CGSizeMake(frame.size.width - 2 * SpareWidth, 1));
        }];
        
        UILabel *detailLabel = [[UILabel alloc]init];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.text = @"以中文或英文字母开头，限4-16个字符";
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.font = TR_Font_Gray(14);
        detailLabel.numberOfLines = 0;
        detailLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(lineView.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(frame.size.width - 2 * SpareWidth, 20));
        }];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.backgroundColor = [UIColor orangeColor];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.layer.cornerRadius = 5.0f;
        sureBtn.layer.masksToBounds = YES;
        sureBtn.titleLabel.font = TR_Font_Gray(15);
        [self addSubview:sureBtn];
        [sureBtn addTarget:self action:@selector(changeUserName:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
            make.top.mas_equalTo(detailLabel.mas_bottom).offset(2 * SpareWidth);
            make.size.mas_equalTo(CGSizeMake(frame.size.width - 2 * SpareWidth, 30));
        }];
        
        
    }
    return self;
}

-(void)changeUserName:(UIButton *)sender{
    
    if (self.userNameTextField.text.length == 0) {
        
        TR_Message(@"用户名输入有误");
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(changeUserNameSuccesswithNewUserName:)]) {
        [self.delegate changeUserNameSuccesswithNewUserName:self.userNameTextField.text];
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
