//
//  RunErrandsViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/5.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "RunErrandsViewController.h"
#import "BMKLocationView.h"
#import "FillInOrderController.h"
#import "HelpMeSendController.h"
#define SpareWidth 10
@interface RunErrandsViewController ()

@end

@implementation RunErrandsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GRAYCLOLOR;
    [self designView];
    
}

//布局界面
-(void)designView {
    CGFloat viewWidth = 110;
    CGFloat btnWidth = 60;
    UIView *bottomV = [[UIView alloc]init];
    bottomV.backgroundColor = [UIColor whiteColor];
    bottomV.layer.cornerRadius = 5.0f;
    bottomV.layer.masksToBounds = YES;
    [self.view addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth * 2);
        make.bottom.mas_equalTo(-SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 4 * SpareWidth, viewWidth));
    }];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.backgroundColor = [UIColor whiteColor];
    [buyBtn setImage:[UIImage imageNamed:@"购物车-23 (1)"] forState:UIControlStateNormal];
    buyBtn.layer.cornerRadius = btnWidth / 2;
    buyBtn.layer.masksToBounds = YES;
    buyBtn.tag = 1000;
    [buyBtn addTarget:self action:@selector(RunErrandsType:) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo((viewWidth - btnWidth) / 2);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.backgroundColor = [UIColor whiteColor];
    [sendBtn setImage:[UIImage imageNamed:@"纸飞机"] forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = btnWidth / 2;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.tag = 1001;
    [sendBtn addTarget:self action:@selector(RunErrandsType:) forControlEvents:UIControlEventTouchUpInside];
    [bottomV addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 50);
        make.top.mas_equalTo((viewWidth - btnWidth) / 2);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnWidth));
    }];
    
    UILabel *buylabel = [[UILabel alloc]init];
    buylabel.textColor = [UIColor blackColor];
    buylabel.text = @"帮我买";
    buylabel.textAlignment = NSTextAlignmentCenter;
    buylabel.numberOfLines = 0;
    buylabel.font = [UIFont systemFontOfSize:12];
    buylabel.backgroundColor = [UIColor whiteColor];
    [bottomV addSubview:buylabel];
    [buylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buyBtn.mas_left );
        make.top.mas_equalTo(buyBtn.mas_bottom).offset(SpareWidth / 2);
        make.size.mas_equalTo(CGSizeMake(btnWidth, 10));
    }];
    
    UILabel *sendlabel = [[UILabel alloc]init];
    sendlabel .textColor = [UIColor blackColor];
    sendlabel .text = @"帮我送";
    sendlabel .textAlignment = NSTextAlignmentCenter;
    sendlabel .numberOfLines = 0;
    sendlabel .font = [UIFont systemFontOfSize:12];
    sendlabel .backgroundColor = [UIColor whiteColor];
    [bottomV addSubview:sendlabel ];
    [sendlabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(sendBtn.mas_right );
        make.top.mas_equalTo(sendBtn.mas_bottom).offset(SpareWidth / 2);
        make.size.mas_equalTo(CGSizeMake(btnWidth, 10));
    }];
    
}
//点击跑腿
-(void)RunErrandsType:(UIButton *)sender {
    if (sender.tag == 1000) {
        FillInOrderController *tempC = [[FillInOrderController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
        tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:nav animated:YES completion:nil];
        
        
    }else if (sender.tag == 1001){
        HelpMeSendController *tempC = [[HelpMeSendController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
        tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
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
