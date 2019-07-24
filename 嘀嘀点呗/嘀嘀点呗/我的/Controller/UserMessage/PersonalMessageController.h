//
//  PersonalMessageController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShareUI.h"
#import "ChangeUserName.h"
#import "ChangeUserPasswordView.h"
@interface PersonalMessageController : ShareVC <UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_controller;
    
     NSString *statusStr;
}
@property(nonatomic,strong)UITableView *mytableView;

@property(nonatomic,strong)ChangeUserName *changeUserNameView;

@property(nonatomic,strong)ChangeUserPasswordView *changeUserPassword;

@property(nonatomic,strong)UIView *hideView;

@end
