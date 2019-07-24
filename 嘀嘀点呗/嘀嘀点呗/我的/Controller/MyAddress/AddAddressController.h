//
//  AddAddressController.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

//地址添加  修改地址后 定义方法  我的地址界面刷新界面
@protocol AddAddressControllerDelegate<NSObject>
-(void)startnetwork;
@end




@interface AddAddressController : UIViewController
@property(nonatomic)NSInteger sexnumber;
@property(nonatomic,strong)UIView *bottomV;
@property(nonatomic,copy)NSString *titleString;
@property(nonatomic,strong)AddressModel *model;
//2:声明delegate属性存储代理人对象
@property (nonatomic, assign)id<AddAddressControllerDelegate>delegate;
@end
