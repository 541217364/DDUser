//
//  BusinessCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell
{
    CGRect buttonF;
    CALayer *layer;
    CGFloat btnWidth;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static float space = 5;
    WeakSelf;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.headimageView = [[UIImageView alloc]init];
        self.headimageView.backgroundColor = [UIColor clearColor];
        self.headimageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.headimageView];
        [self.headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(space);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];

        self.namelabel = [[UILabel alloc]init];
        self.namelabel.text = @"香辣鸡腿堡";
        self.namelabel.textColor = [UIColor colorWithRed:25.5026/255.0 green:25.5026/255.0 blue:25.5026/255.0 alpha:1];
        self.namelabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:15];
        self.namelabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.namelabel];
        [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.headimageView.mas_right).offset(10);
            make.top.mas_equalTo(weakself.headimageView.mas_top);
            make.right.mas_equalTo(-space);
            make.height.mas_equalTo(15);
        }];

        self.salecount = [[UILabel alloc]init];
        self.salecount.font = TR_Font_Gray(14);
        self.salecount.textColor = [UIColor grayColor];
        self.salecount.text = @"月销2666";
        self.salecount.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.salecount];
        [self.salecount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.headimageView.mas_right).offset(10);
            make.top.mas_equalTo(weakself.namelabel.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(150, 15));
        }];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = TR_Font_Gray(14);
        self.titleLabel.textColor = GRAY_Text_COLOR;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.namelabel.mas_left);
        make.top.mas_equalTo(weakself.salecount.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(200, 15));
        }];
        
        self.oldpricelabel = [[UILabel alloc]init];
        self.oldpricelabel.font = TR_Font_Gray(14);
        self.oldpricelabel.text = @"￥30";
        self.oldpricelabel.backgroundColor = [UIColor clearColor];
        self.oldpricelabel.textColor = GRAY_Text_COLOR;
        self.oldpricelabel.textAlignment = NSTextAlignmentLeft;
        self.oldpricelabel.hidden = YES;
        [self addSubview:self.oldpricelabel];
        [self.oldpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.titleLabel.mas_left);
            make.top.mas_equalTo(weakself.titleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(50);
        }];
    
        
        self.pricelabel = [[UILabel alloc]init];
        self.pricelabel.font = TR_Font_Gray(14);
        self.pricelabel.backgroundColor = [UIColor clearColor];
        self.pricelabel.textColor = [UIColor colorWithRed:249/255.0 green:101.003/255.0 blue:91.0019/255.0 alpha:1];
        self.pricelabel.textAlignment = NSTextAlignmentLeft;
        self.pricelabel.numberOfLines = 0;
        [self addSubview:self.pricelabel];
        [self.pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.oldpricelabel.mas_right);
        make.top.mas_equalTo(weakself.titleLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(60);
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
            make.right.mas_equalTo(-space);
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
        sizeBtn.layer.cornerRadius = 10.0f;
        sizeBtn.layer.masksToBounds = YES;
       
        sizeBtn.backgroundColor = ORANGECOLOR;
        [sizeBtn addTarget:self action:@selector(addTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sizeBtn];
        [sizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.pricelabel.mas_centerY);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(-space);
        make.width.mas_equalTo(60);
                }];
        
        
        if (SCREEN_WIDTH < 375) {
            [self.countView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(weakself.titleLabel.mas_centerY);
                make.height.mas_equalTo(20);
                make.right.mas_equalTo(-space / 2);
                make.width.mas_equalTo(btnWidth * 3);
            }];
            
            [sizeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(weakself.titleLabel.mas_centerY);
                make.height.mas_equalTo(20);
                make.right.mas_equalTo(-space / 2);
                make.width.mas_equalTo(60);
            }];
        }
        
        //选择商品的数量
        
        self.selectCountLabel = [[UILabel alloc]init];
        self.selectCountLabel.backgroundColor = [UIColor redColor];
        self.selectCountLabel.font = [UIFont systemFontOfSize:14];
        self.selectCountLabel.textAlignment = NSTextAlignmentCenter;
        self.selectCountLabel.textColor = [UIColor whiteColor];
        self.selectCountLabel.layer.cornerRadius = 10.0f;
        self.selectCountLabel.layer.masksToBounds = YES;
        self.selectCountLabel.hidden = YES;
        [self.contentView addSubview:self.selectCountLabel];
        [self.selectCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(sizeBtn.mas_right);
            make.bottom.mas_equalTo(sizeBtn.mas_top).offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
    }
    return self;
}
//添加数目的按键
- (void)addcountkey {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shop_delete"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
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
    
    NSString *clicktype;
   
    if (sender.tag == 1002) {
        
        if ([self.model.selectCount integerValue] == [self.model.stock integerValue]) {
           
            TR_Message(@"商品库存不足");
            
            return;
        }
        
        if ([self.model.selectCount integerValue] == [self.model.max_num integerValue]) {
            
            if ([self.model.max_num integerValue] != 0) {
                
                TR_Message(@"限购商品无法选择更多");
                
                return;
                
            }
            
        }
        
        buttonF = sender.frame;
        self.count = self.numlabel.text.intValue;
        self.count ++ ;
        clicktype = @"jia";
        
       
        
        self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        //判断是否需要播放动画
        if (_isPlay) {
            
          [self handleGroupAnimation:sender];
        }
        
    }else {
        //如果点击的是减号，先判断是否为0
        self.count = self.numlabel.text.intValue;
        if (self.count > 0) {
            self.count -- ;
            clicktype = @"jian";
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
    
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCountView:withIndexpath:)]) {
        
        if (clicktype.length > 0 && self.indexpath) {
            
            [self.delegate clickCountView:clicktype withIndexpath:self.indexpath];
        }
    }
    
}
- (void)handleGroupAnimation:(UIButton *)btn {
    //获取点击按钮相对于屏幕的坐标
     buttonF = [btn convertRect:btn.bounds toView:[UIApplication sharedApplication].keyWindow];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(buttonF.origin.x, buttonF.origin.y)];
    [path addQuadCurveToPoint:CGPointMake(40, SCREEN_HEIGHT - 40) controlPoint:CGPointMake(100, 200)];
    if (!layer) {
        layer = [CALayer layer];
        layer.contents = (__bridge id)self.headimageView.image.CGImage;
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = CGRectMake(0, 0, 15, 15);
        [layer setCornerRadius:CGRectGetHeight([layer bounds]) / 2];
        layer.masksToBounds = YES;
    }
    layer.position =CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:layer];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CAKeyframeAnimation *keyFrame2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyFrame2.values = @[@1.0, @1.2, @1.4, @1.6, @1.8, @2.0, @1.8, @1.6,@1.4, @1.2, @1.0];
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,keyFrame2];
    groups.duration = 0.3f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];
}
//动画结束的时候移除视图
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
      [layer removeFromSuperlayer];
}



//数据处理
-(void)handWithDatasource:(NSArray *)datasource{
    
    UIButton *btn = [self.countView viewWithTag:1001];
        self.numlabel.hidden = YES;
        
        btn.hidden = YES;
        self.count = 0;
    
    //两个价格label 一个默认隐藏了  两个位置重合的  根据数据重新更新一下位置
    
}




//选规格操作
-(void)addTypeAction:(UIButton *)sender{
    //选规格btn的tag 等于3000  通过数据设置是否隐藏
    //参数数组传递
    if ([self.delegate respondsToSelector:@selector(addFoodType:)]) {
        [self.delegate addFoodType:@[self.indexpath]];
    }
}



//添加数据
-(void)parseDatasourceWithModel:(ProductItem *)model{
    if (model) {
        WeakSelf;
        self.model = model;
        [self.headimageView sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        self.namelabel.text = model.product_name;
        self.salecount.text =[NSString stringWithFormat:@"月售%@%@",model.product_sale,model.unit];
        
    
      
        
        if ([model.sort_discount doubleValue] > 0) {
            
        self.oldpricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:model.o_price]] withPriceType:1];
        self.oldpricelabel.hidden = NO;
        self.titleLabel.textColor = TR_MainColor;
        NSString *maxNum = [model.max_num integerValue] == 0 ? @"无限购":[NSString stringWithFormat:@"限%@",model.max_num];

        self.titleLabel.text = [NSString stringWithFormat:@"%@折 %@",model.sort_discount,maxNum];
            
        NSString *discount_money = [NSString stringWithFormat:@"%.2f",[model.o_price doubleValue] * [model.sort_discount doubleValue] * 0.1];
            
        self.pricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:discount_money]] withPriceType:0];
            
            [self.pricelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakself.oldpricelabel.mas_right);
                make.top.mas_equalTo(weakself.titleLabel.mas_bottom).offset(5);
                make.width.mas_equalTo(70);
            }];
            
        }else{
            
            self.titleLabel.text = @"";
            
            if ([model.stock integerValue ] <= 0) {
                
            self.titleLabel.textColor = TR_MainColor;
                
            self.titleLabel.text = @"库存不足";
              
            }
            
        self.oldpricelabel.hidden = YES;
            
        self.pricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:model.o_price]] withPriceType:0];
        
        [self.pricelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(weakself.oldpricelabel.mas_left);
                make.top.mas_equalTo(weakself.titleLabel.mas_bottom).offset(5);
                make.width.mas_equalTo(70);
            }];
            
//            if ([model.max_num integerValue ] > 0) {
//
//                self.titleLabel.text = [NSString stringWithFormat:@"限购%@",model.max_num];
//                self.titleLabel.textColor = [UIColor redColor];
//                if ([model.max_num integerValue] > 999) {
//                    self.titleLabel.text = @"无限购";
//                }
//            }
            
        }
        
        
        
        
         //判断添加商品的规格
         UIButton *tempBtn3 =    [self.contentView viewWithTag:3000];
        if ([model.has_format isEqualToString:@"1"]) {
            
            self.countView.hidden = YES;
            tempBtn3.hidden = NO;
            if ([model.selectCount integerValue] > 0) {
                self.selectCountLabel.hidden = NO;
                self.selectCountLabel.text = model.selectCount;
            }
            else{
               self.selectCountLabel.hidden = YES;
            }
            
            
            
        }else {
            
            tempBtn3.hidden = YES;
            self.selectCountLabel.hidden = YES;
            self.countView.hidden = NO;
            
        }
        
        if ([model.stock integerValue] <= [self.model.selectCount integerValue]) {
            
            self.countView.userInteractionEnabled = NO;
            
            tempBtn3.userInteractionEnabled = NO;
            
            tempBtn3.backgroundColor = [UIColor lightGrayColor];
            
            UIButton *tempBtn = [self.countView viewWithTag:1002];
            [tempBtn setImage:[UIImage imageNamed:@"shop_add2"] forState:UIControlStateNormal];
            
        }else{
            self.countView.userInteractionEnabled = YES;
            
            tempBtn3.userInteractionEnabled = YES;
            
            tempBtn3.backgroundColor = ORANGECOLOR;
            
            UIButton *tempBtn = [self.countView viewWithTag:1002];
            [tempBtn setImage:[UIImage imageNamed:@"shop_add"] forState:UIControlStateNormal];
            
        }
       
    }
    
    //判断是否添加过商品
    UIButton *tempBtn = (UIButton *)[self.countView viewWithTag:1001];
    if ([model.selectCount integerValue] > 0) {
        tempBtn.hidden = NO;
        self.numlabel.hidden = NO;
        self.numlabel.text = model.selectCount;
    }else{
        self.numlabel.hidden = YES;
        tempBtn.hidden = YES;
    }
    
}


-(void)designCountWithOutData{
    UIButton *tempBtn = (UIButton *)[self.countView viewWithTag:1001];
    tempBtn.hidden = YES;
    self.numlabel.hidden = YES;
    self.numlabel.text = @"0";
    
}

-(void)designCountWithData:(NSString *)countGoods{
    UIButton *tempBtn = (UIButton *)[self.countView viewWithTag:1001];
    
    if (![countGoods isEqualToString:@"0"]) {
        tempBtn.hidden = NO;
        self.numlabel.hidden = NO;
        self.numlabel.text = countGoods;
    }else{
        tempBtn.hidden = YES;
        self.numlabel.hidden = YES;
        self.numlabel.text = countGoods;
        
    }
    
    
    
}


- (NSAttributedString *)attributedText:(NSArray*)stringArray withPriceType:(int )type {
    
    //默认type= 0 红色 现价格 type = 1 灰色  原价
    
    
    NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]};
    NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                      NSForegroundColorAttributeName:[UIColor redColor]};
    if (type == 1) {
        
        attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]};
        attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                          NSForegroundColorAttributeName:[UIColor grayColor]};
    }
    
    NSArray *attributeAttay = @[attributesExtra,attributesPrice];
    NSString * string = [stringArray componentsJoinedByString:@""];
    
    
    
    NSMutableAttributedString * result;
    
    if (type == 0) {
        
        result = [[NSMutableAttributedString alloc]initWithString:string];
        
        for(NSInteger i = 0; i < stringArray.count; i++){
            [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
        }
        
    }else{
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        result = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic];
    }
    
   
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
