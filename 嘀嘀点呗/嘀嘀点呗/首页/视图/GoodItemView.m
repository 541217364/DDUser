//
//  GoodItemView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "GoodItemView.h"
#import "DBManagement.h"
#import "ShopTypeDetailView.h"
#import "SpecAttributeView.h"

@implementation GoodItemView

- (instancetype)init {
    
    self=[super init];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;
        
        _goodImgView=[[UIImageView alloc]init];
        _goodImgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_goodImgView];
        
        [_goodImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.mas_equalTo(0);
            
            make.size.mas_equalTo(CGSizeMake(60,60));
            
        }];
        
        _goodnamelabel=[[UILabel alloc]init];
        _goodnamelabel.font=[UIFont boldSystemFontOfSize:16];
        _goodnamelabel.textColor=TR_COLOR_RGBACOLOR_A(40,40,40,1);

        [self addSubview:_goodnamelabel];
      
        [_goodnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            
            make.left.equalTo(weakSelf.goodImgView.mas_right).offset(10);
            
            make.height.mas_equalTo(20);
        }];
        
        _goodSalelabel=[[UILabel alloc]init];
        _goodSalelabel.font=[UIFont systemFontOfSize:14];
        _goodSalelabel.textColor=TR_TEXTGrayCOLOR;
        [self addSubview:_goodSalelabel];
        
        [_goodSalelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.goodnamelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.goodnamelabel.mas_bottom).offset(0);
            
            make.height.mas_equalTo(20);
            
        }];
        
        _pricelabel=[[UILabel alloc]init];
       
        _pricelabel.font=[UIFont boldSystemFontOfSize:16];
        
        _pricelabel.textColor=TR_COLOR_RGBACOLOR_A(40,40,40,1);
        
        [self addSubview:_pricelabel];
       
        [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.goodnamelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.goodSalelabel.mas_bottom).offset(0);
            
            make.height.mas_equalTo(20);
            
        }];
        
        _plusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_plusbtn setImage:[UIImage imageNamed:@"seach_goodplus"] forState:UIControlStateNormal];
        [_plusbtn addTarget:self action:@selector(plusbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusbtn];
        
        _minusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_minusbtn setImage:[UIImage imageNamed:@"seacg_goodminus"] forState:UIControlStateNormal];
        [_minusbtn addTarget:self action:@selector(minutbtnclick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_minusbtn];
        
        _numlabel=[[UILabel alloc]init];
        
        [self addSubview:_numlabel];
       
        [_plusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.goodSalelabel.mas_bottom).offset(0);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.size.mas_equalTo(CGSizeMake(25,25));
            
        }];
        
        [_numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.goodSalelabel.mas_bottom).offset(0);
            
            make.right.equalTo(weakSelf.plusbtn.mas_left).offset(-5);
            
            make.height.mas_equalTo(25);
        }];
        
        [_minusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.goodSalelabel.mas_bottom).offset(0);
            
            make.right.equalTo(weakSelf.numlabel.mas_left).offset(-5);

            make.size.mas_equalTo(CGSizeMake(25,25));

        }];
        
        
        _specbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_specbtn setTitle:@"选规格" forState:UIControlStateNormal];
        
        _specbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(253,141,67,1);
        _specbtn.layer.cornerRadius=10;
        _specbtn.layer.masksToBounds=YES;
        [_specbtn addTarget:self action:@selector(specbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_specbtn];
        
        [_specbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(80,25));
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.plusbtn.mas_top).offset(-2);
            
        }];
        _specbtn.hidden=YES;
        
    }
    
    return self;
}


- (void)setItem:(GoodItem *)item {
    
    _item=item;
    
    NSInteger num=[_item.goodnum integerValue];
    
    if (num==0) {
        _numlabel.hidden=YES;
        _minusbtn.hidden=YES;
        
    }else{
        _numlabel.text=_item.goodnum;
        _numlabel.hidden=NO;
        _minusbtn.hidden=NO;
    }
    
    if ([item.is_properties integerValue]==1||item.spec_value.length!=0) {
        
        _numlabel.hidden=YES;
        
        _plusbtn.hidden=YES;
        
        _minusbtn.hidden=YES;
        
        _specbtn.hidden=NO;
    };
    
    if ([_item.stock_num integerValue] == 0) {
        
        [_plusbtn setImage:[UIImage imageNamed:@"shop_add2"] forState:UIControlStateNormal];
        
        _specbtn.backgroundColor = [UIColor grayColor];
        
    }else{
       
        [_plusbtn setImage:[UIImage imageNamed:@"seach_goodplus"] forState:UIControlStateNormal];
        _specbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(253,141,67,1);
        
    }
    
}

- (void) minutbtnclick:(UIButton *) button {
    NSInteger num=[_item.goodnum integerValue];
    num--;
    if (num==0) {
        _item.goodnum=@"0";
        
        _numlabel.hidden=YES;
      
        _minusbtn.hidden=YES;
        
    }else{
        
        _item.goodnum=[NSString stringWithFormat:@"%ld",num];
        
    }
    
    _numlabel.text=_item.goodnum;
        
    NSDictionary *dict=[_seachmodel toDictionary];
        
    StoreDataModel *model=[[StoreDataModel alloc]init];
    
    model.storeimg=_seachmodel.image;
    model.store_id=_seachmodel.store_id;
    model.activity=_seachmodel.store_mj;
    model.sendprice=_seachmodel.delivery_price;
    model.storename=_seachmodel.name;
    
    GoodsShopModel *gmodel=[[GoodsShopModel alloc]init];
    
    gmodel.storeid=_seachmodel.store_id;
    gmodel.goodnum=_item.goodnum;
    gmodel.goodprice=_item.price;
    gmodel.goodId=_item.goods_id;
    gmodel.goodpick=_item.packing_charge;
    gmodel.goodimg=_item.g_image;
    gmodel.goodname=_item.name;

    [[GoodShopManagement shareInstance] deleteStore:model andGoodshopmodel:gmodel];
    
}



- (void) plusbtnclick:(UIButton *) button {
    
    if ([_item.stock_num integerValue] == 0) {
        
        TR_Message(@"商品库存不足");
        
        return;
    }
    
    NSInteger num=[_item.goodnum integerValue];
    
    if ([_item.stock_num integerValue] == num) {
        
        TR_Message(@"商品库存不足");
        
        return;
    }
    
    if (num==[_item.max_num integerValue]) {
        NSString *titlestr=[NSString stringWithFormat:@"该商品最大限购%@份",_item.max_num];
        TR_Message(titlestr);
        return;
    }
    
    
    _numlabel.hidden=NO;
    _minusbtn.hidden=NO;
    
    num+=1;
    _item.goodnum=[NSString stringWithFormat:@"%ld",num];
    _numlabel.text=_item.goodnum;
    
    NSDictionary *dict=[_seachmodel toDictionary];
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
    
    model.storeimg=_seachmodel.image;
    model.store_id=_seachmodel.store_id;
    model.activity=_seachmodel.store_mj;
    model.sendprice=_seachmodel.delivery_price;
    model.storename=_seachmodel.name;
    
    GoodsShopModel *gmodel=[[GoodsShopModel alloc]init];
    
    gmodel.storeid=_seachmodel.store_id;
    gmodel.goodnum=_item.goodnum;
    gmodel.goodprice=_item.price;
    gmodel.goodId=_item.goods_id;
    gmodel.goodpick=_item.packing_charge;
    gmodel.goodimg=_item.g_image;
    gmodel.goodname=_item.name;
    [[GoodShopManagement shareInstance] addStore:model andGoodshopmodel:gmodel];
    
}


- (void) specbtnclick:(UIButton *) button {
    
    
    SpecAttributeView *specAttributeView=[[SpecAttributeView alloc]init];
    specAttributeView.storeDict=[_seachmodel toDictionary];
    [specAttributeView loadGoodId:_item.goods_id goodName:_item.name withGoodPrice:_item.price goodData:[_item toDictionary]];
    
    [specAttributeView showInView];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
