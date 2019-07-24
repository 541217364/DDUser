//
//  FxiPhoneNumberController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "FxiPhoneNumberController.h"
#define SpareWidth 10
@interface FxiPhoneNumberController ()

@end

@implementation FxiPhoneNumberController

{
    NSInteger timecount;
    NSArray *picArray;
     NSTimer *timer;
}

-(UITextField *)userNameTextField {
    if (_userNameTextField == nil) {
        _userNameTextField = [[UITextField alloc]init];
        _userNameTextField.backgroundColor = [UIColor whiteColor];
        _userNameTextField.placeholder = @"请输入手机号";
        _userNameTextField.textColor = [UIColor blackColor];
        _userNameTextField.font = TR_Font_Gray(14);
        _userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _userNameTextField;
}
-(UITextField *)userPasswordField {
    if (_userPasswordField == nil) {
        _userPasswordField = [[UITextField alloc]init];
        _userPasswordField = [[UITextField alloc]init];
        _userPasswordField.placeholder = @"请输入验证码";
        _userPasswordField.font = TR_Font_Gray(14);
        _userPasswordField.textColor = [UIColor blackColor];
        _userPasswordField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _userPasswordField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"绑定手机号";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    self.isBackBtn = YES;
    [self designView];
    // Do any additional setup after loading the view.
}





//布局界面
-(void)designView {
    __weak typeof(self) weakSelf = self;
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.text = @"手机号";
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SCREEN_HEIGHT / 3);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    timecount = 60;
    self.VerificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.VerificationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.VerificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.VerificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.VerificationBtn.titleLabel.font = TR_Font_Gray(14);
    [self.VerificationBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.VerificationBtn.layer setBorderWidth:1];
    self.VerificationBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.VerificationBtn];
    [self.VerificationBtn addTarget:self action:@selector(verificationaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.VerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo( - SpareWidth );
        make.centerY.mas_equalTo(phoneLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(phoneLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.VerificationBtn.mas_left).offset(-SpareWidth);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = GRAYCLOLOR;
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_left);
        make.top.mas_equalTo(weakSelf.userNameTextField.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.VerificationBtn.mas_right);
        make.height.mas_equalTo(1);
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
        make.top.mas_equalTo(lineView1.mas_bottom).offset(2 * SpareWidth);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    
    
    [self.view addSubview:self.userPasswordField];
    [self.userPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userNameTextField.mas_left);
        make.centerY.mas_equalTo(verifiLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.userNameTextField.mas_right);
        make.height.mas_equalTo(weakSelf.userNameTextField.mas_height);
        
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = GRAYCLOLOR;
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_left);
        make.top.mas_equalTo(weakSelf.userPasswordField.mas_bottom).offset(5);
        make.right.mas_equalTo(weakSelf.VerificationBtn.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    loginBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(224, 91, 51, 1);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"保存" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginVicification) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(lineView2.mas_bottom).offset(4 * SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 40));
    }];
    
}


-(void)loginVicification{
    
    if (self.userNameTextField.text.length != 11 || ![self.userNameTextField.text isMobileNumber]) {
        TR_Message(@"手机号码输入有误");
        return;
    }
    
    if (self.userPasswordField.text.length != 4) {
        TR_Message(@"验证码输入有误");
        return;
    }
    
    if (self.isFormWX) {
        
        [self fixNewPhoneWithWX];
        
    }else{
        
        [self fixNewPhoneFormOldNewphone];
    }
    
    
   
}




-(void)fixNewPhoneWithWX{
    //绑定新手机
    NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"openid":[Singleton shareInstance].userInfo.app_openid,@"phone":self.userNameTextField.text,@"code":self.userPasswordField.text,@"client":@"1",@"type":@"3",@"union_id":[Singleton shareInstance].userInfo.union_id};
    [HBHttpTool post:PERSONAL_NEWPHONE params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            TR_Message(@"绑定手机成功");
            [Singleton shareInstance].userInfo.phone = self.userNameTextField.text ;
            [self setUserlogin];
            [self back];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)fixNewPhoneFormOldNewphone{
    NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"phone":self.userNameTextField.text,@"code":self.userPasswordField.text,@"client":@"1",@"type":@"3"};
    
    [HBHttpTool post:PERSONAL_NEWPHONE2 params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            TR_Message(@"绑定手机成功");
            [Singleton shareInstance].userInfo  = [[UserInfo alloc]initWithDictionary:responseObj[@"result"][@"user"] error:nil];
            [Singleton shareInstance].userInfo.ticket = responseObj[@"result"][@"ticket"];
            [self setUserlogin];
            [self back];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}


//点击验证码
-(void)verificationaction:(UIButton *)sender{
    //点击验证 先判断是否输入了手机号
    if (self.userNameTextField.text.length == 11 && [self.userNameTextField.text isMobileNumber]) {
        //输入了手机号
        sender.userInteractionEnabled = NO;
        sender.alpha = 0.5;
        [sender setTitle:[NSString stringWithFormat:@"等待%lds",timecount] forState:UIControlStateNormal];
        NSString *type  = self.isFormWX ? @"3":@"1";
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeButtonState:) userInfo:nil repeats:YES];
            //注册验证码
                        [HBHttpTool post:PERSONAL_VERIFITION params:@{@"phone":self.userNameTextField.text,@"type":type,@"Device-Id":DeviceID} success:^(id responseObj) {
                            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                                
                                TR_Message(@"验证码发送成功");
                            }else{
                                TR_Message(responseObj[@"errorMsg"]);
                            }
            
                        } failure:^(NSError *error) {
                            
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


-(void) setUserlogin {
    
    if ([Singleton shareInstance].userInfo) {
        
        NSString *jsstr=[[Singleton shareInstance].userInfo toJSONString];
        
        [USERDEFAULTS setObject:jsstr forKey:@"userinfo"];
        SetUser_Login_State(YES);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDtataUserMessage" object:nil];
    }
    
}


-(void)back{
//    if (self.isFormWX) {
//        TR_Message(@"请先绑定手机号,以免影响后续功能");
//        return;
//    }
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
