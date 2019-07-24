//
//  BusinessDetailView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/9.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "BusinessDetailView.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "CommonCrypto/CommonDigest.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NoticeTipView.h"

#define SpareWidth 10
#define ScreenH SCREEN_HEIGHT -HeightForNagivationBarAndStatusBar
#define ViewHeight (ScreenH - 40 - 3 * SpareWidth)/2
static CGFloat LimitHeight =  -50.f;
@implementation BusinessDetailView
{
    NSArray *deliver_time_list; //服务器获取的时间列表
   // NSDictionary *user_adress;  //服务器端获取的用户地址  貌似是默认地址
    
    NSString *jsonString;
    NSString *shopID;  //店铺ID
    NSString *orderID; //保存订单后返回的订单ID
    NSString *totolPrice;  // 计算出来的总的价格   和 确认订单后返回的订单进行对比 以后台返回的为准
    NSString *returnTotolPrice;// 服务器返回来的总价
    NSArray * pay_method;  //服务器返回的支付方式
    NSString *desc ;//订单备注
    NSString *selectPayType;
    NSString *sendeTime; //送达时间
    NSInteger is_mandatory_sort_id; //必选分区ID
    BOOL ISFirstTime; //立即送达
}

-(UIScrollView *)bottomscrollview{
    if (_bottomscrollview == nil) {
        CGFloat height = IS_RETAINING_SCREEN ? 120:80;
        _bottomscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(SpareWidth, height, SCREEN_WIDTH - SpareWidth,self.frame.size.height)];
        _bottomscrollview.delegate = self;
        
    }
    return _bottomscrollview;
}


-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.layer.masksToBounds = YES;
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}


-(UILabel *)locationL{
    
    if (_locationL == nil) {
        _locationL = [[UILabel alloc]init];
        _locationL.text = @"请选择收货地址亲!     ";
        _locationL.font = TR_Font_Cu(17);
        _locationL.textAlignment = NSTextAlignmentLeft;
        _locationL.textColor = [UIColor blackColor];
        
    }
    return _locationL;
}


-(UILabel *)personL{
    if (_personL == nil) {
        _personL = [[UILabel alloc]init];
        _personL.text = @"                     ";
        _personL.font = TR_Font_Gray(17);
        _personL.textAlignment = NSTextAlignmentLeft;
        _personL.textColor = [UIColor grayColor];
    }
    return _personL;
}

-(UILabel *)takemileL{
    if (_takemileL == nil) {
        _takemileL = [[UILabel alloc]init];
        _takemileL.text = @"          ";
        _takemileL.font = TR_Font_Cu(17);
        _takemileL.textAlignment = NSTextAlignmentLeft;
        _takemileL.textColor = ORANGECOLOR;
    }
    return _takemileL;
}

-(UILabel *)sendLabel{
    if (_sendLabel == nil) {
        _sendLabel = [[UILabel alloc]init];
        _sendLabel.text = @"立即送出";
        _sendLabel.font = TR_Font_Cu(17);
        _sendLabel.textAlignment = NSTextAlignmentLeft;
        _sendLabel.textColor = [UIColor blackColor];
    }
    return _sendLabel;
}

-(UILabel *)taketype{
    if (_taketype == nil) {
        _taketype = [[UILabel alloc]init];
        _taketype.text = @"点呗专送";
        _taketype.font = TR_Font_Cu(15);
        _taketype.textAlignment = NSTextAlignmentLeft;
        _taketype.textColor = [UIColor grayColor];
    }
    return _taketype;
}



-(UILabel *)detailLabel{
    
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"口味、特许情况请备注";
        _detailLabel.font = TR_Font_Cu(15);
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.textColor = [UIColor grayColor];
    }
    return _detailLabel;
}


-(UIView *)centerView{
    if (_centerView == nil) {
        _centerView = [[UIView alloc]init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.userInteractionEnabled = YES;
    }
    return _centerView;
}

-(UIImageView *)titleImageView{
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
        _titleImageView.backgroundColor = [UIColor whiteColor];
        _titleImageView.image = [UIImage imageNamed:PLACEHOLDIMAGE];
    }
    return _titleImageView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"           ";
        _titleLabel.font = TR_Font_Cu(16);
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}



-(UITableView *)foodListTable{
    if (_foodListTable == nil) {
        _foodListTable = [[UITableView alloc]init];
        _foodListTable.backgroundColor = [UIColor whiteColor];
        _foodListTable.dataSource = self;
        _foodListTable.delegate = self;
        _foodListTable.scrollEnabled = NO;
        _foodListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _foodListTable;
}


-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.layer.cornerRadius = 5.0f;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = [UIColor whiteColor];

    }
    return _bottomView;
}


-(UILabel *)DiscountL{
    if (_DiscountL == nil) {
        _DiscountL = [[UILabel alloc]init];
        _DiscountL.text = @"￥                  ";
        _DiscountL.font = TR_Font_Gray(15);
        _DiscountL.textAlignment = NSTextAlignmentLeft;
        _DiscountL.textColor = ORANGECOLOR;
    }
    return _DiscountL;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"￥            ";
        _priceLabel.font = TR_Font_Cu(23);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = [UIColor blackColor];
    }
    return _priceLabel;
}

-(UIView *)takeView{
    if (_takeView == nil) {
        _takeView = [[UIView alloc]init];
        _takeView.backgroundColor = [UIColor whiteColor];
    }
    return _takeView;
}

-(UIView *)blackView{
    if (_blackView == nil) {
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, -50, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.userInteractionEnabled = YES;
        _blackView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaction)];
        [_blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
    }
    return _blackView;
}

-(TimeChooseView *)timeChooseView{
    if (_timeChooseView == nil) {
        _timeChooseView = [[TimeChooseView alloc]init];
        _timeChooseView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT / 3);
        _timeChooseView.delegate = self;
        [self addSubview:_timeChooseView];
        _timeChooseView.backgroundColor = [UIColor whiteColor];
    }
    return _timeChooseView;
}


-(TasteNotesView *)tastNoteView{
    if (_tastNoteView == nil) {
        _tastNoteView = [[TasteNotesView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        _tastNoteView.delegate = self;
         [self addSubview: _tastNoteView];
        _tastNoteView.backgroundColor = [UIColor whiteColor];
    }
    return _tastNoteView;
}



-(LocationChooseView *)locationChooseView{
    if (_locationChooseView == nil) {
        _locationChooseView = [[LocationChooseView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
        _locationChooseView.delegate = self;
        [self addSubview:_locationChooseView];
        
    }
    return _locationChooseView;
}

-(PayMyOrderView *)payPersonOrder{
    if (_payPersonOrder == nil) {
        _payPersonOrder = [[PayMyOrderView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250)];
        _payPersonOrder.delegate = self;
        [self addSubview:_payPersonOrder];
    }
    return _payPersonOrder;
}

-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.bottomscrollview];
        [self.bottomscrollview addSubview:self.topView];
        [self desigentopView];
        [self.bottomscrollview addSubview:self.bottomView];
        [self desigenbottomView];
        [self.bottomscrollview addSubview:self.foodListTable];
        is_mandatory_sort_id = 0;
        [self designcenterView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxPayOrderSuccess:) name:@"WXPAYORDERSUCCESS" object:nil];
    }
    return self;
}




//布局上层视图
-(void)desigentopView{
    
    WeakSelf;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 220));
    }];
    
    UIImageView *rightImage = [[UIImageView alloc]init];
    rightImage.layer.cornerRadius = 15.0f;
    rightImage.layer.masksToBounds = YES;
    rightImage.userInteractionEnabled = YES;
    rightImage.backgroundColor = [UIColor clearColor];
    rightImage.image = [UIImage imageNamed:@"setting-cancle"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retuenTopView:)];
    [rightImage addGestureRecognizer:tap];
    [self addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(SpareWidth / 2);
      make.bottom.mas_equalTo(weakself.bottomscrollview.mas_top).offset(-SpareWidth);
      make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    

    UIImageView *locationV = [[UIImageView alloc]init];
    locationV.backgroundColor = [UIColor clearColor];
    locationV.image = [UIImage imageNamed:@"setting-location"];
    [self.topView addSubview:locationV];
    [locationV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
  
    [self.topView addSubview:self.locationL];
    [self.locationL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationV.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(locationV.mas_centerY);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(20);
    }];

    [self.topView addSubview:self.personL];
    [self.personL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.locationL);
        make.top.mas_equalTo(weakself.locationL.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 4 * SpareWidth - 30, 20));
    }];
    
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.backgroundColor = [UIColor clearColor];
    [rightBtn1 setImage:[UIImage imageNamed:@"setting-forword"] forState:UIControlStateNormal];
    [self.topView addSubview:rightBtn1];
    [rightBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(weakself.locationL.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    
    
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = GRAYCLOLOR;
    [self.topView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakself.personL.mas_bottom).offset(SpareWidth);
        make.right.mas_equalTo(rightBtn1.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    
    UIView *contentView1 = [[UIView alloc]init];
    [self.topView addSubview:contentView1];
    contentView1.tag = 2000;
    UITapGestureRecognizer *taplocation = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMoreDetail:)];
    [contentView1 addGestureRecognizer:taplocation];
    
    [contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(rightImage.mas_top);
        make.bottom.mas_equalTo(lineView1.mas_top);
    }];
    
    
    UIImageView *timeV = [[UIImageView alloc]init];
    timeV.backgroundColor = [UIColor clearColor];
    timeV.image = [UIImage imageNamed:@"setting-time"];
    [self.topView addSubview:timeV];
    [timeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationV);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(2 * SpareWidth);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.topView  addSubview:self.sendLabel];
    CGSize size1 = TR_TEXT_SIZE(self.sendLabel.text, self.sendLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [self.sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(timeV.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(timeV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(size1.width + 10, 20));
    }];
    
 
    
     [self.topView addSubview: self.takemileL];
     [self.takemileL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.sendLabel.mas_right).offset(SpareWidth / 2);
        make.centerY.mas_equalTo(timeV.mas_centerY);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(20);
    }];
    
    [self.topView addSubview:self.taketype];
    [self.taketype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.personL.mas_left);
        make.top.mas_equalTo(weakself.takemileL.mas_bottom).offset(SpareWidth);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(20);
    }];
    
    
    
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.backgroundColor = [UIColor clearColor];
    [timeBtn setImage:[UIImage imageNamed:@"setting-forword"] forState:UIControlStateNormal];
    
    [self.topView addSubview:timeBtn];
    [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(weakself.takemileL.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = GRAYCLOLOR;
    [self.topView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakself.taketype.mas_bottom).offset(SpareWidth);
        make.right.mas_equalTo(rightBtn1.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIView *contentView2 = [[UIView alloc]init];
    [self.topView addSubview:contentView2];
    contentView2.tag = 2001;
    UITapGestureRecognizer *taptime = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMoreDetail:)];
    [contentView2 addGestureRecognizer:taptime];
    
    [contentView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(lineView1.mas_bottom);
        make.bottom.mas_equalTo(lineView2.mas_top);
    }];
    
    
    
    UIImageView *FlavorV = [[UIImageView alloc]init];
    FlavorV.backgroundColor = [UIColor clearColor];
    FlavorV.image = [UIImage imageNamed:@"setting-beizhu"];
    [self.topView addSubview:FlavorV];
    [FlavorV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(locationV.mas_left);
        make.top.mas_equalTo(lineView2.mas_bottom).offset(2 *SpareWidth);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *FlavorL = [[UILabel alloc]init];
    FlavorL.text = @"备注";
    FlavorL.font = [UIFont systemFontOfSize:15];
    FlavorL.textAlignment = NSTextAlignmentLeft;
    FlavorL.textColor = [UIColor blackColor];
    [self.topView addSubview:FlavorL];
    [FlavorL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FlavorV.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(FlavorV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
   
    
    UIButton *FlavorLBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FlavorLBtn.backgroundColor = [UIColor whiteColor];
    [FlavorLBtn setImage:[UIImage imageNamed:@"setting-forword"] forState:UIControlStateNormal];
    
    [self.topView addSubview:FlavorLBtn];
    [FlavorLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(FlavorV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    [self.topView addSubview: self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FlavorL.mas_right);
        make.centerY.mas_equalTo(FlavorLBtn.mas_centerY);
        make.right.mas_equalTo(FlavorLBtn.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    UIView *contentView3 = [[UIView alloc]init];
    [self.topView addSubview:contentView3];
    contentView3.tag = 2002;
    UITapGestureRecognizer *tapfavor = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseMoreDetail:)];
    [contentView3 addGestureRecognizer:tapfavor];
    
    [contentView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(lineView2.mas_bottom);
        make.bottom.mas_equalTo(weakself.detailLabel.mas_bottom);
    }];
    
}

//布局中部视图
-(void)designcenterView{
    
    WeakSelf;
    [self.foodListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakself.topView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 2 * SpareWidth);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * SpareWidth, 60)];
    headView.backgroundColor = [UIColor whiteColor];
    self.foodListTable.tableHeaderView = headView;
   
    [headView addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
  
    [headView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.titleImageView.mas_right).offset(SpareWidth /2);
        make.centerY.mas_equalTo(weakself.titleImageView.mas_centerY);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(20);
    }];
    
}

-(UIView *)addfootViewActionwithDic:(NSDictionary *)result{
    
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *contentArray = [NSMutableArray array];
    
     NSString *packing_charge = [result[@"packing_charge"] stringValue];   //餐盒
    [titleArray addObject:@"餐盒费"];
    [contentArray addObject:packing_charge];
    NSString *delivery_fee = [result[@"delivery_fee"] stringValue];
    
    //配送优惠
    NSString * delivery_fee_reduce = result[@"delivery_fee_reduce"];
    
    NSInteger realDelivery = [delivery_fee integerValue] - [delivery_fee_reduce  integerValue];
    
    [titleArray addObject:@"配送费"];
    [contentArray addObject:[NSString stringWithFormat:@"%ld",(long)realDelivery]];
    
    //优惠
    NSArray * discount_list = result[@"discount_list"];
    BOOL isNewUser = NO;

    for (NSDictionary *temp in discount_list) {
        
        NSString *minus = [temp[@"minus"] stringValue];
        [contentArray addObject:minus];
        [titleArray addObject:@"满减活动"];
        
        if ([temp[@"type"] isEqualToString:@"system_newuser"]) {
            
            isNewUser = YES;
            
            [titleArray replaceObjectAtIndex:titleArray.count - 1 withObject:@"新用户专享"];
        }
        
    }
    
    [titleArray addObjectsFromArray:@[@"点呗红包",@"商家优惠券"]];
    
    [contentArray addObjectsFromArray:@[@"无可用红包",@"无可用优惠券"]];
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.foodListTable.frame.size.width, 160)];
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        UILabel *tempL = [[UILabel alloc]init];
        tempL.text = titleArray[i];
        tempL.font = TR_Font_Gray(15);
        tempL.textAlignment = NSTextAlignmentLeft;
        [footView addSubview:tempL];
        CGSize size = TR_TEXT_SIZE(tempL.text, tempL.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        [tempL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(30 * i + 10);
            make.size.mas_equalTo(CGSizeMake(size.width + 10, 15));
        }];
        
        
        
        UILabel *detailL = [[UILabel alloc]init];
        detailL.text = contentArray[i];
        detailL.font = TR_Font_Cu(15);
        
        
        if (i < 2) {
            
            detailL.text = [NSString stringWithFormat:@"￥%@",contentArray[i]];
            
        }
        
        if (i == 2) {
            detailL.textColor = [UIColor redColor];
        }
        
        if (titleArray.count > 4 && i > 1 && i < titleArray.count - 2) {
            
            detailL.text = [NSString stringWithFormat:@"-￥%@",contentArray[i]];
            
            UIImageView *tempImage = [[UIImageView alloc]init];
            NSString *imagePath = isNewUser ? @"shop_new":@"delete";
            tempImage.image = [UIImage imageNamed:imagePath];
            [footView addSubview:tempImage];
            
            [tempImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(30 * i + 10);
                make.size.mas_equalTo(CGSizeMake(20, 15));
            }];
            
            
            [tempL mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(35);
                
            }];
            
        }
        
        tempL.textAlignment = NSTextAlignmentLeft;
        [footView addSubview:detailL];
        CGSize size2 = TR_TEXT_SIZE(detailL.text, detailL.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(tempL);
            make.size.mas_equalTo(CGSizeMake(size2.width + 10, 15));
        }];
        
        
        if (i == 1) {
            
            if ([delivery_fee_reduce integerValue] > 0) {
                UILabel *detail2 = [[UILabel alloc]init];
                //中划线
                NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}; NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",delivery_fee] attributes:attribtDic];
                // 赋值
                detail2.attributedText = attribtStr;
                detail2.textColor = [UIColor grayColor];
                detail2.font = TR_Font_Gray(15);
                [footView addSubview:detail2];
                [detail2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(detailL.mas_left).offset(-10);
                    make.centerY.mas_equalTo(tempL);
                    make.size.mas_equalTo(CGSizeMake(size2.width + 10, 15));
                }];
                
            }
        }
        
        if (i == titleArray.count - 1 || i == titleArray.count - 2) {
            UIImageView *imageV = [[UIImageView alloc]init];
            imageV.image = [UIImage imageNamed:@"setting-forword"];
            [footView addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(detailL);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(12, 12));
            }];
            detailL.textColor = [UIColor grayColor];
            [detailL mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(imageV.mas_left).offset(5);
            }];
        }
        
        
        
    }
    
    return footView;
    
}


//点击红包或者优惠券 @"餐盒",@"配送费",@"满减活动",@"点呗红包",@"商家优惠券"]

-(void)clickAction:(UIButton *)sender{
    
    if (sender.tag == 1000) {
        
        TR_Message(@"餐盒");
    
    }
    
    if (sender.tag == 1001) {
        TR_Message(@"配送费");
    }
    
    if (sender.tag == 1002) {
        TR_Message(@"满减活动");
    }
    
    if (sender.tag == 1003) {
        TR_Message(@"点呗红包");
    }
    
    if (sender.tag == 1004) {
        TR_Message(@"商家优惠券");
    }
}


//点击选择地址  选择描述  选择 配送时间

-(void)chooseMoreDetail:(UITapGestureRecognizer *)sender{
    if (sender.view.tag == 2000) {
        [self chooseLocation];
        
    }
    
    if (sender.view.tag == 2001) {
        [self choosetime];
    }
    
    if (sender.view.tag == 2002) {
        [self chooseTastNote];
    }
}



-(void)retuenTopView:(UITapGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickReturnBtn:)]) {
        [self.delegate  clickReturnBtn:is_mandatory_sort_id];
    }
}


#pragma mark scrollview delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.bottomscrollview) {
        
        if (scrollView.contentOffset.y < LimitHeight) {

            [self retuenTopView:nil];
        }
        
        CGFloat maxoffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if (scrollView.contentOffset.y > maxoffset) {
            
            [scrollView setContentOffset:CGPointMake(0, maxoffset)];
        }
        
    }
}

#pragma mark tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray.count > 0) {
        CGFloat height = IS_RETAINING_SCREEN ? 31 : 0;
        CGFloat foodViewHeight  = 210 + self.dataArray.count * 100 > SCREEN_HEIGHT - 450 ?  230 + self.dataArray.count * 100 : SCREEN_HEIGHT - 450;
        [self.foodListTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(foodViewHeight);
        }];
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.foodListTable.mas_bottom);
        }];
        
        [self.bottomscrollview setContentSize:CGSizeMake(0, 420 + foodViewHeight + height )];
        [self.bottomscrollview layoutIfNeeded];
        return self.dataArray.count;
    }
    
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 70));
            cell.delegate = self;
        }];
        
        ProductItem *model = self.datasource[indexPath.row];
        cell.model = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.pricelabel.textAlignment = NSTextAlignmentRight;
        cell.pricelabel.font = TR_Font_Cu(15);
        
        [cell.pricelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SpareWidth);
            make.centerY.mas_equalTo(- SpareWidth);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        cell.oldpricelabel.textAlignment = NSTextAlignmentRight;
        cell.oldpricelabel.font = TR_Font_Gray(13);
        [cell.oldpricelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.pricelabel.mas_left);
            make.centerY.mas_equalTo(-SpareWidth);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];

        [cell.countView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-SpareWidth);
            make.bottom.mas_equalTo(- 2 * SpareWidth);
            make.size.mas_equalTo(CGSizeMake(75, 25));
        }];
        
        
        cell.namelabel.numberOfLines = 0;
        [cell.namelabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cell.headimageView.mas_top);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(-10);
        }];
        
    
        cell.namelabel.textColor = [UIColor blackColor];
        cell.namelabel.font = TR_Font_Cu(15);
        cell.pricelabel.textColor = [UIColor blackColor];
        
    }
    
    UIImageView *tempImageV = [cell.contentView viewWithTag:2000];
    if (tempImageV) {
        [tempImageV removeFromSuperview];
    }
    
    
    GoodsShopModel *model = self.dataArray[indexPath.row];
    cell.namelabel.text = model.goodname;
    [cell.headimageView sd_setImageWithURL:[NSURL URLWithString:model.goodimg] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];

    if ([model.gooddiscountprice integerValue] != 0&&model.gooddiscountprice.length>0) {
        
        NSString *newPrice = model.specprice.length > 0 ? model.specprice:model.goodprice;
        NSString *totolPrice = [NSString stringWithFormat:@"%.2f",[model.gooddiscountprice doubleValue] * [newPrice doubleValue] * 0.1 * [model.goodnum integerValue]];
       
        cell.pricelabel.text =  [NSString stringWithFormat:@"￥%@",[TRClassMethod stringNumfloat:totolPrice]];
        cell.oldpricelabel.hidden = NO;
        
        NSString *oldPrice = model.specprice.length > 0 ? model.specprice:model.goodprice;
        
        double old_price = [oldPrice doubleValue] * [model.goodnum doubleValue];
        
        cell.oldpricelabel.attributedText = [self attributedText:@[@"￥",[TRClassMethod stringNumfloat:[NSString stringWithFormat:@"%.2f",old_price]]]];
        
        UIImageView *discountImage = [[UIImageView alloc]init];
        discountImage.tag = 2000;
        discountImage.image = [UIImage imageNamed:@"comment_discount"];
        [cell.contentView addSubview:discountImage];
        [discountImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.headimageView.mas_right).offset(5);
            make.top.mas_equalTo(cell.namelabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(20, 15));
        }];
        
        [cell.namelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(discountImage.mas_right).offset(10);
            make.top.mas_equalTo(cell.headimageView.mas_top);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
        }];
        
    }else{
        
    NSString *oldPrice = model.specprice.length > 0 ? model.specprice:model.goodprice;
    cell.pricelabel.text = [NSString stringWithFormat:@"￥%@",[TRClassMethod stringNumfloat:[NSString stringWithFormat:@"%.2f",[oldPrice doubleValue] * [model.goodnum integerValue]]]];
        
        if ([model.is_skill isEqualToString:@"1"]) {
            
            if ([model.goodnum  integerValue] > 1) {
                double allprice = [model.o_price doubleValue] * ([model.goodnum integerValue] - 1) +[model.skillprice doubleValue];
                cell.pricelabel.text = [NSString stringWithFormat:@"￥%@",[TRClassMethod stringNumfloat:[NSString stringWithFormat:@"%.2f",allprice]]];
                
            }else if ([model.goodnum integerValue] == 1){
                cell.pricelabel.text = [NSString stringWithFormat:@"￥%@",[TRClassMethod stringNumfloat:[NSString stringWithFormat:@"%.2f",[model.skillprice doubleValue]]]];
            }
        }
        
    cell.oldpricelabel.hidden = YES;
    [cell.namelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cell.headimageView.mas_top);
        make.left.mas_equalTo(cell.headimageView.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
        }];
        
    }
    

    NSString *sepname = model.specname ? model.specname:@"";
    NSString  *proname = model.attributename ? model.attributename:@"";
    cell.salecount.text = [NSString stringWithFormat:@"%@ %@",sepname,proname];
    cell.indexpath = indexPath;
    
    [cell designCountWithData:model.goodnum];
   
    CGSize size = TR_TEXT_SIZE(cell.salecount.text, cell.salecount.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [cell.salecount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(size.width + 10, 15));
        }];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}




#pragma mark BusinessCell -delegate

-(void)clickCountView:(NSString *)clickType withIndexpath:(NSIndexPath *)indexpath{
    
    GoodsShopModel *model = self.dataArray[indexpath.row];
    
    if ([clickType isEqualToString:@"jia"]) {
        
        
        model.goodnum = [NSString stringWithFormat:@"%ld",[model.goodnum integerValue] + 1];
        
    }else{
        
        model.goodnum = [NSString stringWithFormat:@"%ld",[model.goodnum integerValue] - 1];
    }
    
    
    StoreDataModel *storeModel = [[GoodsListManager shareInstance]transformModelFrom4:self.model];
    
    
    if ([model.goodnum isEqualToString:@"0"]) {
        
        [[GoodShopManagement shareInstance]deleteStore:storeModel andGoodshopmodel:model];
        model.goodnum = @"0";
        [self.dataArray  removeObjectAtIndex:indexpath.row];
        
        
    }else{
      
        [[GoodShopManagement shareInstance]addStore:storeModel andGoodshopmodel:model];
    }
    
   
    NSMutableArray *selectData = [NSMutableArray arrayWithArray:self.dataArray];
    
    [self addDatasourceToView:selectData];
    
    
    
}



//布局底部视图
-(void)desigenbottomView {

    WeakSelf;
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 150));
        make.bottom.mas_equalTo(weakself.bottomscrollview);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    [self.bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];
    
    
    UILabel *tempLable = [[UILabel alloc]init];
    tempLable.backgroundColor = [UIColor clearColor];
    tempLable.font = TR_Font_Gray(15);
    tempLable.text = @"已优惠";
    tempLable.textAlignment = NSTextAlignmentCenter;
    tempLable.textColor = [UIColor blackColor];
    CGSize size1 = TR_TEXT_SIZE(tempLable.text, tempLable.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [self.bottomView addSubview:tempLable];
    [tempLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(size1.width + 10, 20));
    }];
    
    [self.bottomView addSubview:self.DiscountL];
    CGSize size = TR_TEXT_SIZE(self.DiscountL.text, self.DiscountL.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [self.DiscountL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempLable.mas_right);
        make.centerY.mas_equalTo(tempLable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(size.width + 10, 20));
    }];
    
    
    [self.bottomView addSubview:self.priceLabel];
    CGSize size2 = TR_TEXT_SIZE(self.priceLabel.text, self.priceLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(tempLable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(size2.width + 10, 20));
    }];
    
    UILabel *tempLable2 = [[UILabel alloc]init];
    tempLable2.backgroundColor = [UIColor clearColor];
    tempLable2.font = TR_Font_Gray(13);
    tempLable2.text = @"小计";
    tempLable2.textAlignment = NSTextAlignmentRight;
    tempLable2.textColor = [UIColor blackColor];
    CGSize size3 = TR_TEXT_SIZE(tempLable.text, tempLable.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [self.bottomView addSubview:tempLable2];
    [tempLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.priceLabel.mas_left);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(size3.width + 10, 20));
    }];
    
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.backgroundColor = [UIColor clearColor];
    [detailBtn setImage:[UIImage imageNamed:@"setting-tips"] forState:UIControlStateNormal];
    detailBtn.titleLabel.font = TR_Font_Gray(12);
    [detailBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [detailBtn setTitle:@"10分钟商户未接单，将自动取消" forState:UIControlStateNormal];
    CGSize sizeBtn = TR_TEXT_SIZE(detailBtn.titleLabel.text, detailBtn.titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [self.bottomView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.top.mas_equalTo(weakself.priceLabel.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(sizeBtn.width + 20, 20));
    }];
    
    
    
    self.DiscountLBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.DiscountLBtn.backgroundColor = ORANGECOLOR;
    [self.DiscountLBtn setTitle:@"去支付" forState:UIControlStateNormal];
    self.DiscountLBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.DiscountLBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.DiscountLBtn addTarget:self action:@selector(parMyOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    self.DiscountLBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.DiscountLBtn];
    
    [self.DiscountLBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        
        make.top.mas_equalTo(detailBtn).offset(3 * SpareWidth);
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 8 * SpareWidth, 40));
    }];
    
}




//点击去支付  确认订单信息

-(void)parMyOrderAction:(UIButton *)sender{
    
    NSMutableArray *selectData = [NSMutableArray arrayWithArray:self.dataArray];
    
    [self addDatasourceToView:selectData];
    
    
    
    if (jsonString.length == 0 || shopID.length == 0 || deliver_time_list.count == 0 ) {
        
        return;
    }
    
    if (![self.locationItem.is_deliver isEqualToString:@"1"]) {
        TR_Message(@"地址不在配送范围");

        return;
    }
    
    if (!desc) {
        desc = @"";
    }
    
    if (!sendeTime) {
        
        NSString *time = deliver_time_list[0][@"date_list"][0][@"hour_minute"];
        NSString *daytype = deliver_time_list[0][@"show_date"];
        sendeTime = [NSString stringWithFormat:@"%@%@",daytype,time];
        
        ISFirstTime = YES;
        
    }
    
    NSString *ishurry = ISFirstTime ? @"1":@"0";
    
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"productCart":jsonString,@"store_id":shopID,@"expect_use_time":sendeTime,@"address_id":self.locationItem.adress_id,@"desc":desc,@"is_hurry":ishurry};
    
    [HBHttpTool post:SHOP_SAVEORDER params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"]isEqualToString:@"success"]) {
            
            orderID = [responseObj[@"result"][@"order_id"] stringValue];
            
            [self confirmOrderMessage];
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
    
    
    
   
}


//保存订单成功后  确认订单信息

-(void)confirmOrderMessage{
    if (orderID.length == 0) {
        
        return;
    }
    
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"app_type":@"1",@"app_version":@"200",@"order_id":orderID,@"system_coupon_id":@"2",@"type":@"shop"};
    
    [HBHttpTool post:SHOP_CONFIRMORDER params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"]isEqualToString:@"success"]) {
            

            //确认价格  有没有算错  如果有出入  以服务器返回为准
            returnTotolPrice = responseObj[@"result"][@"order_info"][@"order_total_money"];
            pay_method = responseObj[@"result"][@"pay_method"];
           
            
            [self confirmOrderSuccess];
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
}

-(void)confirmOrderSuccess{
    
    if (self.payOrderOpen == NO) {
        self.blackView.hidden = NO;
        self.payPersonOrder.hidden = NO;
        [self.payPersonOrder designViewWithdatasour:@[returnTotolPrice]];
        [UIView animateWithDuration:0.2 animations:^{
            self.payPersonOrder.frame = CGRectMake(0, SCREEN_HEIGHT - _payPersonOrder.frame.size.height, SCREEN_WIDTH, _payPersonOrder.frame.size.height+50);
            
        }];
        self.payOrderOpen = YES;
    }
}








//选择地址

-(void)chooseLocation{
    if (self.locationOPen == NO) {
        self.blackView.hidden = NO;
        self.locationChooseView.hidden = NO;
       
        [UIView animateWithDuration:0.2 animations:^{
            self.locationChooseView.frame = CGRectMake(0, SCREEN_HEIGHT / 3 * 2 + 20, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        }];
         [self.locationChooseView startNetWork:shopID];
        self.locationOPen = YES;
    }
}








//点击送达时间选择
-(void)choosetime{
    if (self.timeOpen == NO) {
        self.blackView.hidden = NO;
        self.timeChooseView.hidden = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.timeChooseView.frame = CGRectMake(0, SCREEN_HEIGHT / 3 * 2 + 20, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        }];
        
        if (deliver_time_list.count > 0) {
            [self.timeChooseView addDatasourceToView:deliver_time_list];
        }
       
        self.timeOpen = YES;
    }
  
}
//口味选择

-(void)chooseTastNote{
    
    if (self.tastNoteOPen == NO) {
        self.blackView.hidden = NO;
        self.tastNoteView.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.tastNoteView.frame = CGRectMake(0, SCREEN_HEIGHT - self.tastNoteView.frame.size.height, SCREEN_WIDTH, self.tastNoteView.frame.size.height + 100);
            
        }];
        self.tastNoteOPen = YES;
    }
    
}




// 返回操作
-(void)tapaction{
    
    
    if (self.timeOpen) {
        [UIView animateWithDuration:0.2 animations:^{
            self.timeChooseView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            self.timeChooseView.hidden = YES;
            self.blackView.hidden = YES;
            self.timeOpen = NO;
        }];
    }
    
    
    if (self.tastNoteOPen) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tastNoteView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.tastNoteView.frame.size.height);
        } completion:^(BOOL finished) {
            self.tastNoteView.hidden = YES;
            self.blackView.hidden = YES;
            self.tastNoteOPen = NO;
            
        }];
        
    }
    
    
    if (self.locationOPen) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.locationChooseView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            self.locationChooseView.hidden = YES;
            self.blackView.hidden = YES;
            self.locationOPen = NO;
            
        }];
        
    }
    
    
    if (self.payOrderOpen) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.payPersonOrder.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.payPersonOrder.frame.size.height-50);
        } completion:^(BOOL finished) {
            self.payPersonOrder.hidden = YES;
            self.blackView.hidden = YES;
            self.payOrderOpen = NO;
            
        }];
        
    }
    
    
    
}

#pragma mark TasteNotesView

-(void)chooseDescriptionSuccess:(NSString *)chooseTime{
    
    if (chooseTime.length > 0) {
        desc = chooseTime;
        _detailLabel.text = chooseTime;
    }
    
    [self tapaction];
}



#pragma mark  LocationChooseView

-(void)clickCellInCorrecSite:(UserAddressModel *)model{
    
    if (model) {
        self.locationItem = model;
        self.locationL.text = self.locationItem.adress;
        if ([model.sex isEqualToString:@"1"]) {
          self.personL.text =[NSString stringWithFormat:@"%@ 先生    %@",self.locationItem.name,self.locationItem.phone];
        }else{
           self.personL.text =[NSString stringWithFormat:@"%@ 先生    %@",self.locationItem.name,self.locationItem.phone];
        }
        
        NSMutableArray *selectData = [NSMutableArray arrayWithArray:self.dataArray];
        
        [self addDatasourceToView:selectData];
        
        if (self.locationOPen) {
            [UIView animateWithDuration:0.2 animations:^{
                self.locationChooseView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.locationChooseView.frame.size.height);
            } completion:^(BOOL finished) {
                self.locationChooseView.hidden = YES;
                self.blackView.hidden = YES;
                self.locationOPen = NO;
                
            }];
            
        }
    }
    
}

-(void)addNewLocation{
    //添加地址
    ModifyAddressViewController *modifyAdressVC=[[ModifyAddressViewController alloc]init];
    modifyAdressVC.isNewAdress=YES;
    modifyAdressVC.mtitlename=@"新增地址";
    [self tapaction];

 
    if (APP_Delegate.rootViewController.selectedIndex==0) {
        UINavigationController *navc= [APP_Delegate.rootViewController.viewControllers firstObject];
        [navc pushViewController:modifyAdressVC animated:YES];
    }else if (APP_Delegate.rootViewController.selectedIndex==1){
        
        UINavigationController *navc= APP_Delegate.rootViewController.viewControllers[1];
        [navc pushViewController:modifyAdressVC animated:YES];
    }else{
        
        UINavigationController *navc= APP_Delegate.rootViewController.viewControllers[2];
        [navc pushViewController:modifyAdressVC animated:YES];
    }
    
}

-(void)fixMyLocation:(UserAddressModel *)model{
    //编辑地址
    
    if (model) {
        ModifyAddressViewController *modifyAdressVC=[[ModifyAddressViewController alloc]init];
        modifyAdressVC.mtitlename=@"编辑地址";
        modifyAdressVC.model = model;
        [self tapaction];

        
        if (APP_Delegate.rootViewController.selectedIndex==0) {
            UINavigationController *navc= [APP_Delegate.rootViewController.viewControllers firstObject];
            [navc pushViewController:modifyAdressVC animated:YES];
        }else if (APP_Delegate.rootViewController.selectedIndex==1){
            
            UINavigationController *navc= APP_Delegate.rootViewController.viewControllers[1];
            [navc pushViewController:modifyAdressVC animated:YES];
        }else{
            
            UINavigationController *navc= APP_Delegate.rootViewController.viewControllers[2];
            [navc pushViewController:modifyAdressVC animated:YES];
        }
     
    }
}


#pragma mark PayMyOrderView代理

-(void)clickReturnToTop{
    
    if (self.payOrderOpen) {
        [UIView animateWithDuration:0.2 animations:^{
            self.payPersonOrder.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.payPersonOrder.frame.size.height);
        } completion:^(BOOL finished) {
            self.payPersonOrder.hidden = YES;
            self.blackView.hidden = YES;
            self.payOrderOpen = NO;
            
        }];
    }
}

//点击确定支付

-(void)clickPayMyOrder:(NSString *)payType{
    
    
    if ([payType isEqualToString:@"weixin"]) {
        //微信支付
        if (orderID.length == 0) {
            
            return;
        }
        
        if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
            
            TR_Message(@"请先安装微信");
            return;
        }
    }
    
    
    selectPayType = payType;
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"app_version":@"200",@"order_id":orderID,@"pay_type":payType,@"system_coupon_id":@"",@"order_type":@"shop"};
    
    [HBHttpTool post:SHOP_PAYORDERBYWX params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            if ([payType isEqualToString:@"weixin"]) {
               [self sendWxPayWithDic:responseObj[@"result"][@"weixin_param"]];
            }
            
            if ([payType isEqualToString:@"alipay"]) {
                
                [self paryOrderWithAlipay:responseObj[@"result"]];
            }
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - 支付宝支付

-(void)paryOrderWithAlipay:(NSDictionary *)dict{
    
    //支付宝支付
    NSString *appScheme = @"dianbeiwaimai";//在info中urltypes中添加一条并设置Scheme 这样支付宝才能返回到当前应用中
    [[AlipaySDK defaultService] payOrder:dict[@"alipay"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        if (resultDic) {
         
            if ([statusStr isEqualToString:@"9000"]) {
               
                //TR_Message(@"付款成功");
               // [self wxPayOrderSuccess:nil];
                
                return ;
            }else if([statusStr isEqualToString:@"6001"]) {
                
              //  TR_Message(@"付款失败🤷‍♀️");
                
                return ;
            }else {
                
             // TR_Message(@"付款失败🤷‍♀️");
                
                return ;
            }
        }else{
            
          // TR_Message(@"支付宝打开失败");
            return;
           
        }
        
        
    }];
}



#pragma mark - 微信支付

- (void)sendWxPayWithDic:(NSDictionary *)dict; {
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [dict objectForKey:@"appid"];
    req.partnerId           = [dict objectForKey:@"mch_id"];
    req.prepayId            = [dict objectForKey:@"prepay_id"];
    req.nonceStr            = [dict objectForKey:@"nonce_str"];
    req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = [dict objectForKey:@"sign2"];

    [WXApi sendReq:req];
    
}




//支付成功后

-(void)wxPayOrderSuccess:(NSNotification *)sender{
    
    //调用数据库删除订单
    [[GoodsListManager shareInstance]deleteShopOrder:self.model.store_id];
    
    //跳转到订单界面
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JUMPTOORDERMENUVIEWCONTROLLER" object:nil];
}






- (void)onResp:(BaseResp *)resp {
    //接收到微信的回调
   
    if (resp.errCode == WXSuccess) {
        //支付成功 调用支付成功接口
    
    }else {
        //支付失败
        TR_Message(@"支付失败");
        
    }
}










-(void)addDatasourceToView:(NSArray *)datasource{
    
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:datasource];
    
    
    if (self.dataArray.count == 0) {
        
        [[GoodsListManager shareInstance]deleteShopOrder:shopID];
        
        [self retuenTopView:nil];
        
        return;
        
    }
    
    
    GoodsShopModel *model = datasource[0];
    NSMutableArray *orderArray = [NSMutableArray array];
    [self.datasource removeAllObjects];
    for (int i = 0; i < datasource.count; i ++) {

        GoodsShopModel *model = datasource[i];
        [self.datasource addObject:[[GoodsListManager shareInstance]transformModelFrom5:model]];
        NSMutableArray * productParam = [NSMutableArray array];
        NSMutableDictionary *properties = [NSMutableDictionary dictionary];

        if (model.specId) {

            NSDictionary *tempDic = @{@"id":model.specId,@"name":model.specname,@"spec_id":model.spec_tid,@"type":@"spec"};
            [productParam addObject:tempDic];
        }

        if (model.attributeId) {
            [properties setObject:@"properties" forKey:@"type"];
            NSDictionary *dataDic = @{@"id":model.atttip,@"list_id":model.attributeId,@"name":model.attributename};
            NSArray *dataArray = @[dataDic];
            [properties setObject:dataArray forKey:@"data"];
            [productParam addObject:properties];

        }

        NSDictionary *goodsOrder = @{@"count":model.goodnum,@"productId":model.goodId,@"productName":model.goodname,@"productParam":productParam};

        [orderArray addObject:goodsOrder];
    }


    if (orderArray.count == 0) {
        
        return;
    }
    
    self.titleLabel.text = self.model.name;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
    NSData *data=[NSJSONSerialization dataWithJSONObject:orderArray options:NSJSONWritingPrettyPrinted error:nil];

    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    jsonString = jsonStr;
    shopID = model.storeid;
    
    NSString *adress_id = self.locationItem ? self.locationItem.adress_id:@"";
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"user_long":lng,@"user_lat":lat,@"store_id":model.storeid,@"productCart":jsonStr,@"adress_id":adress_id};

    [HBHttpTool post:SHOP_REPORTORDER params:body success:^(id responseObj) {

        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            [self ShowOderData:responseObj];

        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
            [[GoodsListManager shareInstance]deleteShopOrder:self.model.store_id];
            [self retuenTopView:nil];
        }

    } failure:^(NSError *error) {

    }];
}






-(void)ShowOderData:(id)response{
    
    
    deliver_time_list = response[@"result"][@"deliver_time_list"];
   
    
    if (!deliver_time_list || deliver_time_list.count == 0 || [deliver_time_list isKindOfClass:[NSNull class]]) {
        
        TR_Message(@"数据解析异常");
        
        self.DiscountLBtn.backgroundColor = ORANGECOLOR;
        self.DiscountLBtn.userInteractionEnabled = YES;
        
        return;
    }
    
    if (self.locationItem == nil) {
        
        if (response[@"result"][@"user_adress"]) {
            
             self.locationItem = [[UserAddressModel alloc]initWithDictionary:response[@"result"][@"user_adress"] error:nil];
        }
      
    }
    
    
    NSString *takeType =response[@"result"][@"delivery_true_type"];
    
    _taketype.text = takeType ? takeType:@"点呗专送";
    
  
    
    
    if ([self.locationItem.is_deliver isEqualToString:@"1"]) {
        self.locationL.text = self.locationItem.adress;
        if ([self.locationItem.sex isEqualToString:@"1"]) {
            self.personL.text =  [NSString stringWithFormat:@"%@ 先生    %@",self.locationItem.name,self.locationItem.phone];
        }else{
            self.personL.text =  [NSString stringWithFormat:@"%@ 女士    %@",self.locationItem.name,self.locationItem.phone];
        }
        
    }
    
    self.takemileL.text = [NSString stringWithFormat:@"预计%@送达", deliver_time_list[0][@"date_list"][0][@"hour_minute"]];
    self.foodListTable.tableFooterView = [self addfootViewActionwithDic:response[@"result"]];
    [self.foodListTable reloadData];
    
    
    
    
    if ([response[@"result"][@"delivery_type"] integerValue] != 2) {
        
        self.DiscountLBtn.backgroundColor = [UIColor lightGrayColor];
        [self.DiscountLBtn setTitle:@"未达到起送价格" forState:UIControlStateNormal];
        self.DiscountLBtn.userInteractionEnabled = NO;
        
    }else{
        
        [self.DiscountLBtn setTitle:@"去支付" forState:UIControlStateNormal];
        self.DiscountLBtn.backgroundColor = ORANGECOLOR;
        self.DiscountLBtn.userInteractionEnabled = YES;
        
    }
    
    is_mandatory_sort_id = [response[@"result"][@"is_mandatory_sort_id"] integerValue] ;
    
    if ( is_mandatory_sort_id > 0) {
        
        self.DiscountLBtn.backgroundColor = [UIColor lightGrayColor];
        [self.DiscountLBtn setTitle:@"未选择必选商品" forState:UIControlStateNormal];
        self.DiscountLBtn.userInteractionEnabled = NO;
        
//        NoticeTipView *niticView = [[NoticeTipView alloc]init];
//        [niticView showWithTitle:@"提示" withDescrip:@"您还有打包盒必选分类没有选择" withBtn:@[@"确定",@"取消"]];
//        niticView.clickBlock = ^(NSInteger index) {
//
//            NSLog(@"%ld",index);
//        };
//
//        [niticView show];
        
    }else{
        
        [self.DiscountLBtn setTitle:@"去支付" forState:UIControlStateNormal];
        self.DiscountLBtn.backgroundColor = ORANGECOLOR;
        self.DiscountLBtn.userInteractionEnabled = YES;
        
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[TRClassMethod stringNumfloat:response[@"result"][@"real_pay_price"]]];
    
    
    NSString *discount2 = response[@"result"][@"all_discount_money"];
   
    self.DiscountL.text = [NSString stringWithFormat:@"￥%@",[TRClassMethod stringNumfloat:discount2] ];
    

}





-(void)fixtableFootView:(NSString *)titile with:(int )tag withNewUser:(BOOL)isnewUser{
    
    titile = [TRClassMethod stringNumfloat:titile];
    //原配送费
    if (tag == 3001) {
        
        UILabel *tempLabel = (UILabel *)[self.takeView viewWithTag:tag];
        if (isnewUser) {
            
            tempLabel.hidden = YES;
            return;
        }
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}; NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:titile attributes:attribtDic];
        // 赋值
        tempLabel.attributedText = attribtStr;
        tempLabel.textColor = [UIColor grayColor];
        
        
        return;
    }
    
    
    if (tag == 1501) {
        
        if (isnewUser) {
            
            UIImageView *tempImage1 = [self.takeView viewWithTag:1500];
            UIImageView *tempImage2 = [self.takeView viewWithTag:1501];
            tempImage1.hidden = YES;
            tempImage2.hidden = NO;
            UILabel *tempL1 = [self.takeView viewWithTag:1102];
            tempL1.hidden = NO;
            tempL1.text = @"新用户优惠";
            return;
        }
        
        if (!isnewUser) {
            
            UIImageView *tempImage1 = [self.takeView viewWithTag:1500];
            UIImageView *tempImage2 = [self.takeView viewWithTag:1501];
            tempImage1.hidden = NO;
            tempImage2.hidden = YES;
            UILabel *tempL1 = [self.takeView viewWithTag:1102];
            tempL1.hidden = NO;
            tempL1.text = @"满减活动";
            UILabel *tempL2 = [self.takeView viewWithTag:1002];
            tempL2.hidden = NO;
            return;
        }
        
    }
    
    if (tag == 2000) {
        
        UIImageView *tempImage1 = [self.takeView viewWithTag:1500];
        UIImageView *tempImage2 = [self.takeView viewWithTag:1501];
        tempImage1.hidden = YES;
        tempImage2.hidden = YES;
        UILabel *tempL1 = [self.takeView viewWithTag:1102];
        tempL1.hidden = YES;
        UILabel *tempL2 = [self.takeView viewWithTag:1002];
        tempL2.hidden = YES;
        return;
        
    }
    
    
    
    if (tag == 1002) {
        
        UIButton *tempBtn = (UIButton *)[self.takeView viewWithTag:tag];
        [tempBtn setTitle:[NSString stringWithFormat:@"-￥%@",titile] forState:UIControlStateNormal];
    }
    
   
    //真实配送费
    if (tag == 1001) {
        
        UIButton *tempBtn = (UIButton *)[self.takeView viewWithTag:tag];
        [tempBtn setTitle:[NSString stringWithFormat:@"￥%@",titile] forState:UIControlStateNormal];
    }
    
   
    //打包费
    if (tag == 1000) {
        
        UIButton *tempBtn = (UIButton *)[self.takeView viewWithTag:tag];
        [tempBtn setTitle:[NSString stringWithFormat:@"￥%@",titile] forState:UIControlStateNormal];
    }
}



#pragma mark TimeChooseView delegate



-(void)chooseTimeSuccess:(NSString *)chooseTime isfirstTime:(BOOL)isfirsttime{
    if (chooseTime.length > 0) {
        //时间选择成功后修改时间lable
        _sendLabel.text = @"送达时间:";
        
        if (isfirsttime) {
            _sendLabel.text = @"立即送达:";
        }
        sendeTime = chooseTime;
        
        ISFirstTime = isfirsttime;
        
        self.takemileL.text = chooseTime;
        
        [self tapaction];
    }
    
}

//返回字体样式

- (NSAttributedString *)attributedText:(NSArray*)stringArray{
    
    NSString * string = [stringArray componentsJoinedByString:@""];

    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]};
    NSMutableAttributedString *  result = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic];
    // 返回已经设置好了的带有样式的文字
    return   result;//[[NSAttributedString alloc] initWithAttributedString:result];
    
}




@end
