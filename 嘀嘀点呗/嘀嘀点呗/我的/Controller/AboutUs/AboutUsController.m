//
//  AboutUsController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "AboutUsController.h"
@interface AboutUsController()
@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"关于我们";
    self.isBackBtn = YES;
    
    //添加图片
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor whiteColor];
    imageV.image = [UIImage imageNamed:@"aboutus_content"];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(HeightForNagivationBarAndStatusBar);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT -HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT));
    }];
    
    UIImageView *logoimage = [[UIImageView alloc]init];
    logoimage.backgroundColor = [UIColor whiteColor];
    logoimage.image = [UIImage imageNamed:@"aboutus_logo"];
    [imageV addSubview:logoimage];
    [logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    UILabel *buildLabel = [[UILabel alloc]init];
    buildLabel.text = app_Version;
    buildLabel.font=[UIFont systemFontOfSize:14];
    buildLabel.textAlignment = NSTextAlignmentCenter;
    [imageV addSubview:buildLabel];
    [buildLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoimage.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = @"Hangzhou Xiaobei Network The Company";
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    label.textColor = [UIColor colorWithRed:101.003/255.0 green:101.003/255.0 blue:101.003/255.0 alpha:1];
     label.textAlignment = NSTextAlignmentCenter;
    [imageV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 15));
    }];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"杭州小呗网络科技有限公司";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    label2.textColor = [UIColor colorWithRed:101.003/255.0 green:101.003/255.0 blue:101.003/255.0 alpha:1];
    [imageV addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top).offset(-10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 15));
    }];
    
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"检查更新";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:20];
    label3.textColor = [UIColor colorWithRed:25.9998/255.0 green:25.9998/255.0 blue:25.9998/255.0 alpha:1];
    
    [imageV addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label2.mas_top).offset(-100);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 15));
    }];
    
}

//点击完成 返回上一个界面


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
