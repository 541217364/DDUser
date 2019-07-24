//
//  ShopDetailMessageView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/17.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopDetailMessageView.h"

#define SprareWidth  10

#define BtnWidth  30

#define imageViewHeigh (270 *(SCREEN_WIDTH / 375))

@implementation ShopDetailMessageView
{
    NSMutableArray *speArray;//规格数组
    NSMutableArray *proArray;//属性属性；
    NSArray *  listarray;
    NSArray * spec_Array ;//属性
    NSMutableArray *titleSpeArray;
    CGFloat btnWidth;
    NSMutableDictionary *goodSelectDic;
    NSString *productName;
    NSString *shopName;
    NSString *shopID;
    NSString *goodsImages;
    NSString *sid;
    NSString *list_id;
    NSString *packing_charge;
    NSMutableDictionary *selectDic;
    NSMutableDictionary *selectGoodsDic;
    NSMutableArray *goodsSpcIDArray;
    NSArray  *selectSpecArray;
    
}
-(UIImageView *)shopimageView{
    if (_shopimageView == nil) {
        _shopimageView = [[UIImageView alloc]init];
        _shopimageView.backgroundColor = [UIColor clearColor];
        _shopimageView.layer.cornerRadius = 5.0f;
        _shopimageView.layer.masksToBounds = YES;
        _shopimageView.hidden = YES;
        _shopimageView.image = [UIImage imageNamed:@"51514284697_.pic_hd.jpg"];
    }
    return _shopimageView;
}

-(UIScrollView *)bottomScroll{
    if (_bottomScroll == nil) {
        _bottomScroll = [[UIScrollView alloc]init];
        _bottomScroll.backgroundColor = [UIColor whiteColor];
        _bottomScroll.layer.cornerRadius = 5.0f;
        _bottomScroll.layer.masksToBounds = YES;
        _bottomScroll.hidden = YES;
        _bottomScroll.contentSize = CGSizeMake(0, self.frame.size.height / 3 * 2);
    }
    return _bottomScroll;
}

-(UILabel *)namelabel{
    if (_namelabel == nil) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.backgroundColor = [UIColor clearColor];
        _namelabel.text = @"香辣鸡腿堡";
        _namelabel.textAlignment = NSTextAlignmentLeft;
        _namelabel.textColor = [UIColor blackColor];
        _namelabel.font =  TR_Font_Cu(20);
        [_bottomScroll addSubview:self.namelabel];
    }
    return _namelabel;
}

-(UILabel *)salecount{
    if (_salecount == nil) {
        _salecount = [[UILabel alloc]init];
        _salecount.font = TR_Font_Gray(14);
        _salecount.backgroundColor = [UIColor clearColor];
        _salecount.text = @"月销2666";
        _salecount.textColor = GRAY_Text_COLOR;
        _salecount.textAlignment = NSTextAlignmentLeft;
        [_bottomScroll addSubview:self.salecount];
    }
    return _salecount;
}


-(UILabel *)pricelabel{
    if (_pricelabel == nil) {
        _pricelabel = [[UILabel alloc]init];
        _pricelabel.font = [UIFont systemFontOfSize:17];
        _pricelabel.backgroundColor = [UIColor clearColor];
        _pricelabel.textColor = [UIColor redColor];
        _pricelabel.textAlignment = NSTextAlignmentLeft;
        [_bottomView addSubview:_pricelabel];
    }
    return _pricelabel;
}

-(UILabel *)oldpricelabel{
    
    if (_oldpricelabel == nil) {
        _oldpricelabel = [[UILabel alloc]init];
        _oldpricelabel.backgroundColor = [UIColor clearColor];
        _oldpricelabel.textAlignment = NSTextAlignmentLeft;
        [_bottomView addSubview:_oldpricelabel];
    }
    return _oldpricelabel;
    
}


-(UIView *)countView{
    if (_countView == nil) {
        _countView = [[UIView alloc]init];
        _countView.backgroundColor = [UIColor clearColor];
        [_bottomView addSubview:self.countView];
    }
    return _countView;
}

-(UILabel *)commentLabel{
    if (_commentLabel == nil) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.text = @"精选优质材料......";
        _commentLabel.font = TR_Font_Gray(15);
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.textColor = GRAY_Text_COLOR;
        _commentLabel.numberOfLines = 0;
        _commentLabel.backgroundColor = [UIColor clearColor];
        [_bottomView addSubview:_commentLabel];
    }
    return _commentLabel;
}

-(UIButton *)selectTypeBtn{
    
    if (_selectTypeBtn == nil) {
        _selectTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectTypeBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _selectTypeBtn.titleLabel.font = TR_Font_Gray(14);
        _selectTypeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_selectTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectTypeBtn.hidden = YES;
        _selectTypeBtn.layer.cornerRadius = 15.0f;
        _selectTypeBtn.layer.masksToBounds = YES;
        
        _selectTypeBtn.backgroundColor = ORANGECOLOR;
        [_selectTypeBtn addTarget:self action:@selector(addTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_selectTypeBtn];
    }
    return _selectTypeBtn;
}

-(UIView *)goodsSpcView{
    if (_goodsSpcView == nil) {
        _goodsSpcView = [[UIView alloc]init];
        _goodsSpcView.backgroundColor = [UIColor whiteColor];
         [_bottomScroll addSubview:_goodsSpcView];
    }
    return _goodsSpcView;
}

-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomScroll addSubview:_bottomView];
    }
    return _bottomView;
}

-(NSMutableArray *)datasource{
    
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        speArray = [NSMutableArray array];
        proArray = [NSMutableArray array];
        goodSelectDic = [NSMutableDictionary dictionary];
        selectDic = [NSMutableDictionary dictionary];
        selectGoodsDic = [NSMutableDictionary dictionary];
        goodsSpcIDArray = [NSMutableArray array];
        
        [self addSubview:self.shopimageView];
        [self addSubview:self.bottomScroll];
        [self designView];
        
        
    }
    return self;
}



-(void)designView{
    static float space = 10;
    WeakSelf;
    [self.shopimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STATUS_BAR_HEIGHT);
        make.left.mas_equalTo(space);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * space, imageViewHeigh));
    }];
    
    [self.bottomScroll mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(weakself.shopimageView.mas_bottom).offset(space);
    make.bottom.mas_equalTo(-10);
    make.width.mas_equalTo(SCREEN_WIDTH - 2 * space);
    make.left.mas_equalTo(space);
    }];
    
    
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space);
        make.top.mas_equalTo(space);
        make.size.mas_equalTo(CGSizeMake(weakself.frame.size.width - 2 * space, 20));
    }];
    
    
    [self.salecount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.namelabel.mas_left);
        make.top.mas_equalTo(weakself.namelabel.mas_bottom).offset(space);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.goodsSpcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakself.salecount.mas_bottom).offset(space);
        make.size.mas_equalTo(CGSizeMake(weakself.frame.size.width, 0));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakself.goodsSpcView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(weakself.frame.size.width, 100));
    }];
    
    
    [self.pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.salecount.mas_left);
        make.top.mas_equalTo(space);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [self.oldpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.pricelabel.mas_right).offset(20);
        make.centerY.mas_equalTo(weakself.pricelabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 4 * space);
        make.height.mas_equalTo(BtnWidth);
        make.width.mas_equalTo(BtnWidth * 3);
        make.centerY.mas_equalTo(weakself.pricelabel.mas_centerY);
    }];
    
    // 选规格   与上一个互斥  根据返回的数据判断
    
    [self.selectTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 4 * space);
        make.height.mas_equalTo(BtnWidth);
        make.width.mas_equalTo(BtnWidth * 3);
        make.centerY.mas_equalTo(weakself.pricelabel.mas_centerY);
    }];
    
    
    
    UILabel *commentL = [[UILabel alloc]init];
    commentL.text = @"商品描述";
    commentL.font =  TR_Font_Gray(15);
    [self.bottomView addSubview:commentL];
    commentL.backgroundColor = [UIColor clearColor];
    [commentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space);
        make.top.mas_equalTo(weakself.countView.mas_bottom).offset(space * 2);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space);
        make.top.mas_equalTo(commentL.mas_bottom).offset(space);
        make.right.mas_equalTo(-space);
    }];
    
    
    [self addcountkey];
    
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"shop_detail_back"];
    
    [self addSubview:backImageView];
    backImageView.userInteractionEnabled = YES;
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.shopimageView.mas_left).offset(space);
        make.top.mas_equalTo(weakself.shopimageView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UIView *hide_view = [[UIView alloc]init];
    [self addSubview:hide_view];
    [hide_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(weakself.shopimageView.mas_top);
    }];
    
   
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlereturenAction:)];
    [backImageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlereturenAction:)];
    
    [hide_view addGestureRecognizer:tap2];
}

//数据
-(void)designViewWithShopMessage:(NSArray *)contentArray{
    
    __weak typeof(self) weakSelf = self;
    ProductItem *model = contentArray[0];
    self.indexPath = contentArray[1];
    if (model) {
        self.model = model;
        [self.shopimageView sd_setImageWithURL:[NSURL URLWithString:model.product_image] placeholderImage:[UIImage imageNamed:@"shop_detail_pl"]];
        self.namelabel.text = model.product_name;
        self.pricelabel.text =[NSString stringWithFormat:@"￥%@",model.o_price];
        
        if ([model.sort_discount doubleValue] > 0) {
           
            
            double price = [model.o_price doubleValue] * [model.sort_discount doubleValue] * 0.1;
            
            NSAttributedString *attributedString = [self attributedText:@[@"￥", model.o_price]];
            
            _oldpricelabel.attributedText = attributedString;
            
            self.pricelabel.text =[NSString stringWithFormat:@"￥%.2f",price];
            self.oldpricelabel.hidden = NO;
            
        }else{
            
            self.oldpricelabel.hidden = YES;
        }
        self.salecount.text = [NSString stringWithFormat:@"月售%@%@",model.product_sale,model.unit];

        if (model.des.length > 0) {
            
           self.commentLabel.text = model.des;
            
        }

        for (UIView * temp in self.goodsSpcView.subviews) {
            [temp removeFromSuperview];
        }
        
        if ([model.has_format isEqualToString:@"1"]) {
            
            
            [self getShopGoodsSpcData];
    

        }else
        {
            [self.goodsSpcView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(weakSelf.salecount.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, 0));
            }];
            
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(weakSelf.goodsSpcView.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, 100));
            }];
            
            [self.bottomScroll layoutIfNeeded];
            [self.bottomScroll setContentOffset:CGPointZero];

            if ([model.selectCount integerValue ] > 0) {
                self.numlabel.text = model.selectCount;
                self.countView.hidden = NO;
                self.selectTypeBtn.hidden = YES;
                
            }else{
                
                self.numlabel.text = @"0";
                self.countView.hidden = YES;
                self.selectTypeBtn.hidden = NO;
                
            }
            
            if (!model.selectCount) {
                
                self.numlabel.text = @"0";
                self.countView.hidden = YES;
                self.selectTypeBtn.hidden = NO;
            }
            


        }
        
        
    }
    
    
}


-(void)getShopGoodsSpcData{
    
    [HBHttpTool post: SHOP_AJAXSHOPGOODS params:@{@"Device-Id":DeviceID,@"goods_id":self.model.product_id} success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            [self.datasource removeAllObjects];
            self->productName = responseObj[@"result"][@"name"];
            self->goodsImages = responseObj[@"result"][@"image"];
            self->shopID = responseObj[@"result"][@"store_id"];

            
            NSDictionary *dict=[responseObj objectForKey:@"result"];
            
            self.sepModel=[[SpecAttuributrModel alloc]initWithDictionary:dict error:nil];
            
            [self loadDatasourceWithresponse:(responseObj[@"result"])];
        }
        
        
    } failure:^(NSError *error) {
        
    }];

}
























-(void)loadDatasourceWithresponse:(NSDictionary *)result{
    
    //计算文本宽度
    __weak typeof(self) weakSelf = self;
    [proArray removeAllObjects];
    [speArray removeAllObjects];

    
    // 添加商品的按键
    
    btnWidth = 25;
   
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [goodsSpcIDArray removeAllObjects];
    
    
    
    for (int i = 0; i < self.sepModel.spec_list.count; i ++) {
        
       SpecDataModel *specmodel= self.sepModel.spec_list[i];
        
        
        for (int j = 0 ; j < specmodel.list.count ; j ++) {
            
            SpecDataItem *tempModel = specmodel.list[j];
            [tempArray addObject:tempModel.name];
        }
        
        
    }
    

    spec_Array  = result[@"spec_list"];
    NSArray *testkey;

    if ([result[@"is_properties"] isEqualToString:@"1"]) {
        NSString *properties = result[@"properties_list"][0][@"name"];
        AttuributrModel *atturimodel = [self.sepModel.properties_list firstObject];
        NSArray *propertiesArray = atturimodel.val;
        
        if (self.sepModel.spec_list.count > 0) {
            
            self.testDic = @{@"规格":tempArray,properties:propertiesArray};
            testkey = @[@"规格",properties];
            
        }else{
            
            self.testDic = @{properties:propertiesArray};
             testkey = @[properties];
        }
        
        
    }else{
        
        self.testDic = @{@"规格":tempArray};
         testkey = @[@"规格"];
        
    }
    
   
    
    NSInteger typecount = 0;
    //布局规格和属性  根据传入的参数改变
    CGFloat btnwidth = (self.frame.size.width - 60)/3 ;
    CGFloat btnheight = 30;
    NSInteger linenum  = 0;
    NSInteger allcount = 0;
    
    for (int i = 0; i < testkey.count; i ++) {
        
        NSArray *detailArray = [self.testDic valueForKey:testkey[i]];
        
        NSInteger arrayCount = detailArray.count;
        
        NSInteger count1 = arrayCount / 3;
        
        NSInteger count2 = arrayCount % 3 > 0 ? 1:0;
        
        allcount  = allcount + count1 + count2;
    }
    
    
    [self.goodsSpcView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.salecount.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, allcount * 40 + [self.testDic allKeys].count * 50));
    }];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.goodsSpcView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, 100));
    }];
    
    [self layoutIfNeeded];
    
    
    
    
    
    for (UIView * temp in self.goodsSpcView.subviews) {
        [temp removeFromSuperview];
    }
    
    for (int i = 0; i < testkey.count; i++) {
        
        NSArray *detailArray = [self.testDic valueForKey:testkey[i]];
        
        typecount  = typecount + detailArray.count;
        
        if (i > 0) {
            NSArray *tempA = [self.testDic valueForKey:testkey[i - 1]];
            
            linenum = tempA.count % 3 == 0 ? tempA.count / 3 : tempA.count / 3 + 1;
           
        }
        
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = testkey[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.goodsSpcView addSubview:titleLabel];
        CGSize titleSize = TR_TEXT_SIZE(titleLabel.text, titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        CGFloat Heigh = i == 0 ? SprareWidth : (linenum + 1) *(SprareWidth + btnheight) + SprareWidth ;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SprareWidth);
            make.top.mas_equalTo(Heigh);
            make.size.mas_equalTo(CGSizeMake(titleSize.width + 20, btnheight));
        }];
        
        
        
        for (int j = 0; j < detailArray.count; j ++) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
            rightBtn.tag = 1000 + j + i * 100;
            
            if (rightBtn.tag ==1000) {
                
                if (spec_Array.count > 0) {
                    //有规格 情况
                    
                    [speArray addObject:[NSString stringWithFormat:@"%ld",(long)rightBtn.tag]];
                   
                    
                }else{
                    //没有规格
                    
                     [proArray addObject:[NSString stringWithFormat:@"%ld",(long)rightBtn.tag]];
                    
                }
            }
            
            
            if (rightBtn.tag == 1100) {
                //此情况只有可能是 有规格有 属性
                
                [proArray addObject:[NSString stringWithFormat:@"%ld",(long)rightBtn.tag]];
      
        }
            
            
   
            
            
            
            [rightBtn setTitle:detailArray[j] forState:UIControlStateNormal];
            rightBtn.titleLabel.font = TR_Font_Gray(14);
            [rightBtn addTarget:self action:@selector(chooseDone:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            if (j == 0) {
                rightBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 236, 224, 1);
                [rightBtn setTitleColor:TR_COLOR_RGBACOLOR_A(249, 72, 60, 1) forState:UIControlStateNormal];
            }
            
            if (spec_Array.count > 0 && i == 0) {
                SpecDataModel *model = [self.sepModel.spec_list firstObject];
                
                if (model.list.count > 0) {
                    
                    SpecDataItem *tempModel = model.list[j];
                    
                    if ([tempModel.stock_num integerValue] == 0) {
                        rightBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
                        [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        rightBtn.userInteractionEnabled = NO;
                    }
                    
                }
            }
            
         
            
            
            [self.goodsSpcView addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLabel.mas_left).offset((btnwidth + SprareWidth) * (j % 3));
                make.top.mas_equalTo(titleLabel.mas_bottom).offset((btnheight + SprareWidth) *(j / 3) + SprareWidth / 2);
                make.size.mas_equalTo(CGSizeMake(btnwidth, btnheight));
                
            }];
        }
        
      
        [self.bottomScroll setContentOffset:CGPointZero];
        
        CGSize size = TR_TEXT_SIZE(self.model.des, self.commentLabel.font, CGSizeMake(SCREEN_WIDTH - 50, MAXFLOAT), nil)
        [self.bottomScroll setContentSize:CGSizeMake(0, 220 + typecount * 35 + size.height)];
        [self getSelectFoodsCount];

    }
    
    
}

-(void)chooseDone:(UIButton *)sender{
    
    //点击了规格 或者属性
    if (sender.tag < 1100) {
        
        NSString *selectTag;
        
        if (self.sepModel.spec_list.count > 0) {
            
            selectTag = speArray[0];
           
        }else{
            
            selectTag = proArray[0];
        }
        
        
        if (![selectTag isEqualToString:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            
            UIButton *btn =  [self.goodsSpcView viewWithTag:[selectTag integerValue]];
            
            if (btn.userInteractionEnabled) {
                btn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            

            NSString *selectNewTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
            
            
            if (self.sepModel.spec_list.count > 0) {
                [speArray removeAllObjects];
                [speArray addObject:selectNewTag];

                
            }else{
                
                [proArray removeAllObjects];
                [proArray addObject:selectNewTag];
                
            }
            
            
            sender.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 236, 224, 1);
            [sender setTitleColor:TR_COLOR_RGBACOLOR_A(249, 72, 60, 1) forState:UIControlStateNormal];
            
          
            
        }
        
    }
    
    
    //选择属性
    if (sender.tag >= 1100) {
        
        NSString *selectTag = proArray[0];
        if (![selectTag isEqualToString:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            UIButton *btn =  [self.goodsSpcView viewWithTag:[selectTag integerValue]];
            btn.backgroundColor = TR_COLOR_RGBACOLOR_A(246, 246, 246, 1);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [proArray removeAllObjects];
            NSString *selectNewTag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
            [proArray addObject:selectNewTag];
            sender.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 236, 224, 1);
            [sender setTitleColor:TR_COLOR_RGBACOLOR_A(249, 72, 60, 1) forState:UIControlStateNormal];
        }
        
    }
    
    [self getSelectFoodsCount];
    
}


-(void)getSelectFoodsCount{
    
    GoodsShopModel *goodModel = [[GoodsListManager shareInstance]transformModelFrom3:self.model withShopID:self.ShopModel.store_id];
    
    
    
    if (self.sepModel.spec_list.count > 0) {
        
        SpecDataModel *model = [self.sepModel.spec_list firstObject];
        NSString *selctTag = speArray[0];
        
        SpecDataItem *tempModel = model.list[[selctTag integerValue] - 1000];
        goodModel.specId = tempModel.id_;
        
        [self fixPriceLable:tempModel.price];
        
        if (proArray.count > 0 ) {
            //有规格  有属性情况
            NSString *selctTag2 = proArray[0];
            goodModel.atttip = [NSString stringWithFormat:@"%ld",[selctTag2 integerValue] - 1100];
            AttuributrModel *atturimodel = [self.sepModel.properties_list firstObject];
            
            goodModel.attributeId = atturimodel.id_;
            
            [self fixPriceLable:tempModel.price];
            
        }
        
        
    }else{
        //没有规格  只有属性
        if (proArray.count  == 0) {
            
            self.selectTypeBtn.hidden = NO;
            self.countView.hidden = YES;
            self.model.has_format = @"0";
            return;
        }
        
        NSString *selctTag2 = proArray[0];
        goodModel.atttip = [NSString stringWithFormat:@"%ld",[selctTag2 integerValue] - 1000];
        AttuributrModel *atturimodel = [self.sepModel.properties_list firstObject];
        
        goodModel.attributeId = atturimodel.id_;
        
        [self fixPriceLable:self.model.product_price];
    }
    
    
    goodModel.marking = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",goodModel.storeid,goodModel.goodId,goodModel.specId,goodModel.attributeId,goodModel.atttip];
    
    GoodsShopModel *tempModel = [[GoodsListManager shareInstance]getSelectGoodsFromDB:self.ShopModel.store_id withGoodMark:goodModel.marking];
    
    [self fixCountViewState:tempModel];
    
}
    
    



-(void)fixCountViewState:(GoodsShopModel *)model{
    
    if (model) {
        
        if (model.goodnum > 0) {
            self.countView.hidden = NO;
            self.numlabel.text = model.goodnum;
            UIButton *btn = [self.countView viewWithTag:1001];
            btn.hidden = NO;
            self.selectTypeBtn.hidden = YES;
        }else{
            self.countView.hidden = YES;
            self.selectTypeBtn.hidden = NO;
            self.selectTypeBtn.backgroundColor = ORANGECOLOR;
            self.numlabel.text = @"0";
            
        }
        
    }else{
        
        self.countView.hidden = YES;
        self.selectTypeBtn.hidden = NO;
        self.selectTypeBtn.backgroundColor = ORANGECOLOR;
        self.numlabel.text = @"0";
    }
    
    
    
    if ([self.model.has_format isEqualToString:@"1"]) {
        
        if (spec_Array.count > 0) {
            
            SpecDataModel *model = [self.sepModel.spec_list firstObject];
            
            if (model.list.count > 0) {
                NSInteger index = [speArray[0] integerValue];
                SpecDataItem *tempModel = model.list[index - 1000];
                
                if ([tempModel.stock_num integerValue]  == 0 ) {
                    
                    self.selectTypeBtn.hidden = NO;
                    self.countView.hidden = YES;
                    self.selectTypeBtn.backgroundColor = [UIColor lightGrayColor];
                    
                }
                
            }
            
            
        }else{
    
            if ([self.model.stock integerValue]  == 0 ) {
                self.selectTypeBtn.hidden = NO;
                self.countView.hidden = YES;
                self.selectTypeBtn.backgroundColor = [UIColor lightGrayColor];
                self.selectTypeBtn.userInteractionEnabled = NO;
                
            }
            
        }
    }
    
    
    
}


-(void)fixPriceLable:(NSString *)price{
    
    double goodPrice = [self.model.sort_discount doubleValue] > 0 ?
    
    [price doubleValue]*[self.model.sort_discount doubleValue] * 0.1:[price doubleValue];
    
        NSAttributedString *attributedString = [self attributedText:@[@"￥", price]];
    
    self.oldpricelabel.attributedText = attributedString;
    
    self.pricelabel.text = [NSString stringWithFormat:@"￥%.2f",goodPrice];
    
    
}


//添加数目的按键
- (void)addcountkey {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shop_delete"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.countView addSubview:btn];
    btn.tag = 1001;
    [btn addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BtnWidth, BtnWidth));
    }];
    
    self.numlabel = [[UILabel alloc]init];
    self.numlabel.font = [UIFont systemFontOfSize:14];
    [self.countView addSubview:self.numlabel];
    self.numlabel.textAlignment = NSTextAlignmentCenter;
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BtnWidth);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BtnWidth, BtnWidth));
    }];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"shop_add"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor clearColor];
    [self.countView addSubview:btn2];
    [btn2 addTarget:self action:@selector(countnumber:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1002;
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BtnWidth * 2);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(BtnWidth, BtnWidth));
    }];
    
}


//点击数目的事件
-(void)countnumber:(UIButton *)sender {
    
    NSString *countType;
    
    if (sender.tag == 1002) {
        
        if ([self.numlabel.text integerValue] > [self.model.stock integerValue]) {
            
            TR_Message(@"商品库存不足");
            
            return;
        }
        
        if ([self.numlabel.text integerValue] > [self.model.max_num integerValue]) {
            
            if ([self.model.max_num integerValue] != 0) {
                
                TR_Message(@"限购商品无法选择更多");
                
                return;
                
            }
            
        }
        
        self.count = self.numlabel.text.intValue;
        self.count ++ ;
        countType = @"jia";
        
        self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        
    }else {
        //如果点击的是减号，先判断是否为0
        self.count = self.numlabel.text.intValue;
        if (self.count > 0) {
            self.count -- ;
            countType = @"jian";
            
            self.numlabel.text = [NSString stringWithFormat:@"%d",self.count];
        }
    }
    
    UIButton *btn = [self.countView viewWithTag:1001];
    if (self.count > 0) {
        
        self.numlabel.hidden = NO;
        
        btn.hidden = NO;
        
    }else {
        self.countView.hidden = YES;
        self.selectTypeBtn.hidden = NO;
    }
    
    
        // 数据入库操作
        [self addgoodsAction];
        

   
}

//商品加入购物车

-(void)addTypeAction:(UIButton *)sender{
    
    self.selectTypeBtn.hidden = YES;
    self.countView.hidden = NO;
    self.numlabel.text = @"1";
    [self addgoodsAction];
    
    
    
}




-(void)addgoodsAction{
    
    
    StoreDataModel *storeModel = [[GoodsListManager shareInstance]transformModelFrom4:self.ShopModel];
    
    GoodsShopModel *goodModel = [[GoodsListManager shareInstance]transformModelFrom3:self.model withShopID:self.ShopModel.store_id];

    goodModel.goodnum = self.numlabel.text;
    goodModel.atttip = @"0";
    
  
    
    if (![self.model.has_format isEqualToString:@"1"]) {
        
        if ([self.numlabel.text integerValue] > [self.model.stock integerValue]) {
            
            TR_Message(@"商品库存不足");
            if ([self.numlabel.text integerValue] > 0) {
                self.numlabel.text = [NSString stringWithFormat:@"%ld",[self.numlabel.text integerValue] - 1];
                
                if ([self.numlabel.text integerValue] == 0) {
                    self.countView.hidden = YES;
                    self.selectTypeBtn.hidden = NO;
                }
                
            }
           
            
            return;
        }
        
        if ([self.numlabel.text integerValue] > [self.model.max_num integerValue]) {
            
            if ([self.model.max_num integerValue] != 0) {
                
                TR_Message(@"限购商品无法选择更多");
                
                if ([self.numlabel.text integerValue] > 0) {
                    self.numlabel.text = [NSString stringWithFormat:@"%ld",[self.numlabel.text integerValue] - 1];
                    
                    if ([self.numlabel.text integerValue] == 0) {
                        self.countView.hidden = YES;
                        self.selectTypeBtn.hidden = NO;
                    }
                    
                }
             
                
                return;
                
            }
            
        }
        
        //没有规格和属性的时候  添加商品
        if ([self.numlabel.text integerValue] > 0) {
            //此时数目不为0
            [[GoodsListManager shareInstance]setSelctModelCount:self.model withCount:self.numlabel.text];
             [[GoodShopManagement shareInstance]addStore:storeModel andGoodshopmodel:goodModel];
            return;
           
        }else{
           //数目为0的时候
            
            [[GoodsListManager shareInstance]setSelctModelCount:self.model withCount:@"0"];
            [[GoodShopManagement shareInstance]deleteStore:storeModel andGoodshopmodel:goodModel];
            
            return;
            
        }
        
        
        
    }
    
    
    // 改商品有规格属性的时候
    
    if ([self.model.has_format isEqualToString:@"1"]) {
        
        if (self.sepModel.spec_list.count > 0) {
            
            SpecDataModel *model = [self.sepModel.spec_list firstObject];
            NSString *selctTag = speArray[0];
            
            SpecDataItem *tempModel = model.list[[selctTag integerValue] - 1000];
            
            if ([self.numlabel.text integerValue] > [tempModel.stock_num integerValue]) {
                
                TR_Message(@"商品库存不足");
                if ([self.numlabel.text integerValue] > 0) {
                    self.numlabel.text = [NSString stringWithFormat:@"%ld",[self.numlabel.text integerValue] - 1];
                    
                    if ([self.numlabel.text integerValue] == 0) {
                        self.countView.hidden = YES;
                        self.selectTypeBtn.hidden = NO;
                    }
                    
                }
                return;
                
            }
            
            goodModel.specId = tempModel.id_;
            goodModel.specname = tempModel.name;
            goodModel.specprice = tempModel.price;
            goodModel.specpick = tempModel.packing_charge;
            goodModel.spec_tid = tempModel.sid;
            [self fixPriceLable:tempModel.price];
            
            if (proArray.count > 0 ) {
                //有规格  有属性情况
                NSString *selctTag2 = proArray[0];
                goodModel.atttip = [NSString stringWithFormat:@"%ld",[selctTag2 integerValue] - 1100];
                AttuributrModel *atturimodel = [self.sepModel.properties_list firstObject];
                
                goodModel.attributeId = atturimodel.id_;
                goodModel.attributename = atturimodel.val[[selctTag2 integerValue] - 1100];
                [self fixPriceLable:tempModel.price];
                
            }
            
            
        }else{
            //没有规格  只有属性
            NSString *selctTag2 = proArray[0];
            goodModel.atttip = [NSString stringWithFormat:@"%ld",[selctTag2 integerValue] - 1000];
            AttuributrModel *atturimodel = [self.sepModel.properties_list firstObject];
            
            goodModel.attributeId = atturimodel.id_;
            goodModel.attributename = atturimodel.val[[selctTag2 integerValue] - 1000];
            [self fixPriceLable:self.model.product_price];
        }
        
    }
    
    goodModel.marking = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",goodModel.storeid,goodModel.goodId,goodModel.specId,goodModel.attributeId,goodModel.atttip];
    
    if ([goodModel.goodnum integerValue] > 0) {
        
       
        [[GoodShopManagement shareInstance]addStore:storeModel andGoodshopmodel:goodModel];
        
    }else{
        
         [[GoodShopManagement shareInstance]deleteStore:storeModel andGoodshopmodel:goodModel];
    }
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];
}





//返回上一界面

-(void)handlereturenAction:(UITapGestureRecognizer *)sender{
    

        if (self.delegate && [self.delegate respondsToSelector:@selector(returnTopViewAction)]) {
            [self.delegate returnTopViewAction];
        }
   

}




//动画部分
-(void)startAnimalWithRect:(CGRect)rect{
    
    self.shopimageView.frame = rect;
    
    self.bottomScroll.frame =
    CGRectMake(10, SCREEN_HEIGHT, SCREEN_WIDTH - 2 * 10, SCREEN_HEIGHT - imageViewHeigh - 20- STATUS_BAR_HEIGHT);

    self.shopimageView.hidden = NO;
    self.bottomScroll.hidden  = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.shopimageView.frame =
        CGRectMake(10, STATUS_BAR_HEIGHT, SCREEN_WIDTH - 2 * 10, imageViewHeigh);
        self.bottomScroll.frame =
        CGRectMake(10, STATUS_BAR_HEIGHT + imageViewHeigh + 10, SCREEN_WIDTH - 2 * 10, SCREEN_HEIGHT - imageViewHeigh - STATUS_BAR_HEIGHT -20);
        
    } completion:^(BOOL finished) {
    
    }];
    
    
   
    
}






#pragma mark AddGoodsToShopCarDelegate

//-(void)addGoodsToShopCar:(NSArray *)tempArray{
//
//    if (tempArray.count > 0) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsToShopCarAction:)]) {
//            [self.delegate addGoodsToShopCarAction:tempArray];
//        }
//    }
//
//
//}





- (NSAttributedString *)attributedText:(NSArray*)stringArray{
    NSString * string = [stringArray componentsJoinedByString:@""];
   
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]};
    NSMutableAttributedString *  result = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic];
    // 返回已经设置好了的带有样式的文字
    return   result;  //[[NSAttributedString alloc] initWithAttributedString:result];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
