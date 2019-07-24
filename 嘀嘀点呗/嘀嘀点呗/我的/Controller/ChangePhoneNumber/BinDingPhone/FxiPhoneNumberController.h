//
//  FxiPhoneNumberController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShareUI.h"

@interface FxiPhoneNumberController : ShareVC

@property(nonatomic,strong)UITextField *userNameTextField;

@property(nonatomic,strong)UITextField *userPasswordField;

@property(nonatomic,strong)UIButton *VerificationBtn;

@property(nonatomic)BOOL  isFormWX;

@end
