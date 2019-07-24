//
//  ShopTypeDetailView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/17.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopTypeDetailView.h"
#import "StoreInfo.h"
#import "CommoditySpecificationModel.h"
#define SpareWidth 10

@implementation ShopTypeDetailView
{
    ProductItem *productItem;
    NSMutableArray *speArray;//规格数组
    NSMutableArray *proArray;//属性属性；
    NSArray *  listarray;
    NSArray * spec_Array ;//属性
    NSArray *properties_status_list; //属性
    NSMutableArray *titleSpeArray;
    CGFloat btnWidth;
    NSMutableDictionary *goodSelectDic;
    NSString *productName;
    NSString *shopName;
    NSString *shopID;
    NSString *goodsImages;
    NSString *list_id;
    NSMutableDictionary *selectDic;
    NSMutableDictionary *selectGoodsDic;
    NSMutableArray *goodsSpcIDArray;
    
    NSIndexPath *cellIndexpath;
    NSInteger selectGoodsCount;
    
    
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"辣椒炒肉";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = TR_Font_Gray(20);
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}



-(UIScrollView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];

    }
    return _contentView;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = TR_Font_Cu(17);
        
        NSAttributedString *attributedString = [self attributedText:@[@"￥", @"15"]];
        _priceLabel.attributedText = attributedString;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.backgroundColor = [UIColor clearColor];
    }
    return _priceLabel;
}

-(UIButton *)addShopCar{
    
    if (_addShopCar == nil) {
        
        _addShopCar = [UIButton buttonWithType:UIButtonTypeCustom];
        _addShopCar.layer.cornerRadius = 5.0f;
        _addShopCar.layer.masksToBounds = YES;
        _addShopCar.backgroundColor = TR_COLOR_RGBACOLOR_A(252, 123, 46, 1);
        [_addShopCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addShopCar.titleLabel.font = [UIFont systemFontOfSize:17];
        _addShopCar.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_addShopCar setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addShopCar addTarget:self action:@selector(addtoshopcar:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addShopCar;
}

-(UIView *)countView{
    if (_countView == nil) {
        _countView = [[UIView alloc]init];
        _countView.backgroundColor = [UIColor whiteColor];
        _countView.userInteractionEnabled = YES;
        _countView.hidden = YES;
        [self addcountkey];
    }
    return _countView;
}

-(NSMutableArray *)datasource{
    
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentView];
        speArray = [NSMutableArray array];
        proArray = [NSMutableArray array];
        goodSelectDic = [NSMutableDictionary dictionary];
        selectDic = [NSMutableDictionary dictionary];
        selectGoodsDic = [NSMutableDictionary dictionary];
        goodsSpcIDArray = [NSMutableArray array];
    }
    return  self;
}



-(void)designViewWithDatasource:(NSArray *)datasource {
    __weak typeof(self) weakSelf = self;
    ProductItem *model = datasource[0];
    productItem = model;
    cellIndexpath = datasource[1];
    selectGoodsCount = [model.selectCount integerValue];
    self.nameLabel.text = model.product_name;
    if (model) {
        
        [HBHttpTool post: SHOP_AJAXSHOPGOODS params:@{@"Device-Id":DeviceID,@"goods_id":model.product_id} success:^(id responseObj) {
            
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                [self.datasource removeAllObjects];
                NSDictionary *list = responseObj[@"result"][@"list"];
                productName = responseObj[@"result"][@"name"];
                goodsImages = responseObj[@"result"][@"image"];
                shopID = responseObj[@"result"][@"store_id"];
                NSArray *tempArray = [list allKeys];
               listarray = [tempArray sortedArrayUsingSelector:@selector(compare:)];
                for (int i = 0; i < listarray.count; i ++) {
                    CommoditySpecificationModel *model = [[CommoditySpecificationModel alloc]initWithDictionary:list[listarray[i]] error:nil];
                    [self.datasource addObject:model];
                }
                NSLog(@"%@",responseObj);
                
                [weakSelf loadDatasourceWithresponse:(responseObj[@"result"])];
            }
            
            
        } failure:^(NSError *error) {
            
            
        }];
    }
    
}


-(void)designViewWithDatasource:(NSString *)goodsID withGoodsCount:(NSString *)goodscount withGoodsName:(NSString *)goodsName{
    __weak typeof(self) weakSelf = self;
    
    selectGoodsCount = [goodscount integerValue];
    //self.nameLabel.text = model.product_name;
//    if (model) {
    
        [HBHttpTool post: SHOP_AJAXSHOPGOODS params:@{@"Device-Id":DeviceID,@"goods_id":goodsID} success:^(id responseObj) {
            
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                [self.datasource removeAllObjects];
                NSDictionary *list = responseObj[@"result"][@"list"];
                productName = responseObj[@"result"][@"name"];
                goodsImages = responseObj[@"result"][@"image"];
                shopID = responseObj[@"result"][@"store_id"];
                NSArray *tempArray = [list allKeys];
                listarray = [tempArray sortedArrayUsingSelector:@selector(compare:)];
                for (int i = 0; i < listarray.count; i ++) {
                    CommoditySpecificationModel *model = [[CommoditySpecificationModel alloc]initWithDictionary:list[listarray[i]] error:nil];
                    [self.datasource addObject:model];
                }
                
                
                [weakSelf loadDatasourceWithresponse:(responseObj[@"result"])];
            }
            
            
        } failure:^(NSError *error) {
            
            
        }];
//    }
    
}


-(void)loadDatasourceWithresponse:(NSDictionary *)result{
    
    //计算文本宽度
    __weak typeof(self) weakSelf = self;
    [proArray removeAllObjects];
    [speArray removeAllObjects];
   // [selectDic removeAllObjects];
   // _countView.hidden = YES;
    //_addShopCar.hidden = NO;
   
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width - 2 * SpareWidth, 20));
    }];
    
 
    
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 4 * SpareWidth, 50));
    }];
    
    [bottomView addSubview:self.priceLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 4 * SpareWidth)/ 2, 30));
    }];
    
    
    [bottomView addSubview:self.addShopCar];
    [self.addShopCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(weakSelf.priceLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    // 添加商品的按键
    
    btnWidth = 25;
    [bottomView addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(weakSelf.priceLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(btnWidth * 3, 30));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, weakSelf.frame.size.height - 100));
    }];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [goodsSpcIDArray removeAllObjects];
    for (int i = 0; i < self.datasource.count; i ++) {
        CommoditySpecificationModel *model = self.datasource[i];
        SpecModel *model2 = model.spec[0];
        if (i == 0) {
            NSAttributedString *attributedString = [self attributedText:@[@"￥", model.old_price]];
            _priceLabel.attributedText = attributedString;
        }
        [tempArray addObject:model2.spec_val_name];
        [goodsSpcIDArray addObject:model2.spec_val_id];
    }
    
    titleSpeArray = [NSMutableArray array];
    spec_Array  = result[@"spec_list"];
    
    NSString *spec;
    
    if (spec_Array.count > 0) {
        
        spec = spec_Array[0][@"name"];
        
        [titleSpeArray addObject:spec];
    }
    
    
    if ([result[@"is_properties"] isEqualToString:@"1"]) {
        properties_status_list = result[@"properties_status_list"];
        NSString *properties = result[@"properties_list"][0][@"name"];
        list_id = result[@"properties_list"][0][@"id_"];
        NSArray *propertiesArray = result[@"properties_list"][0][@"val"];
        
        if (spec_Array.count > 0) {
            
            self.testDic = @{spec:tempArray,properties:propertiesArray};
            
        }else{
            
            self.testDic = @{properties:propertiesArray};
        }
        
        [titleSpeArray addObject:properties];
        
    }else{
        
        self.testDic = @{spec:tempArray};
        
    }
    

    
    NSArray *testkey = titleSpeArray;
    NSInteger typecount = 0;
    //布局规格和属性  根据传入的参数改变
    CGFloat btnwidth = (self.frame.size.width - 80)/3 ;
    CGFloat btnheight = 30;
    NSInteger linenum  = 0;
    
    for (UIView * temp in self.contentView.subviews) {
        [temp removeFromSuperview];
    }
    for (int i = 0; i < testkey.count; i++) {
        
        NSArray *detailArray = [self.testDic valueForKey:testkey[i]];
        
        typecount  = typecount + detailArray.count;
        
        if (i > 0) {
            NSArray *tempA = [self.testDic valueForKey:testkey[i - 1]];
            if (tempA.count <= 3) {
                linenum += 1;
            }else if (tempA.count <= 6){
                linenum += 2;
            }else if (tempA.count <= 9){
                linenum += 3;
            }
            
            
        }
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = testkey[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        CGSize titleSize = TR_TEXT_SIZE(titleLabel.text, titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo((4 * SpareWidth + btnheight)* (linenum) + SpareWidth);
            make.size.mas_equalTo(CGSizeMake(titleSize.width + 20, btnheight));
        }];
        
        
        
        for (int j = 0; j < detailArray.count; j ++) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
            rightBtn.tag = 1000 + j + i * 100;
            
            if (rightBtn.tag == 1000) {
                
                if (spec_Array.count > 0) {
                    //有规格 情况
                    
                    [speArray addObject:[NSString stringWithFormat:@"%ld",(long)rightBtn.tag]];
                    
                    
                }else{
                    //没有规格
                    
                    [proArray addObject:[NSString stringWithFormat:@"%ld",(long)rightBtn.tag]];
                    
                }
            }
            
            if (rightBtn.tag == 1100) {
                
                [proArray addObject:[NSString stringWithFormat:@"%ld",(long)rightBtn.tag]];
            }
            [rightBtn setTitle:detailArray[j] forState:UIControlStateNormal];
            rightBtn.titleLabel.font = TR_Font_Gray(15);
            [rightBtn addTarget:self action:@selector(chooseDone:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            if (j == 0) {
                rightBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 236, 224, 1);
                [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            
            [self.contentView addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLabel.mas_left).offset((btnwidth + SpareWidth) * (j % 3) + SpareWidth);
                make.top.mas_equalTo(titleLabel.mas_bottom).offset((btnheight + SpareWidth) *(j / 3) + SpareWidth / 2);
                make.size.mas_equalTo(CGSizeMake(btnwidth, btnheight));
                
            }];
        }
        
        
    }
    
    self.contentView.contentSize = CGSizeMake(0, typecount /3 * (150));
    [self.contentView setContentOffset:CGPointZero];
    
    NSString *tempString = titleSpeArray[0];
    NSString *selctTag ;
    NSArray *tempArra  = self.testDic[tempString];
    
    GoodsChooseModel *model = [[GoodsChooseModel alloc]init];
    model.productName = productName;
    
    if (spec_Array.count > 0) {
        
        selctTag = speArray[0];
        model.spc_selectName = tempArra[[selctTag integerValue] - 1000];
        
    }else{
        
        selctTag = proArray[0];
        model.pro_name = tempArra[[selctTag integerValue] - 1000];
        
    }
    
  
    if (proArray.count > 0 && spec_Array.count > 0) {
        NSString *tempString2 = titleSpeArray[1];
        NSString *selctTag2 = proArray[0];
        NSArray *tempArray2 = self.testDic[tempString2];
        model.pro_name = tempArray2[[selctTag2 integerValue] - 1100];
    }
   
    
    NSString *sting = [NSString stringWithFormat:@"%@%@%@",model.productName,model.spc_selectName,model.pro_name];
    NSString *countString = [selectDic valueForKey:sting];
    if ([countString integerValue] >0) {
        _countView.hidden = NO;
        _addShopCar.hidden = YES;
        _numlabel.text = countString;
        
    }else{
        
        _countView.hidden = YES;
        _addShopCar.hidden = NO;
    }
    
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
    
    NSString *contentString;

    if (sender.tag == 1002) {
        self.count = self.numlabel.text.intValue;
        self.count ++ ;
        contentString = @"jia";
        self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        
        
        
    }else {
        //如果点击的是减号，先判断是否为0
        self.count = self.numlabel.text.intValue;
        self.count -- ;
        contentString = @"jian";
        self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        if (self.count == 0) {
            
            _addShopCar.hidden = NO;
            _countView.hidden = YES;
            

        }
    }
    
    
    NSString *tempString = titleSpeArray[0];
    NSString *selectTag = spec_Array.count > 0 ? speArray[0]:proArray[0];
    NSArray *tempArray  = self.testDic[tempString];
    
    GoodsChooseModel *model = [[GoodsChooseModel alloc]init];
    model.productName = productName;
    
    if (spec_Array.count > 0) {
        model.spc_selectName = tempArray[[selectTag integerValue] - 1000];
        CommoditySpecificationModel *model2 = self.datasource[[selectTag integerValue] - 1000];
        model.goodsPrice = model2.price;
        
    }else{
        
        selectTag = proArray[0];
        model.pro_name = tempArray[[selectTag integerValue] - 1000];
        model.goodsPrice = productItem.product_price;
        model.pro_id = [NSString stringWithFormat:@"%ld",sender.tag -1000];
        model.list_id = list_id;
        
    }
    
    
    if (proArray.count > 0 && spec_Array.count > 0) {
        NSString *tempString2 = titleSpeArray[1];
        NSString *selctTag2 = proArray[0];
        NSArray *tempArray2 = self.testDic[tempString2];
        model.pro_name = tempArray2[[selctTag2 integerValue] - 1100];
        model.pro_id = [NSString stringWithFormat:@"%ld",sender.tag -1100];
        model.list_id = list_id;
    }
    
    NSString *sting = [NSString stringWithFormat:@"%@%@%@",model.productName,model.spc_selectName,model.pro_name];
    NSString *countString = [selectDic valueForKey:sting];
   
    if ([contentString isEqualToString:@"jia"] ) {
        countString =  [NSString stringWithFormat:@"%ld",[countString integerValue] +1];
        selectGoodsCount = selectGoodsCount + 1;
        
        
    }else{
        countString =  [NSString stringWithFormat:@"%ld",[countString integerValue] -1];
        selectGoodsCount = selectGoodsCount - 1;
        
    }
    
    if ([countString integerValue] != 0) {
        
        [selectDic setValue:countString forKey:sting];
        
    }else{
        
         [selectDic removeObjectForKey:sting];
        
    }
    
    NSDictionary *tempDic = @{contentString:model};
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsToShopCar:)]) {
        [self.delegate addGoodsToShopCar:@[tempDic]];
        [self fixGoodsListDatasource];
    }
    
}



-(void)chooseDone:(UIButton *)sender{
    
    //点击了规格
    if (sender.tag < 1100) {
        
        NSString *selectNewTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        
        NSString *selctTag = spec_Array.count > 0 ? speArray[0]:proArray[0];
        NSAttributedString *attributedString;
     

        
        if (![selctTag isEqualToString:selectNewTag]) {
            UIButton *btn =  [self.contentView viewWithTag:[selctTag integerValue]];
            btn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            sender.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 236, 224, 1);
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            
            if (spec_Array.count > 0) {
                
    
                [speArray removeAllObjects];
                
                [speArray addObject:selectNewTag];
                
                CommoditySpecificationModel *model = self.datasource[sender.tag -1000];
                
                attributedString = [self attributedText:@[@"￥", model.old_price]];
                
            }else{
                
                [proArray removeAllObjects];
                [proArray addObject:selectNewTag];
                attributedString = [self attributedText:@[@"￥", productItem.product_price]];
            }
            
            self.priceLabel.attributedText = attributedString;
            
            
            
        }
     
    }
    
    
    //选择属性
    if (sender.tag >= 1100) {
        
        NSString *selectTag = proArray[0];
        if (![selectTag isEqualToString:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            UIButton *btn =  [self.contentView viewWithTag:[selectTag integerValue]];
            btn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [proArray removeAllObjects];
            NSString *selectNewTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
            [proArray addObject:selectNewTag];
            sender.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 236, 224, 1);
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
    }
   
    
    NSString *tempString = titleSpeArray[0];
    NSString *selctTag = spec_Array.count > 0 ? speArray[0]:proArray[0];
    NSArray *tempArray  = self.testDic[tempString];
    
    GoodsChooseModel *model = [[GoodsChooseModel alloc]init];
    model.productName = productName;
    if (spec_Array.count >0) {
        
        selctTag = speArray[0];
        model.spc_selectName = tempArray[[selctTag integerValue] - 1000];
        CommoditySpecificationModel *model2 = self.datasource[[selctTag integerValue] - 1000];
        model.goodsPrice = model2.price;
        model.spcID = spec_Array[0][@"id_"];;
        model.spc_name = tempString;
        model.spec_id = goodsSpcIDArray[[selctTag integerValue] - 1000];
        
        
    }else{
        
        selctTag = proArray[0];
        model.pro_name = tempArray[[selctTag integerValue] - 1000];
        model.goodsPrice = productItem.product_price;
        model.pro_id = [NSString stringWithFormat:@"%ld",sender.tag -1000];
        model.list_id = list_id;
        
    }
    
    
    if (proArray.count > 0 && spec_Array.count > 0) {
        NSString *tempString2 = titleSpeArray[1];
        NSString *selctTag2 = proArray[0];
        NSArray *tempArray2 = self.testDic[tempString2];
        model.pro_name = tempArray2[[selctTag2 integerValue] - 1100];
        model.pro_id = [NSString stringWithFormat:@"%ld",[selctTag2 integerValue] - 1100];
        model.list_id = list_id;
    }
    
    NSString *sting = [NSString stringWithFormat:@"%@%@%@",model.productName,model.spc_selectName,model.pro_name];
    NSString *countString = [selectDic valueForKey:sting];
    self.numlabel.text = countString;
    
    if ([countString integerValue] >= 1) {
        _addShopCar.hidden = YES;
        _countView.hidden = NO;
    }else{
        _addShopCar.hidden = NO;
        _countView.hidden = YES;
    }
    
   
}


-(void)addtoshopcar:(UIButton *)sender{
  
    GoodsChooseModel *model = [[GoodsChooseModel alloc]init];
    model.productName = productName;
    model.goodsCount = @"1";
    NSString *tempString = titleSpeArray[0];
    NSArray *tempArray  = self.testDic[tempString];
    NSString *selctTag;
    
    if (spec_Array.count >0) {
        
        selctTag = speArray[0];
        model.spc_selectName = tempArray[[selctTag integerValue] - 1000];
        CommoditySpecificationModel *model2 = self.datasource[[selctTag integerValue] - 1000];
        model.goodsPrice = model2.price;
        model.spcID = spec_Array[0][@"id_"];;
        model.spc_name = tempString;
        model.spec_id = goodsSpcIDArray[[selctTag integerValue] - 1000];

        
    }else{
        
        selctTag = proArray[0];
        model.pro_name = tempArray[[selctTag integerValue] - 1000];
        model.goodsPrice = productItem.product_price;
        model.pro_id = [NSString stringWithFormat:@"%ld",sender.tag -1000];
        model.list_id = list_id;
        
    }
    
    
    if (proArray.count > 0 && spec_Array.count > 0) {
        NSString *tempString2 = titleSpeArray[1];
         NSString *selctTag2 = proArray[0];
        NSArray *tempArray2 = self.testDic[tempString2];
        model.pro_name = tempArray2[[selctTag2 integerValue] - 1100];
        model.pro_id = [NSString stringWithFormat:@"%ld",[selctTag2 integerValue] - 1100];
        model.list_id = list_id;
    }

    
    _numlabel.text = @"1";
    _addShopCar.hidden = YES;
    _countView.hidden = NO;
    selectGoodsCount = selectGoodsCount + 1;
    
    NSDictionary *tempDic = @{@"jia":model};
    
    NSString *sting = [NSString stringWithFormat:@"%@%@%@",model.productName,model.spc_selectName,model.pro_name];
    [selectDic setValue:@"1" forKey:sting];
    [selectGoodsDic setObject:model forKey:sting];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsToShopCar:)]) {
        [self.delegate addGoodsToShopCar:@[tempDic]];
        [self fixGoodsListDatasource];
    }
}





-(void)reportDatasourcetoTopView{
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSString *tempString in [selectDic allKeys]) {
        
        NSString *count = [selectDic valueForKey:tempString];
        GoodsChooseModel *goodmodel    =  selectGoodsDic[tempString];
        if ([count integerValue] > 0) {
            GoodsChooseModel *model = [[GoodsChooseModel alloc]init];
            model.productName = productName;
            model.image = goodsImages;
            model.shopName = shopName;
            model.shopID = shopID;
            model.shopImage = self.shopImages;
            model.productId = goodmodel.productId;
            
            
            if (spec_Array.count > 0) {
                
                model.spc_selectName = goodmodel.spc_selectName;
                model.spcID = goodmodel.spcID;
                model.spc_name = goodmodel.spc_name;
                model.goodsCount = count;
                model.spec_id = goodmodel.spec_id;
                model.goodsPrice = goodmodel.goodsPrice;
                
            }else{
               
                model.pro_name = goodmodel.pro_name;
                model.pro_id = goodmodel.pro_id;
                model.list_id = goodmodel.list_id;
                model.goodsPrice = productItem.product_price;
            }
           
            
            
           
            
            if (proArray.count > 0 && spec_Array.count > 0) {
                
                model.goodsCount = count;
                model.goodsPrice = goodmodel.goodsPrice;
                model.pro_name = goodmodel.pro_name;
                model.pro_id = goodmodel.pro_id;
                model.list_id = goodmodel.list_id;
            }
            
            model.nickName = [NSString stringWithFormat:@"%@%@%@",model.productName,model.spc_selectName,model.pro_name];
            [dataArray addObject:model];
           
        }
    }

    NSLog(@"%@",dataArray);
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(reportSelectDataSource:)]) {
//        [self.delegate reportSelectDataSource:dataArray];
//
//    }
    
}



-(void)fixGoodsListDatasource{
    
    if (cellIndexpath) {
        ProductItem *model = [GoodsListManager shareInstance].goodsListArray[cellIndexpath.section][cellIndexpath.row];
        model.selectCount = [NSString stringWithFormat:@"%ld",selectGoodsCount];
        NSMutableArray *tempArray = [GoodsListManager shareInstance].goodsListArray[cellIndexpath.section];
        [tempArray replaceObjectAtIndex:cellIndexpath.row withObject:model];
        [[GoodsListManager shareInstance].goodsListArray replaceObjectAtIndex:cellIndexpath.section withObject:tempArray];
    }
}


- (NSAttributedString *)attributedText:(NSArray*)stringArray {
    
    NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:25],
                                      NSForegroundColorAttributeName:[UIColor redColor]};
    NSArray *attributeAttay = @[attributesExtra,attributesPrice];
    NSString * string = [stringArray componentsJoinedByString:@""];
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++){
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
