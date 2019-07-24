//
//  Singleton.m
//  SYApp
//
//  Created by DuQ on 14/12/12.
//  Copyright (c) 2014年 DuQ. All rights reserved.
//

#import "Singleton.h"
//#import "LoginView.h"

@implementation Singleton

// 获取单例
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        
    });
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)isLogin{
    if (!DWX_ISLogin) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你还未登录！" delegate:self cancelButtonTitle:@"去登录" otherButtonTitles:@"取消", nil];
        alert.delegate=self;
        [alert show];
        return NO;
    }
    return YES;
}

#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
//        LoginView *loginView = [[LoginView alloc]initWithFrame:TR_Frame withData:@[@1,@1]];
//        [ROOTVIEW addSubview:loginView];
    }
}

@end
