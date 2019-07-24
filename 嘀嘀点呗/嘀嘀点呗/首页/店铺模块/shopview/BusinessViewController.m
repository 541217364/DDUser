//
//  BusinessViewController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "BusinessViewController.h"
#import "BusinessCell.h"
#import "OrderManagerEvaluationViewController.h"
#import "ProductGoodsModel.h"

@interface BusinessViewController ()
@property(nonatomic,assign)BOOL businessIsopen;
@end

@implementation BusinessViewController



- (void)viewDidLoad {
   
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumptoordermenuviewcontroller:) name:@"JUMPTOORDERMENUVIEWCONTROLLER" object:nil];
    
    //界面调整
    self.shopView = [[BusinessShopView alloc]initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT+STATUS_BAR_HEIGHT)];

    self.shopView.delegate = self;
    
    
    [self.view addSubview:self.shopView];
    
    [self.shopView startnetworkingwith:self.storeID];
    
    if (_orderid.length!=0) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.shopView loadAgainDataOrderId:self.orderid withStoreID:self.storeID];
            
        });
    }


    
}







#pragma mark BusinessShopView 协议



-(void)backView{
    

    [self.shopView.bottomContentView.moveTopbtn removeFromSuperview];
    
    self.shopView.bottomContentView.moveTopbtn = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)jumptoordermenuviewcontroller:(NSNotification *)sender{

    self.shopView.bottomContentView.moveTopbtn.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    [APP_Delegate.rootViewController setSelectedIndex:1];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
    [self prefersStatusBarHidden];

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
