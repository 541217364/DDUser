//
//  AdressShippingCell.m
//  送小宝
//
//  Created by xgy on 2017/3/12.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "AdressShippingCell.h"

@implementation AdressShippingCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
        
//        _buyerlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,10,100,20)];
//
//        _buyerlabel.textAlignment=NSTextAlignmentLeft;
//        _buyerlabel.text=@"xx先生";
//       // _buyerlabel.font=[UIFont systemFontOfSize:15];
//        [self addSubview:_buyerlabel];
        
        _addresslabel=[[UILabel alloc]initWithFrame:CGRectMake(40,10,SCREEN_WIDTH-70,40)];
        _addresslabel.textAlignment=NSTextAlignmentLeft;
     //   _addresslabel.textColor=[];
        _addresslabel.numberOfLines=0;
        _addresslabel.text=@"亿升南座25A09";
        [self addSubview:_addresslabel];
        
        
        _buyerPhonelabel=[[UILabel alloc]initWithFrame:CGRectMake(40,_addresslabel.frame.origin.y+_addresslabel.frame.size.height+5,SCREEN_WIDTH-70,20)];
        _buyerPhonelabel.font=[UIFont systemFontOfSize:14];
        _buyerPhonelabel.textColor=TR_COLOR_RGBACOLOR_A(152,152,152,1);
        _buyerPhonelabel.textAlignment=NSTextAlignmentLeft;
        _buyerPhonelabel.text=@"1888888888";
       // _buyerPhonelabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:_buyerPhonelabel];
        
       
        
        _tiplabel=[[UILabel alloc]init];
        
        _tiplabel.frame=CGRectMake(SCREEN_WIDTH-60,20,50,20);
        
        _tiplabel.textColor=TR_COLOR_RGBACOLOR_A(252,178,135,1);
        _tiplabel.layer.borderColor=TR_COLOR_RGBACOLOR_A(252,178,135,1).CGColor;
        _tiplabel.textAlignment=NSTextAlignmentCenter;
        _tiplabel.layer.borderWidth=1;
        [self addSubview:_tiplabel];
        
        
        _showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showMoreBtn.titleLabel.font = TR_Font_Gray(15);
        _showMoreBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_showMoreBtn setTitle:@"展示全部地址" forState:UIControlStateNormal];
        
        [_showMoreBtn setImage:[UIImage imageNamed:@"location_down"] forState:UIControlStateNormal];
        [_showMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_showMoreBtn setTitle:@"收起全部地址" forState:UIControlStateSelected];
         [_showMoreBtn setImage:[UIImage imageNamed:@"location_up"] forState:UIControlStateSelected];
        
        [_showMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        [_showMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        
        [_showMoreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 110, 0, 0)];
        
        [self addSubview:_showMoreBtn];
        
      
        
        UIView *line=[[UIView alloc]init];
        
        line.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
        
        [self addSubview:line];
        __weak typeof(self) weakSelf=self;

        
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(40);
            
            make.top.mas_equalTo(weakSelf.buyerPhonelabel.mas_bottom).offset(15);
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40,1));
            
        }];
        
        
        [_showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_equalTo(line.mas_bottom);
           // make.size.mas_equalTo(CGSizeMake(150, 50));
            make.width.mas_offset(150);
            make.bottom.mas_offset(0);
        }];
        
               
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
