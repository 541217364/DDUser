//
//  TasteNotesView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/10.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "TasteNotesView.h"

#define SpareWidth 10


@implementation TasteNotesView
{
    NSArray *contentArray;
}
-(UITextView *)mytextView{
    
    if (_mytextView == nil) {
        
        _mytextView = [[UITextView alloc]init];
        _mytextView.layer.borderWidth = 1.0f;
        _mytextView.layer.borderColor = [UIColor blackColor].CGColor;
        _mytextView.font = TR_Font_Gray(15);
        _mytextView.delegate = self;
        _mytextView.textColor = [UIColor grayColor];
        _mytextView.text = @"输入您的要求";
    }
    return _mytextView;
}

-(NSMutableSet *)myset{
    
    if (_myset == nil) {
        _myset = [NSMutableSet set];
    }
    return _myset;
}

-(UIView *)countView{
    if (_countView == nil) {
        _countView = [[UIView alloc]init];
        _countView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_countView];
    }
    return _countView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        [self designViewWith:@{}];
    }
    return self;
}



-(void)designViewWith:(NSDictionary *)contentDic{
    
     __weak typeof(self) weakSelf = self;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"提醒商家";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = TR_Font_Mdeium(18);
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = TR_Font_Gray(15);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chooseDone:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
   
    //布局可以点击的button  默认一行5个  间距一样  传入的个数默认是8个
    int count = 5;
   // int btnCount = 8;
    CGFloat width = 60 ;
    CGFloat height = 20;
    contentArray = @[@"不吃辣",@"不吃葱",@"不吃姜",@"不吃蒜",@"多点辣",@"不吃香菜",@"不吃蔬菜",@"多点香菜",@"多点菜",@"不吃醋"];
    CGFloat spare = (SCREEN_WIDTH - width * count) / (count + 1);
    for (int i = 0; i < 10; i ++) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.layer.borderWidth = 1.0f;
        tempBtn.layer.borderColor = [UIColor blackColor].CGColor;
        tempBtn.backgroundColor = [UIColor clearColor];
        tempBtn.tag = 1000 + i;
         tempBtn.titleLabel.font = TR_Font_Gray(14);
        [tempBtn setTitle:contentArray[i] forState:UIControlStateNormal];
           [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tempBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [tempBtn addTarget:self action:@selector(chooseDoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tempBtn];
        [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((spare + width)*(i%5) + spare);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(2 *SpareWidth + (height + SpareWidth)*(i / 5));
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
    }
    
    [self addSubview:self.mytextView];
    [self.mytextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 100));
    }];
    
    
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.textColor = [UIColor blackColor];
    countLabel.text = @"餐具数量";
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    countLabel.font = TR_Font_Mdeium(15);
    countLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
    make.top.mas_equalTo(weakSelf.mytextView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    CGFloat btnWidth = 25;
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(countLabel.mas_centerY);
        make.height.mas_equalTo(btnWidth);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(btnWidth * 3);
    }];
    [self addcountkey];
    
}

//添加数目的按键
- (void)addcountkey {
    
     CGFloat btnWidth = 25;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shop_delete"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.cornerRadius = btnWidth / 2;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.countView addSubview:btn];
    btn.tag = 1001;
    [btn addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"1";
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.countView addSubview:self.numlabel];
    self.numlabel.textAlignment = NSTextAlignmentCenter;
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnWidth);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"shop_add"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.layer.cornerRadius = btnWidth / 2;
    btn2.layer.masksToBounds = YES;
    [self.countView addSubview:btn2];
    [btn2 addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1002;
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnWidth * 2);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
}
//点击数目的事件
-(void)countnumber:(UIButton *)sender {
    
    if (sender.tag == 1002) {
        
        self.count = self.numlabel.text.intValue;
        self.count ++ ;
        self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];

    }else {
        //如果点击的是减号，先判断是否为0
        self.count = self.numlabel.text.intValue;
        if (self.count > 0) {
            self.count -- ;
            self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        }
    }
    
    UIButton *btn = [self.countView viewWithTag:1001];
    
    if (self.count > 0) {
        
        self.numlabel.hidden = NO;
        
        btn.hidden = NO;
        
    }else {
        self.numlabel.hidden = YES;
        
        btn.hidden = YES;
    }
    
}






-(void)chooseDoneAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    [self.myset addObject:contentArray[sender.tag - 1000]];
    
    
}








-(void)chooseDone:(UIButton *)sender{
    
    if (self.myset.count == 0 && [self.mytextView.text isEqualToString:@"输入您的要求"] && self.count == 0) {
        
        TR_Message(@"输入内容为空!");
        
        return;
    }
    
    NSMutableString *descrip = [[NSMutableString alloc]init];
    
    for (NSString *desc in self.myset) {
        
        
        [descrip appendString:desc];
        
    }
    
    if (![self.mytextView.text isEqualToString:@"输入您的要求"]) {
        [descrip appendFormat:@" %@", [NSString stringWithFormat:@"%@",self.mytextView.text]];
    }
    
    if (self.count > 0) {
        [descrip appendFormat:@" 餐具数量:%@", [NSString stringWithFormat:@"%d",self.count]];
    }
    
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDescriptionSuccess:)]) {
        [self.delegate chooseDescriptionSuccess:descrip];
    }
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"输入您的要求"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"输入您的要求";
        textView.textColor = [UIColor grayColor];
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
