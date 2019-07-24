//
//  PersonalWebController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/6/5.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PersonalWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BusinessViewController.h"
#import "WYWebProgressLayer.h"


@interface PersonalWebController ()<UIWebViewDelegate>

@property(nonatomic, strong) JSContext *context;

@end

@implementation PersonalWebController

{
    WYWebProgressLayer *_progressLayer; ///< 网页加载进度条
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isBackBtn = YES;
   
    [self setupUI];
    
   
    

}


- (void)setupUI {
  
    UIWebView *web = [[UIWebView alloc]init];
    web.delegate = self;
    web.frame = CGRectMake(0, HeightForNagivationBarAndStatusBar, SCREEN_WIDTH, SCREEN_HEIGHT -HeightForNagivationBarAndStatusBar + HOME_INDICATOR_HEIGHT);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    JSContext *context = [web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    __weak typeof(self) weakSelf = self;
    
    context[@"goStore"] = ^(NSString *storeid) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            BusinessViewController *tempC = [[BusinessViewController alloc]init];
            
            tempC.storeID = storeid;
            
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
            
            [strongSelf.navigationController pushViewController:tempC animated:YES];
            
        });
    };
    
    
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    _progressLayer = [WYWebProgressLayer layerWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, SCREEN_WIDTH, 2)];
    [self.view.layer addSublayer:_progressLayer];
    [_progressLayer startLoad];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}






- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_progressLayer finishedLoad];
    
    self.titleName = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
//    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//
//    NSString *str=[NSString stringWithFormat:@"iosShowCount('%@','%@','%@','%@')",DeviceID,@"1",[Singleton shareInstance].userInfo.ticket,@""];
//
//    [context evaluateScript:str];
//
//    _context=context;
}


-(void)back{
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:YES];
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
