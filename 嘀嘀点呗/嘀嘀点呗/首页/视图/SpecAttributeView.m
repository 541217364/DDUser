//
//  SpecAttributeView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/21.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "SpecAttributeView.h"
#import "SpecAttuributrModel.h"
#import "DBManagement.h"

#define BACKVIEWHEIGHT 320

#define BTNWIDTH  80

#define BTNHEIGHT 30

@interface SpecAttributeView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) SpecAttuributrModel *model;

@property (nonatomic, strong) UIScrollView *mscrollView;

@property (nonatomic, assign) CGFloat pointY;

@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) NSString *goodPrice;

@property (nonatomic, strong) UILabel *numlabel;

@property (nonatomic, strong) UILabel *pricelabel;

@property (nonatomic, strong) UIButton *goshopbtn;

@property (nonatomic, strong) UIButton *plusbtn;

@property (nonatomic, strong) UIButton *minusbtn;

@property (nonatomic, strong) NSMutableDictionary *goodDict;

@property (nonatomic, strong) SpecDataItem *selectSpecItem;

@property (nonatomic, assign) NSInteger  attselectindex;

@property (nonatomic, strong) NSArray *dbDataArr;

@property (nonatomic, strong) AttuributrModel *selectattmodel;

@property (nonatomic, strong) GoodsShopModel *selectGoodModel;

@property (nonatomic, strong) NSString *sortdiscount;

@property (nonatomic, strong) UILabel *oldlabel;

@end

@implementation SpecAttributeView


- (instancetype)init {
    
    self=[super init];
    
    if (self) {
        
        self.tag = 1000;
        
        self.backgroundColor=TR_COLOR_RGBACOLOR_A(40,40,40,0.6);
        _backView=[[UIView alloc]initWithFrame:CGRectMake(20,150,SCREEN_WIDTH-40,BACKVIEWHEIGHT)];
     
        _backView.backgroundColor=[UIColor whiteColor];
        
        [self addSubview:_backView];
        
        _titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0,15,SCREEN_WIDTH-40,20)];
        
        _titlelabel.textAlignment=NSTextAlignmentCenter;
        
        [_backView addSubview:_titlelabel];
        
        _mscrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,50,_backView.frame.size.width,_backView.frame.size.height-100)];
        [_backView addSubview:_mscrollView];
        
        
        UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        tapGestureRecognizer2.delegate = self;
        
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
       //tapGestureRecognizer2.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self addGestureRecognizer:tapGestureRecognizer2];
        
    }
    return self;
}


- (void)loadPriceNumberView {
    __weak typeof(self) weakSelf=self;

    UILabel *tippice=[[UILabel alloc]init];
    tippice.text=@"¥";
    tippice.font=[UIFont systemFontOfSize:12];
    tippice.textAlignment=NSTextAlignmentCenter;
    [_backView addSubview:tippice];
    
    [tippice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(weakSelf.backView.frame.size.height-35);
        make.size.mas_equalTo(CGSizeMake(20,20));
    }];
    
    _pricelabel=[[UILabel alloc]init];
    
    _pricelabel.textAlignment=NSTextAlignmentLeft;
    [_backView addSubview:_pricelabel];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tippice.mas_right).offset(0);
        make.top.equalTo(tippice.mas_top).offset(0);
      
        make.height.mas_equalTo(20);
       
        make.width.mas_equalTo(60);
    }];
    _pricelabel.text=_goodPrice;
    
    _oldlabel=[[UILabel alloc]init];
    
    _oldlabel.textAlignment=NSTextAlignmentLeft;
    _oldlabel.font=TR_Font_Gray(14);
    _oldlabel.textColor = [UIColor grayColor];
    [_backView addSubview:_oldlabel];
    
    [_oldlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.pricelabel.mas_right).offset(5);
        make.top.equalTo(tippice.mas_top).offset(1);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    _oldlabel.hidden=YES;
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor grayColor];
    
    [_oldlabel addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.oldlabel.mas_left).offset(0);
       
        make.top.equalTo(tippice.mas_centerY).offset(0);
      
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(weakSelf.oldlabel.mas_width);
    }];
    
    
    CGFloat interval= (_mscrollView.frame.size.width-3*BTNWIDTH)/4;

    _plusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_plusbtn setImage:[UIImage imageNamed:@"seach_goodplus"] forState:UIControlStateNormal];
    [_backView addSubview:_plusbtn];
    [_plusbtn addTarget:self action:@selector(plusbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_plusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.backView.mas_right).offset(-interval);
        make.bottom.equalTo(weakSelf.backView.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(25,25));
        
    }];
    
    _numlabel=[[UILabel alloc]init];
    
    _numlabel.textAlignment=NSTextAlignmentCenter;
    
    [_backView addSubview:_numlabel];
    
    [_numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.plusbtn.mas_left).offset(-5);
        
        make.top.equalTo(weakSelf.plusbtn.mas_top).offset(0);
        
        make.height.mas_equalTo(25);
        
    }];
    
    _minusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_minusbtn setImage:[UIImage imageNamed:@"seacg_goodminus"] forState:UIControlStateNormal];
    [_minusbtn addTarget:self action:@selector(minusbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_minusbtn];
    
    [_minusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.numlabel.mas_left).offset(-5);
        
        make.top.equalTo(weakSelf.plusbtn.mas_top).offset(0);
        
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _goshopbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_goshopbtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    _goshopbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    _goshopbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(251,131,62,1);
    _goshopbtn.layer.cornerRadius=10;
    _goshopbtn.layer.masksToBounds=YES;
    [_goshopbtn addTarget:self action:@selector(goshopbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_goshopbtn];
  
    [_goshopbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.backView.mas_right).offset(-interval);
        
        make.bottom.equalTo(weakSelf.backView.mas_bottom).offset(-12);
        
        make.size.mas_equalTo(CGSizeMake(80,25));
        
    }];
    
    _minusbtn.hidden=YES;
    
    _plusbtn.hidden=YES;
    
    _numlabel.hidden=YES;
}

- (void)plusbtnclick:(UIButton *) button {
    
    NSInteger num=[_numlabel.text integerValue];
   
    num++;
    
    
    if ([_selectSpecItem.stock_num integerValue]<num&&_selectSpecItem) {

        TR_Message(@"库存不足");
        num--;
        return;
    }
    
    _numlabel.text=[NSString stringWithFormat:@"%ld",num];

    if (_selectSpecItem) {
        _selectSpecItem.specnum=[NSString stringWithFormat:@"%ld",num];
    }else
        [_goodDict setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"goodnum"];
    
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
    
    model.storeimg=_storeDict[@"image"];
    model.store_id=_storeDict[@"store_id"];
    NSString *str = [self retureTagStringWithArray:_storeDict[@"tag"]];
    model.activity= str;
    model.sendprice=_storeDict[@"delivery_price"];
    model.storename=_storeDict[@"name"];
    
    GoodsShopModel *gmodel=[[GoodsShopModel alloc]init];
    gmodel.storeid=_storeDict[@"store_id"];
    gmodel.goodnum= _numlabel.text;
    gmodel.goodprice=_goodDict[@"price"];
    gmodel.goodId=_goodDict[@"goods_id"];
    gmodel.goodpick=_goodDict[@"packing_charge"];
    gmodel.goodimg=_goodDict[@"g_image"];
    gmodel.goodname=_goodDict[@"name"];

    if (_selectSpecItem) {
        
        gmodel.spec_tid=_selectSpecItem.sid;
        gmodel.specId=_selectSpecItem.id_;
        gmodel.specname=_selectSpecItem.name;
        gmodel.specpick=_selectSpecItem.packing_charge;
        gmodel.specprice=_selectSpecItem.price;

    }
    
    if (_selectattmodel) {
        
        NSString *value=_selectattmodel.val[_attselectindex];
        
        gmodel.attributename=value;
        gmodel.attributeId=_selectattmodel.id_;
        
    }
    if (_sortdiscount.length!=0) {
        gmodel.gooddiscountprice=_sortdiscount;
    }
    gmodel.atttip=[NSString stringWithFormat:@"%ld",_attselectindex];

    
    [[GoodShopManagement shareInstance] addStore:model andGoodshopmodel:gmodel];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];

}


- (void)minusbtnclick:(UIButton *) button {
    
    NSInteger num=[_numlabel.text integerValue];
    
    num--;
    
    if (num==0) {
        _minusbtn.hidden=YES;
        
        _plusbtn.hidden=YES;
        
        _numlabel.hidden=YES;
        
        _goshopbtn.hidden=NO;
        
        if (_selectSpecItem) {
            
            _selectSpecItem.specnum=@"0";
        }else
            [_goodDict setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"goodnum"];
        
    }else{
        
        if (_selectSpecItem) {
           
            _selectSpecItem.specnum=[NSString stringWithFormat:@"%ld",num];
            
        }else
            [_goodDict setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"goodnum"];
        
    }

    _numlabel.text=[NSString stringWithFormat:@"%ld",num];
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
    
    model.storeimg=_storeDict[@"image"];
    model.store_id=_storeDict[@"store_id"];
    NSString *str = [self retureTagStringWithArray:_storeDict[@"tag"]];
    model.activity= str;
    model.sendprice=_storeDict[@"delivery_price"];
    model.storename=_storeDict[@"name"];
    
    GoodsShopModel *gmodel=[[GoodsShopModel alloc]init];
    
    gmodel.storeid=_storeDict[@"store_id"];
    gmodel.goodnum= _numlabel.text;
    gmodel.goodprice=_goodDict[@"price"];
    gmodel.goodId=_goodDict[@"goods_id"];
    gmodel.goodpick=_goodDict[@"packing_charge"];
    gmodel.goodimg=_goodDict[@"g_image"];
    gmodel.goodname=_goodDict[@"name"];

    if (_selectSpecItem) {
        
        gmodel.spec_tid=_selectSpecItem.sid;
        gmodel.specId=_selectSpecItem.id_;
        gmodel.specname=_selectSpecItem.name;
        gmodel.specpick=_selectSpecItem.packing_charge;
        gmodel.specprice=_selectSpecItem.price;
        
    }
    
    if (_selectattmodel) {
        
        NSString *value=_selectattmodel.val[_attselectindex];
        
        gmodel.attributename=value;
        gmodel.attributeId=_selectattmodel.id_;
        
    }
    if (_sortdiscount.length!=0) {
        gmodel.gooddiscountprice=_sortdiscount;
    }
    gmodel.atttip=[NSString stringWithFormat:@"%ld",_attselectindex];

    
    [[GoodShopManagement shareInstance] deleteStore:model andGoodshopmodel:gmodel];
  
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];

}


- (void)goshopbtnclick:(UIButton *)button {
    
    
    if ([_selectSpecItem.stock_num integerValue]==0&&_selectSpecItem) {

        TR_Message(@"库存不足");
        return;
    }
    
    _minusbtn.hidden=NO;
    
    _plusbtn.hidden=NO;
    
    _numlabel.hidden=NO;
   
    _goshopbtn.hidden=YES;
    
    _numlabel.text=@"1";
    
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
    
    model.storeimg=_storeDict[@"image"];
    model.store_id=_storeDict[@"store_id"];
    NSString *str = [self retureTagStringWithArray:_storeDict[@"tag"]];
    model.activity= str;
    model.sendprice=_storeDict[@"delivery_price"];
    model.storename=_storeDict[@"name"];
    
    GoodsShopModel *gmodel=[[GoodsShopModel alloc]init];
    
    gmodel.storeid=_storeDict[@"store_id"];
    gmodel.goodnum= _numlabel.text;
    gmodel.goodprice=_goodDict[@"price"];
    gmodel.goodId=_goodDict[@"goods_id"];
    gmodel.goodpick=_goodDict[@"packing_charge"];
    gmodel.goodimg=_goodDict[@"g_image"];
    gmodel.goodname=_goodDict[@"name"];
    if (_selectSpecItem) {
        
        gmodel.spec_tid=_selectSpecItem.sid;
        gmodel.specId=_selectSpecItem.id_;
        gmodel.specname=_selectSpecItem.name;
        gmodel.specpick=_selectSpecItem.packing_charge;
        gmodel.specprice=_selectSpecItem.price;
    }
    
    if (_selectattmodel) {
        
        NSString *value=_selectattmodel.val[_attselectindex];
        gmodel.attributename=value;
        gmodel.attributeId=_selectattmodel.id_;
       // gmodel.goodnum=_selectGoodModel?_selectGoodModel.goodnum:_selectGoodModel.goodnum;
    }
    
    if (_sortdiscount.length!=0) {
        gmodel.gooddiscountprice=_sortdiscount;
    }
    
    gmodel.atttip=[NSString stringWithFormat:@"%ld",_attselectindex];

    
    [[GoodShopManagement shareInstance] addStore:model andGoodshopmodel:gmodel];
  
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];

   
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
  //  [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];
        
         [self removeFromSuperview];
   
}


- (void)loadGoodId:(NSString *)gooid  goodName:(NSString *)goodname withGoodPrice:(NSString *)price  goodData:(NSDictionary *)dict{
    
    
    _dbDataArr=[[GoodsShonp_DB shareInstance] getFootprintGoodsforAttriteInfoArrayforkey:gooid andstorid:_storeDict[@"store_id"]];
    
    _goodPrice=price;
    
    _titlelabel.text=goodname;
    
    _sortdiscount=dict[@"sort_discount"];
    
    _goodDict=[NSMutableDictionary dictionaryWithDictionary:dict];
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    NSString *ticket = [Singleton shareInstance].userInfo.ticket ? [Singleton shareInstance].userInfo.ticket :@"";
    
    [HBHttpTool post:SHOP_AJAXSHOPGOODS params:@{@"Device-Id":DeviceID,@"ticket":ticket,@"user_lat":lat,@"user_long":lng,@"goods_id":gooid} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSDictionary *dict=[dataDict objectForKey:@"result"];
                
                _model=[[SpecAttuributrModel alloc]initWithDictionary:dict error:nil];

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self loaddataView];
                    
                });
            }
        }
        
    }failure:^(NSError *error){
        
    }];
    
}

- (void)loaddataView {
    
    SpecDataModel *specmodel=[_model.spec_list firstObject];
    
    [self compDataSpecs:specmodel.list];
    

    [self setSpecData:specmodel.list withSpecname:@"规格"];
    
    NSArray *attributes=_model.properties_list;
   
    if (attributes.count!=0) {
      
        for (int i=1; i<=attributes.count; i++) {
            
            AttuributrModel *attModel=attributes[i-1];
            
            [self setAttributes:attModel.val andAttributeName:attModel.name index:i];
            
        }
        
    }
    

    if ((_pointY+20)>_mscrollView.frame.size.height) {

        _mscrollView.contentSize=CGSizeMake(_mscrollView.frame.size.width,_pointY+20);

    }else{
        
        _mscrollView.frame=CGRectMake(0,50,_backView.frame.size.width,_pointY+20);
        _backView.frame=CGRectMake(20,150,SCREEN_WIDTH-40,_pointY+20+100);

    }
    
    [self loadPriceNumberView];
  
    UIButton *button =(UIButton *)[_mscrollView viewWithTag:1000];
    
    if (button) {
        
        [self sepcmenubtnclick:button];
    }else{
        
        self.goshopbtn.backgroundColor = [UIColor lightGrayColor];
        
//        [self.goshopbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        self.goshopbtn.userInteractionEnabled = NO;
        
    }
    
    UIButton * button1=[_mscrollView viewWithTag:10000];
    if (button1) {
        [self atturitemenubtnclick:button1];

    }
    
    
    if (specmodel.list.count == 0 && attributes.count > 0) {
        
        _goshopbtn.backgroundColor = ORANGECOLOR;
        
        [_goshopbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goshopbtn.userInteractionEnabled = YES;
       
    }
    
  
}


- (void) setSpecData:(NSArray *)data withSpecname:(NSString *) specname {
    
    if (data.count==0) {
        return;
    }
    
    CGFloat interval= (_mscrollView.frame.size.width-3*BTNWIDTH)/4;
    
    NSInteger num = data.count%3==0?data.count/3:data.count/3+1;
    
      UILabel *tiplabel=[[UILabel alloc]initWithFrame:CGRectMake(interval,5+_pointY,_backView.frame.size.width-2*interval,20)];
  
    tiplabel.font=[UIFont systemFontOfSize:12];
  
    tiplabel.textAlignment=NSTextAlignmentLeft;
  
    tiplabel.text=specname;
   
    [_mscrollView addSubview:tiplabel];
    
    for (int y=0; y<num; y++) {
        
        for (int x=0; x<3; x++) {
            
            if (data.count>(y*3+x)) {
                
                SpecDataItem *item=data[y*3+x];
                
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                
                [button setTitle:item.name forState:UIControlStateNormal];
                [button addTarget:self action:@selector(sepcmenubtnclick:) forControlEvents:UIControlEventTouchUpInside];
                button.titleLabel.font=TR_Font_Gray(12);
                button.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
                [button setTitleColor:TR_COLOR_RGBACOLOR_A(40,40,40,1) forState:UIControlStateNormal];
                button.frame=CGRectMake(x*(interval+BTNWIDTH)+interval,tiplabel.frame.size.height+tiplabel.frame.origin.y+10+(10+BTNHEIGHT)*y, BTNWIDTH, BTNHEIGHT);
                button.tag=1000+y*3+x;
                
                if ([item.stock_num integerValue ] == 0) {
                    
                    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    button.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);;
                    button.userInteractionEnabled = NO;
                    
                    if (button.tag == 1000) {
                        
                        _goshopbtn.backgroundColor = [UIColor lightGrayColor];
                        
                        _goshopbtn.userInteractionEnabled = NO;
                        
                    }
                }
                
                [_mscrollView addSubview:button];
                
            }
        }
    }

    
    
    _pointY=tiplabel.frame.origin.y+tiplabel.frame.size.height+num*BTNHEIGHT+(num)*10+10;
   
   
  
   
    
}



- (void)setAttributes:(NSArray *)attributes andAttributeName:(NSString *)name  index:(NSInteger)index{
    
    if (attributes.count==0) {
        return;
    }
    
    CGFloat interval= (_mscrollView.frame.size.width-3*BTNWIDTH)/4;
    
    NSInteger num = attributes.count%3==0?attributes.count/3:attributes.count/3+1;
    
    UILabel *tiplabel=[[UILabel alloc]initWithFrame:CGRectMake(interval,5+_pointY,_backView.frame.size.width-2*interval,20)];
    
    tiplabel.font=[UIFont systemFontOfSize:12];
    
    tiplabel.textAlignment=NSTextAlignmentLeft;
    
    tiplabel.text=name;
    
    [_mscrollView addSubview:tiplabel];
    
    for (int y=0; y<num; y++) {
        
        for (int x=0; x<3; x++) {
            
            if (attributes.count>(y*3+x)) {
                
                NSString *str=attributes[y*3+x];
                
                UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
                
                [button setTitle:str forState:UIControlStateNormal];
                [button addTarget:self action:@selector(atturitemenubtnclick:) forControlEvents:UIControlEventTouchUpInside];
                button.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
                [button setTitleColor:TR_COLOR_RGBACOLOR_A(40,40,40,1) forState:UIControlStateNormal];
                button.titleLabel.font=[UIFont systemFontOfSize:12];
                button.tag=index*10000+y*3+x;
                button.frame=CGRectMake(x*(interval+BTNWIDTH)+interval,tiplabel.frame.size.height+tiplabel.frame.origin.y+10+(10+BTNHEIGHT)*y, BTNWIDTH, BTNHEIGHT);
                
                [_mscrollView addSubview:button];
                
            }
        }
    }
    
  
    
    _pointY=tiplabel.frame.origin.y+tiplabel.frame.size.height+num*BTNHEIGHT+(num)*10+10;
}


- (void)sepcmenubtnclick:(UIButton *)button {
    
    
    
    SpecDataModel *specmodel=[_model.spec_list firstObject];
    
    SpecDataItem *item=specmodel.list[button.tag-1000];
    
    _selectSpecItem=item;
    
    _selectGoodModel=[self getmGoodModelSpecId:_selectSpecItem.id_ attributeid:_selectattmodel.id_ atttips:[NSString stringWithFormat:@"%ld",_attselectindex]];

    
    button.backgroundColor=TR_COLOR_RGBACOLOR_A(253,236,225,1);
    [button setTitleColor:TR_COLOR_RGBACOLOR_A(252,122,46,1) forState:UIControlStateNormal];
    
    self.goshopbtn.backgroundColor = ORANGECOLOR;
    
    [self.goshopbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    if (button.userInteractionEnabled == NO) {
        
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
        
        self.goshopbtn.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    
   
    for (int i=0; i<specmodel.list.count;i++) {
        
        UIButton *btn=[_mscrollView viewWithTag:1000+i];
        
       
        
        if ((1000+i)!=button.tag) {
            
            if (btn.userInteractionEnabled) {
                
                btn.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
                [btn setTitleColor:TR_COLOR_RGBACOLOR_A(40,40,40,1) forState:UIControlStateNormal];
                
            }
            
        }
    }
    
    NSString *pricetext=item.price;
    
    if ([_sortdiscount integerValue]!=0) {

        pricetext=[NSString stringWithFormat:@"%.2f",[pricetext doubleValue]*([_sortdiscount doubleValue]/10)];
       
        CGSize size = TR_TEXT_SIZE(pricetext, _pricelabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        
        [_pricelabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(size.width+5);
        }];
        NSString *oldprice=[NSString stringWithFormat:@"¥%@",item.price];
        CGSize size2 = TR_TEXT_SIZE(oldprice, _oldlabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);

        
        [_oldlabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(size2.width+5);
        }];
        _oldlabel.hidden=NO;

        _oldlabel.text=oldprice;
    }
    
    _pricelabel.text=pricetext;
    
    if (_selectGoodModel) {
        
        _numlabel.text=_selectGoodModel.goodnum;
        _goshopbtn.hidden=YES;
        
        _minusbtn.hidden=NO;
        
        _plusbtn.hidden=NO;
        
        _numlabel.hidden=NO;
    }else{
        
        _goshopbtn.hidden=NO;
        
        _minusbtn.hidden=YES;
        
        _plusbtn.hidden=YES;
        
        _numlabel.hidden=YES;
        _numlabel.text=@"0";
        
    }
    
}

- (void)atturitemenubtnclick:(UIButton *) button {
    
    NSInteger num=button.tag/10000;
    
    button.backgroundColor=TR_COLOR_RGBACOLOR_A(253,236,225,1);
    [button setTitleColor:TR_COLOR_RGBACOLOR_A(252,122,46,1) forState:UIControlStateNormal];
    
    AttuributrModel *attModel=_model.properties_list[num-1];
    _selectattmodel=attModel;
   
    _attselectindex=button.tag-num*10000;
    
    _selectGoodModel=[self getmGoodModelSpecId:_selectSpecItem.id_ attributeid:_selectattmodel.id_ atttips:[NSString stringWithFormat:@"%ld",_attselectindex]];


    for (int i=0; i<attModel.val.count;i++) {
        
        UIButton *btn=[_mscrollView viewWithTag:10000*num+i];
        
        if ((10000*num+i)!=button.tag) {
            
            btn.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
            
            [btn setTitleColor:TR_COLOR_RGBACOLOR_A(40,40,40,1) forState:UIControlStateNormal];
        }
    }
    
    SpecDataModel *specmodel=[_model.spec_list firstObject];
    
    if (specmodel.list.count == 0  && _model.properties_list.count > 0 && [_sortdiscount integerValue]!=0) {
        
        NSString *pricetext=_goodPrice;
        
        if ([_sortdiscount integerValue]!=0) {
            
            pricetext=[NSString stringWithFormat:@"%.2f",[pricetext doubleValue]*([_sortdiscount doubleValue]/10)];
            
            CGSize size = TR_TEXT_SIZE(pricetext, _pricelabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
            
            [_pricelabel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(size.width+5);
            }];
            
            NSString *oldprice=[NSString stringWithFormat:@"¥%@",_goodPrice];
            CGSize size2 = TR_TEXT_SIZE(oldprice, _oldlabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
            
            
            [_oldlabel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(size2.width+5);
            }];
            
            _oldlabel.hidden=NO;
            
            _oldlabel.text=oldprice;
        }
        
        _pricelabel.text=pricetext;
    }
    
    
    
    if (_selectGoodModel) {
        
        _numlabel.text=_selectGoodModel.goodnum;
      
        _goshopbtn.hidden=YES;
        
        _minusbtn.hidden=NO;
        
        _plusbtn.hidden=NO;
        
        _numlabel.hidden=NO;
    }else{
        
        _goshopbtn.hidden=NO;
        
        _minusbtn.hidden=YES;
        
        _plusbtn.hidden=YES;
        
        _numlabel.hidden=YES;
        _numlabel.text=@"0";
        
    }

}

- (void)showInView {
    
    self.frame=CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    
    [APP_Delegate.window addSubview:self];
    
}


- (void)compDataSpecs:(NSArray *)array {
    
    for (GoodsShopModel *model in _dbDataArr) {
        
        for (SpecDataItem *item in  array) {
            
            if ([model.specId isEqualToString:item.id_]) {
                
                item.specnum=model.goodnum;
                
            }
            
        }
    }
}

- (void)compDataAttrtes:(NSArray *)array {

    for (GoodsShopModel *model in _dbDataArr) {
        
        if ([model.attributename isEqualToString:_selectattmodel.val[_attselectindex]]&&[model.atttip isEqualToString:[NSString stringWithFormat:@"%ld",_attselectindex]]) {
            
        }
        
    }
}

- (GoodsShopModel *) getmGoodModelSpecId:(NSString *)specid  attributeid:(NSString *)attbuteid atttips:(NSString *) tip {
    
    GoodsShopModel *model =[[GoodShopManagement shareInstance] getstoreId:_storeDict[@"store_id"] goodid:_goodDict[@"goods_id"] specId:specid attributeId:attbuteid attrubutetip:tip];
    
    return model;
}

-(NSString *)retureTagStringWithArray:(NSArray *)tags{
    
    NSString *str=@"";
    for (int i =0; i<tags.count; i++) {
        
        NSString *s= tags[i];
        
        if (i==0) {
            str=s;
        }else
            str=[NSString stringWithFormat:@"%@,%@",str,s];
        
    }
    return str;
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ( [touch view].tag == 1000) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return YES;
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
