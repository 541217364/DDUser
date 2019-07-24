//
//  GoodsItemReusableView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/25.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "GoodsItemReusableView.h"

#define ListHeight 80

@implementation GoodsItemReusableView


-(instancetype)init{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

-(void)setMytitle:(NSString *)mytitle{
    
    __weak typeof(self) weakSelf=self;
    
    if (self.shopDisView == nil) {
        
        _shopDisView = [[UIView alloc]init];
        
        _shopDisView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_shopDisView];
        
        [_shopDisView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.mas_equalTo(0);
            
            make.top.mas_equalTo(0);
            
            make.height.mas_equalTo(0);
            
        }];
    }
    
    if (self.mytitleLabel == nil) {
        
        _mytitleLabel = [[UILabel alloc]init];
        
        _mytitleLabel.font = TR_Font_Cu(16);
        
        [self addSubview:_mytitleLabel];
        
        [self.mytitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(weakSelf.shopDisView.mas_bottom);
            
            make.bottom.mas_equalTo(0);
        }];
        
    }
    
    
    
    
    self.mytitleLabel.text = mytitle;
    
//    if (_timeShowItem == nil) {
//        _timeShowItem = [[TimeShowsItem alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
//        [self addSubview:_timeShowItem];
//        [self.timeShowItem mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(weakSelf.mytitleLabel.mas_right).offset(5);
//            make.centerY.mas_equalTo(weakSelf.mytitleLabel);
//            make.height.mas_equalTo(20);
//        }];
//    }
    
    
}






-(void)shopDiscountListView{
    
    
    [_shopDisView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(ListHeight * 3);
    }];
    
    for ( int i = 0; i < 3; i ++) {
        
        UIImageView *disListView = [[UIImageView alloc]init];
        
        disListView.image = [UIImage imageNamed:@"shop_dislist"];
        
        disListView.userInteractionEnabled = YES;
        
        [_shopDisView addSubview:disListView];
        
        [disListView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(5);
            
            make.right.mas_equalTo(-5);
            
            make.top.mas_equalTo(i * ListHeight + 5);
            
            make.height.mas_equalTo(ListHeight - 5);
        }];
        
       
        
        UILabel *priceL = [[UILabel alloc]init];
        
        priceL.textAlignment = NSTextAlignmentCenter;
        
        [disListView addSubview:priceL];
        
        priceL.attributedText = [self setText2:@"￥5" andText2:@"5"];
        
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.mas_equalTo(0);
            
            make.bottom.mas_equalTo(0);
        }];
        
        
        UILabel *discountL = [[UILabel alloc]init];
        
        discountL.font = TR_Font_Gray(16);
        
        discountL.text = @"满20可用";
        
        discountL.textAlignment = NSTextAlignmentCenter;
    
        [disListView addSubview:discountL];
        
        
        [discountL mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(priceL.mas_right);
            
            make.right.mas_equalTo(-80);
            
            make.top.mas_equalTo(priceL.mas_top).offset(15);
        }];
        
        
        UILabel *timeL = [[UILabel alloc]init];
        
        timeL.font = TR_Font_Gray(13);
        
        timeL.adjustsFontSizeToFitWidth = YES;
        
        timeL.text = @"有效期至2018.07.27";
        
        timeL.textColor = [UIColor grayColor];
        
        timeL.textAlignment = NSTextAlignmentCenter;
        
        [disListView addSubview:timeL];
        
        [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.mas_equalTo(discountL.mas_bottom).offset(5);
            
            make.left.right.mas_equalTo(discountL);
        }];
        
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [rightBtn setTitle:@"领取" forState:UIControlStateNormal];
        
        rightBtn.titleLabel.font = TR_Font_Gray(15);
        
        rightBtn.tag = 1000 + i;
        
        [rightBtn addTarget:self action:@selector(getDiscount:) forControlEvents:UIControlEventTouchUpInside];
        
        rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        rightBtn.layer.cornerRadius = 10.0f;
        
        rightBtn.layer.masksToBounds = YES;
        
        rightBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(93, 75, 29, 1);
        
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [disListView addSubview:rightBtn];
        
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-10);
            
            make.centerY.mas_equalTo(0);
            
            make.size.mas_equalTo(CGSizeMake(50, 25));
            
        }];
        
    }
    
    
    [self layoutIfNeeded];
    
}



-(void)getDiscount:(UIButton *)sender{
    
   // NSString * title = [NSString stringWithFormat:@"%ld",sender.tag];
    
    UIView *tempV = sender.superview;
    
    __weak typeof(self) weakSelf=self;
    
    CGRect rect = tempV.frame;
    
    [UIView animateWithDuration:ANIMATIONDURATION animations:^{
       
        tempV.frame = CGRectMake(SCREEN_WIDTH, rect.origin.y, rect.size.width, rect.size.height);
        
    } completion:^(BOOL finished) {
        
        
        [tempV removeFromSuperview];
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(reloadViewData)]) {
            
            [weakSelf.delegate reloadViewData];
        }
        
    }];
    
    
}


- (NSMutableAttributedString *) setText2:(NSString *)text andText2:(NSString *)mtext2 {
    
    NSString *text1=text;
    
    NSString *text2=mtext2;
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:ORANGECOLOR,
                              NSFontAttributeName:TR_Font_Gray(15)
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    
    NSRange redTextRange =[text1 rangeOfString:text2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:ORANGECOLOR,NSFontAttributeName:TR_Font_Cu(25)} range:redTextRange];
    
    return attributedText;
    
}

@end
