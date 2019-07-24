//
//  ModifyAddressViewController.m
//  送小宝
//
//  Created by xgy on 2017/3/13.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ModifyAddressViewController.h"
#import "ModifyAdresslocationView.h"
#import "ChangeAddressViewController.h"

@interface ModifyAddressViewController ()

@property (nonatomic, strong) UITextField *nametext;

@property (nonatomic, strong) UITextField *phonetext;

@property (nonatomic, strong) UITextField *adresstext;

@property (nonatomic, strong) UIButton * determineBtn;

@property (nonatomic, strong) UIButton * deleteBtn;

@property (nonatomic, strong) ModifyAdresslocationView *addressloaction;

@property (nonatomic, assign) CLLocationCoordinate2D mycoorPiot;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) NSString *sexstr;

@property (nonatomic, strong) NSString *oftenStr;

@end

@implementation ModifyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    _oftenStr=@"";
    
    _sexstr=@"1";
   
    self.isBackBtn=YES;
    
    [self.backbtn setImage:[UIImage imageNamed:@"root_backArrow"] forState:UIControlStateNormal];
   
    self.topBackView.backgroundColor=[UIColor whiteColor];
    
    self.topImageView.backgroundColor=[UIColor whiteColor];
    
    self.mtitlelabel.textColor=[UIColor blackColor];
    
    self.titleName=_mtitlename;

    
    _mycoorPiot=(CLLocationCoordinate2D){[_lat doubleValue],[_lng doubleValue]};
    
    self.view.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0,self.superY+10,SCREEN_WIDTH,330)];
   
    backview.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:backview];
    
    _backView=backview;
    
    UILabel *leftlabel1=[[UILabel alloc]initWithFrame:CGRectMake(10,10,100,40)];
    
    leftlabel1.textAlignment=NSTextAlignmentLeft;
    leftlabel1.text=@"联系人:";
    leftlabel1.font=[UIFont systemFontOfSize:15];
    leftlabel1.textColor=TR_COLOR_RGBACOLOR_A(26,26,26,1);
    [backview addSubview:leftlabel1];
    
    _nametext =[[UITextField alloc]initWithFrame:CGRectMake(leftlabel1.frame.origin.x+leftlabel1.frame.size.width,leftlabel1.frame.origin.y,SCREEN_WIDTH-(leftlabel1.frame.origin.x+leftlabel1.frame.size.width),40)];
    _nametext.textAlignment=NSTextAlignmentLeft;
    _nametext.textColor=TR_COLOR_RGBACOLOR_A(26,26,26,1);
    _nametext.font=[UIFont systemFontOfSize:15];
    [backview addSubview:_nametext];
    
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(_nametext.frame.origin.x,_nametext.frame.origin.y+_nametext.frame.size.height,_nametext.frame.size.width,1)];
    line1.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
    
    [backview addSubview:line1];
    
    UIButton *manbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [manbtn setImage:[UIImage imageNamed:@"address_selectRound"] forState:UIControlStateNormal];
 manbtn.frame=CGRectMake(_nametext.frame.origin.x,line1.frame.origin.y+line1.frame.size.height+10,20,20);
     manbtn.tag=3000;
    [manbtn addTarget:self action:@selector(sexbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:manbtn];
    
    UILabel *tiplabel=[[UILabel alloc]initWithFrame:CGRectMake(manbtn.frame.origin.x+manbtn.frame.size.width+5,manbtn.frame.origin.y,40,20)];
    tiplabel.textAlignment=NSTextAlignmentLeft;
    tiplabel.text=@"先生";
    tiplabel.font=[UIFont systemFontOfSize:15];
    tiplabel.textColor=TR_COLOR_RGBACOLOR_A(26,26,26,1);
    [backview addSubview:tiplabel];
    
    UIButton *ldbtn=[UIButton buttonWithType:UIButtonTypeCustom];
 ldbtn.frame=CGRectMake(tiplabel.frame.origin.x+tiplabel.frame.size.width+40,manbtn.frame.origin.y,20,20);
    ldbtn.tag=3001;
    [ldbtn setImage:[UIImage imageNamed:@"address_emtyRound"] forState:UIControlStateNormal];

    [ldbtn addTarget:self action:@selector(sexbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:ldbtn];
    
    UILabel *tip2=[[UILabel alloc]initWithFrame:CGRectMake(ldbtn.frame.origin.x+ldbtn.frame.size.width+5,manbtn.frame.origin.y,40,20)];
    tip2.text=@"女士";
    tip2.textColor=TR_COLOR_RGBACOLOR_A(26,26,26,1);
    tip2.font=[UIFont systemFontOfSize:15];
    [backview addSubview:tip2];
    
    UIView *line5=[[UIView alloc]initWithFrame:CGRectMake(_nametext.frame.origin.x,tip2.frame.origin.y+tip2.frame.size.height+5,_nametext.frame.size.width,1)];
    line5.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
    
    [backview addSubview:line5];
    
    UILabel *leftlabel2=[[UILabel alloc]initWithFrame:CGRectMake(10,line5.frame.origin.y+line5.frame.size.height,100,40)];
    leftlabel2.textAlignment=NSTextAlignmentLeft;
    leftlabel2.text=@"联系电话:";
    leftlabel2.font=[UIFont systemFontOfSize:15];
    [backview addSubview:leftlabel2];
    
    _phonetext=[[UITextField alloc]initWithFrame:CGRectMake(leftlabel2.frame.origin.x+leftlabel2.frame.size.width,leftlabel2.frame.origin.y,_nametext.frame.size.width,40)];
    
    _phonetext.textAlignment=NSTextAlignmentLeft;
    _phonetext.keyboardType=UIKeyboardTypePhonePad;
    _phonetext.textColor=TR_COLOR_RGBACOLOR_A(26,26,26,1);
    _phonetext.font=[UIFont systemFontOfSize:15];
    [backview addSubview:_phonetext];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(_phonetext.frame.origin.x,_phonetext.frame.origin.y+_phonetext.frame.size.height,line1.frame.size.width,1)];
    line2.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
    
    [backview addSubview:line2];
    
    UILabel *leftlabel3=[[UILabel alloc]initWithFrame:CGRectMake(10,line2.frame.origin.y+line2.frame.size.height,100,40)];
    leftlabel3.textAlignment=NSTextAlignmentLeft;
    leftlabel3.textColor=TR_COLOR_RGBACOLOR_A(26,26,26,1);
    [backview addSubview:leftlabel3];
    leftlabel3.font=[UIFont systemFontOfSize:15];
    leftlabel3.text=@"收货地址:";
    
    ModifyAdresslocationView *locationview=[[ModifyAdresslocationView alloc]initWithFrame:CGRectMake(leftlabel3.frame.origin.x+leftlabel3.frame.size.width,leftlabel3.frame.origin.y,_phonetext.frame.size.width,40)];
    [locationview addTarget:self action:@selector(changeAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:locationview];

    locationview.locationlabel.text=APP_Delegate.addressName;

    _addressloaction=locationview;

    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(locationview.frame.origin.x,locationview.frame.origin.y+locationview.frame.size.height,locationview.frame.size.width,1)];
    line3.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
    
    [backview addSubview:line3];
    
    UILabel *leftlabel4=[[UILabel alloc]initWithFrame:CGRectMake(10,line3.frame.origin.y+line3.frame.size.height,100,40)];
    leftlabel4.textAlignment=NSTextAlignmentLeft;
    
    [backview addSubview:leftlabel4];
    
    leftlabel4.text=@"门牌号:";
    leftlabel4.font=[UIFont systemFontOfSize:15];
    _adresstext=[[UITextField alloc]initWithFrame:CGRectMake(leftlabel4.frame.origin.x+leftlabel4.frame.size.width,leftlabel4.frame.origin.y,SCREEN_WIDTH-leftlabel4.frame.origin.x-leftlabel4.frame.size.width,40)];
    _adresstext.textAlignment=NSTextAlignmentLeft;
    _adresstext.font=[UIFont systemFontOfSize:15];
    [backview addSubview:_adresstext];
    
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(line3.frame.origin.x,_adresstext.frame.origin.y+_adresstext.frame.size.height,line3.frame.size.width,1)];
    line4.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
    [backview addSubview:line4];
    
    UILabel *leftlabel5=[[UILabel alloc]initWithFrame:CGRectMake(leftlabel4.frame.origin.x,line4.frame.origin.y+line4.frame.size.height+10,120,30)];
    leftlabel5.text=@"设为常用地址:";
    leftlabel5.font=[UIFont systemFontOfSize:15];
    [backview addSubview:leftlabel5];
    
    NSArray *arrbtn=@[@"家",@"公司",@"学校"];
    
    for (int i=0; i<arrbtn.count;i++) {
        
        NSString *str=arrbtn[i];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(leftlabel5.frame.origin.x+leftlabel5.frame.size.width+i*70, leftlabel5.frame.origin.y+5,55,20);
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tipsbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:TR_COLOR_RGBACOLOR_A(26,26,26,1) forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        btn.layer.borderColor=TR_COLOR_RGBACOLOR_A(26,26,26,1).CGColor;
        btn.tag=2000+i;
        btn.layer.borderWidth=1;
        btn.layer.masksToBounds=YES;
        [backview addSubview:btn];
    
    }
    
    
    if (_isNewAdress) {
        
        _nametext.placeholder=@"请输入您姓名";
        
        _phonetext.placeholder=@"请输入您的联系方式";
        
        _adresstext.placeholder=@"比如: 单元,楼号,楼层";
        
        _mycoorPiot=APP_Delegate.mylocation;
        
    }
    
    if (_model) {
        
        _nametext.text=_model.name;
        
        locationview.locationlabel.text=_model.adress;
      
        _phonetext.text=_model.phone;
       
        _adresstext.text=_model.detail;
        
        _mycoorPiot=(CLLocationCoordinate2D){[_model.lat doubleValue],[_model.lng doubleValue]};
        
        if ([_model.sex integerValue]==1) {
            
            UIButton *button=[_backView viewWithTag:3000];
            [self sexbtnclick:button];
        }else{
            
            UIButton *button=[_backView viewWithTag:3001];
            [self sexbtnclick:button];


        }
        if (_model.often_label.length!=0) {
            
            NSInteger num=[arrbtn indexOfObject:_model.often_label];
            
            UIButton *btn=[_backView viewWithTag:2000+num];
            
            [self tipsbtnclick:btn];
        }
  }
    
    _determineBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _determineBtn.frame=CGRectMake(15,backview.frame.size.height-55,SCREEN_WIDTH- 30,40);
    
    [_determineBtn setTitle:@"保存地址" forState:UIControlStateNormal];
    [_determineBtn setTitleColor:TR_COLOR_RGBACOLOR_A(26,26,26,1) forState:UIControlStateNormal];
    _determineBtn.backgroundColor=TR_COLOR_RGBACOLOR_A(244,167,111,1);
    
    _determineBtn.layer.cornerRadius=5;
    
    _determineBtn.layer.masksToBounds=YES;
    
    [_determineBtn addTarget:self action:@selector(deterbtnclick:) forControlEvents:UIControlEventTouchUpInside];
   
    [backview addSubview:_determineBtn];
    
    _deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _deleteBtn.frame=CGRectMake(SCREEN_WIDTH-50,5,40,20);
    
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    [_deleteBtn setTitleColor:TR_COLOR_RGBACOLOR_A(254,60,0,1) forState:UIControlStateNormal];
    
    _deleteBtn.backgroundColor=[UIColor clearColor];
    
//    _deleteBtn.layer.borderColor=TR_COLOR_RGBACOLOR_A(254,60, 0, 1).CGColor;
//
//    _deleteBtn.layer.borderWidth=1;
//
//    _deleteBtn.layer.cornerRadius=10;
//
//    _deleteBtn.layer.masksToBounds=YES;
//
    [_deleteBtn addTarget:self action:@selector(deletebtnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topImageView addSubview:_deleteBtn];
    
    _deleteBtn.hidden=_isNewAdress;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_nametext resignFirstResponder];
    
    [_phonetext resignFirstResponder];
    
    [_adresstext resignFirstResponder];
    
}


- (void) changeAddressBtnClick:(UIButton *) button {

    __weak typeof(self) weakSelf=self;
    
    ChangeAddressViewController *changeVC=[[ChangeAddressViewController alloc]init];
    
    if (!_isNewAdress) {

        changeVC.lat=_lat;
        changeVC.lng=_lng;
        
    }

    changeVC.adressName=_addressloaction.locationlabel.text;

    changeVC.addressblck=^(NSString *addressstr,CLLocationCoordinate2D l_pt) {

        __strong typeof(weakSelf) strongSelf=weakSelf;

        strongSelf.addressloaction.locationlabel.text=addressstr;

        strongSelf.mycoorPiot=l_pt;
    };

    [self.navigationController pushViewController:changeVC animated:YES];

}



- (void) deterbtnclick:(UIButton *) button {
    
    
    
        if (_mycoorPiot.latitude==0&&_mycoorPiot.longitude==0) {
            
            TR_Message(@"请正确填写位置信息");
            
            return;
        }
        
        if (_phonetext.text.length==0||_nametext.text==0||_addressloaction.locationlabel.text.length==0) {

            TR_Message(@"请正确填写地址信息");

            return;
        }
    
    if (_adresstext.text.length==0) {
        TR_Message(@"请填写详细地址");
         return;
    }
        
        if (_phonetext.text.length!=11) {
            
            TR_Message(@"请正确填写手机号码");
            
            return;
            
        }
    
        if (_sexstr.length==0) {
        
            TR_Message(@"请选择性别");
            return;
        }
        
        NSString *lat=[NSString stringWithFormat:@"%f",_mycoorPiot.latitude];
        
        NSString *lng=[NSString stringWithFormat:@"%f",_mycoorPiot.longitude];
        
//        NSString *addresstext=[NSString stringWithFormat:@"%@/%@",_addressloaction.locationlabel.text,_adresstext.text];
    
    NSDictionary *dict=nil;
    
        if (_isNewAdress) {
            dict= @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"adress":_addressloaction.locationlabel.text,@"detail":_adresstext.text,@"latitude":lat,@"longitude":lng,@"name":_nametext.text,@"phone":_phonetext.text,@"sex":_sexstr,@"often_label":_oftenStr};
        }else{
            dict= @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"adress_id":_model.adress_id,@"adress":_addressloaction.locationlabel.text,@"detail":_adresstext.text,@"latitude":lat,@"longitude":lng,@"name":_nametext.text,@"phone":_phonetext.text,@"sex":_sexstr,@"often_label":_oftenStr};
        }
    
    
        [HBHttpTool post:SHOP_ADDDRESS params:dict success:^(id responseDic){


            if (responseDic) {

                NSDictionary *dataDict=responseDic;

                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {


                    TR_Message(@"保存成功");

                }else{

                    TR_Message(@"保存失败");

                }

                dispatch_async(dispatch_get_main_queue(), ^{

                    [self back];

                });

            }

        }failure:^(NSError *error){

            NSLog(@"%@",error);
        }];

}


- (void) deletebtnclick:(UIButton *) button {

    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除该地址" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertview show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==1) {
       
        [HBHttpTool post:SHOP_DELADRESS params:@{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"adress_id":_model.adress_id} success:^(id responseDic){


            if (responseDic) {

                NSDictionary *dataDict=responseDic;

                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                    
                    TR_Message(@"删除成功");
                }else{
                    
                    TR_Message([dataDict objectForKey:@"errorMsg"]);
                }


                dispatch_async(dispatch_get_main_queue(), ^{

                    [self back];
                });

            }

        }failure:^(NSError *error){

            NSLog(@"%@",error);
        }];

    }
    
    
    
}



-(void)back {
    
    if (self.resourceType) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) sexbtnclick:(UIButton *) sexbtn {
    
    if (sexbtn.tag==3000) {
        
        UIButton *btn=[_backView viewWithTag:3001];
        
        [sexbtn setImage:[UIImage imageNamed:@"address_selectRound"] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageNamed:@"address_emtyRound"] forState:UIControlStateNormal];
        _sexstr=@"1";
    }
    
    if (sexbtn.tag==3001) {
        
        UIButton *btn=[_backView viewWithTag:3000];
        
        [sexbtn setImage:[UIImage imageNamed:@"address_selectRound"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"address_emtyRound"] forState:UIControlStateNormal];
        _sexstr=@"2";
    }
    
    
}


- (void)tipsbtnclick:(UIButton *)button {
    
    _oftenStr=button.titleLabel.text;
    
    if (button.tag==2000) {
        
        UIButton *btn= [_backView viewWithTag:2001];
        
        UIButton *btn1= [_backView viewWithTag:2002];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=TR_COLOR_RGBACOLOR_A(249,155,97,1);
        button.layer.borderColor=TR_COLOR_RGBACOLOR_A(249,155,97,1).CGColor;
        
        btn.layer.borderColor=[UIColor blackColor].CGColor;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn1.layer.borderColor=[UIColor blackColor].CGColor;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn1.backgroundColor=[UIColor whiteColor];
        
    }
    
    if (button.tag==2001) {
        
        UIButton *btn= [_backView viewWithTag:2000];
        
        UIButton *btn1= [_backView viewWithTag:2002];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=TR_COLOR_RGBACOLOR_A(249,155,97,1);
        button.layer.borderColor=TR_COLOR_RGBACOLOR_A(249,155,97,1).CGColor;
        
        btn.layer.borderColor=[UIColor blackColor].CGColor;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn1.layer.borderColor=[UIColor blackColor].CGColor;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn1.backgroundColor=[UIColor whiteColor];
        
    }
    
    if (button.tag==2002) {
        
        UIButton *btn= [_backView viewWithTag:2000];
        
        UIButton *btn1= [_backView viewWithTag:2001];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=TR_COLOR_RGBACOLOR_A(249,155,97,1);
        button.layer.borderColor=TR_COLOR_RGBACOLOR_A(249,155,97,1).CGColor;
        
        btn.layer.borderColor=[UIColor blackColor].CGColor;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn1.layer.borderColor=[UIColor blackColor].CGColor;
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor whiteColor];
        btn1.backgroundColor=[UIColor whiteColor];
        
    }
    
    
    
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
