//
//  NoticeTipView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/9/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "NoticeTipView.h"

#define Width 300

@interface NoticeTipView ()

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)UIView *tipsView;

@property(nonatomic,strong)UILabel *topLabel;

@property(nonatomic,strong)UILabel *desLabel;

@property(nonatomic,strong)UIView *botView;

@property(nonatomic)CGFloat superY;

@end

@implementation NoticeTipView


-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.backgroundColor = [UIColor blackColor];
        _hideView.alpha = TR_Alpha;
    }
    return _hideView;
}

-(UIView *)tipsView{
    if (_tipsView == nil) {
        _tipsView = [[UIView alloc]init];
        _tipsView.backgroundColor = [UIColor whiteColor];
    }
    return _tipsView;
}

-(UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.font = TR_Font_Gray(20);
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}

-(UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.font = TR_Font_Gray(14);
        _desLabel.textColor = [UIColor grayColor];
        _desLabel.numberOfLines = 0;
    }
    return _desLabel;
}



-(UIView *)botView{
    if (_botView == nil) {
        _botView = [[UIView alloc]init];
        _botView.backgroundColor = [UIColor whiteColor];
    }
    return _botView;
}


-(void)showWithTitle:(NSString *)title withDescrip:(NSString *)descrip withBtn:(NSArray *)btnArray{
    
    CGSize size = TR_TEXT_SIZE(descrip, self.desLabel.font, CGSizeMake(Width, 0), nil);
    
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.hideView.frame = self.bounds;
        [self addSubview:self.hideView];
        
        self.tipsView.frame = CGRectMake(0, 0, Width, size.height + 100);
        self.tipsView.center = self.hideView.center;
        self.tipsView.layer.cornerRadius = 10.0f;
        self.tipsView.layer.masksToBounds = YES;
        [self addSubview:self.tipsView];
        
        self.topLabel.frame = CGRectMake(0, 10, Width, 20);
        self.topLabel.text = title;
        [self.tipsView addSubview:self.topLabel];
        
        self.superY = 40;
        self.desLabel.frame = CGRectMake(0, self.superY, Width, size.height);
        self.desLabel.text = descrip;
        [self.tipsView addSubview:self.desLabel];
        self.superY = self.superY + size.height + 10;
    
        UIView  *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, self.tipsView.frame.size.height - 41, Width, 1);
        lineView.backgroundColor = GRAYCLOLOR;
        [self.tipsView addSubview:lineView];
    
        self.botView.frame = CGRectMake(0, self.tipsView.frame.size.height - 40, Width, 30);
        [self.tipsView addSubview:self.botView];
        [self designBottom:btnArray];
    
        [self addTapAction];
    
    
    
}


-(void)addTapAction{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSelf)];
    [_hideView addGestureRecognizer:tap];
}

-(void)hideSelf{
    
    [self removeFromSuperview];
}

-(void)designBottom:(NSArray *)btnArray{
    
    if (btnArray.count > 0) {
        CGFloat width = Width / btnArray.count;
        for (int i = 0; i < btnArray.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width * i, 5, width, 25);
            [btn setTitle:btnArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag = 2000 + i ;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self.botView addSubview:btn];
            if (btnArray.count > 1 && i != 0) {
                UIView * lineView = [[UIView alloc]init];
                lineView.frame = CGRectMake(width * i, 2.5, 1, 30);
                lineView.backgroundColor = GRAYCLOLOR;
                [self.botView addSubview:lineView];
            }
            
        }
    }
}



-(void)click:(UIButton *)sender{
    
    if (_clickBlock) {
        _clickBlock(sender.tag - 2000);
    }
    
    [self removeFromSuperview];
    
}

-(void)show{
    
    [ROOTVIEW addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
