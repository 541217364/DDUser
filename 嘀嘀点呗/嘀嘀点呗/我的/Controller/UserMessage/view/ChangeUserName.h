//
//  ChangeUserName.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SuccessChangeUserName<NSObject>

-(void)changeUserNameSuccesswithNewUserName:(NSString *)newUserName;

@end


@interface ChangeUserName : UIView

@property(nonatomic,assign)NSString *userName;

@property(nonatomic,strong)UITextField *userNameTextField;

@property(nonatomic,strong)id<SuccessChangeUserName>delegate;

@end
