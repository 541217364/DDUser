//
//  GoodsItemCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/17.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "GoodsItemCell.h"

@implementation GoodsItemCell

{
    CGRect buttonF;
    CALayer *layer;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;
        
        _goodImageV = [[UIImageView alloc]init];
        _goodImageV.contentMode = UIViewContentModeScaleAspectFill;
        _goodImageV.backgroundColor = GRAYCLOLOR;
        _goodImageV.userInteractionEnabled = YES;
        _goodImageV.layer.cornerRadius = 4.0f;
        _goodImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:_goodImageV];
        
        [_goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(103*SCREEN_WIDTH/375);
        }];
        
        
        _discountlabel = [[UILabel alloc]init];
        
        _discountlabel.textColor = [UIColor whiteColor];
        
        _discountlabel.text = @"5.13折 限1份";
        
        _discountlabel.font = TR_Font_Gray(13);
        
        _discountlabel.textAlignment = NSTextAlignmentCenter;
        
        _discountlabel.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:_discountlabel];
        
        [_discountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            
            make.bottom.mas_equalTo(weakSelf.goodImageV.mas_bottom);
            
            make.height.mas_equalTo(15);
            
        }];
        
        
        
        _namelabel = [[UILabel alloc]init];
        
        _namelabel.font = TR_Font_Cu(15);
        
        _namelabel.text = @"葱油拌面";
        
        _namelabel.textColor = [UIColor blackColor];
        
        
        [self.contentView addSubview:_namelabel];
        
        [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.goodImageV.mas_left);
            make.top.mas_equalTo(weakSelf.goodImageV.mas_bottom).offset(15);
            make.height.mas_equalTo(15);
            make.right.mas_equalTo(0);
        }];
        
        
        _saleCountlabel = [[UILabel alloc]init];
        
        _saleCountlabel.font = TR_Font_Gray(12);
        
        _saleCountlabel.text = @"月售709 赞6";
        
        _saleCountlabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_saleCountlabel];
        
        [_saleCountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.goodImageV.mas_left);
            make.top.mas_equalTo(weakSelf.namelabel.mas_bottom).offset(10);
            make.height.mas_equalTo(15);
        }];
        
        _stokelabel = [[UILabel alloc]init];
        
        _stokelabel.textColor = [UIColor redColor];
        
        _stokelabel.text = @"库存不足";
        
        _stokelabel.font = TR_Font_Gray(14);
        
        [self.contentView addSubview:_stokelabel];
        
        [_stokelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.goodImageV.mas_left);
        make.top.mas_equalTo(weakSelf.saleCountlabel.mas_bottom).offset(5);
            make.height.mas_equalTo(10);
        }];
        
        
        _nowPricelabel = [[UILabel alloc]init];
        [self.contentView addSubview:_nowPricelabel];
        
        [_nowPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.goodImageV.mas_left);
            make.top.mas_equalTo(weakSelf.stokelabel.mas_bottom).offset(5);
            make.height.mas_equalTo(20);
        }];
    
        
        _selectTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectTypeBtn.backgroundColor = ORANGECOLOR;
        _selectTypeBtn.layer.cornerRadius = 12.0f;
        _selectTypeBtn.layer.masksToBounds = YES;
        _selectTypeBtn.titleLabel.font = TR_Font_Gray(12);
        [_selectTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectTypeBtn.hidden = YES;
        [_selectTypeBtn setTitle:@"选规格" forState:UIControlStateNormal];
        
        [self.contentView addSubview:_selectTypeBtn];
        
        [_selectTypeBtn addTarget:self action:@selector(addGoodsType:) forControlEvents:UIControlEventTouchUpInside];
        
        [_selectTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(weakSelf.nowPricelabel);
            make.size.mas_equalTo(CGSizeMake(55, 25));
        }];
        
    
        _plusNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _plusNumBtn.layer.cornerRadius = 10.0f;
        
        _plusNumBtn.layer.masksToBounds = YES;
        
        _plusNumBtn.hidden = YES;
        
        [_plusNumBtn setImage:[UIImage imageNamed:@"seach_goodplus"] forState:UIControlStateNormal];
        
        [_plusNumBtn addTarget:self action:@selector(addGoodsNum:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_plusNumBtn];
        
        [_plusNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(weakSelf.nowPricelabel);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            
        }];
        
        
        UILabel *goosNumLabel = [[UILabel alloc]init];
        goosNumLabel.backgroundColor = [UIColor redColor];
        goosNumLabel.font = [UIFont systemFontOfSize:10];
        goosNumLabel.textAlignment = NSTextAlignmentCenter;
        goosNumLabel.textColor = [UIColor whiteColor];
        goosNumLabel.adjustsFontSizeToFitWidth = YES;
        goosNumLabel.layer.cornerRadius = 7.5f;
        goosNumLabel.layer.masksToBounds = YES;
        goosNumLabel.hidden = YES;
        _goodsNumlabel = goosNumLabel;
        [self.contentView addSubview:goosNumLabel];
        [goosNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(weakSelf.plusNumBtn.mas_top).offset(5);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        UILabel * seckillpricelabel = [[UILabel alloc]init];
        _seckillpricelabel = seckillpricelabel;
        [self.contentView addSubview:seckillpricelabel];
        [seckillpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nowPricelabel.mas_bottom);
            make.left.mas_equalTo(weakSelf.nowPricelabel);
        }];
        
        
        
    }
    return self;
}





-(void)parseDatasourceWithModel:(ProductItem *)model{
    
    if (model) {
        
        _model = model;
       
        [_goodImageV sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        
        _namelabel.text = model.product_name;
        
        _saleCountlabel.text = [NSString stringWithFormat:@"月售%@  赞%@",model.product_sale,model.product_reply];
        
        if ([model.stock integerValue] == 0) {
            
            _stokelabel.text = @"库存不足";
            
        }else{
            
            _stokelabel.text = @"";
        }
        
       
        if ([model.has_format isEqualToString:@"1"]) {
            //有规格
            
            _nowPricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:model.o_price]] withPriceType:0];
            
            _selectTypeBtn.hidden = NO;
            
            _selectTypeBtn.backgroundColor = ORANGECOLOR;
            
            _selectTypeBtn.userInteractionEnabled = YES;
            
            _plusNumBtn.hidden = YES;
            
            _discountlabel.hidden = YES;
            
            if ([model.sort_discount doubleValue] > 0) {
                
                NSString *max_num = [model.max_num integerValue]==0 ? @"不限购":[NSString stringWithFormat:@"限%@份",model.max_num];
                
                _discountlabel.text = [NSString stringWithFormat:@" %@折 %@",model.sort_discount,max_num];
                
                _discountlabel.hidden = NO;
                _seckillpricelabel.hidden  = NO;
                _seckillpricelabel.attributedText = [self setText2:[NSString stringWithFormat:@"价格 ￥%@",model.o_price] andText2:model.o_price];
                
            }else{
                
                NSString *price = [model.is_seckill_price isEqualToString:@"1"] ? model.product_price:model.o_price;
                _nowPricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:price]] withPriceType:0];
                _seckillpricelabel.hidden  = YES;
                _discountlabel.text = @"限时优惠 限1份";
                _discountlabel.hidden = ![model.is_seckill_price isEqualToString:@"1"] ;
            }
            
        }else{
            
            //没有规格
            
            if ([model.sort_discount doubleValue] > 0) {
                
                NSString *discount_money = [NSString stringWithFormat:@"%.2f",[model.o_price doubleValue] * [model.sort_discount doubleValue] * 0.1];
                
                _nowPricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:discount_money]] withPriceType:0];
                
                
                NSString *max_num = [model.max_num integerValue]==0 ? @"不限购":[NSString stringWithFormat:@"限%@份",model.max_num];
                
                
                _discountlabel.text = [NSString stringWithFormat:@" %@折 %@",model.sort_discount,max_num];
                
               
                _seckillpricelabel.attributedText = [self setText2:[NSString stringWithFormat:@"价格 ￥%@",model.o_price] andText2:model.o_price];
            
                _discountlabel.hidden = NO;
                
                _seckillpricelabel.hidden  = NO;
                
                _plusNumBtn.hidden = NO;
                
                _selectTypeBtn.hidden = YES;
                
                
            }else{
                
                NSString *price = [model.is_seckill_price isEqualToString:@"1"] ? model.product_price:model.o_price;
              _nowPricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:price]] withPriceType:0];
                
                NSString *realPrice = [model.is_seckill_price isEqualToString:@"1"] ? model.o_price:@"";
                _seckillpricelabel.hidden  = ![model.is_seckill_price isEqualToString:@"1"];
                _seckillpricelabel.attributedText = [self setText2:[NSString stringWithFormat:@"价格 ￥%@",realPrice] andText2:realPrice];
               
                _discountlabel.hidden = YES;
                
                _plusNumBtn.hidden = NO;
                
                _selectTypeBtn.hidden = YES;
                
                _seckillpricelabel.hidden  = YES;
            }
            
            
            
            [_plusNumBtn setImage:[UIImage imageNamed:@"seach_goodplus"] forState:UIControlStateNormal];
            _plusNumBtn.userInteractionEnabled = YES;
            
            
        }
        
        
        if ([model.stock integerValue ] == 0) {
           
            //库存不足情况
            
            if ([model.has_format isEqualToString:@"1"]) {
                
                //有规格
                
                _selectTypeBtn.backgroundColor = [UIColor lightGrayColor];
                
                _selectTypeBtn.userInteractionEnabled = NO;
                
                
            }else{
               
                //没有规格情况
                
                [_plusNumBtn setImage:[UIImage imageNamed:@"shop_add2"] forState:UIControlStateNormal];
                
                _plusNumBtn.userInteractionEnabled = NO;
                
            }
            
        }
        
        
        if ([model.selectCount integerValue] > 0) {
            
            _goodsNumlabel.text = model.selectCount;
            
            _goodsNumlabel.hidden = NO;
        }else{
            
            _goodsNumlabel.hidden = YES;
            
            _goodsNumlabel.text = @"0";
        }
        
    }
    
}




//选规格操作

-(void)addGoodsType:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(addFoodType:)]) {
        [self.delegate addFoodType:@[self.indexpath]];
    }
    
}


//添加商品

-(void)addGoodsNum:(UIButton *)sender{
    
    
    NSString *clicktype;
    
        
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
        
        
        clicktype = @"jia";
        
        
        _goodsNumlabel.text = [NSString stringWithFormat:@"%ld",[_goodsNumlabel.text integerValue] + 1];
        _goodsNumlabel.hidden = NO;
        
        //判断是否需要播放动画
        if (_isPlay) {

            [self handleGroupAnimation:sender];
        }
    
    
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCountView:withIndexpath:)]) {
        
        if (clicktype.length > 0 && self.indexpath) {
            
            [self.delegate clickCountView:clicktype withIndexpath:self.indexpath];
        }
    }
    
    
}




- (NSAttributedString *)attributedText:(NSArray*)stringArray withPriceType:(int )type {
    
    //默认type= 0 红色 现价格 type = 1 灰色  原价
    
    
    NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]};
    NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                      NSForegroundColorAttributeName:[UIColor redColor]};
    if (type == 1) {
        
        attributesExtra = @{NSFontAttributeName:TR_Font_Gray(12),NSForegroundColorAttributeName:[UIColor grayColor]};
        attributesPrice = @{NSFontAttributeName:TR_Font_Gray(12),
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
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:TR_Font_Gray(14),NSForegroundColorAttributeName:[UIColor grayColor]};
        result = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic];
        
    }
    
    
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}


- (NSMutableAttributedString *)setText2:(NSString *)text andText2:(NSString *)mtext2 {
    
    NSString *text1=text;
    
    NSString *text2=mtext2;
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor grayColor],
                              NSFontAttributeName:TR_Font_Gray(12)
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    
    NSRange redTextRange =[text1 rangeOfString:text2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:TR_Font_Cu(12),NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:redTextRange];
    
    return attributedText;
    
}

- (void)handleGroupAnimation:(UIButton *)btn {
    //获取点击按钮相对于屏幕的坐标
    buttonF = [btn convertRect:btn.bounds toView:[UIApplication sharedApplication].keyWindow];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(buttonF.origin.x, buttonF.origin.y)];
    [path addQuadCurveToPoint:CGPointMake(30, SCREEN_HEIGHT - 30) controlPoint:CGPointMake(100, 200)];
    if (!layer) {
        layer = [CALayer layer];
        layer.contents = (__bridge id)self.goodImageV.image.CGImage;
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


@end
