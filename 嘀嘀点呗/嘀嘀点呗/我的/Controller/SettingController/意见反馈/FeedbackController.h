//
//  FeedbackController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShareUI.h"

@interface FeedbackController : ShareVC<UITextViewDelegate>

@property(nonatomic,strong)UITextField *userNameTextField;

@property(nonatomic,strong)UITextField *feedBackTypeField;

@property(nonatomic,strong)UITextView *descripTextView;

@property(nonatomic,strong)UIImageView *feedImageView;

@end
