//
//  AddAddressController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "AddAddressController.h"
#import "AddressModel.h"
#define SpareWidth 10
@interface AddAddressController ()

@end

@implementation AddAddressController
{
    NSArray *titleArray;
    NSArray *contentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    self.view.backgroundColor = GRAYCLOLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"下拉"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(returntopView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self designview];
    // Do any additional setup after loading the view.
}

//布局界面
-(void)designview {
    //该页面有两种情况  一种是修改地址  一种是添加地址
    __weak typeof(self) weakSelf = self;
    titleArray = @[@"联系人",@"手机号",@"",@"收货地址",@"门牌号"];
    contentArray=@[@"请填写收货人姓名",@"请填写收货人手机号",@"",@"点击选择",@"详细地址，方便骑士更快送餐"];
    
    if (self.model) {
      contentArray = @[self.model.name,self.model.phone,@"",self.model.adress,self.model.detail];
    }
    
    
    CGFloat titleWidth = 40 ;
    
    for (int i = 0 ; i < 5 ; i ++ ) {
        self.bottomV = [[UIView alloc]init];
        self.bottomV.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.bottomV];
        [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(titleWidth * i + SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, titleWidth));
        }];
        
        UIView *lineView= [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [self.bottomV addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(titleWidth - 1);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
        }];
        
        if (i != 2) {
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.text = titleArray[i];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.backgroundColor = [UIColor whiteColor];
            [self.bottomV addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SpareWidth * 1.5);
                make.top.mas_equalTo(SpareWidth / 2);
                make.size.mas_equalTo(CGSizeMake(60, 30));
            }];
            
            if (i != 3) {
                UITextField *contentField = [[UITextField alloc]init];
                if (self.model) {
                    contentField.text = contentArray[i];
                }else {
                    contentField.placeholder = contentArray[i];
                }
                contentField.textColor = [UIColor blackColor];
                contentField.backgroundColor = [UIColor whiteColor];
                contentField.textAlignment = NSTextAlignmentLeft;
                contentField.font = [UIFont systemFontOfSize:13];
                contentField.tag = 1000 + i;
                [self.bottomV addSubview:contentField];
                [contentField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(titleLabel.mas_right).offset(SpareWidth * 2);
                    make.centerY.mas_equalTo(titleLabel.mas_centerY);
                    make.size.mas_equalTo(CGSizeMake(150, 30));
                }];
                if (i == 1) {
                    contentField.keyboardType = UIKeyboardTypeNumberPad;
                }
            }else if (i == 3) {

                UILabel *contentLabel = [[UILabel alloc]init];
                if (self.model) {
                    contentLabel.textColor = [UIColor blackColor];
                }else {
                 contentLabel.textColor = TR_COLOR_RGBACOLOR_A(212, 212, 216, 1);
                }
                contentLabel.text = contentArray[i];
                contentLabel.textAlignment = NSTextAlignmentLeft;
                contentLabel.numberOfLines = 0;
                contentLabel.tag = 1000 + i;
                contentLabel.text = @"杭州萧山";
                contentLabel.font = [UIFont systemFontOfSize:13];
                contentLabel.backgroundColor = [UIColor whiteColor];
                [self.bottomV addSubview:contentLabel];
                [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(titleLabel.mas_right).offset(SpareWidth * 2);
                    make.centerY.mas_equalTo(titleLabel.mas_centerY);
                    make.size.mas_equalTo(CGSizeMake(150, 30));
                }];
                
                
                UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [locationBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
                locationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                locationBtn.backgroundColor = [UIColor whiteColor];
                [locationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                locationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                [_bottomV addSubview:locationBtn];
                [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo( - SpareWidth);
                    make.centerY.mas_equalTo(contentLabel.mas_centerY);
                    make.size.mas_equalTo(CGSizeMake(20, 10));
                }];
            }
          
        }else if (i == 2 ){
            UIButton *sexBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            sexBtn1.backgroundColor = [UIColor whiteColor];
            [sexBtn1 setTitle:@"先生" forState:UIControlStateNormal];
            [sexBtn1 setImage:[UIImage imageNamed:@"选中"] forState: UIControlStateSelected];
             [sexBtn1 setImage:[UIImage imageNamed:@"未选中"] forState: UIControlStateNormal];
            [sexBtn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [sexBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            sexBtn1.tag = 601;
            self.sexnumber = sexBtn1.tag;
            [sexBtn1 addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
            sexBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
            sexBtn1.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.bottomV addSubview:sexBtn1];
            [sexBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(85);
                make.top.mas_equalTo(SpareWidth);
                make.size.mas_equalTo(CGSizeMake(70, 30));
            }];
            
            UIButton *sexBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            sexBtn2.backgroundColor = [UIColor whiteColor];
            [sexBtn2 setTitle:@"女士" forState:UIControlStateNormal];
            [sexBtn2 setImage:[UIImage imageNamed:@"选中"] forState: UIControlStateSelected];
            [sexBtn2 setImage:[UIImage imageNamed:@"未选中"] forState: UIControlStateNormal];
            [sexBtn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
            [sexBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            sexBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
            sexBtn2.titleLabel.textAlignment = NSTextAlignmentCenter;
            sexBtn2.tag = 602;
             [sexBtn2 addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomV addSubview:sexBtn2];
            [sexBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(sexBtn1.mas_right);
                make.top.mas_equalTo(SpareWidth);
                make.size.mas_equalTo(CGSizeMake(70, 30));
            }];
            //修改地址界面  根据传入的性别修改
            if ([self.titleString isEqualToString:@"修改地址"]) {
                if ([self.model.zipcode isEqualToString:@"0"]) {
                    sexBtn1.selected = YES;
                    self.sexnumber = sexBtn1.tag;
                }else {
                    sexBtn2.selected = YES;
                    self.sexnumber = sexBtn2.tag;
                }
            }else {
                //添加地址界面  默认先生
                sexBtn1.selected = YES;
                self.sexnumber = sexBtn1.tag;
            }
        }
    }
    
    //如果是修改地址 改变视图布局
    if ([self.titleString isEqualToString:@"修改地址"]) {
        UIImage *image = [UIImage imageNamed:@"垃圾桶"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(delteAddress)];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        
        UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reportBtn setTitle:@"提交"forState:UIControlStateNormal];
        [reportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        reportBtn.backgroundColor = TR_COLOR_RGBACOLOR_A(220,93,65,1);
        reportBtn.layer.cornerRadius = 5.0f;
        reportBtn.layer.masksToBounds = YES;
        [reportBtn addTarget:self action:@selector(handleReportAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:reportBtn];
        [reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(weakSelf.bottomV.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 30));
        }];
    }
    
    
    //如果是添加地址
    if ([self.title isEqualToString:@"添加地址"]) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [[UIImage imageNamed:@"确定"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [rightBtn setImage:image forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(reportAddress) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
}


//修改已经有的地址
-(void)handleReportAction {
    //获取填写的数据
    __weak typeof(self) weakSelf = self;
    AddressModel *model = [self getListData];
    if (model.name.length > 0 &&
        model.phone.length == 11 &&
        model.adress.length > 0 &&
        model.zipcode.length > 0
        ) {
        [HBHttpTool post:PERSONAL_EDIT_ADRESS params:@{
                                                       @"ticket":[Singleton shareInstance].userInfo.ticket,
                                                       @"Device-Id":DeviceID,
                                                       @"adress":model.adress,
                                                       @"default":@"0",
                                                       @"detail":model.detail,
                                                       @"latitude":@"30.241274",
                                                       @"longitude":@"120.25727",
                                                       @"name":model.name,
                                                       @"phone":model.phone,
                                                       @"zipcode":model.zipcode,
                                                       @"adress_id":model.adress_id
                                                       }
                 success:^(id responseObj) {
                     if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                         TR_Message(@"修改地址成功");
                         if ([weakSelf.delegate respondsToSelector:@selector(startnetwork)]) {
                             [weakSelf.delegate startnetwork];
                     }
                 }
            }
                 failure:^(NSError *error) {
                     TR_Message(@"添加失败请检查网络");
                 }];
    }
   
}


//点击删除地址
-(void)delteAddress {
    __weak typeof(self) weakSelf = self;
    UIAlertController *tempC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该地址吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //网络请求删除该地址
        [HBHttpTool post:PERSONAL_DELADRESS params:@{
                                                     @"ticket":[Singleton shareInstance].userInfo.ticket,
                                                     @"Device-Id":DeviceID,
                                                     @"adress_id":self.model.adress_id} success:^(id responseObj) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        } failure:^(NSError *error) {
            
        }];
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [tempC addAction:action];
    [tempC addAction:action1];
    [self presentViewController:tempC animated:YES completion:nil];
}

-(void)chooseSex:(UIButton *)sender {
    if (sender.tag != self.sexnumber) {
        UIButton *btn = (UIButton *)[self.view.superview viewWithTag:self.sexnumber];
        btn.selected = !btn.selected;
        sender.selected = !sender.selected;
       self.sexnumber = sender.tag;
    }
    
   
}

// 提交保存地址操作 非修改地址
-(void)reportAddress {
    //获取填写的数据
    __weak typeof(self) weakSelf = self;
    AddressModel *model = [self getListData];
    if (model.name.length > 0 &&
        model.phone.length == 11 &&
        model.adress.length > 0 &&
        model.zipcode.length > 0
        ) {
        [HBHttpTool post:PERSONAL_EDIT_ADRESS params:@{
        @"ticket":[Singleton shareInstance].userInfo.ticket,
        @"Device-Id":DeviceID,
        @"adress":model.adress,
        @"detail":model.detail,
        @"latitude":@"30.241274",
        @"longitude":@"120.257272",
        @"name":model.name,
        @"phone":model.phone,
        @"zipcode":model.zipcode
                              }
        success:^(id responseObj) {
            NSLog(@"errorMsg = %@",responseObj[@"errorMsg"]);
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            TR_Message(@"添加地址成功");
            
            if ([weakSelf.delegate respondsToSelector:@selector(startnetwork)]) {
                [weakSelf.delegate startnetwork];
                
            }
                                  }
                                                       }
                 failure:^(NSError *error) {
                   TR_Message(@"添加失败请检查网络");
                                                       }];
    }
    
}

//定义方法 获取表中的数据
-(AddressModel *)getListData {
    AddressModel *model = [[AddressModel alloc]init];
    if ([self.titleString isEqualToString:@"修改地址"]) {
        model = self.model;
    }
    
    //获取姓名
    UITextField *nameT = [self.view.superview viewWithTag:1000];
    NSString *nameS = nameT.text;
    model.name = nameS;
    //手机号
    UITextField *phoneT = [self.view.superview viewWithTag:1001];
    NSString *phoneS = phoneT.text;
    model.phone = phoneS;
    //收货地址
    UILabel *addressL = [self.view.superview viewWithTag:1003];
     model.adress = addressL.text;
   //model.adress = @"博地中心";
    //门牌号
    UITextField *gateT = [self.view.superview viewWithTag:1004];
    NSString *gateS = gateT.text;
    model.detail = gateS;
    //性别
    
    if (self.sexnumber == 601) {
        model.zipcode = @"0";
    }
    if (self.sexnumber == 602) {
        model.zipcode = @"1";
    }
    NSLog(@"%@,%@,%@,%@",model.name,model.phone,model.adress_id,model.zipcode);
    return model;
}




-(void)returntopView{
    [self.navigationController popViewControllerAnimated:YES];
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
