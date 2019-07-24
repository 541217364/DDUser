//
//  ShopSearchCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopSearchCell.h"

@implementation ShopSearchCell

{
    CGRect buttonF;
    CALayer *layer;
    CGFloat btnWidth;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    static float space = 5;
    WeakSelf;
    
    if (self) {
        self.headimageView = [[UIImageView alloc]init];
        self.headimageView.backgroundColor = [UIColor redColor];
        self.headimageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.headimageView];
        [self.headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(space);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        self.namelabel = [[UILabel alloc]init];
        self.namelabel.text = @"香辣鸡腿堡";
        self.namelabel.textColor = [UIColor blackColor];
        self.namelabel.font = [UIFont systemFontOfSize:14];
        self.namelabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.namelabel];
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.headimageView.mas_right).offset(10);
            make.top.mas_equalTo(weakself.headimageView.mas_top);
            make.right.mas_equalTo(-space);
            make.height.mas_equalTo(15);
        }];
        
        self.salecount = [[UILabel alloc]init];
        self.salecount.font = TR_Font_Gray(15);
        self.salecount.textColor = GRAY_Text_COLOR;
        self.salecount.text = @"月销2666";
        self.salecount.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.salecount];
        [self.salecount mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakself.namelabel.mas_left);
            make.top.mas_equalTo(weakself.namelabel.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = TR_Font_Gray(15);
        self.titleLabel.textColor = GRAY_Text_COLOR;
        //        self.titleLabel.text = @"8折";
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.namelabel.mas_left);
            make.top.mas_equalTo(weakself.salecount.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        self.oldpricelabel = [[UILabel alloc]init];
        self.oldpricelabel.font = TR_Font_Gray(15);
        self.oldpricelabel.text = @"￥30";
        self.oldpricelabel.backgroundColor = [UIColor clearColor];
        self.oldpricelabel.textColor = GRAY_Text_COLOR;
        self.oldpricelabel.textAlignment = NSTextAlignmentLeft;
        self.oldpricelabel.hidden = YES;
        [self addSubview:self.oldpricelabel];
        [self.oldpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.titleLabel.mas_left);
            make.top.mas_equalTo(weakself.titleLabel.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        
        
        self.pricelabel = [[UILabel alloc]init];
        self.pricelabel.font = TR_Font_Gray(15);
        self.pricelabel.backgroundColor = [UIColor clearColor];
        self.pricelabel.textColor = ORANGECOLOR;
        self.pricelabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.pricelabel];
        [self.pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.titleLabel.mas_left);
            make.top.mas_equalTo(weakself.titleLabel.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        
        // 添加商品的按键
        
        btnWidth = 25;
        self.countView = [[UIView alloc]init];
        [self.contentView addSubview:self.countView];
        self.countView.backgroundColor = [UIColor whiteColor];
        self.countView.userInteractionEnabled = YES;
        [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakself.pricelabel.mas_centerY);
            make.height.mas_equalTo(btnWidth);
            make.right.mas_equalTo(-2 * space);
            make.width.mas_equalTo(btnWidth * 3);
        }];
        [self addcountkey];
        
        
        // 选规格   与上一个互斥  根据返回的数据判断
        UIButton *sizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sizeBtn setTitle:@"选规格" forState:UIControlStateNormal];
        sizeBtn.titleLabel.font = TR_Font_Gray(14);
        sizeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [sizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sizeBtn.tag = 3000;
        sizeBtn.hidden = YES;
        sizeBtn.layer.cornerRadius = 5.0f;
        sizeBtn.layer.masksToBounds = YES;
        
        sizeBtn.backgroundColor = ORANGECOLOR;
        [sizeBtn addTarget:self action:@selector(addTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sizeBtn];
        [sizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakself.pricelabel.mas_centerY);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(-2 * space);
            make.width.mas_equalTo(60);
        }];
        
    }
    return self;
}
//添加数目的按键
- (void)addcountkey {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"-" forState:UIControlStateNormal];
    btn.backgroundColor = ORANGECOLOR;
    btn.layer.cornerRadius = btnWidth / 2;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.countView addSubview:btn];
    btn.tag = 1001;
    btn.hidden = YES;
    [btn addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.text = @"0";
    self.numlabel.hidden = YES;
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.countView addSubview:self.numlabel];
    self.numlabel.textAlignment = NSTextAlignmentCenter;
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnWidth);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"+" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = ORANGECOLOR;
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
        buttonF = sender.frame;
        self.count = self.numlabel.text.intValue;
        self.count ++ ;
        self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        //判断是否需要播放动画
        if (_isPlay) {
            //[self handleGroupAnimation:sender];
        }
        
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








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
