//
//  LogInViewController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/13.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "LogInViewController.h"
#import "WXApiManager.h"
#import "UIAlertView+WX.h"
#import "WXApiRequestHandler.h"
#import "Constant.h"
#import "WechatAuthSDK.h"
#import "WeixinModel.h"

#define SpareWidth 20
@interface LogInViewController ()<WXApiManagerDelegate,WechatAuthAPIDelegate>
{
    NSInteger timecount;
    NSArray *picArray;
    NSTimer *timer;
}
@end

@implementation LogInViewController
-(UITextField *)userNameTextField {
    if (_userNameTextField == nil) {
        _userNameTextField = [[UITextField alloc]init];
    }
    return _userNameTextField;
}
-(UITextField *)userPasswordField {
    if (_userPasswordField == nil) {
        _userPasswordField = [[UITextField alloc]init];
    }
    return _userPasswordField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleName = @"登录";
    self.isBackBtn = YES;
    [self designView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weiixnloginsuccess:) name:@"weixinloginsuccess" object:nil];
    // Do any additional setup after loading the view.
}

//布局界面
-(void)designView {
    __weak typeof(self) weakSelf = self;
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.text = @"手机号";
    CGSize size = TR_TEXT_SIZE(phoneLabel.text, phoneLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SCREEN_HEIGHT / 3);
        make.size.mas_equalTo(CGSizeMake(size.width + 20, 20));
    }];
    
    
  
    
    
    
    
    self.userNameTextField.backgroundColor = [UIColor whiteColor];
    self.userNameTextField.placeholder = @"请输入手机号";
    self.userNameTextField.textColor = [UIColor blackColor];
    self.userNameTextField.font = [UIFont systemFontOfSize:14];
    self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_right);
        make.top.mas_equalTo(phoneLabel.mas_top);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = GRAYCLOLOR;
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_left);
    make.top.mas_equalTo(weakSelf.userNameTextField.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];
    
    
    UILabel *verifiLabel = [[UILabel alloc]init];
    verifiLabel.textColor = [UIColor blackColor];
    verifiLabel.text = @"验证码";
    verifiLabel.textAlignment = NSTextAlignmentLeft;
    
    verifiLabel.font = [UIFont systemFontOfSize:15];
    verifiLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:verifiLabel];
    [verifiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(size.width + 20, 30));
    }];
    
    self.userPasswordField = [[UITextField alloc]init];
    self.userPasswordField.placeholder = @"请输入验证码";
    self.userPasswordField.font = [UIFont systemFontOfSize:14];
    self.userPasswordField.textColor = [UIColor blackColor];
    self.userPasswordField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.userPasswordField];
    [self.userPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verifiLabel.mas_right);
        make.top.mas_equalTo(verifiLabel.mas_top);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = GRAYCLOLOR;
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_left);
    make.top.mas_equalTo(weakSelf.userPasswordField.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
    }];
    
  
    timecount = 60;
    self.VerificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.VerificationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.VerificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.VerificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.VerificationBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.VerificationBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.VerificationBtn.layer setBorderWidth:0.5];
    self.VerificationBtn.layer.cornerRadius = 7.0f;
    self.VerificationBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.VerificationBtn];
    [self.VerificationBtn addTarget:self action:@selector(verificationaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(weakSelf.userPasswordField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
  
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    loginBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(224, 91, 51, 1);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginVicification) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(lineView2.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 40));
    }];
    
    
    //服务条款
    
    UIButton *serveceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // serveceBtn.backgroundColor = [UIColor grayColor];
//    [serveceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    serveceBtn.titleLabel.font = TR_Font_Gray(14);
//    serveceBtn.layer.cornerRadius = 10.0f;
    serveceBtn.layer.masksToBounds = YES;
    [self.view addSubview:serveceBtn];
    [serveceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginBtn.mas_left);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(SpareWidth * 2);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *serverLabel = [[UILabel alloc]init];
    serverLabel.textColor = [UIColor blackColor];
    serverLabel.font = TR_Font_Gray(14);
    serverLabel.text = @"登录代表同意点呗外卖";
    CGSize sizeL = TR_TEXT_SIZE(serverLabel.text, serverLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    serverLabel.textAlignment = NSTextAlignmentCenter;
    serverLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:serverLabel];
    [serverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(serveceBtn.mas_right);
        make.centerY.mas_equalTo(serveceBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(sizeL.width + 10, 20));
    }];
    
    
    UIButton *serveceDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serveceDetailBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    serveceDetailBtn.titleLabel.font = TR_Font_Gray(14);
    serveceDetailBtn.backgroundColor = [UIColor clearColor];
    [serveceDetailBtn setTitle:@"《用户服务协议》" forState:UIControlStateNormal];
    CGSize sizeBtn = TR_TEXT_SIZE(serveceDetailBtn.titleLabel.text, serveceDetailBtn.titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    serveceDetailBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:serveceDetailBtn];
    [serveceDetailBtn addTarget:self action:@selector(chooseServerce:) forControlEvents:UIControlEventTouchUpInside];
    [serveceDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(serverLabel.mas_right);
        make.centerY.mas_equalTo(serveceBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(sizeBtn.width, 20));
    }];
    
    if ([WXApi isWXAppInstalled] || [WXApi isWXAppSupportApi]) {
        
        //第三方登录
        UIView * bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 120));
        }];
        
        UIView * leftlineview = [[UIView alloc]init];
        leftlineview.backgroundColor = [UIColor grayColor];
        [bottomView addSubview:leftlineview];
        [leftlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth / 2);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 3 * SpareWidth)/3 , 1));
        }];
        
        
        UILabel *centerLabel = [[UILabel alloc]init];
        centerLabel.text = @"第三方登录";
        centerLabel.textColor = [UIColor grayColor];
        centerLabel.font = [UIFont systemFontOfSize:14];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:centerLabel];
        [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftlineview.mas_right).offset(SpareWidth / 2);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 3 * SpareWidth)/3 , 20));
        }];
        
        UIView * rightlineview = [[UIView alloc]init];
        rightlineview.backgroundColor = [UIColor grayColor];
        [bottomView addSubview:rightlineview];
        [rightlineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(centerLabel.mas_right).offset(SpareWidth / 2);
            make.top.mas_equalTo(SpareWidth / 2);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 3 * SpareWidth)/3 , 1));
        }];
        float  imageWidth = 40;
        float imagespare = (SCREEN_WIDTH - imageWidth * 3)/4 ;
        picArray = @[@"微博 (1)",@"椭圆 1 拷贝",@"椭圆 1"];
        for (int i = 0 ; i < 3; i ++ ) {
            UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
            Btn.backgroundColor = [UIColor whiteColor];
            Btn.layer.cornerRadius = 15.f;
            Btn.layer.masksToBounds = YES;
            if (i != 1 ) {
                Btn.hidden = YES;
            }
            [Btn setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];
            [bottomView addSubview:Btn];
            Btn.tag = 301 + i;
            [Btn addTarget:self action:@selector(thirdPartyLogin:) forControlEvents:UIControlEventTouchUpInside];
            [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((imagespare + imageWidth) * i + imagespare);
                make.top.mas_equalTo(leftlineview.mas_bottom).offset(30);
                make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
            }];
        }

    }
    
    
 
}

//点击完成 返回上一个界面


-(void)back{
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}



//点击验证码
-(void)verificationaction:(UIButton *)sender{
    //点击验证 先判断是否输入了手机号
    if (self.userNameTextField.text.length == 11 && [self.userNameTextField.text isMobileNumber]) {
        //输入了手机号
        sender.userInteractionEnabled = NO;
        sender.alpha = 0.5;
        [sender setTitle:[NSString stringWithFormat:@"等待%lds",timecount] forState:UIControlStateNormal];
        
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonState:) userInfo:nil repeats:YES];
            //注册验证码
            [HBHttpTool post:PERSONAL_VERIFITION params:@{@"phone":self.userNameTextField.text,@"type":@"0",@"Device-Id":DeviceID} success:^(id responseObj) {
                 if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                     TR_Message(@"获取验证码成功");
                 }

            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        
        
            
    
    }else {
        //未输入手机号  或者手机号码尾数不对
        UIAlertController *tempC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [tempC addAction:action];
        [self presentViewController:tempC animated:YES completion:nil];
        
        
    }
    
}

//改变button状态

-(void)changeButtonState:(UIButton *)sender{
    if (timecount > 0) {
        timecount -- ;
        [self.VerificationBtn setTitle:[NSString stringWithFormat:@"等待%lds",timecount] forState:UIControlStateNormal];
        [self.VerificationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    if (timecount == 0) {
        self.VerificationBtn.userInteractionEnabled = YES;
        [self.VerificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.VerificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.VerificationBtn.alpha = 1;
        timecount = 60;
        [timer invalidate];
    }
}



//点击登录
-(void)loginVicification{
//    if (self.userNameTextField.text.length == 11 &&  self.userPasswordField.text.length == 4 &&
//        [self.userNameTextField.text isMobileNumber]) {
        [HBHttpTool post:PERSONAL_LOGIN
                  params:@{@"phone":self.userNameTextField.text,@"client":@"1",@"Device-Id":DeviceID,@"code":self.userPasswordField.text,@"passwd":@"1111"} success:^(id responseObj) {
                      if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                         //登录成功
                           NSLog(@"%@",responseObj);
                    [Singleton shareInstance].userInfo  = [[UserInfo alloc]initWithDictionary:responseObj[@"result"][@"user"] error:nil];
                         [Singleton shareInstance].userInfo.ticket = responseObj[@"result"][@"ticket"];
                          
                          //记录登录状态
                          [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:@"USER_IS_LOGIN"];
                        [[NSUserDefaults standardUserDefaults] setValue:responseObj[@"result"][@"ticket"] forKey:@"ticket"];
                          NSLog(@"ticket = %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"ticket"]);
                          NSDictionary *user = responseObj[@"result"][@"user"];
                          [[NSUserDefaults standardUserDefaults]setObject:user[@"device_id"] forKey:@"device_id"];
                          [self setUserlogin];
                          TR_Message(@"登录成功");
                          [self.view endEditing:YES];
                          [self back];
                      }else{
                          
                          TR_Message(responseObj[@"errorMsg"]);
                      }
                     
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                  }];
  //  }
}


-(void) setUserlogin {
    
    if ([Singleton shareInstance].userInfo) {
        
        NSString *jsstr=[[Singleton shareInstance].userInfo toJSONString];
        
        [USERDEFAULTS setObject:jsstr forKey:@"userinfo"];
        SetUser_Login_State(YES);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDtataUserMessage" object:nil];
    }
    
}


-(void)chooseServerce:(UIButton *)sender{
    NSLog(@"服务条款");
}




//第三方登录
-(void)thirdPartyLogin:(UIButton *)sender {
    if (sender.tag == 301) {
        NSLog(@"微博登录");
    }
    if (sender.tag == 303) {
        NSLog(@"QQ登录");
    }
    if (sender.tag == 302) {
        [WXApiManager sharedManager].delegate = self;
//        [WXApiRequestHandler sendAuthRequestScope: kAuthScope
//                                           State:kAuthState
//                                          OpenID:kAuthOpenID
//                                 InViewController:self];
        SendAuthReq* req =[[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }
}



-(void)weiixnloginsuccess:(NSNotification *)sender{
    
    SendAuthResp *object = sender.object;
    NSString * codeStr = object.code;
    
    if (codeStr.length > 0) {
        
        NSDictionary *body = @{@"code":codeStr,@"client":@"1",@"Device-Id":DeviceID};
        
        [HBHttpTool post:PERSONAL_BULDUSERMESSAGE params:body success:^(id responseObj) {
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                TR_Message(@"微信登录成功");
                [Singleton shareInstance].userInfo  = [[UserInfo alloc]initWithDictionary:responseObj[@"result"][@"user"] error:nil];
                [Singleton shareInstance].userInfo.ticket = responseObj[@"result"][@"ticket"];
                if ([Singleton shareInstance].userInfo.phone.length > 0) {
                    [self setUserlogin];
                    [self back];
                    return ;
                }
                    FxiPhoneNumberController *tempC = [[FxiPhoneNumberController alloc]init];
                    tempC.isFormWX = YES;
                    [self.navigationController pushViewController:tempC animated:YES];
                  
               
                
            
                
            }else{
                
                TR_Message(responseObj[@"errorMsg"]);
            }
            
        } failure:^(NSError *error) {
            TR_Message(@"微信登录失败");
        }];
    }
    
}







//成功登录
- (void)onAuthFinish:(int)errCode AuthCode:(NSString *)authCode
{
    NSLog(@"onAuthFinish");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"onAuthFinish"
                                                    message:[NSString stringWithFormat:@"authCode:%@ errCode:%d", authCode, errCode]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}


- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    if (response.errCode == 0) {
        
            //用户允许授权登录
            
            //第二步通过code获取access_token
            
            NSString * codeStr = response.code;
            
//            NSString * grantStr =@"grant_type=authorization_code";
//
//            //通过code获取access_token https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
//
//            NSString * tokenUrl =@"https://api.weixin.qq.com/sns/oauth2/access_token?";
//
//            NSString * tokenUrl1 = [tokenUrl stringByAppendingString:[NSString stringWithFormat:@"appid=%@&",@"wxf71e9c874c9cde95"]];
//
//            NSString * tokenUrl2 = [tokenUrl1 stringByAppendingString:[NSString stringWithFormat:@"secret=%@&",@"cbc7ac871611243b992c7cfdaf170b40"]];
//
//            NSString * tokenUrl3 = [tokenUrl2 stringByAppendingString:[NSString stringWithFormat:@"code=%@&",codeStr]];
//
//            NSString * tokenUrlend = [tokenUrl3 stringByAppendingString:grantStr];
        
        
        
//        __weak typeof(self) weakSelf = self;
//        [HBHttpTool get:tokenUrlend params:nil success:^(id responseObj) {
//
//            [weakSelf getUserMessage:responseObj[@"access_token"] withopenid:responseObj[@"openid"]];
//
//        } failure:^(NSError *error) {
//
//        }];
        
        //调整 通过后台接口获取微信信息
        
        if (codeStr.length > 0) {
            
            NSDictionary *body = @{@"code":codeStr,@"client":@"1"};
            
            [HBHttpTool post:PERSONAL_BULDUSERMESSAGE params:body success:^(id responseObj) {
                if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                    TR_Message(@"微信登录成功");
                    [Singleton shareInstance].userInfo  = [[UserInfo alloc]initWithDictionary:responseObj[@"result"][@"user"] error:nil];
                    
                    [Singleton shareInstance].userInfo.ticket = responseObj[@"result"][@"ticket"];
                    [self setUserlogin];
                    
                    
                }
                
            } failure:^(NSError *error) {
                TR_Message(@"微信登录失败");
            }];
        }

    }
}



-(void)getUserMessage:(NSString *)access_token withopenid:(NSString *)openid{
    //第三步：通过access_token得到昵称、unionid等信息
    
    NSString * userfulStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    

    //NSString * unionidStr = [userfulResultDic objectForKey:@"unionid"];//每个用户所对应的每个开放平台下的每个应用是同一个唯一标识
    //
    //  NSString * nickStr = [userfulResultDic objectForKey:@"nickname"];
    __weak typeof(self) weakSelf = self;
    [HBHttpTool get:userfulStr params:nil success:^(id responseObj) {
        
        TR_Message(responseObj[@"nickname"]);
        
        WeixinModel *model = [[WeixinModel alloc]initWithDictionary:responseObj error:nil];
        if (model) {
            NSString *datastring = [model toJSONString];
            [USERDEFAULTS setObject:datastring forKey:@"weixinmodel"];
            [weakSelf sendUserMassageToserver];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}



//微信登录成功绑定用户信息

-(void)sendUserMassageToserver{
    NSString *data = [USERDEFAULTS valueForKey:@"weixinmodel"];
    WeixinModel *model = [[WeixinModel alloc]initWithString:data error:nil];
    if (model) {
        
        NSDictionary *body = @{@"weixin_open_id":model.openid,@"weixin_union_id":model.unionid,@"Device-Id":DeviceID,@"nickname":model.nickname,@"avatar":model.headimgurl};
        
        [HBHttpTool post:PERSONAL_BULDUSERMESSAGE params:body success:^(id responseObj) {
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                TR_Message(@"微信登录成功");
                [Singleton shareInstance].userInfo  = [[UserInfo alloc]initWithDictionary:responseObj[@"result"][@"user"] error:nil];
                [Singleton shareInstance].userInfo.ticket = responseObj[@"result"][@"ticket"];
                [self setUserlogin];
                
            }
            
        } failure:^(NSError *error) {
            TR_Message(@"微信登录失败");
        }];
        
    }
}



//收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
