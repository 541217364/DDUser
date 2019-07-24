//
//  ChangeUserPasswordView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/3.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuccessChangeUserPassword<NSObject>

-(void)changeUserPasswordSuccess:(NSString *)originPassword withNewPass:(NSString *)newPassword;

@end


@interface ChangeUserPasswordView : UIView

@property(nonatomic,strong)NSString *originPassword;

@property(nonatomic,assign)id <SuccessChangeUserPassword> delegate;
@end
