//
//  ShopBotCarView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopBotCarView.h"

#define BtnGray [UIColor groupTableViewBackgroundColor]

@implementation ShopBotCarView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //  [self createLines];
        
        
        UIImageView *bottomImageV = [[UIImageView alloc]init];
        
        bottomImageV.frame = self.bounds;
        
        [self addSubview:bottomImageV];
        
        
        bottomImageV.image = [UIImage imageNamed:@"shop_shoaw"];
        
        UIImageView *shopImageV = [[UIImageView alloc]init];
        
        _shopimageV = shopImageV;
        
        _shopimageV.image = [UIImage imageNamed:@"shop_unselected"];
        
        [self addSubview:shopImageV];
        
        [shopImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(50, 70));
        }];
        
        UILabel *priceLable = [[UILabel alloc]init];
        _pricelable = priceLable;
        priceLable.adjustsFontSizeToFitWidth = YES;
        priceLable.textAlignment = NSTextAlignmentCenter;
        
        priceLable.attributedText = [self setText:@"共￥0" andText2:@"0" withisGray:NO];
        
        [self addSubview:priceLable];
        
        [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(shopImageV);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(shopImageV.mas_right).offset(5);
            
        }];
        
        UIButton *settmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _settmentBtn = settmentBtn;
        
        settmentBtn.titleLabel.font = TR_Font_Gray(15);
        
        settmentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [settmentBtn setTitleColor:TR_COLOR_RGBACOLOR_A(80, 80, 80, 1) forState:UIControlStateNormal];
        
        settmentBtn.backgroundColor = BtnGray;
        
        settmentBtn.layer.cornerRadius = 3.0f;
        
        settmentBtn.layer.masksToBounds = YES;
        
        settmentBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [settmentBtn addTarget:self action:@selector(handleSettlement) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:settmentBtn];
        
        [settmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(priceLable);
            make.bottom.mas_equalTo(shopImageV);
            make.height.mas_equalTo(20);
            
            make.width.mas_equalTo(80);
            
        }];
        
        
        UIButton *contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [contentBtn addTarget:self action:@selector(handleSettlement) forControlEvents:UIControlEventTouchUpInside];
        
        contentBtn.backgroundColor = [UIColor clearColor];
        
        [self addSubview:contentBtn];
        
        [contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
            make.top.mas_equalTo(30);
            
            make.width.mas_equalTo(frame.size.width *0.75 );
        }];
        
    }
    
    return self;
}









//获取数据库中的数据

-(void)getGoodsCountAction{
    
    NSArray *dataArray = [[GoodsListManager shareInstance]getGoodsCount:self.model.store_id];
    
    NSInteger count = 0;
    CGFloat goodsPrice = 0.0f;
    
    for (GoodsShopModel *goodsModel in dataArray) {
        
        count = [goodsModel.goodnum integerValue] + count;
        
        if ([goodsModel.gooddiscountprice doubleValue] > 0) {
            
            CGFloat discount = [goodsModel.gooddiscountprice doubleValue] * 0.1;
            
            goodsPrice = goodsPrice + [goodsModel.goodprice floatValue] * [goodsModel.goodnum doubleValue] * discount + [goodsModel.goodpick doubleValue] * [goodsModel.goodnum doubleValue];
            
        }else if ([goodsModel.is_skill isEqualToString:@"1"]){
            
            if ([goodsModel.goodnum integerValue] > 1) {
                //有优惠价格时候 第一份优惠  第二份  原价
                goodsPrice = goodsPrice + [goodsModel.skillprice floatValue] +[goodsModel.o_price doubleValue]* ([goodsModel.goodnum doubleValue ] - 1) + [goodsModel.goodpick doubleValue] * [goodsModel.goodnum doubleValue];
            }else{
                
               goodsPrice = goodsPrice + [goodsModel.skillprice floatValue] + [goodsModel.goodpick doubleValue];
            }
            
            
        }else{
           
             goodsPrice = goodsPrice + [goodsModel.goodprice floatValue] * [goodsModel.goodnum doubleValue] + [goodsModel.goodpick doubleValue] * [goodsModel.goodnum doubleValue];
        }
       
        
    }
    
    
    
    if (count > 0) {
        
        NSString * all_price = [TRClassMethod stringNumfloat:[NSString stringWithFormat:@"%.2f",goodsPrice]];
        
        _pricelable.attributedText = [self setText:[NSString stringWithFormat:@"共￥%@",all_price] andText2:all_price withisGray:YES];
        
        _shopimageV.image = [UIImage imageNamed:@"shop_selected"];
        
        if (goodsPrice >= [self.model.delivery_price doubleValue]) {
            
            _settmentBtn.backgroundColor = ORANGECOLOR;
            [_settmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _settmentBtn.userInteractionEnabled = YES;
            [_settmentBtn setTitle:@"结算" forState:UIControlStateNormal];
            
        }else{
            
            
            NSString *temprice = [NSString stringWithFormat:@"%.2f",[self.model.delivery_price doubleValue] - goodsPrice];
            
            temprice = [NSString stringWithFormat:@"差￥%@起送",[TRClassMethod stringNumfloat:temprice]];
            
            _settmentBtn.backgroundColor = BtnGray;
            [_settmentBtn setTitle:temprice forState:UIControlStateNormal];
            
            _settmentBtn.userInteractionEnabled = NO;
            
            [_settmentBtn setTitleColor:TR_COLOR_RGBACOLOR_A(80, 80, 80, 1) forState:UIControlStateNormal];
            
        }
        
    }else{
        
        _pricelable.attributedText = [self setText:@"共￥0" andText2:@"0" withisGray:NO];
        
        _shopimageV.image = [UIImage imageNamed:@"shop_unselected"];
        
        self.settmentBtn.backgroundColor = BtnGray;
        self.settmentBtn.userInteractionEnabled = NO;
        [self.settmentBtn setTitle:[NSString stringWithFormat:@"￥%@起送",self.model.delivery_price] forState:UIControlStateNormal];
        [_settmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:ORDERTYPE]) {
        
        [self handleSettlement];
    }
    
    
}




-(void)handleSettlement {
    
    
    NSArray *dataArray = [[GoodsListManager shareInstance]getGoodsCount:self.model.store_id];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clicksettmentaction:)]) {
        
        [self.delegate clicksettmentaction:dataArray];
        
    }
    
}








-(void)createLines{
    
    CAShapeLayer *linepath;
    
    linepath = [CAShapeLayer layer];
    
    [linepath setFillColor:[[UIColor whiteColor] CGColor]];
    [linepath setStrokeColor:[[UIColor grayColor] CGColor]];
    linepath.lineWidth = 1.0f ;
    
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    [path moveToPoint:CGPointMake(0, self.frame.size.height)];
    
    [path addLineToPoint:CGPointMake(0, 0)];
    
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height) controlPoint:CGPointMake(self.frame.size.width * 0.85, self.frame.size.height * 0.05f)];
    
    
    [path closePath];
    
    linepath.path = path.CGPath;
    
    [self.layer addSublayer:linepath];
    
    
}


- (NSMutableAttributedString *) setText:(NSString *)text andText2:(NSString *)mtext2 withisGray:(BOOL)isGray{
    
    NSString *text1=text;
    
    NSString *text2=mtext2;
    
    UIColor *tempColor1 = isGray ? [UIColor blackColor] : GRAY_Text_COLOR;
    
    UIColor *tempColor2 = isGray ? [UIColor redColor] : GRAY_Text_COLOR;
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:tempColor1,
                              NSFontAttributeName:[UIFont systemFontOfSize:14]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    
    NSRange redTextRange =[text1 rangeOfString:text2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:tempColor2,NSFontAttributeName:[UIFont systemFontOfSize:17]} range:redTextRange];
    
    return attributedText;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
