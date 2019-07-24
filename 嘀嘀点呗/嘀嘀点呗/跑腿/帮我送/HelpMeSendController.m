//
//  HelpMeSendController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/22.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "HelpMeSendController.h"
#define SpareWidth 10
@interface HelpMeSendController ()

@end

@implementation HelpMeSendController
 {
   NSArray *titleImages; //存放商品类型的图片
   NSArray *titleName; //存放商品类型的名字
   NSArray *requireArray ; //存放商品要求
   NSArray *tipsArray;
 }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GRAYCLOLOR;
    self.title = @"填写订单";
    UIImage *image = [UIImage imageNamed:@"下拉"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(returntopView)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self designView];
    // Do any additional setup after loading the view.
}
-(void)designView {
    __weak typeof(self) weakSelf = self;
    UIScrollView *contentV = [[UIScrollView alloc]init];
    contentV.backgroundColor = GRAYCLOLOR;
    contentV.userInteractionEnabled = YES;
    contentV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    //上层的界面
    titleImages = @[@"类目 品类 分类 类别",@"美食 (1)",@"文件",@"蛋糕 (1)",@"鲜花"];
    titleName = @[@"其他",@"美食",@"文件",@"蛋糕",@"鲜花"];
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled = YES;
    [contentV addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    
    CGFloat btnWidth = 30;
    CGFloat btnSpare = (SCREEN_WIDTH - 5 * btnWidth) / 6 ;
    for (int i = 0; i < 5; i++ ) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.backgroundColor = [UIColor whiteColor];
        [tempBtn setImage:[UIImage imageNamed:titleImages[i]] forState:UIControlStateNormal];
        tempBtn.layer.cornerRadius = 15.0f;
        tempBtn.layer.masksToBounds = YES;
        [topView addSubview:tempBtn];
        [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((btnSpare +btnWidth) * i + btnSpare);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
        }];
        
        UILabel *tempLabel = [[UILabel alloc]init];
        tempLabel.textColor = [UIColor blackColor];
        tempLabel.text = titleName[i];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.numberOfLines = 0;
        tempLabel.font = [UIFont systemFontOfSize:13];
        tempLabel.backgroundColor = [UIColor whiteColor];
        [topView addSubview:tempLabel];
        [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tempBtn.mas_left);
            make.top.mas_equalTo(tempBtn.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(btnWidth, 10));
        }];
    }
    
    //商品要求输入
    UIView *secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.userInteractionEnabled = YES;
    [contentV addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(topView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 160));
    }];
    
    UIImageView *myLocationView = [[UIImageView alloc]init];
    myLocationView.backgroundColor = [UIColor greenColor];
    [secondView addSubview:myLocationView];
    [myLocationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(27.5);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    
    _mylocationLabel = [[UILabel alloc]init];
    _mylocationLabel.textColor = [UIColor blackColor];
    _mylocationLabel.text = @"杭州市萧山区博地中心A座2602";
    _mylocationLabel.textAlignment = NSTextAlignmentLeft;
    _mylocationLabel.numberOfLines = 0;
    _mylocationLabel.font = [UIFont systemFontOfSize:13];
    _mylocationLabel.backgroundColor = [UIColor clearColor];
    [secondView addSubview:_mylocationLabel];
    [_mylocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(myLocationView.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(myLocationView.mas_centerY).offset(-SpareWidth);
        make.size.mas_equalTo(CGSizeMake(200, 10));
    }];
    
    _myphoneLable = [[UILabel alloc]init];
    _myphoneLable.textColor = [UIColor grayColor];
    _myphoneLable.text = @"张先生 155XXXXXXXXX";
    _myphoneLable.textAlignment = NSTextAlignmentLeft;
    _myphoneLable.numberOfLines = 0;
    _myphoneLable.font = [UIFont systemFontOfSize:13];
    _myphoneLable.backgroundColor = [UIColor clearColor];
    [secondView addSubview:_myphoneLable];
    [_myphoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(myLocationView.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(myLocationView.mas_centerY).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(180, 10));
    }];
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn  setTitle:@">" forState:UIControlStateNormal];
    locationBtn .titleLabel.font = [UIFont systemFontOfSize:13];
    locationBtn .backgroundColor = [UIColor whiteColor];
    [locationBtn  setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    locationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:locationBtn ];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo( - SpareWidth);
        make.centerY.mas_equalTo(myLocationView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];
    
    //  上面两个视图 高度 暂定 60  下面40
    UIView *lineView1 =[[UIView alloc]init];
    lineView1.backgroundColor = GRAYCLOLOR;
    [secondView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];
    
    UIImageView *sendgoodsView = [[UIImageView alloc]init];
    sendgoodsView.backgroundColor = [UIColor redColor];
    [secondView addSubview:sendgoodsView];
    [sendgoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(87.5);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    
    UILabel *sendGoodsLabel = [[UILabel alloc]init];
    sendGoodsLabel.textColor = [UIColor grayColor];
    sendGoodsLabel.text = @"物品送到哪里去";
    sendGoodsLabel.textAlignment = NSTextAlignmentLeft;
    sendGoodsLabel.numberOfLines = 0;
    sendGoodsLabel.font = [UIFont systemFontOfSize:13];
    sendGoodsLabel.backgroundColor = [UIColor clearColor];
    [secondView addSubview:sendGoodsLabel];
    [sendGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(myLocationView.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(sendgoodsView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(180, 10));
    }];
    
    UIButton *sendGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendGoodsBtn  setTitle:@">" forState:UIControlStateNormal];
    sendGoodsBtn .titleLabel.font = [UIFont systemFontOfSize:13];
    sendGoodsBtn .backgroundColor = [UIColor whiteColor];
    [sendGoodsBtn  setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendGoodsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:sendGoodsBtn];
    [sendGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo( - SpareWidth);
        make.centerY.mas_equalTo(sendgoodsView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];
    
    UIView *lineView2 =[[UIView alloc]init];
    lineView2.backgroundColor = GRAYCLOLOR;
    [secondView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(120);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];
    
    UIView *lineView3 =[[UIView alloc]init];
    lineView3.backgroundColor = GRAYCLOLOR;
    [secondView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH  /2 );
        make.top.mas_equalTo(lineView2.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(1, 40));
    }];
    
    UILabel *timePickLabel = [[UILabel alloc]init];
    timePickLabel.textColor = [UIColor grayColor];
    timePickLabel.text = @"取件时间";
    timePickLabel.textAlignment = NSTextAlignmentLeft;
    timePickLabel.numberOfLines = 0;
    timePickLabel.font = [UIFont systemFontOfSize:13];
    timePickLabel.backgroundColor = [UIColor clearColor];
    [secondView addSubview:timePickLabel ];
    [timePickLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.centerY.mas_equalTo(lineView3.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 10));
    }];
    
    UIButton *timePickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [timePickBtn setTitle:@"立即取件 >" forState:UIControlStateNormal];
   // [timePickBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    timePickBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    timePickBtn.backgroundColor = [UIColor whiteColor];
    [timePickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    timePickBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [sendgoodsView addSubview:timePickBtn];
    [timePickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lineView3.mas_left).offset(-SpareWidth /2);
        make.centerY.mas_equalTo(timePickLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 2 * SpareWidth) / 2 -80 , 10));
    }];
    
    UILabel *goodsWeightLabel = [[UILabel alloc]init];
    goodsWeightLabel.textColor = [UIColor grayColor];
    goodsWeightLabel.text = @"物品重量";
    goodsWeightLabel.textAlignment = NSTextAlignmentLeft;
    goodsWeightLabel.numberOfLines = 0;
    goodsWeightLabel.font = [UIFont systemFontOfSize:13];
    goodsWeightLabel.backgroundColor = [UIColor clearColor];
    [secondView addSubview:goodsWeightLabel];
    [goodsWeightLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView3.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(lineView3.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 10));
    }];
    
    UIButton *goodsWeightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goodsWeightBtn setTitle:@"5kg >" forState:UIControlStateNormal];
    // [timePickBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    goodsWeightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    goodsWeightBtn.backgroundColor = [UIColor whiteColor];
    [goodsWeightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    goodsWeightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [secondView addSubview:goodsWeightBtn];
    [goodsWeightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(lineView3.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 2 * SpareWidth) / 2 -80 , 10));
    }];
    
    //红包视图
    UIView *fivethView = [[UIView alloc]init];
    fivethView.backgroundColor = [UIColor whiteColor];
    [contentV addSubview:fivethView];
    [fivethView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(secondView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 125));
    }];
    NSArray *redArray = @[@"货运险",@"货品价值",@"红包",@"小费"];
    CGFloat redlabelWidth = 20;
    for (int i = 0 ; i < redArray.count; i ++ ) {
        UILabel *redLabel = [[UILabel alloc]init];
        redLabel.textColor = [UIColor blackColor];
        redLabel.text = redArray[i];
        redLabel.textAlignment = NSTextAlignmentLeft;
        redLabel.numberOfLines = 0;
        redLabel.font = [UIFont systemFontOfSize:13];
        redLabel.backgroundColor = [UIColor clearColor];
        [fivethView addSubview:redLabel];
        [redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth );
            make.top.mas_equalTo((SpareWidth + redlabelWidth ) * i + SpareWidth);
            make.size.mas_equalTo(CGSizeMake(60, redlabelWidth));
        }];
        
        if (i < 3) {
            UIView *redlineView = [[UIView alloc]init];
            redlineView.backgroundColor = GRAYCLOLOR;
            [fivethView addSubview:redlineView];
            [redlineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SpareWidth);
                make.top.mas_equalTo((SpareWidth + redlabelWidth + 1)* (i+ 1));
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
            }];
        }
        
        if (i == 0) {
            UIButton *peisongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [peisongBtn setTitle:@">" forState:UIControlStateNormal];
            peisongBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            peisongBtn.backgroundColor = [UIColor whiteColor];
            [peisongBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            peisongBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [fivethView addSubview:peisongBtn];
            [peisongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo( - SpareWidth);
                make.centerY.mas_equalTo(redLabel.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(20, 10));
            }];
            
            UILabel *peisongLabel = [[UILabel alloc]init];
            peisongLabel.textColor = [UIColor blackColor];
            peisongLabel.text = @"未选购";
            peisongLabel.textAlignment = NSTextAlignmentRight;
            peisongLabel.numberOfLines = 0;
            peisongLabel.font = [UIFont systemFontOfSize:13];
            peisongLabel.backgroundColor = [UIColor clearColor];
            [fivethView addSubview:peisongLabel];
            [peisongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(peisongBtn.mas_left).offset(- SpareWidth);
                make.top.mas_equalTo((SpareWidth + redlabelWidth ) * i + SpareWidth);
                make.size.mas_equalTo(CGSizeMake(50, redlabelWidth));
            }];
        }
        
        if (i == 1) {
            UIButton *redCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [redCountBtn setTitle:@">" forState:UIControlStateNormal];
            redCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            redCountBtn.backgroundColor = [UIColor whiteColor];
            [redCountBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            redCountBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [fivethView addSubview:redCountBtn];
            [redCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo( - SpareWidth);
                make.centerY.mas_equalTo(redLabel.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(20, 10));
            }];
            
            UILabel *redCountLabel = [[UILabel alloc]init];
            redCountLabel.textColor = [UIColor blackColor];
            redCountLabel.text = @"100元以下";
            redCountLabel.textAlignment = NSTextAlignmentRight;
            redCountLabel.numberOfLines = 0;
            redCountLabel.font = [UIFont systemFontOfSize:13];
            redCountLabel.backgroundColor = [UIColor clearColor];
            [fivethView addSubview:redCountLabel];
            [redCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(redCountBtn.mas_left).offset(- SpareWidth);
                make.top.mas_equalTo((SpareWidth + redlabelWidth ) * i + SpareWidth);
                make.size.mas_equalTo(CGSizeMake(100, redlabelWidth));
            }];
        }
        
        if (i == 2) {
            UIButton *redCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [redCountBtn setTitle:@">" forState:UIControlStateNormal];
            redCountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            redCountBtn.backgroundColor = [UIColor whiteColor];
            [redCountBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            redCountBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [fivethView addSubview:redCountBtn];
            [redCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo( - SpareWidth);
                make.centerY.mas_equalTo(redLabel.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(20, 10));
            }];
            
            UILabel *redCountLabel = [[UILabel alloc]init];
            redCountLabel.textColor = [UIColor redColor];
            redCountLabel.text = @"一个红包可用";
            redCountLabel.textAlignment = NSTextAlignmentRight;
            redCountLabel.numberOfLines = 0;
            redCountLabel.font = [UIFont systemFontOfSize:13];
            redCountLabel.backgroundColor = [UIColor clearColor];
            [fivethView addSubview:redCountLabel];
            [redCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(redCountBtn.mas_left).offset(- SpareWidth);
                make.top.mas_equalTo((SpareWidth + redlabelWidth ) * i + SpareWidth);
                make.size.mas_equalTo(CGSizeMake(100, redlabelWidth));
            }];
        }
        
        if (i == 3) {
            NSArray *segArray = @[@"",@""];
            UISegmentedControl *segmentC = [[UISegmentedControl alloc]initWithItems:segArray];
            segmentC.layer.cornerRadius = 5.0f;
            segmentC.layer.masksToBounds = YES;
            segmentC.tintColor = [UIColor redColor];
            segmentC.selectedSegmentIndex = 0;
            [fivethView addSubview:segmentC];
            [segmentC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-SpareWidth);
                make.centerY.mas_equalTo(redLabel.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(30, 15));
            }];
            
        }
    }
    
    //小费界面
    _tipsView = [[UIView alloc]init];
    _tipsView.backgroundColor = [UIColor whiteColor];
    [contentV addSubview:_tipsView];
    [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(fivethView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    CGFloat tipsWidth = (SCREEN_WIDTH - 6 * 10 ) /5 ;
    CGFloat tipsSpare = 10;
    tipsArray = @[@"￥1",@"￥2",@"￥3",@"￥5",@"其他"];
    for (int i = 0; i < tipsArray.count; i ++ ) {
        UIButton *tipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tipsBtn.backgroundColor = GRAYCLOLOR ;
        [tipsBtn setTitle:tipsArray[i] forState:UIControlStateNormal];
        [tipsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tipsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        tipsBtn.layer.cornerRadius = 5.0f;
        tipsBtn.layer.masksToBounds = YES;
        tipsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.tipsView addSubview:tipsBtn];
        [tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(((tipsWidth + tipsSpare )* i) + tipsSpare);
            make.top.mas_equalTo(tipsSpare / 2);
            make.size.mas_equalTo(CGSizeMake(tipsWidth, 20));
        }];
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    [_tipsView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];
    
    UILabel *remarksLabel = [[UILabel alloc]init];
    remarksLabel.textColor = [UIColor blackColor];
    remarksLabel.text = @"备注";
    remarksLabel.textAlignment = NSTextAlignmentLeft;
    remarksLabel.numberOfLines = 0;
    remarksLabel.font = [UIFont systemFontOfSize:13];
    remarksLabel.backgroundColor = [UIColor whiteColor];
    [_tipsView addSubview:remarksLabel];
    [remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(lineView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(50, 10));
    }];

    UIButton *remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [remarkBtn setTitle:@">" forState:UIControlStateNormal];
    remarkBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    remarkBtn.backgroundColor = [UIColor whiteColor];
    [remarkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    remarkBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_tipsView addSubview:remarkBtn];
    [remarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo( - SpareWidth);
        make.centerY.mas_equalTo(remarksLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];

    UILabel *remarkLabel2 = [[UILabel alloc]init];
    remarkLabel2.textColor = [UIColor blackColor];
    remarkLabel2.text = @"想对骑士说什么？";
    remarkLabel2.textAlignment = NSTextAlignmentRight;
    remarkLabel2.numberOfLines = 0;
    remarkLabel2.font = [UIFont systemFontOfSize:13];
    remarkLabel2.backgroundColor = [UIColor clearColor];
    [_tipsView addSubview:remarkLabel2];
    [remarkLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(remarkBtn.mas_left).offset(- SpareWidth);
        make.centerY.mas_equalTo(remarksLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, redlabelWidth));
    }];
    
    //布局最底层视图
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [contentV addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.tipsView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    UIButton *settlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settlementBtn.backgroundColor = [UIColor redColor];
    [settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settlementBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    settlementBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [settlementBtn setTitle:@"下单并支付" forState:UIControlStateNormal];
    [_bottomView addSubview:settlementBtn];
    [settlementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
    NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:25],
                                      NSForegroundColorAttributeName:[UIColor redColor]};
    NSAttributedString *attributedString = [self attributedText:@[@"￥", @"18"]
                                                 attributeAttay:@[attributesExtra,attributesPrice]];
    UILabel *runlabel = [[UILabel alloc]init];
    runlabel.attributedText = attributedString;
    runlabel.textAlignment = NSTextAlignmentRight;
    runlabel.backgroundColor = [UIColor whiteColor];
    [_bottomView addSubview:runlabel];
    [runlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(settlementBtn.mas_left).offset(-SpareWidth);
        make.centerY.mas_equalTo(settlementBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    UILabel *runTitleLabel = [[UILabel alloc]init];
    runTitleLabel.textColor = [UIColor blackColor];
    runTitleLabel.text = @"跑腿费";
    runTitleLabel.textAlignment = NSTextAlignmentRight;
    runTitleLabel.numberOfLines = 0;
    runTitleLabel.font = [UIFont systemFontOfSize:13];
    runTitleLabel.backgroundColor = [UIColor clearColor];
    [_bottomView addSubview:runTitleLabel];
    [runTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(runlabel.mas_left).offset(- SpareWidth);
        make.centerY.mas_equalTo(runlabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 10));
    }];
}

//界面跳转
-(void)returntopView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay{
    NSString * string = [stringArray componentsJoinedByString:@""];
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++){
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
