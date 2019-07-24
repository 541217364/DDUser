//
//  FeedbackController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "FeedbackController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
#import  <MobileCoreServices/MobileCoreServices.h>
#define  SpareWidth 10
@interface FeedbackController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation FeedbackController
{
    NSArray *contentArray;
    
    UIImagePickerController *_controller;
    
    NSString *statusStr;
    
}
-(UITextField *)userNameTextField {
    if (_userNameTextField == nil) {
        _userNameTextField = [[UITextField alloc]init];
        _userNameTextField.backgroundColor = [UIColor whiteColor];
        _userNameTextField.placeholder = @"你的邮箱或手机号";
        _userNameTextField.textColor = [UIColor blackColor];
        _userNameTextField.font = TR_Font_Gray(14);
        _userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _userNameTextField;
}

-(UITextField *)feedBackTypeField {
    if (_feedBackTypeField == nil) {
        _feedBackTypeField = [[UITextField alloc]init];
        _feedBackTypeField = [[UITextField alloc]init];
        _feedBackTypeField.placeholder = @"选择反馈类型";
        _feedBackTypeField.font = TR_Font_Gray(14);
        _feedBackTypeField.userInteractionEnabled = YES;
        _feedBackTypeField.textColor = [UIColor blackColor];
        _feedBackTypeField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _feedBackTypeField;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isBackBtn = YES;
    self.view.userInteractionEnabled = YES;
    contentArray = @[@"账号相关",@"界面及订单操作",@"订单,支付及退款",@"物流配送",@"商家,及餐品质量",@"其他",@"取消"];
    [self designView];
    // Do any additional setup after loading the view.
}


//布局界面
-(void)designView {
    __weak typeof(self) weakSelf = self;
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.text = @"联系方式";
    CGSize size = TR_TEXT_SIZE(phoneLabel.text, phoneLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SCREEN_HEIGHT / 6);
        make.size.mas_equalTo(CGSizeMake(size.width + 20, 30));
    }];
    
  
    
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_right).offset(SpareWidth);
        make.centerY.mas_equalTo(phoneLabel.mas_centerY);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = GRAYCLOLOR;
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_left);
        make.top.mas_equalTo(weakSelf.userNameTextField.mas_bottom).offset(5);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    
    UILabel *verifiLabel = [[UILabel alloc]init];
    
    verifiLabel.textColor = [UIColor blackColor];
    verifiLabel.text = @"反馈类型";
    verifiLabel.textAlignment = NSTextAlignmentLeft;
    
    verifiLabel.font = [UIFont systemFontOfSize:15];
    verifiLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:verifiLabel];
    [verifiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(2 * SpareWidth);
        make.size.mas_equalTo(CGSizeMake(size.width + 20, 30));
    }];
    
    UIImageView *typeimage = [[UIImageView alloc]init];
    typeimage.image = [UIImage imageNamed:@"shop_down"];
    [self.view addSubview:typeimage];

    [typeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- SpareWidth);
        make.centerY.mas_equalTo(verifiLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 10));
    }];
    
   
    
    
    
    [self.view addSubview:self.feedBackTypeField];
    [self.feedBackTypeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userNameTextField.mas_left);
        make.centerY.mas_equalTo(verifiLabel.mas_centerY);
        make.right.mas_equalTo(typeimage.mas_left);
        make.height.mas_equalTo(weakSelf.userNameTextField.mas_height);
        
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = GRAYCLOLOR;
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_left);
        make.top.mas_equalTo(weakSelf.feedBackTypeField.mas_bottom).offset(5);
        make.right.mas_equalTo(-SpareWidth);
        make.height.mas_equalTo(1);
    }];
    
    UIView *tapView = [[UIView alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseFeedBackType:)];
    
    [tapView addGestureRecognizer:tap];
    [self.view addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.feedBackTypeField.mas_left);
        make.top.mas_equalTo(weakSelf.feedBackTypeField.mas_top);
        make.right.mas_equalTo(-SpareWidth);
        make.bottom.mas_equalTo(lineView2.mas_top);
        
    }];
    
    
    
    self.descripTextView = [[UITextView alloc]init];
    self.descripTextView.text = @"补充更多信息以便我们帮你更好处理(必填)";
    self.descripTextView.delegate = self;
    self.descripTextView.textColor = [UIColor grayColor];
    self.descripTextView.backgroundColor = GRAYCLOLOR;
    self.descripTextView.layer.cornerRadius = 1.0f;
    self.descripTextView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.descripTextView];
    [self.descripTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(lineView2.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 150));
        
    }];
    
    
    self.feedImageView = [[UIImageView alloc]init];
    self.feedImageView.image = [UIImage imageNamed:@"comment_photo"];
    self.feedImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapimage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImgaeAction)];
    [self.feedImageView addGestureRecognizer:tapimage];
    [self.view addSubview:self.feedImageView];
    
    [self.feedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
    make.top.mas_equalTo(weakSelf.descripTextView.mas_bottom).offset(SpareWidth);
      
    make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];
    
    
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    loginBtn.backgroundColor = ORANGECOLOR;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginVicification) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(weakSelf.feedImageView.mas_bottom).offset(2 * SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 40));
    }];
    
}









//选择反馈类型
-(void)chooseFeedBackType:(UIButton *)sender{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < contentArray.count; i ++) {
        UIAlertAction *tempAction = [UIAlertAction actionWithTitle:contentArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (i != contentArray.count -1) {
                 self.feedBackTypeField.text = contentArray[i];
            }
           
           
        }];
        [tempAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
       
        [alter addAction:tempAction];

    }
    
    [self presentViewController:alter animated:YES completion:nil];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}








- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"补充更多信息以便我们帮你更好处理(必填)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        textView.text = @"补充更多信息以便我们帮你更好处理(必填)";
        textView.textColor = [UIColor grayColor];
    }
    
    
}





-(void)loginVicification{
    
    if (!GetUser_Login_State) {
        TR_Message(@"请先登录");
        return;
    }
    
    if (self.userNameTextField.text.length == 0) {
        TR_Message(@"请输出手机号或邮箱");
        return;
    }
    
    if (self.feedBackTypeField.text.length == 0) {
        
        TR_Message(@"请输出反馈类型");
        
        return;
    }
    
    NSString *decpText = [self.descripTextView.text isEqualToString:@"补充更多信息以便我们帮你更好处理(必填)"] ? @"":self.descripTextView.text;
    
   
    
    
    NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"emailphone":self.userNameTextField.text,@"comment":self.descripTextView.text,@"class":decpText};
    
    
    [HBHttpTool post:PERSONAL_SUGGESS params:body success:^(id responseObj) {
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            TR_Message(@"反馈成功");
            [self back];
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
        
    } failure:^(NSError *error) {
      
        
        
    }];
}





-(void)chooseImgaeAction{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *imagesourece = @[@"图库",@"相机"];
    
    for (int i = 0; i < imagesourece.count; i ++) {
        UIAlertAction *tempAction = [UIAlertAction actionWithTitle:imagesourece[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (i != imagesourece.count) {
                
                if (i == 0) {
                    
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
                }
                
                if (i == 1) {
                    
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
                }
            
            }
            
            
        }];
        [tempAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
        
        [alter addAction:tempAction];
        
    }
    
    [self presentViewController:alter animated:YES completion:nil];
    
}





-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.feedImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    return;
    // 在此处理图片将图片上传到服务器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSData *tempData = UIImageJPEGRepresentation(image, 0.2f);
    //3. 图片二进制文件
    NSLog(@"upload image size: %ld k", (long)(tempData.length / 1024));
    //上传图片
    __weak typeof(self) weakSelf = self;
    [HBHttpTool post:ORDERCOMMENR_AVATAR params:@{
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




//上传图片成功后存储地址
-(void)saveIMageFile:(id)responseObj {
    
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
