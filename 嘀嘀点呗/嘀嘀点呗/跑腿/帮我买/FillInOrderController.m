//
//  FillInOrderController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/22.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "FillInOrderController.h"
#define SpareWidth 10
@interface FillInOrderController ()<UITextViewDelegate>
{
    NSArray *titleImages; //存放商品类型的图片
    NSArray *titleName; //存放商品类型的名字
    NSArray *requireArray ; //存放商品要求
    NSArray *tipsArray;
}
@end

@implementation FillInOrderController

//-(UITextView *)requirementTextV {
//    if (_requirementTextV == nil) {
//        _requirementTextV = [[UITextView alloc]init];
//    }
//    return _requirementTextV;
//}


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


// 布局界面
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
    titleImages = @[@"购物",@"独立吸烟区 (1)",@"酒水",@"药 (1)",@"水果"];
    titleName = @[@"日常",@"香烟",@"酒",@"药品",@"水果"];
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 150));
    }];

    _requirementTextV = [[UITextView alloc]init];
    _requirementTextV.backgroundColor = [UIColor whiteColor];
    _requirementTextV.delegate = self;
    _requirementTextV.text = @"点击输入你的商品要求";
    _requirementTextV.textColor = [UIColor grayColor];
    _requirementTextV.editable = YES;
     _requirementTextV.dataDetectorTypes = UIDataDetectorTypeAll;
    [secondView addSubview:_requirementTextV];
    [_requirementTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
    }];
    
    requireArray = @[@"香蕉",@"苹果",@"一斤",@"需要发票"];
    CGFloat typeWinth = 50 ;
    for (int i = 0; i < 4; i ++ ) {
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.backgroundColor = GRAYCLOLOR;
        [typeBtn setTitle:requireArray[i] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        typeBtn.titleLabel.textAlignment  = NSTextAlignmentCenter;
        typeBtn.layer.cornerRadius = 5.0f;
        typeBtn.layer.masksToBounds = YES;
        [secondView addSubview:typeBtn];
        [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((typeWinth + SpareWidth) * i + SpareWidth);
            make.top.mas_equalTo(weakSelf.requirementTextV.mas_bottom).offset(SpareWidth / 2 );
            make.size.mas_equalTo(CGSizeMake(typeWinth, 20));
        }];
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    [secondView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_requirementTextV.mas_left);
        make.top.mas_equalTo(_requirementTextV.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];

    UILabel *moredecLabel = [[UILabel alloc]init];
    moredecLabel.textColor = [UIColor blackColor];
    moredecLabel.text = @"骑手垫付商品费,送货时当面结算";
    moredecLabel.textAlignment = NSTextAlignmentLeft;
    moredecLabel.numberOfLines = 0;
    moredecLabel.font = [UIFont systemFontOfSize:13];
    moredecLabel.backgroundColor = [UIColor whiteColor];
    [secondView addSubview:moredecLabel];
    [moredecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_requirementTextV.mas_left).offset(SpareWidth);
        make.top.mas_equalTo(lineView.mas_bottom).offset(SpareWidth * 1.5);
        make.size.mas_equalTo(CGSizeMake(200, 10));
    }];
    
    UIButton *priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    priceBtn.backgroundColor = [UIColor whiteColor];
    [priceBtn setTitle:@"预估商品价格" forState:UIControlStateNormal];
    priceBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    priceBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [priceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [secondView addSubview:priceBtn];
    [priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(moredecLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 10));
    }];
    
    //去哪里买视图
    UIView *thirdView = [[UIView alloc]init];
    thirdView.backgroundColor = [UIColor whiteColor];
    [contentV addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(secondView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    UILabel *buylabel = [[UILabel alloc]init];
    buylabel.textColor = [UIColor blackColor];
    buylabel.text = @"去哪买";
    buylabel.textAlignment = NSTextAlignmentLeft;
    buylabel.numberOfLines = 0;
    buylabel.font = [UIFont systemFontOfSize:13];
    buylabel.backgroundColor = [UIColor clearColor];
    [thirdView addSubview:buylabel];
    [buylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SpareWidth );
        make.size.mas_equalTo(CGSizeMake(50, 10));
    }];
    
    _buydeslabel = [[UILabel alloc]init];
    _buydeslabel.textColor = [UIColor redColor];
    _buydeslabel.text = @"如不填写地址,默认就近购买";
    _buydeslabel.textAlignment = NSTextAlignmentLeft;
    _buydeslabel.numberOfLines = 0;
    _buydeslabel.font = [UIFont systemFontOfSize:14];
    _buydeslabel.backgroundColor = [UIColor clearColor];
    [thirdView addSubview:_buydeslabel];
    [_buydeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buylabel.mas_right).offset(2 * SpareWidth);
        make.centerY.mas_equalTo(buylabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(180, 10));
    }];
    
    UIButton *butBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [butBtn setTitle:@">" forState:UIControlStateNormal];
    butBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    butBtn.backgroundColor = [UIColor whiteColor];
    [butBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    butBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [thirdView addSubview:butBtn];
    [butBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(buylabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];
    
    //地址的视图
    UIView *fourthView = [[UIView alloc]init];
    fourthView.backgroundColor = [UIColor whiteColor];
    [contentV addSubview:fourthView];
    [fourthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(thirdView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    
    UILabel *sendbabel = [[UILabel alloc]init];
    sendbabel.textColor = [UIColor blackColor];
    sendbabel.text = @"送达";
    sendbabel.textAlignment = NSTextAlignmentLeft;
    sendbabel.numberOfLines = 0;
    sendbabel.font = [UIFont systemFontOfSize:13];
    sendbabel.backgroundColor = [UIColor whiteColor];
    [fourthView addSubview:sendbabel];
    [sendbabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SpareWidth * 1.5 );
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@">" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sendBtn.backgroundColor = [UIColor whiteColor];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [fourthView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo( - SpareWidth);
        make.centerY.mas_equalTo(sendbabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];
    
    _locationLabel = [[UILabel alloc]init];
    _locationLabel.textColor = [UIColor blackColor];
    _locationLabel.text = @"杭州市萧山区博地中心A座";
    _locationLabel.textAlignment = NSTextAlignmentLeft;
    _locationLabel.numberOfLines = 0;
    _locationLabel.font = [UIFont systemFontOfSize:13];
    _locationLabel.backgroundColor = [UIColor whiteColor];
    [fourthView addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sendbabel.mas_right).offset(SpareWidth);
        make.top.mas_equalTo(3);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 20));
    }];
    
    _personalName = [[UILabel alloc]init];
    _personalName.textColor = [UIColor grayColor];
    _personalName.text = @"张 先生   135XXXXXXXXXXX";
    _personalName.textAlignment = NSTextAlignmentLeft;
    _personalName.numberOfLines = 0;
    _personalName.font = [UIFont systemFontOfSize:13];
    _personalName.backgroundColor = [UIColor whiteColor];
    [fourthView addSubview:_personalName];
    [_personalName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sendbabel.mas_right).offset(SpareWidth);
        make.top.mas_equalTo(weakSelf.locationLabel.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 20));
    }];
    
    //红包视图
    UIView *fivethView = [[UIView alloc]init];
    fivethView.backgroundColor = [UIColor whiteColor];
    [contentV addSubview:fivethView];
    [fivethView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(fourthView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    NSArray *redArray = @[@"送达时间",@"红包",@"小费"];
    CGFloat redlabelWidth = 20;
    for (int i = 0 ; i < 3; i ++ ) {
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
        
        if (i < 2) {
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
            peisongLabel.text = @"立即配送";
            peisongLabel.textAlignment = NSTextAlignmentRight;
            peisongLabel.numberOfLines = 0;
            peisongLabel.font = [UIFont systemFontOfSize:13];
            peisongLabel.backgroundColor = [UIColor clearColor];
            [fivethView addSubview:peisongLabel];
            [peisongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(peisongBtn.mas_left).offset(- SpareWidth);
                make.top.mas_equalTo((SpareWidth + redlabelWidth ) * i + SpareWidth);
                make.size.mas_equalTo(CGSizeMake(60, redlabelWidth));
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
        if (i == 2) {
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
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




#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"点击输入你的商品要求";
        textView.textColor = [UIColor grayColor];
    }else {
        //self.contetString = textView.text;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"点击输入你的商品要求"]){
        textView.text=@"";
        textView.textColor=[UIColor grayColor];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   [self.requirementTextV resignFirstResponder];
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
-(void)returntopView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击完成 返回上一个界面
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
