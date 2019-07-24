//
//  OrderManagementViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/5.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "OrderManagerCell.h"
#import "OrderMapDetailsViewController.h"
#import "OrderListModel.h"
#import "MJRefresh.h"
#import "PayMyOrderView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "OrderManagerEvaluationViewController.h"
#import "BusinessViewController.h"
#import "MyRefreshOrderHeader.h"
#import "LogInViewController.h"




@interface OrderManagementViewController ()<UITableViewDelegate,UITableViewDataSource,OrderManagerCelldelegate,PayMyOrderViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *mdataArray;

@property (nonatomic, strong) PayMyOrderView *paymyOrderView;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) UIView *mybackView;

@property (nonatomic, strong)UIView *notworkBackView;

@property (nonatomic, strong)UIView *nouserBackView;

@property (nonatomic, strong)UIView *noOrderBackView;

@property (nonatomic, strong)NSString *selectOrid;


@end

@implementation OrderManagementViewController

- (void)loadNotworkdata {
    
    if (!_notworkBackView) {
        CGFloat height=self.superY;
        
        CGFloat bheight=44;
        
        UIImage *notimg=[UIImage imageNamed:@"norwork_pic"];
        
        _notworkBackView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-height-bheight)];
        _notworkBackView.backgroundColor=[UIColor whiteColor];
        
        [_mytableView addSubview:_notworkBackView];
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-notimg.size.width/2,200,notimg.size.width, notimg.size.height)];
        imgview.image=notimg;
        
        [_notworkBackView addSubview:imgview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, imgview.frame.origin.y+imgview.frame.size.height+15,SCREEN_WIDTH,20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=TR_TEXTGrayCOLOR;
        label.font=[UIFont systemFontOfSize:14];
        label.text=@"网络太调皮,点击刷新下看看...";
        
        [_notworkBackView addSubview:label];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapactionwork)];
        [_notworkBackView addGestureRecognizer:tap];
    }
    _mytableView.mj_header.hidden=YES;

    _notworkBackView.hidden=NO;
    
}

-(void)tapactionwork {
    
    if (TR_IsNetWork) {
        _notworkBackView.hidden=YES;
     
        _mytableView.mj_header.hidden=NO;
      
        [self loadAndRefreshData];
     
    }else
        TR_Message(@"暂无网络请查看系统设置");
}


- (void)loadnotUserdata {
    
    if (!_nouserBackView) {
     
        CGFloat height=self.superY;
        
        CGFloat bheight=44;
        
        UIImage *notimg=[UIImage imageNamed:@"no_logionorder"];
        
        _nouserBackView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-height-bheight)];
        _nouserBackView.backgroundColor=[UIColor whiteColor];
        
        [_mytableView addSubview:_nouserBackView];
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-notimg.size.width/2,150,notimg.size.width, notimg.size.height)];
        imgview.image=notimg;
        
        [_nouserBackView addSubview:imgview];
        
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0,imgview.frame.origin.y+imgview.frame.size.height+20,SCREEN_WIDTH, 20)];
        titlelabel.textAlignment=NSTextAlignmentCenter;
        titlelabel.font=[UIFont systemFontOfSize:13];
        titlelabel.textColor=TR_COLOR_RGBACOLOR_A(102,102,102,1);
        titlelabel.text=@"您还没有登录,请登录后查看订单";
        [_nouserBackView addSubview:titlelabel];
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(SCREEN_WIDTH/2-75,titlelabel.frame.origin.y+titlelabel.frame.size.height+15,150,35);
        [btn addTarget:self action:@selector(loginbtnclick:) forControlEvents:UIControlEventTouchUpInside];
       
        [btn setTitle:@"登录/注册" forState:UIControlStateNormal];
        btn.layer.cornerRadius=15;
        btn.backgroundColor=TR_COLOR_RGBACOLOR_A(238,119,51,175);
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_nouserBackView addSubview:btn];
        
    }
   
    _mytableView.mj_header.hidden=YES;
    
    _nouserBackView.hidden=NO;
}


- (void)loadnoOrderdata {
    
    if (!_noOrderBackView) {
       
        CGFloat height=self.superY;
        
        CGFloat bheight=44;
        
        UIImage *notimg=[UIImage imageNamed:@"no_logionorder"];
        
        _noOrderBackView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-height-bheight)];
        _noOrderBackView.backgroundColor=[UIColor whiteColor];
        
        [_mytableView addSubview:_noOrderBackView];
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-notimg.size.width/2,150,notimg.size.width, notimg.size.height)];
        imgview.image=notimg;
        
        [_noOrderBackView addSubview:imgview];
        
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0,imgview.frame.origin.y+imgview.frame.size.height+20,SCREEN_WIDTH, 20)];
        titlelabel.textAlignment=NSTextAlignmentCenter;
        titlelabel.font=[UIFont systemFontOfSize:13];
        titlelabel.textColor=TR_COLOR_RGBACOLOR_A(102,102,102,1);
        titlelabel.text=@"您还没有订单哦,请速去下单吧";
        [_noOrderBackView addSubview:titlelabel];
        
        
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(SCREEN_WIDTH/2-75,titlelabel.frame.origin.y+titlelabel.frame.size.height+15,150,35);
        [btn addTarget:self action:@selector(orderbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:@"去下单" forState:UIControlStateNormal];
        btn.layer.cornerRadius=15;
        btn.backgroundColor=TR_COLOR_RGBACOLOR_A(238,119,51,175);
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_noOrderBackView addSubview:btn];
        
    }
    
    _mytableView.mj_header.hidden=YES;

    _noOrderBackView.hidden=NO;
}


- (void)orderbtnclick:(UIButton *) button {
    
    APP_Delegate.rootViewController.selectedIndex=0;
    
}


- (void) loginbtnclick:(UIButton *) button {
   
    _mytableView.mj_header.hidden=NO;

    LogInViewController *logvc=[[LogInViewController alloc]init];
    [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];

    [self.navigationController pushViewController:logvc animated:YES];
}

-(UITableView *)mytableView {
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
    }
    return _mytableView;
}

-(NSMutableArray *)datasource{
    
    if (_datasource == nil) {
        
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(PayMyOrderView *)paymyOrderView {
    
    if (_paymyOrderView==nil) {
      
        _paymyOrderView=[[PayMyOrderView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,300)];
        _paymyOrderView.delegate=self;
    }
  
    return _paymyOrderView;
}

-(UIView *)mybackView {
    
    if (_mybackView==nil) {
        
        _mybackView = [[UIView alloc]initWithFrame:CGRectMake(0, -50, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mybackView.backgroundColor = [UIColor blackColor];
        _mybackView.userInteractionEnabled = YES;
        _mybackView.alpha = 0.4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaction)];
        [_mybackView addGestureRecognizer:tap];
       
    }
    
    return _mybackView;
}

// 返回操作
-(void)tapaction {
    
    [self.mybackView removeFromSuperview];
    
    [UIView animateWithDuration:ANIMATIONDURATION animations:^{
        
        self.paymyOrderView.frame=CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,300);
        
    }completion:^(BOOL finished) {
        [self.paymyOrderView removeFromSuperview];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.topBackView.backgroundColor=[UIColor whiteColor];
    self.topImageView.backgroundColor=[UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"订单";
    [self.datasource addObjectsFromArray:@[@1,@2,@0,@3,@1,@2,@0,@3,@1,@0]];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
   
    CGFloat height=IS_RETAINING_SCREEN?40:20;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(height);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 4, 40));
    }];
    self.view.backgroundColor=[UIColor whiteColor];
    self.mytableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mytableView];
   // [self.mytableView registerClass:[OrderManagerCell class] forCellReuseIdentifier:@"cell"];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    if (@available(iOS 11.0, *)) {
        self.mytableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        //                _mtableView.contentInset =UIEdgeInsetsMake(0,0,0,0);//64和49自己看效果，是否应该改成0
        //                _mtableView.scrollIndicatorInsets =_mtableView.contentInset;
        self.mytableView.estimatedRowHeight = 0;
        
        self.mytableView.estimatedSectionFooterHeight = 0;
        
        self.mytableView.estimatedSectionHeaderHeight = 0;
    }
    __weak typeof(self) weakSelf = self;

    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.superY-5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-weakSelf.superY-44));
    }];

    // Do any additional setup after loading the view.
    [self addFreshAndGetMoreView];
}

- (void)viewWillAppear:(BOOL)animated {
   
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];

    
    if (GetUser_Login_State) {
    
        _nouserBackView.hidden=YES;
    
        _mytableView.mj_header.hidden=NO;

        [self loadAndRefreshData];
        
    }else{
        
        [self loadnotUserdata];
    }
    
    if (!TR_IsNetWork) {
        
        [self loadNotworkdata];
    }else
        _mytableView.mj_header.hidden=NO;

    
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    
}



#pragma mark -  下拉刷新和上拉加载更多
//添加下拉刷新
-(void)addFreshAndGetMoreView
{
    __weak __typeof(self) weakSelf = self;
    
    MyRefreshOrderHeader*header = [MyRefreshOrderHeader headerWithRefreshingBlock:^{
        
        weakSelf.page=@(1);
        [weakSelf loadData];
        
    }];
    
    _mytableView.mj_header=header;
    // 隐藏时间
 //   header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
  //  header.stateLabel.hidden = YES;
    MyRefreshFooter*foot = [MyRefreshFooter footerWithRefreshingBlock:^{
        
        NSInteger num=[self.page integerValue];
        num++;
        
        weakSelf.page=@(num);
        
        [weakSelf loadData];
    }];
    
    _mytableView.mj_footer=foot;

}


- (void)loadData {
    
    if ([Singleton shareInstance].userInfo) {
        
        [HBHttpTool post:SHOP_ORDERLIST body:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"page":self.page} success:^(id responseDic){
            
            if (responseDic) {
                [_mytableView.mj_footer endRefreshing];
                [_mytableView.mj_header endRefreshing];
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                    
                    NSArray *data=[dataDict objectForKey:@"result"];
                                        
                        if ([self.page integerValue]==1) {
                     
                            _mdataArray=[NSMutableArray arrayWithArray:[OrderListModel arrayOfModelsFromDictionaries:data]];
                            
                            if (_mdataArray.count<6) {
                                [_mytableView.mj_footer endRefreshingWithNoMoreData];

                            }
                            
                        }else{
                            
                            [_mdataArray addObjectsFromArray:[OrderListModel arrayOfModelsFromDictionaries:data]];
                        }
                    if (data.count==0) {
                        [_mytableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [_mytableView reloadData];
                    });
                    
                }
            }
            
        }failure:^(NSError *error){
            
            [_mytableView.mj_footer endRefreshing];
            
            [_mytableView.mj_header endRefreshing];
        }];
    }
    
    
    
}


-(void)loadAndRefreshData {
    
    if ([Singleton shareInstance].userInfo) {
        
        self.page=@(1);
        [HBHttpTool post:SHOP_ORDERLIST params:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"page":self.page} success:^(id responseDic){
            [_mytableView.mj_footer endRefreshing];
            
            [_mytableView.mj_header endRefreshing];
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                    
                    NSArray *data=[dataDict objectForKey:@"result"];
                    
                    
                    _mdataArray=[NSMutableArray arrayWithArray:[OrderListModel arrayOfModelsFromDictionaries:data]];
                    
                    if (_mdataArray.count<6) {
                        [_mytableView.mj_footer endRefreshingWithNoMoreData];
                        
                    }
                    if (data.count==0) {
                        [_mytableView.mj_footer endRefreshingWithNoMoreData];
                        [self loadnoOrderdata];
                    }else{
                        _noOrderBackView.hidden=YES;
                        _mytableView.mj_header.hidden=NO;

                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [_mytableView reloadData];
                    });
                    
                }
            }
            
        }failure:^(NSError *error){
            
        }];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _mdataArray.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_mdataArray&&_mdataArray.count!=0) {
        if (indexPath.row<_mdataArray.count) {

        OrderListModel *model=_mdataArray[indexPath.row];
      
        NSInteger count=model.goods_list.count>=3?3:model.goods_list.count;
        
        OrderStateItem *stateItem=[model.status firstObject];
       
        return [self heightwithState:stateItem.status]+count*25;
        }else
            return 0;
    }return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    static NSString *cellID =@"cell";
    OrderManagerCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[OrderManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.backgroundColor=[UIColor whiteColor];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(nextstore:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.busphoto);
            make.right.mas_equalTo(cell.titleLabel);
            make.top.mas_equalTo(cell.busphoto);
            make.height.mas_equalTo(40);
        }];
    }
    
    if (_mdataArray&&_mdataArray.count!=0) {
        if (indexPath.row<_mdataArray.count) {
            OrderListModel *model=_mdataArray[indexPath.row];
            
            OrderStateItem *stateItem=[model.status firstObject];
            
            [cell setOrderState:stateItem.status andOrderModel:model];
            
            cell.stateLabel.text = stateItem.status_des;
            
        }
     
   
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    OrderMapDetailsViewController *orderMapVC=[[OrderMapDetailsViewController alloc]init];
  
    OrderListModel *model=_mdataArray[indexPath.row];

    [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
    
    orderMapVC.orderId=model.order_id;
    
    if ([model.deliver_type isEqualToString:@"0"]) {
        
//        if (model.deliver_place) {
//            
//            if ([model.deliver_place[@"lines"] isKindOfClass:[NSDictionary class]]) {
//                
//                NSDictionary *dict=model.deliver_place[@"lines"];
//                
//                double lat=[dict[@"lat"] doubleValue];
//                
//                double lng=[dict[@"lng"] doubleValue];
//                
//                CLLocationCoordinate2D qscoor=CLLocationCoordinate2DMake(lat,lng);
//                
//                orderMapVC.qscoor=qscoor;
//                
//            }
//        }
        OrderStateItem *stateItem=[model.status firstObject];
        orderMapVC.state=stateItem.status;
        [self.navigationController pushViewController:orderMapVC animated:YES];
        
    }
    
    
    if ([model.deliver_type isEqualToString:@"1"]) {
        
        OrderStateItem *stateItem=[model.status firstObject];
        orderMapVC.state=stateItem.status;
        
        [self.navigationController pushViewController:orderMapVC animated:YES];
        
    }
    
    
}


- (CGFloat )heightwithState:(NSString *)state {
    
    if ([state integerValue]==4||[state integerValue]==3||[state integerValue]==5) {
        
        return 155+10;
        
    }else if ([state integerValue]==1||[state integerValue]==2){
        
        return 155+10;
        
    }else{
        
        return 155+10;
    }
}


-(void)orderManagerCell:(OrderManagerCell *)cell selectOrderModel:(OrderListModel *)model andclickbtn:(UIButton *)clickbtn {
    
    if ([clickbtn.titleLabel.text isEqualToString:@"再来一单"]) {
        
        BusinessViewController *bussinewVC=[[BusinessViewController alloc]init];

        bussinewVC.storeID=model.store_id;
        bussinewVC.orderid=model.order_id;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:ORDERTYPE];
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        [self.navigationController pushViewController:bussinewVC animated:YES];
        
    }
    
    if ([clickbtn.titleLabel.text isEqualToString:@"去支付"]) {
      
        _orderId=model.order_id;
      
        [self confirmOrderMessageOrder:model.order_id andGreattime:model.create_time];
     
    }
    
    if ([clickbtn.titleLabel.text isEqualToString:@"取消订单"]) {
        if (clickbtn.tag==90000) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确定取消订单操作吗?" message:@"" delegate:self cancelButtonTitle:@"取消订单" otherButtonTitles:@"不取消", nil];
            [alert show];
            _selectOrid=model.order_id;
        }
        
    }
    
    if ([clickbtn.titleLabel.text isEqualToString:@"评价晒单"]) {
       
        OrderManagerEvaluationViewController *managerVC=[[OrderManagerEvaluationViewController alloc]init];
        managerVC.model=model;
        
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        [self.navigationController pushViewController:managerVC animated:YES];
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex==0) {
        [HBHttpTool post:SHOP_CANCELORDER body:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_selectOrid} success:^(id responseDic){
            
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        TR_Message([dataDict objectForKey:@"result"]);
                        self.page=@(1);
                        [self loadData];
                    });
                    
                }else
                    TR_Message([dataDict objectForKey:@"errorMsg"]);
                
                
            }
            
        }failure:^(NSError *error){
            
        }];
    }
    
}

//保存订单成功后  确认订单信息

-(void)confirmOrderMessageOrder:(NSString *)order_id andGreattime:(NSString *)time{
  
    if (_orderId.length == 0) {
        
        return;
    }
    
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"app_type":@"1",@"app_version":@"200",@"order_id":order_id,@"system_coupon_id":@"2",@"type":@"shop"};
    
    [HBHttpTool post:SHOP_CONFIRMORDER params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"]isEqualToString:@"success"]) {
            
            NSLog(@"%@",responseObj);
            //确认价格  有没有算错  如果有出入  以服务器返回为准
            NSString* returnTotolPrice = responseObj[@"result"][@"order_info"][@"order_total_money"];
          
            NSString* pay_method = responseObj[@"result"][@"pay_method"];
      
            
            dispatch_async(dispatch_get_main_queue(), ^{
             
                [self.paymyOrderView loadMinusStarTime:time];
                
                [APP_Delegate.window addSubview:self.mybackView];
              
                [APP_Delegate.window addSubview:self.paymyOrderView];
               
                self.paymyOrderView.frame=CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,300);

                [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                   
                    NSLog(@"%f",self.paymyOrderView.frame.origin.y);
                    NSLog(@"%f",SCREEN_HEIGHT);

                    self.paymyOrderView.frame=CGRectMake(0,SCREEN_HEIGHT-300,SCREEN_WIDTH,300);
                    
                    NSLog(@"%f",self.paymyOrderView.frame.origin.y);
               
                }completion:^(BOOL finished) {
                    
                }];
                [self.paymyOrderView designViewWithdatasour:@[returnTotolPrice]];
            });
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}



//点击确定支付
-(void)clickReturnToTop {
    
    [self tapaction];
}

-(void)clickPayMyOrder:(NSString *)payType {
    
    if ([payType isEqualToString:@"weixin"]) {
        //微信支付
        if (_orderId.length == 0) {
            
            return;
        }
        
        if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
            
            TR_Message(@"请先安装微信");
            
            return;
        }
    }
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"app_version":@"200",@"order_id":_orderId,@"pay_type":payType,@"system_coupon_id":@"",@"order_type":@"shop"};
    
    [HBHttpTool post:SHOP_PAYORDERBYWX params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            if ([payType isEqualToString:@"weixin"]) {
                
                [self sendWxPayWithDic:responseObj[@"result"][@"weixin_param"]];
            }
            
            if ([payType isEqualToString:@"alipay"]) {
                
                [self paryOrderWithAlipay:responseObj[@"result"]];
            }
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}




#pragma mark - 支付宝支付

-(void)paryOrderWithAlipay:(NSDictionary *)dict{
    
    //支付宝支付
    NSString *appScheme = @"dianbeiwaimai";//在info中urltypes中添加一条并设置Scheme 这样支付宝才能返回到当前应用中
    [[AlipaySDK defaultService] payOrder:dict[@"alipay"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
        if (resultDic) {
            
            if ([statusStr isEqualToString:@"9000"]) {
                
                //TR_Message(@"付款成功");
                // [self wxPayOrderSuccess:nil];
                
                return ;
            }else if([statusStr isEqualToString:@"6001"]) {
                
                //  TR_Message(@"付款失败🤷‍♀️");
                
                return ;
            }else {
                
                // TR_Message(@"付款失败🤷‍♀️");
                
                return ;
            }
        }else{
            
            // TR_Message(@"支付宝打开失败");
            return;
            
        }
        
        
    }];
    [self.paymyOrderView removeFromSuperview];
    [self.mybackView removeFromSuperview];
}


#pragma mark - 微信支付

- (void)sendWxPayWithDic:(NSDictionary *)dict; {
    
  
    //调起微信支付
    
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [dict objectForKey:@"appid"];
    req.partnerId           = [dict objectForKey:@"mch_id"];
    req.prepayId            = [dict objectForKey:@"prepay_id"];
    req.nonceStr            = [dict objectForKey:@"nonce_str"];
    req.timeStamp           = [[dict objectForKey:@"timestamp"] intValue];
    req.package             = @"Sign=WXPay";
    req.sign                = [dict objectForKey:@"sign2"];

    [WXApi sendReq:req];
    
    [self.paymyOrderView removeFromSuperview];
    [self.mybackView removeFromSuperview];
}



- (void)nextstore:(UIButton *)button {
    
    NSIndexPath *indexpath=[_mytableView indexPathForCell:(OrderManagerCell*)button.superview];
    if (_mdataArray.count!=0) {
        OrderListModel *model=_mdataArray[indexpath.row];
        
        if (model) {
            BusinessViewController *bvc=[[BusinessViewController alloc]init];
            bvc.storeID=model.store_id;
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
            [self.navigationController pushViewController:bvc animated:YES];
            
        }
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
