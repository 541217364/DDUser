//
//  ShopGoodItemView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopGoodItemView.h"
#import "GoodShopManagement.h"

@interface ShopGoodItemView()

@property (nonatomic, strong) GoodsShopModel *goodModel;

@property (nonatomic, strong) StoreDataModel *storeModel;

@end

@implementation ShopGoodItemView

- (instancetype)init {
    
    self=[super init];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;
        
        
        _picImgView=[[UIImageView alloc]init];
    //    _picImgView.backgroundColor=[UIColor redColor];
        [self addSubview:_picImgView];
        
        [_picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            
            make.top.mas_equalTo(5);
            
            make.size.mas_equalTo(CGSizeMake(60,60));
            
        }];
        
        _pricelabel=[[UILabel alloc]init];
       
        _pricelabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:_pricelabel];
        
        [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.picImgView.mas_top).offset(0);
           
            make.size.mas_equalTo(CGSizeMake(80,20));
            
        }];
        
        
        _goodNamelabel=[[UILabel alloc]init];
        
        _goodNamelabel.textAlignment=NSTextAlignmentLeft;
        _goodNamelabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_goodNamelabel];
        
        [_goodNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picImgView.mas_right).offset(10);
            
            make.top.equalTo(weakSelf.picImgView.mas_top).offset(0);
            
            make.height.mas_equalTo(20);
            
            make.right.equalTo(weakSelf.pricelabel.mas_left).offset(0);
            
        }];
        
        _attbrutelabel=[[UILabel alloc]init];
        _attbrutelabel.textAlignment=NSTextAlignmentLeft;
        _attbrutelabel.textColor=TR_TEXTGrayCOLOR;
        _attbrutelabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:_attbrutelabel];
        
        [_attbrutelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.goodNamelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.goodNamelabel.mas_bottom).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(150,20));
            
        }];
        
        _plusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_plusbtn setImage:[UIImage imageNamed:@"plus_shopcar"] forState:UIControlStateNormal];
        [self addSubview:_plusbtn];
        [_plusbtn addTarget:self action:@selector(plusbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        _minusbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_minusbtn setImage:[UIImage imageNamed:@"seacg_goodminus"] forState:UIControlStateNormal];
        [self addSubview:_minusbtn];
        [_minusbtn addTarget:self action:@selector(minusbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_plusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.attbrutelabel.mas_bottom).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(25,25));
            
        }];
        
        _numlabel=[[UILabel alloc]init];
      
        _numlabel.textAlignment=NSTextAlignmentCenter;
        
        [self addSubview:_numlabel];
        
        
        [_numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.plusbtn.mas_left).offset(-5);
            
            make.top.equalTo(weakSelf.plusbtn.mas_top).offset(0);
            
            make.height.mas_equalTo(25);
            
        }];
      
        [_minusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.plusbtn.mas_top).offset(0);
            
            make.right.equalTo(weakSelf.numlabel.mas_left).offset(-5);
            
            make.size.mas_equalTo(CGSizeMake(25,25));
            
        }];
        
//        UIView *line=[[UIView alloc]init];
//        
//        line.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
//        
//        [self addSubview:line];
//        
//        
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
//            
//            make.left.mas_equalTo(0);
//            
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-55,1));
//            
//        }];
        
    }
    
    return self;
}



//- (void) loadStoreData:(StoreDataModel *)smodel  andGoodData:(GoodDataModel *)gmodel  specData:(DBGoodSpecModel*)specmodel {
//    
//    _storeModel=smodel;
//    
//    _goodModel=gmodel;
//    
//    _specModel=specmodel;
//    
//    [_picImgView sd_setImageWithURL:[NSURL URLWithString:gmodel.goodimg]];
//    _goodNamelabel.text=_goodModel.goodname;
//    
//    if (_goodModel.specs.count!=0&&_specModel) {
//        
//        _pricelabel.text=[NSString stringWithFormat:@"¥%@",_specModel.specprice];
//        
//        _attbrutelabel.text=[NSString stringWithFormat:@"%@ ",_specModel.specname];
//        
//        _numlabel.text=[NSString stringWithFormat:@"%@",_specModel.specnum];
//        
//        
//    }
//}


- (void) loadStoreData:(StoreDataModel *)smodel  andGoodData:(GoodsShopModel *)gmodel {
    
    
    _storeModel=smodel;
    
    _goodModel=gmodel;
    
    
    [_picImgView sd_setImageWithURL:[NSURL URLWithString:gmodel.goodimg] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
  
    _goodNamelabel.text=_goodModel.goodname;
    
    _pricelabel.text=[NSString stringWithFormat:@"¥%@",_goodModel.goodprice];
    
    if (_goodModel.attributename.length!=0&&_goodModel.specname.length!=0) {
        _attbrutelabel.text=[NSString stringWithFormat:@"%@ %@",_goodModel.specname,_goodModel.attributename];

    }
    
    if (_goodModel.attributename.length!=0&&_goodModel.specname.length==0) {
        _attbrutelabel.text=[NSString stringWithFormat:@"%@",_goodModel.attributename];

    }
    
    if (_goodModel.attributename.length==0&&_goodModel.specname.length!=0) {
        _attbrutelabel.text=[NSString stringWithFormat:@"%@",_goodModel.specname];
        
    }
    
    
    _numlabel.text=[NSString stringWithFormat:@"%@",_goodModel.goodnum];
    
    if (_goodModel.specprice.length!=0) {
        _pricelabel.text=[NSString stringWithFormat:@"¥%@",_goodModel.specprice];

    }
    
}


- (void)minusbtnclick:(UIButton *) button {
    
    NSInteger num=[_numlabel.text integerValue];
    
    num--;
    
    if (num==0) {
        
        _minusbtn.hidden=YES;
        _numlabel.hidden=YES;
        _numlabel.text=@"0";
        
    }
    
 
        if (num==0) {
            _goodModel.goodnum=@"0";
           
        }
    
        _goodModel.goodnum=[NSString stringWithFormat:@"%ld",num];;
    
    

    _numlabel.text=[NSString stringWithFormat:@"%ld",num];
    [[GoodShopManagement shareInstance] deleteStore:_storeModel andGoodshopmodel:_goodModel];
  
    _goodModel.goodnum=@"0";

    if (_delegate&&[_delegate respondsToSelector:@selector(loadshopGood:)]) {
        
        [_delegate loadshopGood:_goodModel];
    }


}

- (void)plusbtnclick:(UIButton *) button {
    
    NSInteger num=[_numlabel.text integerValue];
    
    if (num==0) {
        _minusbtn.hidden=NO;
        _numlabel.hidden=NO;
    }

    num++;
    
    _numlabel.text=[NSString stringWithFormat:@"%ld",num];
    
    
    _goodModel.goodnum=[NSString stringWithFormat:@"%ld",num];
        
    

    if (_delegate&&[_delegate respondsToSelector:@selector(loadshopGood:)]) {
        
        [_delegate loadshopGood:_goodModel];
        
    }
    [[GoodShopManagement shareInstance] addStore:_storeModel andGoodshopmodel:_goodModel];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
