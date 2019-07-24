//
//  ShopBottomCarView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopBottomCarView.h"
#import "GoodsChooseModel.h"
#define space 10

@implementation ShopBottomCarView

{
    BOOL isclick;
    NSMutableArray *selectedGoods;
    CGFloat goodsTotolPrice;
}
-(UITableView *)mytable{
    if (_mytable == nil) {
        _mytable = [[UITableView alloc]init];
        _mytable.backgroundColor = [UIColor whiteColor];
        _mytable.separatorStyle = UITableViewCellSelectionStyleNone;
        _mytable.delegate = self;
        _mytable.dataSource = self;
        _mytable.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300);
        _mytable.hidden = YES;
        [self addHeaderView];
    }
    return _mytable;
}


-(UIView *)hideContentView{
    
    if (_hideContentView == nil) {
        _hideContentView = [[UIView alloc]init];
        _hideContentView.frame = APP_Delegate.window.bounds;
        _hideContentView.backgroundColor = [UIColor blackColor];
        _hideContentView.alpha = TR_Alpha;
        _hideContentView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideVIewAction:)];
        [_hideContentView addGestureRecognizer:tap];
        
    }
    return _hideContentView;
}


-(void)setHideView:(BOOL)hideView{
    
    self.mytable.hidden = hideView;
    self.hideContentView.hidden = hideView;
    
}

-(void)setHideAll:(BOOL)hideAll{
    
    self.hidden = hideAll;
    self.mytable.hidden = hideAll;
    self.hideContentView.hidden = hideAll;
    
}

-(UIView *)bacview{
    if (_bacview == nil) {
        _bacview = [[UIView alloc]init];
        _bacview.backgroundColor = [UIColor whiteColor];
        _bacview.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50);
    }
    return _bacview;
}

-(UILabel *)titleDetailLabel{
    if (_titleDetailLabel == nil) {
        _titleDetailLabel =[[UILabel alloc]init];
        _titleDetailLabel.backgroundColor = ORANGECOLOR;
        _titleDetailLabel.font = [UIFont systemFontOfSize:15];
        _titleDetailLabel.textAlignment = NSTextAlignmentCenter;
        _titleDetailLabel.text = @"已减6元，再买6元减8元，去凑单 >";
        _titleDetailLabel.hidden = YES;
        _titleDetailLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    }
    return _titleDetailLabel;
}

-(UILabel *)countLabel{
    
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.layer.cornerRadius = 10.0f;
        _countLabel.layer.masksToBounds = YES;
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.text = @"0";
        _countLabel.hidden = YES;
    }
    return _countLabel;
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableDictionary *)dataDic{
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}




-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
       
       // [[UIApplication sharedApplication].keyWindow addSubview:self.hideContentView];
        
       // [[UIApplication sharedApplication].keyWindow addSubview:self.mytable];
    
      //  [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        //self.frame = CGRectMake(0, SCREEN_HEIGHT -70, SCREEN_WIDTH, 70);
        
        [self addSubview:self.titleDetailLabel];
        
        [self addSubview:self.bacview];
        
        [self addbackview];
    
        
    }
    return self;
}

-(void)addbackview {
    __weak typeof(self) weakSelf = self;
  
    self.imageV = [[UIImageView alloc]init];
    self.imageV.backgroundColor = [UIColor clearColor];
    self.imageV.image = [UIImage imageNamed:@"shop_car"];
    [self.bacview addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 35));
    }];
    
    [self.bacview addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageV.mas_right).offset(-10);
        make.bottom.mas_equalTo(weakSelf.imageV.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    self.pricelable = [[UILabel alloc]init];
    self.pricelable.text = @"未选购商品";
    self.pricelable.font = [UIFont systemFontOfSize:12];
    CGSize size = TR_TEXT_SIZE(self.pricelable.text, self.pricelable.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    self.pricelable.textColor = [UIColor grayColor];
    [self.bacview addSubview:self.pricelable];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageV.mas_right).mas_offset(20);
        make.top.mas_equalTo(weakSelf.imageV.mas_top);
        make.size.mas_equalTo(CGSizeMake(size.width + 10, 20));
    }];
    
    
    self.peisonglabel = [[UILabel alloc]init];
    self.peisonglabel.text = @"另需配送费￥2.5 | 支持到店自取";
    self.peisonglabel.font = [UIFont systemFontOfSize:12];
    CGSize size2 = TR_TEXT_SIZE(self.peisonglabel.text, self.peisonglabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    self.peisonglabel.textColor = [UIColor grayColor];
    [self.bacview addSubview:self.peisonglabel];
    [self.peisonglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.pricelable.mas_left);
        make.top.mas_equalTo(weakSelf.pricelable.mas_top).offset(17);
        make.size.mas_equalTo(CGSizeMake(size2.width + 10, 20));
    }];
    
    
    self.settmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settmentBtn.backgroundColor = [UIColor grayColor];
    self.settmentBtn.titleLabel.font = TR_Font_Cu(17);
    [self.settmentBtn setTitle:@"去结算" forState:UIControlStateNormal];
    self.settmentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.settmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.settmentBtn addTarget:self action:@selector(handleSettlement) forControlEvents:UIControlEventTouchUpInside];
    [self.bacview addSubview:self.settmentBtn];
    [self.settmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickmenu)];
    [self.bacview addGestureRecognizer:tap];
}




//处理点击结算按钮  此处逻辑有问题 离开界面隐藏购物

-(void)handleSettlement {
    
   
     NSArray *dataArray = [[GoodsListManager shareInstance]getGoodsCount:self.model.store_id];
     //点击去结算判断是否达到起送价格  修改为在结算中判断
//
//
//    CGFloat goodsPrice = 0.0f;
//
//    for (GoodsShopModel *goodsModel in dataArray) {
//
//        goodsPrice = goodsPrice + [goodsModel.goodprice floatValue] * [goodsModel.goodnum doubleValue];
//
//    }
//
//    if (goodsPrice < [self.model.delivery_price integerValue]) {
//
//        TR_Message(@"未达到起送价格");
//
//        return;
//
//    }
    
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(clicksettmentaction:)]) {
            
          [self.delegate clicksettmentaction:dataArray];
        
    }
    
}




-(void)clickmenu {
    
    [self handleSettlement];
    
    
//
//    if (!isclick) {
//
//        if (self.dataSource.count == 0) {
//
//            TR_Message(@"购物车里空空如也");
//            return;
//
//        }
//
//        self.mytable.hidden = NO;
//        self.hideContentView.hidden = NO;
//        [self.mytable reloadData];
//
//        [UIView animateWithDuration:0.2 animations:^{
//            self.mytable.frame = CGRectMake(0, SCREEN_HEIGHT -50 - self.mytable.frame.size.height - HOME_INDICATOR_HEIGHT, self.mytable.frame.size.width, self.mytable.frame.size.height);
//        }];
//
//    }else{
//
//        [UIView animateWithDuration:0.2 animations:^{
//            self.mytable.frame = CGRectMake(0, SCREEN_HEIGHT, self.mytable.frame.size.width, self.mytable.frame.size.height);
//        }];
//
//        self.mytable.hidden = YES;
//        self.hideContentView.hidden = YES;
//    }
//
//    isclick = !isclick;
    
    
}



-(void)changefootviewithDatasource:(NSArray *)tempArray{
    
    NSDictionary *contentDic = tempArray[0];
    if ([[contentDic allKeys][0] isEqualToString:@"jia"]) {
        
        NSInteger count = [self.countLabel.text integerValue];
        count +=1;
        self.countLabel.text =[NSString stringWithFormat:@"%ld",count];
        self.countLabel.hidden = NO;
        GoodsChooseModel *model = contentDic[@"jia"];
        goodsTotolPrice = goodsTotolPrice +[model.goodsPrice floatValue];
        self.pricelable.text = [NSString stringWithFormat:@"￥%.2f",goodsTotolPrice];
    }
    
   
    if ([[contentDic allKeys][0] isEqualToString:@"jian"]) {
        
        NSInteger count = [self.countLabel.text integerValue];
        count -=1;
        self.countLabel.text =[NSString stringWithFormat:@"%ld",count];
        GoodsChooseModel *model = contentDic[@"jian"];
        goodsTotolPrice = goodsTotolPrice -[model.goodsPrice floatValue];
        self.pricelable.text = [NSString stringWithFormat:@"￥%.2f",goodsTotolPrice];
    
        if (count == 0) {
            self.countLabel.hidden = YES;
            goodsTotolPrice = 0.0f;
            self.pricelable.text = @"未选购商品";
        }
    }
    
    
    if (goodsTotolPrice >= 30) {
        
        self.settmentBtn.backgroundColor = ORANGECOLOR;
    }else{
        
        self.settmentBtn.backgroundColor = [UIColor grayColor];
    }
    
}


//获取数据库中的数据

-(void)getGoodsCountAction{
    
    NSArray *dataArray = [[GoodsListManager shareInstance]getGoodsCount:self.model.store_id];
    
    self.peisonglabel.text = [NSString stringWithFormat:@"另需配送费￥%@ | 支持到店自取",self.model.delivery_money];
    
    NSInteger count = 0;
    CGFloat goodsPrice = 0.0f;
    [self.dataSource removeAllObjects];
    
    for (GoodsShopModel *goodsModel in dataArray) {
        
        count = [goodsModel.goodnum integerValue] + count;
        
        goodsPrice = goodsPrice + [goodsModel.goodprice floatValue] * [goodsModel.goodnum doubleValue] + [goodsModel.goodpick doubleValue] * [goodsModel.goodnum doubleValue];
        
        [self.dataSource addObject:goodsModel];
    }
   
    [self.mytable reloadData];
    
  
    
    if (count > 0) {
        
        self.countLabel.text =[NSString stringWithFormat:@"%ld",count];
        self.countLabel.hidden = NO;
       
        self.pricelable.text = [NSString stringWithFormat:@"￥%.2f",goodsPrice];
        self.imageV.image = [UIImage imageNamed:@"shop_car1"];
        
        if (goodsPrice >= [self.model.delivery_price doubleValue]) {
            
            self.settmentBtn.backgroundColor = ORANGECOLOR;
            self.settmentBtn.userInteractionEnabled = YES;
            [self.settmentBtn setTitle:@"去结算" forState:UIControlStateNormal];
        }else{
            
            self.settmentBtn.backgroundColor = [UIColor lightGrayColor];
            [self.settmentBtn setTitle:[NSString stringWithFormat:@"￥%@起送",self.model.delivery_price] forState:UIControlStateNormal];
            
        }
        
    }else{
        
        self.countLabel.hidden = YES;
        self.pricelable.text = @"未选购商品";
        self.imageV.image = [UIImage imageNamed:@"shop_car"];
        self.settmentBtn.backgroundColor = [UIColor lightGrayColor];
        self.settmentBtn.userInteractionEnabled = NO;
        [self.settmentBtn setTitle:[NSString stringWithFormat:@"￥%@起送",self.model.delivery_price] forState:UIControlStateNormal];
    }
    

    
   
    if ([[NSUserDefaults standardUserDefaults]boolForKey:ORDERTYPE]) {
        
        [self handleSettlement];
    }
    
    
}


//tabview协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * tempV in cell.contentView.subviews) {
        
        [tempV removeFromSuperview];
    }
    
    [self designWithCell:cell withIndexpath:indexPath];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


// cell 的样式
-(void)designWithCell:(UITableViewCell *)cell withIndexpath:(NSIndexPath *)indexpath{
    
    GoodsShopModel *goodsModel = self.dataSource[indexpath.row];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = goodsModel.goodname;
    
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space );
        make.top.mas_equalTo(space);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UIView *tempView = [[UIView alloc]init];
    tempView.backgroundColor = [UIColor whiteColor];
    tempView.tag = 200;
    [cell.contentView addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(90, 30));
    }];
    
    [self addcountkeyWidthCell:tempView withCount:goodsModel.goodnum];
    
    
    self.moneycountlabel = [[UILabel alloc]init];
    self.moneycountlabel.textColor = [UIColor blackColor];
    self.moneycountlabel.text = [NSString stringWithFormat:@"￥%@",goodsModel.goodprice];
    self.moneycountlabel.textAlignment = NSTextAlignmentLeft;
    self.moneycountlabel.font = [UIFont systemFontOfSize:13];
    self.moneycountlabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:self.moneycountlabel];
    [self.moneycountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(10);
        make.centerY.equalTo(tempView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    
    UIView *lineview = [[UIView alloc]init];
    lineview.backgroundColor = GRAYCLOLOR;
    [cell.contentView addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left);
        make.right.mas_equalTo(tempView.mas_right);
        make.bottom.mas_equalTo(-1);
        make.height.mas_equalTo(1);
        
    }];
}

//添加数目的按键
- (void)addcountkeyWidthCell:(UIView *)contentView withCount:(NSString *)goodnum {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shop_delete"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contentView addSubview:btn];
    btn.tag = 1001;
    [btn addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.text = goodnum;
    numLabel.tag = 1003;
    [contentView addSubview:numLabel];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
   
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"shop_add"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:btn2];
    btn2.tag = 1002;
    [btn2 addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}


-(void)addHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.mytable.tableHeaderView = headerView;
    UILabel *descripLabel = [[UILabel alloc]init];
    descripLabel.backgroundColor = ORANGECOLOR;
//    descripLabel.text = @"已减6元，再买6元减8元，去凑单";
    descripLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:descripLabel];
    [descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 20));
    }];
    
}


-(void)countnumber:(UIButton *)sender{
    
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview.superview;
    
    NSIndexPath *indexpath = [self.mytable indexPathForCell:cell];
    StoreDataModel *shopModel = [[GoodsListManager shareInstance]transformModelFrom4:self.model];
    GoodsShopModel *goodsModel = self.dataSource[indexpath.row];
    UIView *tempView = [cell.contentView viewWithTag:200];
    UILabel *numLabel = [tempView viewWithTag:1003];
    NSInteger goodnum = [numLabel.text integerValue];
    
    if (sender.tag == 1002) {
        
       numLabel.text = [NSString stringWithFormat:@"%ld",goodnum + 1];
        goodsModel.goodnum = numLabel.text;
        [[GoodShopManagement shareInstance]addStore:shopModel andGoodshopmodel:goodsModel];
        
    }
    
    if (sender.tag == 1001) {
        
        if (goodnum - 1 > 0) {
            
            numLabel.text = [NSString stringWithFormat:@"%ld",goodnum - 1];
             goodsModel.goodnum = numLabel.text;
            
            [[GoodShopManagement shareInstance]addStore:shopModel andGoodshopmodel:goodsModel];
            
        }else{
            
            numLabel.text = [NSString stringWithFormat:@"%ld",goodnum - 1];
            goodsModel.goodnum = @"0";
             [[GoodShopManagement shareInstance]deleteStore:shopModel andGoodshopmodel:goodsModel];
        }
        
    }
    
    
    
    [self getGoodsCountAction];
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];
}




-(void)hideVIewAction:(UITapGestureRecognizer *)sender{
    
    [self setHideView:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
