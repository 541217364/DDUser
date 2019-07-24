//
//  PersonalMessageController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PersonalMessageController.h"
#import "PersonalMessageCell.h"
#import "ChangeUserPhoneNumberController.h"
#import  <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
#import "UIImageView+WebCache.h"
#import "WXApiManager.h"
#import "UIAlertView+WX.h"
#import "WXApiRequestHandler.h"
#import "Constant.h"
#import "WechatAuthSDK.h"
#import "WeixinModel.h"

#define  SpareWidth 10
@interface PersonalMessageController ()<SuccessChangeUserPassword,SuccessChangeUserName,UIAlertViewDelegate,WXApiManagerDelegate>

@end

@implementation PersonalMessageController

{
    NSArray *titleArray;
    NSArray *contentArray;
    NSString *imageUrl;
}

-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.backgroundColor = [UIColor whiteColor];
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _mytableView;
}


-(UIView *)changeUserNameView{
    if (_changeUserNameView == nil) {
        _changeUserNameView = [[ChangeUserName alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * SpareWidth, 150)];
        _changeUserNameView.backgroundColor = [UIColor whiteColor];
        _changeUserNameView.center = self.view.center;
        _changeUserNameView.hidden = YES;
        _changeUserNameView.delegate = self;
        [APP_Delegate.window addSubview:_changeUserNameView];
    }
    return _changeUserNameView;
}


-(ChangeUserPasswordView *)changeUserPassword{
    if (_changeUserPassword == nil) {
        _changeUserPassword = [[ChangeUserPasswordView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * SpareWidth, 300)];
        _changeUserPassword.backgroundColor = [UIColor whiteColor];
        _changeUserPassword.center = CGPointMake(self.view.center.x, self.view.center.y  - 50);
        _changeUserPassword.hidden = YES;
        _changeUserPassword.delegate = self;
        _changeUserPassword.originPassword = @"123";
        [APP_Delegate.window addSubview:_changeUserPassword];
    }
    return _changeUserPassword;
}

-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]initWithFrame:self.view.bounds];
        _hideView.backgroundColor = [UIColor clearColor];
        _hideView.userInteractionEnabled = YES;
        [self.view addSubview:_hideView];
        _hideView.hidden = YES;
    }
    return _hideView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"账户管理";
    self.view.backgroundColor = GRAYCLOLOR;
    self.isBackBtn = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weiixnloginsuccess:) name:@"weixinloginsuccess" object:nil];
    [self.view addSubview:self.mytableView];
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(HeightForNagivationBarAndStatusBar + SpareWidth);
        make.bottom.mas_equalTo(HOME_INDICATOR_HEIGHT);
    }];
    
    titleArray = @[@"头像",@"用户名",@"手机号",@"微信号"];
    NSString *imageUrl = [Singleton shareInstance].userInfo.avatar;
    NSString *userName = [Singleton shareInstance].userInfo.nickname;
    NSString *userphone = [Singleton shareInstance].userInfo.phone;
    NSString *userweixin;
    
    if ([Singleton shareInstance].userInfo.app_openid.length > 0 ) {
        userweixin = @"解绑";
        
    }else{
        userweixin = @"未绑定";
        
    }
    contentArray = @[imageUrl,userName,userphone,userweixin];
    

    // Do any additional setup after loading the view.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[PersonalMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell desginCellWithIndexpath:indexPath];
    cell.userNameLabel.text = titleArray[indexPath.row];
    cell.contentLabel.text = contentArray[indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 80;
    }
    return 60;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        ChangeUserPhoneNumberController *tempVC = [[ChangeUserPhoneNumberController alloc]init];
        
        [self.navigationController pushViewController:tempVC animated:YES];
    }
    
    
    if (indexPath.row == 0) {
        [self pickImageAndTakePhotos];
}

    if (indexPath.row == 1) {
        //修改账号
        if (self.changeUserNameView.hidden) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.changeUserNameView.hidden = NO;
                self.hideView.hidden = NO;
                self.view.superview.backgroundColor = [UIColor blackColor];
                self.view.alpha = TR_Alpha;
            }];
        }
        
    }
    
//    if (indexPath.row == 2) {
//        if (self.changeUserPassword.hidden) {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.changeUserPassword.hidden = NO;
//                self.hideView.hidden = NO;
//                self.view.superview.backgroundColor = [UIColor blackColor];
//                self.view.alpha = TR_Alpha;
//            }];
//        }
//    }
    
    if (indexPath.row == 3) {
        
        if ([Singleton shareInstance].userInfo.app_openid.length == 0) {
            
            UIAlertView *alterView2 = [[UIAlertView alloc]initWithTitle:@"微信绑定" message:@"确定绑定微信吗？" delegate:self cancelButtonTitle:@"绑定" otherButtonTitles:@"取消", nil];
            alterView2.tag = 205;
            [alterView2 show];
            return;
            
        }
        
        UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"微信解绑" message:@"确定解除微信账号的绑定吗？" delegate:self cancelButtonTitle:@"暂不解除" otherButtonTitles:@"解除绑定", nil];
        alterView.tag = 200;
        [alterView show];
    }
    
}







#pragma mark  微信相关

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    
    if (buttonIndex == 1 && alertView.tag == 200) {
        //解除绑定微信
         NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID};
        [HBHttpTool post:PERSONAL_DELETEWEIXIN params:body success:^(id responseObj) {
            
            TR_Message(@"解除微信绑定成功");
            PersonalMessageCell *cell = [self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.contentLabel.text = @"未绑定";
            [Singleton shareInstance].userInfo.app_openid = @"";
            NSString *jsstring = [[Singleton shareInstance].userInfo toJSONString];
            [USERDEFAULTS setObject:jsstring forKey:@"userinfo"];
            
        } failure:^(NSError *error) {
            
        }];
       
    }
    
    
    if (buttonIndex == 0 && alertView.tag == 205) {
        
        [WXApiManager sharedManager].delegate = self;
        SendAuthReq* req =[[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req];
    }
}






-(void)weiixnloginsuccess:(NSNotification *)sender{
    
    SendAuthResp *object = sender.object;
    NSString * codeStr = object.code;
    
    if (codeStr.length > 0) {
        
        NSDictionary *body = @{@"code":codeStr,@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket};
        
        [HBHttpTool post:PERSONAL_BULDWX params:body success:^(id responseObj) {
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                
                TR_Message(@"绑定成功");
                PersonalMessageCell *cell = [self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                cell.contentLabel.text = @"已绑定";
                [Singleton shareInstance].userInfo.app_openid = @"1111";
                [self setUserlogin];
              
            }else{
                
                TR_Message(responseObj[@"errorMsg"]);
                
            }
            
        } failure:^(NSError *error) {
            
        }];
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


//隐藏视图

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    if (!self.changeUserNameView.hidden) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.changeUserNameView.hidden = YES;
            self.hideView.hidden = YES;
            self.view.superview.backgroundColor = [UIColor clearColor];
            self.view.alpha = 1;
        }];
    }
    
    
    if (!self.changeUserPassword.hidden) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.changeUserPassword.hidden = YES;
            self.hideView.hidden = YES;
            self.view.superview.backgroundColor = [UIColor clearColor];
            self.view.alpha = 1;
        }];
    }
}




#pragma mark 修改用户信息的代理

-(void)changeUserPasswordSuccess:(NSString *)originPassword withNewPass:(NSString *)newPassword{
    
    TR_Message(@"修改密码成功");
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.changeUserPassword.hidden = YES;
        self.hideView.hidden = YES;
        self.view.superview.backgroundColor = [UIColor clearColor];
        self.view.alpha = 1;
    }];
    
}

-(void)changeUserNameSuccesswithNewUserName:(NSString *)newUserName{
    
    //修改昵称操作
    
    
    if (newUserName.length > 16) {
        TR_Message(@"用户名过长");
        return;
    }
    
    if (newUserName.length < 4) {
        TR_Message(@"用户名过短");
        return;
    }
    
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.changeUserNameView.hidden = YES;
        self.hideView.hidden = YES;
        self.view.superview.backgroundColor = [UIColor clearColor];
        self.view.alpha = 1;
    }];
    
    NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"nickname":newUserName};
    
    [HBHttpTool post:PERSONAL_NICNAME params:body success:^(id responseObj) {
       if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            TR_Message(@"修改用户名成功");
           PersonalMessageCell *cell = [self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
           cell.contentLabel.text = newUserName;
           [Singleton shareInstance].userInfo.nickname = newUserName;
           NSString *jsstring = [[Singleton shareInstance].userInfo toJSONString];
          [USERDEFAULTS setObject:jsstring forKey:@"userinfo"];
           [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDtataUserMessage" object:nil];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
   
    
   
}



//照片选择 与拍照

-(void)pickImageAndTakePhotos{
    //选择头像
    
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册中选取
        if ([self isPhotoLibraryAvailable]) {
            
            if (_controller == nil) {
                _controller = [[UIImagePickerController alloc] init];
                _controller.delegate = self;
            }
            _controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            _controller.mediaTypes = mediaTypes;
            
            _controller.allowsEditing = YES;
            [self isPhotoJurisdiction];
        }
        
        
    }];
    [alertC addAction:action];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            if (_controller == nil) {
               _controller = [[UIImagePickerController alloc] init];
            }
            
            _controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                _controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            _controller.mediaTypes = mediaTypes;
            _controller.delegate = self;
            _controller.allowsEditing = YES;
            [self isCameraJurisdiction];

        }
        
    }];
    
    [alertC addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action2];
    
    [self  presentViewController:alertC animated:YES completion:nil];

}





//判断相册时候有权限
- (void)isPhotoJurisdiction {
    //相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"此应用没有权限访问您的照片或视频。您可以到“隐私设置中”启用访问。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alerView.tag = 111;
        [alerView show];
    }else {
        statusStr = @"相册";
        [self presentViewController:_controller animated:YES completion:nil];
    }
}


//判断相机是否有权限
- (void)isCameraJurisdiction {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"应用未开启相机权限，请到iPhone设置-隐私-相机中开启" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alerView.tag = 112;
        [alerView show];
    }else {
        statusStr = @"相机";
        [self  presentViewController:_controller animated:YES completion:nil];
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取用户选择照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    PersonalMessageCell *cell = [self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.userImage.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 在此处理图片将图片上传到服务器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSData *tempData = UIImageJPEGRepresentation(image, 0.2f);
    //3. 图片二进制文件
    NSLog(@"upload image size: %ld k", (long)(tempData.length / 1024));
    //上传图片
    __weak typeof(self) weakSelf = self;
    [HBHttpTool post:PERSONAL_AVATAR params:@{
                                               @"Device-Id":DeviceID,
                                               @"ticket":[Singleton shareInstance].userInfo.ticket,
                                               @"file":@"file"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                   NSData * imageData = tempData;
                                                   // 上传filename
                                                   NSString * fileName = [NSString stringWithFormat:@"%@.jpg", currentTime];
                                                   [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                                               } success:^(id responseObj) {
                                                   if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                                                       [weakSelf saveIMageFile:responseObj];
                                                   }
                                                   
                                               } failure:^(NSError *error) {
                                                   NSLog(@"%@",error);
                                               }];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}





//上传图片成功后存储地址
-(void)saveIMageFile:(id)responseObj {
  
    imageUrl = responseObj[@"result"][@"url"];
    [Singleton shareInstance].userInfo.avatar = imageUrl;
    NSString *jsstring = [[Singleton shareInstance].userInfo toJSONString];
    [USERDEFAULTS setObject:jsstring forKey:@"userinfo"];
    TR_Message(@"头像设置成功");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDtataUserMessage" object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}












#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}



- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}


- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}


- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}




-(void)dealloc{
    
    [self.changeUserNameView removeFromSuperview];
    self.changeUserNameView.delegate = nil;
     self.changeUserNameView = nil;
    
    [self.changeUserPassword removeFromSuperview];
    self.changeUserPassword.delegate = nil;
    self.changeUserPassword = nil;
    
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
