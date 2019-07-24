//
//  PersonalViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/5.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "PersonalViewController.h"
#import "LogInViewController.h"
#import "MyAddressController.h"
#import "EvaluateViewController.h"
#import "MyRefundController.h"
#import "MyRedEnvelopesController.h"
#import "AboutUsController.h"
#import "MyRedBaoTablView.h"
#import "PersonalMessageController.h"
#import "PersonalSettingController.h"
#import "MySaveShopsView.h"
#import "BusinessViewController.h"
#import "PersonalWebController.h"
@interface PersonalViewController ()<MyCollectionSelectDelegate,HideViewDelegate,HideRedViewDelegate>

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)MyRedBaoTablView  *myRedBaoTableView;

@property(nonatomic,strong)PersonalView *contentView;

@property(nonatomic,strong)MySaveShopsView *mySaveShopsView;

@end

@implementation PersonalViewController

{
    BOOL IsShowRedBaoVIew;
    BOOL IsShowSaveShopVIew;
}
-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]initWithFrame:self.view.bounds];
        _hideView.backgroundColor = [UIColor clearColor];
        _hideView.userInteractionEnabled = YES;
        _hideView.hidden = YES;
    }
    return _hideView;
}

-(MyRedBaoTablView *)myRedBaoTableView{
    if (_myRedBaoTableView == nil) {
        _myRedBaoTableView = [[MyRedBaoTablView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _myRedBaoTableView.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_myRedBaoTableView];
        _myRedBaoTableView.hidden = YES;
        
        
    }
    return _myRedBaoTableView;
}

-(MySaveShopsView *)mySaveShopsView{
    if (_mySaveShopsView == nil) {
        _mySaveShopsView = [[MySaveShopsView alloc]initWithFrame:self.view.bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:_mySaveShopsView];
        _mySaveShopsView.hidden = YES;
        _mySaveShopsView.delegate = self;
    }
    return _mySaveShopsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView = [[PersonalView alloc]init];
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(JumpToAimController:) name:@"JumoToLoginViewController" object:nil];
}

-(void)MyCollectionVIewDidSeletedWith:(NSIndexPath *)indexpath WithDatasource:(NSDictionary *)datasource WithTitleArray:(NSArray *)titleArray{
    if (datasource) {
        NSString *title = titleArray[indexpath.section];
        NSArray *tempArray = [datasource valueForKey:title];
        //跳转我的评价
        if ([tempArray[indexpath.row] isEqualToString:@"我的评价"]) {
    
            
            if (![Singleton shareInstance].userInfo) {
                LogInViewController *logvc=[[LogInViewController alloc]init];
                [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
                
                [self.navigationController pushViewController:logvc animated:YES];
                return;
                
            }
            
            
                EvaluateViewController *tempC = [[EvaluateViewController alloc]init];
            
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
            [self.navigationController pushViewController:tempC animated:YES];
            return;
        }
        
        //跳转我的地址
        if ([tempArray[indexpath.row] isEqualToString:@"我的地址"]) {
            
            if (![Singleton shareInstance].userInfo) {
                LogInViewController *logvc=[[LogInViewController alloc]init];
                [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
                
                [self.navigationController pushViewController:logvc animated:YES];
                return;
                
            }
            
            
            
        MyAddressController *tempC = [[MyAddressController alloc]init];
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        [self.navigationController pushViewController:tempC animated:YES];
            return;
        }
        
        //推荐部分
        if ([tempArray[indexpath.row] isEqualToString:@"城市加盟"]) {
            
            PersonalWebController *tempC = [[PersonalWebController alloc]init];
            tempC.viewName = tempArray[indexpath.row];
            tempC.weburl = @"http://www.didiwaimai.cn/wap.php?c=Agencypartner&a=deliver_recruit";
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
            [self.navigationController pushViewController:tempC animated:YES];
            return;
            
        }else{
            
            if (![TKAlertCenter defaultCenter]._active) {
                TR_Message(@"暂未开通此功能");
                return;
            }
            
        }
        
        
    }
    
   
    
}


//点击上面三个标签
-(void)SelectTopThreeItemWith:(NSString *)titleIndex andStringNumber:(NSString *)strnumber{
    
    if (![Singleton shareInstance].userInfo) {
        LogInViewController *logvc=[[LogInViewController alloc]init];
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
        
        [self.navigationController pushViewController:logvc animated:YES];
        return;
        
    }
    
    
    
    

    if ([titleIndex isEqualToString:@"收藏"]) {
       
        if ([strnumber integerValue]!=0) {
            
        if (!IsShowSaveShopVIew) {
            self.view.superview.backgroundColor = [UIColor blackColor];
            self.hideView.hidden = NO;
            self.mySaveShopsView.hidden = NO;
            self.contentView.userInteractionEnabled = NO;
            [self.mySaveShopsView loadDatasource];
            [UIView animateWithDuration:0.3 animations:^{
                
            self.mySaveShopsView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT );
            self.view.alpha = TR_Alpha;
                
            } completion:^(BOOL finished) {
                
                self->IsShowSaveShopVIew = YES;
                
            }];
        }
        }else{
            
            TR_Message(@"暂无收藏店铺");
        }
}

    
    
    if ([titleIndex isEqualToString:@"红包"] || [titleIndex isEqualToString:@"代金券"]) {
        TR_Message(@"暂未开通此功能");
        return;
        
//        if ([strnumber integerValue]!=0) {
//            if (!IsShowRedBaoVIew) {
//                self.view.superview.backgroundColor = [UIColor blackColor];
//                self.myRedBaoTableView.hidden = NO;
//                self.contentView.userInteractionEnabled = NO;
//                self.myRedBaoTableView.titleName = titleIndex;
//                [self.myRedBaoTableView designViewWith:titleIndex];
//                [UIView animateWithDuration:0.3 animations:^{
//
//                    self.myRedBaoTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT);
//                    self.view.alpha = TR_Alpha;
//                    self.hideView.hidden = NO;
//
//                } completion:^(BOOL finished) {
//
//                    IsShowRedBaoVIew = YES;
//
//                }];
//            }
//        }else{
//
//
//
//                NSString *title= [NSString stringWithFormat:@"暂无可以用%@",titleIndex];
//                TR_Message(title);
//            }
        
            
        
        
    }
    
    
    
    
}

//用户信息界面 设置界面
-(void)jumpToPersonalMessageView:(NSString *)aimVC{
    
    if ([aimVC isEqualToString:@"PersonalMessageVC"]) {
        if (!GetUser_Login_State) {
             {
                 
                LogInViewController *tempC = [[LogInViewController alloc]init];

                [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
                 [self.navigationController pushViewController:tempC animated:YES];
              
                
            }
            return;
        }
        
        PersonalMessageController *tempVC = [[PersonalMessageController alloc]init];
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        [self.navigationController pushViewController:tempVC animated:YES];
        
    }
   
    
    if ([aimVC isEqualToString:@"PersonalSettingVC"]) {
        PersonalSettingController *tempVC = [[PersonalSettingController alloc]init];
       [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        
       [self.navigationController pushViewController:tempVC animated:YES];
       
    }
   
    
}





#pragma mark  协议

-(void)clickHideView:(NSString *)viewType{

    if (IsShowSaveShopVIew) {
        self.view.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.mySaveShopsView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH , SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            self.hideView.hidden = YES;
            self.mySaveShopsView.hidden = YES;
            self.contentView.userInteractionEnabled = YES;
            IsShowSaveShopVIew = NO;
        }];
    }
    
}

-(void)clickCellAtIndexPath:(NSIndexPath *)indexpath withShopID:(NSString *)shopID{
    
    if (shopID.length > 0) {
        
        [self clickHideView:@""];
        BusinessViewController *tempC = [[BusinessViewController alloc]init];
        tempC.storeID = shopID;
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        [self.navigationController pushViewController:tempC animated:YES];
    }
    
}




-(void)clickHideRedView:(NSString *)viewType{
    
    if (IsShowRedBaoVIew) {
        self.view.alpha = 1;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.myRedBaoTableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH , SCREEN_HEIGHT / 2);
        } completion:^(BOOL finished) {
            self.hideView.hidden = YES;
            self.myRedBaoTableView.hidden = YES;
            self.contentView.userInteractionEnabled = YES;
            IsShowRedBaoVIew = NO;
        }];
    }
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.contentView startNetworkingWithUrl];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    
}





//以前的部分 重新修改了  已经废弃
-(void)JumpToAimController:(NSNotification *)sender {
    if ([sender.object isEqualToString:@"登录"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            LogInViewController *tempC = [[LogInViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
            tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        });
      
    }
    if ([sender.object isEqualToString:@"我的地址"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MyAddressController *tempC = [[MyAddressController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
             tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        });
    }
    if ([sender.object isEqualToString:@"我的评价"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            EvaluateViewController *tempC = [[EvaluateViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
            tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        });
    }
    if ([sender.object isEqualToString:@"我的退款"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MyRefundController *tempC = [[MyRefundController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
             tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        });
    }
    if ([sender.object isEqualToString:@"我的红包"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MyRedEnvelopesController *tempC = [[MyRedEnvelopesController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
            tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        }) ;
       
    }
    if ([sender.object isEqualToString:@"意见反馈"]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            FeedBackController *tempC = [[FeedBackController alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
//             tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//             [self presentViewController:nav animated:YES completion:nil];
//        });
       
    }
    
    if ([sender.object isEqualToString:@"关于我们"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AboutUsController *tempC = [[AboutUsController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tempC];
            tempC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:nav animated:YES completion:nil];
        });
        
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
