//
//  OrderMapDetailsViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/4.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "OrderMapDetailsViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "RiderModel.h"
#import "OrderDetailsModel.h"
#import "StoreDetailsModel.h"
#import "OrderTrackingView.h"
#import "PayMyOrderView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"

#define LimitHeight self.superY+10

@interface OrderMapDetailsViewController ()<BMKMapViewDelegate, BMKRouteSearchDelegate,UIAlertViewDelegate,PayMyOrderViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKRouteSearch *routesearch;

@property (nonatomic, strong) UIScrollView *mscrollView;

@property (nonatomic, strong) UIView *detailView;

@property (nonatomic, strong) UIView *lineview;

@property (nonatomic, assign) CGPoint orgPoint;

@property (nonatomic, assign) CGFloat offsety;

@property (nonatomic, strong) RiderModel *riderModel;

@property (nonatomic, assign) CGFloat load_PointY;

@property (nonatomic, strong) OrderDetailsModel *detailsModel;

@property (nonatomic, strong) NSArray *goodsArray;

@property (nonatomic, strong) NSString *storeImg;

@property (nonatomic, strong) UIButton *exitbtn;

@property (nonatomic, strong)  NSTimer *timer;

@property (nonatomic, strong)  NSTimer *remainTimer;

@property (nonatomic, strong)  UILabel *qsStatelabel;

@property (nonatomic, strong)  UIImageView *qsHeadPic;

@property (nonatomic, strong)  UIButton *qscallBtn;

@property (nonatomic, strong)  UIButton *qsnamebtn;

@property (nonatomic, assign)  CGFloat startpointY;

@property (nonatomic, strong)  NSString *storename;

@property (nonatomic, strong)  NSString *deliver_distance;

@property (nonatomic, strong)  NSArray *storeIphones;

@property (nonatomic, strong)  NSArray *discounDetails;

@property (nonatomic, strong)  NSArray *staus;

@property (nonatomic, strong)  UILabel *remainTimelabel;

@property (nonatomic, strong) PayMyOrderView *paymyOrderView;

@property (nonatomic, strong) UIView *mybackView;

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation OrderMapDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=TR_COLOR_RGBACOLOR_A(245,245,245,1);
    
    self.topBackView.hidden=YES;
    
    [self  setUpUI];
    
   // [self loadDetailsView];
    
    [self loadDetailData];
    
}

-(void)setUpUI{
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    //设置为卫星地图
    [_mapView setMapType:BMKMapTypeSatellite];
    //设置为普通地图,系统默认为普通地图
    [_mapView setMapType:BMKMapTypeStandard];
    
    _mapView.minZoomLevel=10;
    
    _mapView.maxZoomLevel=20;
    
    _mapView.zoomLevel=15;

    [_mapView setBaiduHeatMapEnabled:NO];
    
    _mapView.zoomEnabled =YES;
    _mapView.hidden = YES;
    
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    
    
    if ([_state integerValue]==2||[_state integerValue]==3||[_state integerValue]==4||[_state integerValue]==5) {
        
        self.topImageView.hidden=YES;
        
        _startpointY=SCREEN_HEIGHT-210;
        
        _exitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _exitbtn.frame=CGRectMake(20,30,30,30);
        [_exitbtn setImage:[UIImage imageNamed:@"orderexitbtn_pic"] forState:UIControlStateNormal];
        [_exitbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_exitbtn];
        
        if ([_state integerValue]!=2) {
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(loadQsData) userInfo:nil repeats:YES];
            _timer=timer;
            [timer fire];
            
        }
        
        
    }else{
        self.topImageView.backgroundColor=[UIColor clearColor];
        self.titleName=@"订单详情";
        self.isBackBtn=YES;
        _startpointY=self.superY+10;
    }
    
    if ([_state integerValue] == 0) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back) name:@"WXPAYORDERSUCCESS" object:nil];
    }
    
}


- (void)back {
    
    if (_mybackView) {
        
        [_mybackView removeFromSuperview];
        
        _mybackView = nil;
        
    }
    
    if (_paymyOrderView == nil) {
        
        [_paymyOrderView removeFromSuperview];
        
        _paymyOrderView = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _mapView.delegate=self;
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    displayParam.locationViewOffsetX=0;//定位偏移量(经度)
    displayParam.locationViewOffsetY=0;//定位偏移量（纬度）
    displayParam.isAccuracyCircleShow=NO;//经度圈是否显示
    //这里替换自己的图标路径，必须把图片放到百度地图SDK的Resources/mapapi.bundle/images 下面
    //还有一种方法就是获取到_locationView之后直接设置图片
    displayParam.locationViewImgName=@"xx";
    
    [_mapView updateLocationViewWithParam:displayParam];
    
}







- (void)loadStoreAndBuyerInMap {
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    BMKPointAnnotation * pointsh=[[BMKPointAnnotation alloc]init];
    
    pointsh.coordinate=_storecoor;
    
    pointsh.title=@"商户";
    
    [_mapView addAnnotation:pointsh];
    
    BMKPointAnnotation * pointbuyer=[[BMKPointAnnotation alloc]init];
    
    pointbuyer.coordinate=_buyercoor;
    
    pointbuyer.title=@"用户";
    
    [_mapView addAnnotation:pointbuyer];
    
    _mapView.centerCoordinate=_storecoor;
    
    BMKPointAnnotation * mypoint=[[BMKPointAnnotation alloc]init];
    
    mypoint.coordinate=_qscoor;
    
    mypoint.title=@"骑士";
    
    [_mapView addAnnotation:mypoint];
    
    if ([_state isEqualToString:@"2"]) {
        _mapView.centerCoordinate = _storecoor;
    }else{
        
        if (_qscoor.longitude!=0&&_qscoor.latitude!=0) {
            
            _mapView.centerCoordinate=_qscoor;
            
        }
        
    }
    
    
    if ([_state isEqualToString:@"0"]) {
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(transfromTime) userInfo:nil repeats:YES];
        _remainTimer=timer;
        
        [timer fire];
    }
    
}



-(void)transfromTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:_detailsModel.create_time];
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue]; //支付时间戳
    
    
    NSDate *datenow = [NSDate date];
    
    NSInteger currentTimeString =  (long)[datenow timeIntervalSince1970]; //当前时间戳
    
    
    
    NSInteger timeshort = currentTimeString - timeSp;
    
    _remainTimelabel.hidden = NO;
    
    if (timeshort > 60 * 15) {
        
        //超时未支付 ，  后台删除单子
        
        timeshort = timeshort - 60 * 15;
        
        NSInteger hour = timeshort / 3600;
        
        NSInteger min  = timeshort % 3600 / 60 ;
        
        NSInteger sec  = timeshort % 3600 % 60 ;
        
        
        if (hour > 0) {
            
            _remainTimelabel.attributedText = [self setText3:[NSString stringWithFormat:@"超时 %ld:%02ld:%02ld",hour,min,sec] andText3:[NSString stringWithFormat:@"%ld:%02ld:%02ld",hour,min,sec]];
            
        }else{
            
            if (min > 0) {
                
                _remainTimelabel.attributedText = [self setText3:[NSString stringWithFormat:@"超时 %ld:%02ld",min,sec] andText3:[NSString stringWithFormat:@"%ld:%02ld",min,sec]];
                
            }else{
                
                _remainTimelabel.attributedText = [self setText3:[NSString stringWithFormat:@"超时 %ld",sec] andText3:[NSString stringWithFormat:@"%ld",sec]];
            }
        }
        
    }else{
        
        //未超时
        
        NSInteger remainTime = 60 * 15 - timeshort;
        
        NSInteger min = remainTime / 60 ;
        
        NSInteger sec = remainTime % 60 ;
        
        
        if (min > 0) {
            
            _remainTimelabel.text = [NSString stringWithFormat:@"%ld:%02ld",min,sec];

            
        }else{
            _remainTimelabel.text = [NSString stringWithFormat:@"%ld",sec];
        }
        
    }
    
    
}


- (void)loadQsData {
    
    [HBHttpTool post:SHOP_QSLINES body:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_orderId} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                
                NSDictionary *data=[dataDict objectForKey:@"result"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self mintueqsMapViewData:data];
                    
                });
                
            }
        }
        
    }failure:^(NSError *error){
        
    }];
}


- (void) loadqsMapViewData:(NSDictionary *)dict  {
    
    NSDictionary *points=dict[@"points"];
    
    NSInteger status=[dict[@"status"] integerValue];
    
    if (points.allKeys.count!=0) {
        
        NSString *qslat=points[@"from_site"][@"lat"];
        NSString *qslng=points[@"from_site"][@"lng"];
        
        CLLocationCoordinate2D qscoor=CLLocationCoordinate2DMake([qslat doubleValue],[qslng doubleValue]);
        
        _qscoor=qscoor;
        
        [self loadStoreAndBuyerInMap];
        
    }
    if (_detailsModel.deliver_log_list.count > 0) {
        
        OrderStateItem *item = [_detailsModel.deliver_log_list firstObject];
        
        _qsStatelabel.text= item.status_des;
        
    }
    
    
    if (status==0) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        //  _qsStatelabel.text=@"等待支付";
        
    }else if (status==1) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        //  _qsStatelabel.text=@"等待商家接单";
    }else if (status==2) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        //  _qsStatelabel.text=@"商家已接单";
    }else if (status==3) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        
        //  _qsStatelabel.text=@"骑士正在赶往商家";
        
    }else if (status==4) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        // _qsStatelabel.text=@"骑士已到店";
        
    }else if (status==5) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        //  _qsStatelabel.text=@"骑士正在送货";
        
    }else if (status==10) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        //  _qsStatelabel.text=@"订单已取消";
        
    }else if (status==9) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        //退款
        //   _qsStatelabel.text=@"订单已取消";
        
    }else{
        
        if (status == 6 || status == 7 || status == 8) {
            
            _qsHeadPic.hidden=YES;
            
            _qscallBtn.hidden=YES;
            
            _qsnamebtn.hidden=YES;
            
            //    _qsStatelabel.text=@"订单已完成";
        }
        
        
    }
    
}



- (void) mintueqsMapViewData:(NSDictionary *)dict  {
    
    NSDictionary *lines=dict[@"lines"];
    
    NSInteger status=[dict[@"status"] integerValue];
    
    if (lines.allKeys.count!=0) {
        
        NSString *qslat=lines[@"lat"];
        NSString *qslng=lines[@"lng"];
        CLLocationCoordinate2D qscoor=CLLocationCoordinate2DMake([qslat doubleValue],[qslng doubleValue]);
        
        _qscoor=qscoor;
        
        _deliver_distance = dict[@"deliver_distance"];
        
        [self loadStoreAndBuyerInMap];
        
    }
    
    if (status==0) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        // _qsStatelabel.text=@"等待支付";
        
    }else if (status==1) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        // _qsStatelabel.text=@"等待商家接单";
    }else if (status==2) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        // _qsStatelabel.text=@"商家已接单";
    }else if (status==3) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        
        // _qsStatelabel.text=@"骑士正在赶往商家";
        
    }else if (status==4) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        // _qsStatelabel.text=@"骑士已到店";
        
    }else if (status==5) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        // _qsStatelabel.text=@"骑士正在送货";
        
    }else if (status==10) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        // _qsStatelabel.text=@"订单已取消";
        
    }else if (status==9) {
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        //退款
        //  _qsStatelabel.text=@"订单已退款";
        
    }else{
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
        // _qsStatelabel.text=@"订单已完成";
        
    }
    
    
    if (_qscoor.longitude != 0 && _qscoor.latitude != 0) {
        
        _qsHeadPic.hidden=NO;
        
        _qscallBtn.hidden=NO;
        
        _qsnamebtn.hidden=NO;
        
        [_qsnamebtn setTitle:_detailsModel.deliver_info[@"name"] forState:UIControlStateNormal];
        
    }else{
        
        _qsHeadPic.hidden=YES;
        
        _qscallBtn.hidden=YES;
        
        _qsnamebtn.hidden=YES;
        
    }
    
}


- (void)loadDetailData {
    
    [HBHttpTool post:SHOP_ORDERDETAILS params:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_orderId} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            NSLog(@"%@",dataDict);
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                
                NSDictionary *dict=[dataDict objectForKey:@"result"];
                
                if (dict) {
                    
                    self->_detailsModel=[[OrderDetailsModel alloc]initWithDictionary:dict[@"order_details"] error:nil];
                    
                    self->_detailsModel.store = [[OrderStoreItem alloc]initWithDictionary:dict[@"store"] error:nil];
                    
                    if ([dict[@"discount_details"] isKindOfClass:[NSArray class]]) {
                        self->_discounDetails=[StoreDetailsdisCount arrayOfModelsFromDictionaries:dict[@"discount_details"]];
                    }
                    
                    
                    NSArray*arry=dict[@"goods"];
                    
                    self->_goodsArray=[StoreDetailsGoodsItem arrayOfModelsFromDictionaries:arry error:nil];
                    
                    NSDictionary *storedict=dict[@"store"];
                    
                    self->_storecoor.latitude=[storedict[@"store_lat"] doubleValue];
                    
                    self->_storecoor.longitude=[storedict[@"store_lng"] doubleValue];
                    
                    self->_buyercoor.latitude=[self->_detailsModel.lat doubleValue];
                    
                    self->_buyercoor.longitude=[self->_detailsModel.lng doubleValue];
                    
                    self->_storeImg=storedict[@"store_image"];
                    
                    self->_storename=storedict[@"store_name"];
                    
                    self->_storeIphones=storedict[@"store_phone"];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    
                    [self loadOrderDatainit];
                    
                    [self loadqsMapViewData:[[self->_detailsModel.deliver_log_list firstObject] toDictionary]];
                    
                    [self loadStoreAndBuyerInMap];
                    
                });
                
            }
        }
        
    }failure:^(NSError *error){
        
    }];
}


-(void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    
    _mapView.delegate = nil; // 不用时，置nil
    
    _routesearch.delegate = nil; // 不用时，置nil
    
    [_timer invalidate];
    
    _timer=nil;
    
    if (_remainTimer) {
        
        [_remainTimer invalidate];
        
        _remainTimer = nil;
    }
}

- (void)dealloc {
    
    if (_routesearch != nil) {
        _routesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

- (BMKAnnotationView*)mapView:(BMKMapView*)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    BMKAnnotationView* view = nil;
    
    BMKPointAnnotation *point=(BMKPointAnnotation*)annotation;
    if (point.coordinate.latitude==_storecoor.latitude&&point.coordinate.longitude==_storecoor.longitude) {
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
        if (view == nil) {
            view = [[BMKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"start_node"];
            view.image = [UIImage imageNamed:@"sh_headpic"];
            view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            view.canShowCallout = TRUE;
            
            //            UIImageView *imgView=[[UIImageView alloc]init];
            //
            //            imgView.frame=CGRectMake(3,2,25,25);
            //            imgView.layer.cornerRadius=12.5;
            //            imgView.layer.masksToBounds=YES;
            
            // [imgView sd_setImageWithURL:[NSURL URLWithString:_storeImg] placeholderImage:[UIImage imageNamed:@"sh_headpic"]];
            
            // [view addSubview:imgView];
            
        }
        
        view.bounds=CGRectMake(0,0,view.frame.size.width*0.8,view.frame.size.height*0.8);
        point.title=@"商家";
        
        view.annotation = point;
        
        return view;
        
    }else if (point.coordinate.longitude==_buyercoor.longitude&&point.coordinate.latitude==_buyercoor.latitude){
        
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
        if (view == nil) {
            view = [[BMKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"end_node"];
            view.image = [UIImage imageNamed:@"nouesr_pic"];
            view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            view.canShowCallout = TRUE;
            
            UIImageView *imgView=[[UIImageView alloc]init];
            
            imgView.frame=CGRectMake(2,1,30,30);
            imgView.layer.cornerRadius=15;
            imgView.layer.masksToBounds=YES;
            [imgView sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"xx"]];
            
            [view addSubview:imgView];
        }
        
        view.bounds=CGRectMake(0,0,view.frame.size.width*0.8,view.frame.size.height*0.8);
        
        point.title=@"用户";
        
        view.annotation = point;
        
        return view;
        
    } else{
        
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"my_node"];
        if (view == nil) {
            view = [[BMKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"my_node"];
            view.image = [UIImage imageNamed:@"qs_headpic"];
            view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            view.canShowCallout = TRUE;
            //            UIImageView *imgView=[[UIImageView alloc]init];
            //
            //            imgView.frame=CGRectMake(3,2,25,25);
            //            imgView.layer.cornerRadius=12.5;
            //            imgView.layer.masksToBounds=YES;
            // [imgView sd_setImageWithURL:[NSURL URLWithString:_detailmodel.user_pic] placeholderImage:[UIImage imageNamed:@"qs_point"]];
            
            //         [view addSubview:imgView];
        }
        
        point.title=@"骑士";
        
        if (![TRClassMethod isEmpty:_deliver_distance]) {
            
            point.title = _deliver_distance;
        }
        
        
        return view;
        
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}


- (void)loadDetailsView {
    
    UIView *detailView=[[UIView alloc]initWithFrame:CGRectMake(0,10,SCREEN_WIDTH-20,60)];
    detailView.backgroundColor=[UIColor whiteColor];
    detailView.layer.contentsScale=4;
    detailView.layer.masksToBounds=YES;
    _detailView=detailView;
    [_mscrollView addSubview:detailView];
    
    UILabel * leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,20,detailView.frame.size.width/2, 20)];
    leftlabel.font = TR_Font_Cu(18);
    leftlabel.textColor = [UIColor blackColor];
    [detailView addSubview:leftlabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearbtnclick:)];
    [leftlabel addGestureRecognizer:tap];
    _qsStatelabel=leftlabel;
    
    UIButton *phonebtn=[UIButton buttonWithType:UIButtonTypeCustom];
 phonebtn.frame=CGRectMake(detailView.frame.size.width-30,leftlabel.frame.origin.y,20,20);
    [phonebtn setImage:[UIImage imageNamed:@"callmenu_pic"] forState:UIControlStateNormal];
    [phonebtn addTarget:self action:@selector(qsCallIphonebtn:) forControlEvents:UIControlEventTouchUpInside];
    [detailView addSubview:phonebtn];
    
    _qscallBtn=phonebtn;
    
    UIButton *qs_btn=[UIButton buttonWithType:UIButtonTypeCustom];
    qs_btn.frame=CGRectMake(phonebtn.frame.origin.x-60,phonebtn.frame.origin.y,50,20);
    qs_btn.titleLabel.font=[UIFont systemFontOfSize:15];
    qs_btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    qs_btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [qs_btn addTarget:self action:@selector(qsCallIphonebtn:) forControlEvents:UIControlEventTouchUpInside];
    [qs_btn setTitleColor:TR_COLOR_RGBACOLOR_A(65,65,65,1) forState:UIControlStateNormal];
    [detailView addSubview:qs_btn];
    _qsnamebtn=qs_btn;
    UIImageView *qs_picbtn=[[UIImageView alloc]init];
    qs_picbtn.frame=CGRectMake(qs_btn.frame.origin.x - 40,12,35,35);
    qs_picbtn.layer.cornerRadius=17.5;
    qs_picbtn.layer.masksToBounds=YES;
    [detailView addSubview:qs_picbtn];
    qs_picbtn.image=[UIImage imageNamed:@"rider_image"];
    _qsHeadPic=qs_picbtn;
    
    _remainTimelabel = [[UILabel alloc]init];
    [detailView addSubview:_remainTimelabel];
    
    [_remainTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(qs_btn.mas_centerY);
        make.height.mas_equalTo(15);
    }];
    
    _qsHeadPic.hidden=YES;
    
    _qscallBtn.hidden=YES;
    
    _qsnamebtn.hidden=YES;
    
    _remainTimelabel.hidden = YES;
    
    if ([_state integerValue]==3||[_state integerValue]==3||[_state integerValue]==4||[_state integerValue]==5 || [_state integerValue]==2){
        _mapView.hidden=NO;
    
    }else
        _mapView.hidden=YES;
    
}


- (void)clearbtnclick:(UITapGestureRecognizer *)sender {
    
    OrderTrackingView *orderTrack = [[OrderTrackingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [orderTrack loadstatus:_detailsModel.deliver_log_list];
    [ROOTVIEW addSubview:orderTrack];
    
}


- (void)loadOrderDatainit {
    
    _mscrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10,_startpointY,SCREEN_WIDTH-20,SCREEN_HEIGHT-50)];
    _mscrollView.layer.cornerRadius=8;
    _mscrollView.layer.masksToBounds=YES;
    _mscrollView.showsVerticalScrollIndicator = NO;
    _mscrollView.delegate = self;
    _mscrollView.backgroundColor=[UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        _mscrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:_mscrollView];
    [self loadDetailsView];
    CGFloat viewHeight = 0.0f;
    if ([_state integerValue]==0||[_state integerValue]==3||[_state integerValue]==3||[_state integerValue]==4||[_state integerValue]==5 || [_state integerValue]==2){
        
        viewHeight = 120.0f;
        
    }else{
        
        viewHeight = 0;
    }
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH-20, viewHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [_mscrollView addSubview:topView];
    
    CGRect bottomRect = CGRectMake(0, 80, SCREEN_WIDTH - 20, _mscrollView.frame.size.height - topView.frame.size.height -topView.frame.origin.y);
    
    if (viewHeight > 0) {
        [self designTopView:topView];
        bottomRect.origin.y = viewHeight + 90;
    }
    
    UIView *bottomView = [[UIView alloc]initWithFrame:bottomRect];
    bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView = bottomView;
    [_mscrollView addSubview:bottomView];
    [self designBottomView:bottomView];
    
    
    
}



-(void)designBottomView:(UIView *)bottomView{
    
    UIImageView *store_pic=[[UIImageView alloc]initWithFrame:CGRectMake(10,10,30,30)];
    store_pic.layer.cornerRadius = 4.0f;
    store_pic.layer.masksToBounds = YES;
    [store_pic sd_setImageWithURL:[NSURL URLWithString:_storeImg] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
    [bottomView addSubview:store_pic];
    
    UIButton *storebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    storebtn.frame=CGRectMake(_mscrollView.frame.size.width-30,15,20,20);
    [storebtn setImage:[UIImage imageNamed:@"callmenu_pic"] forState:UIControlStateNormal];
    [storebtn addTarget:self action:@selector(callStoreIphone:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:storebtn];
    
    UIButton *clearstorebtn=[UIButton buttonWithType:UIButtonTypeSystem];
    clearstorebtn.backgroundColor=[UIColor clearColor];
    clearstorebtn.frame=CGRectMake(_mscrollView.frame.size.width-20,10 ,30,30);
    [clearstorebtn addTarget:self action:@selector(callStoreIphone:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:clearstorebtn];
    
    UILabel *storenamelabel=[[UILabel alloc]initWithFrame:CGRectMake(40+10, store_pic.frame.origin.y,SCREEN_WIDTH-90,30)];
    storenamelabel.textAlignment=NSTextAlignmentLeft;
    
    storenamelabel.text=_storename;
    [bottomView addSubview:storenamelabel];
 _load_PointY=storenamelabel.frame.origin.y+storenamelabel.frame.size.height+10;
    for (StoreDetailsGoodsItem *item in _goodsArray) {
        
        [self loadGoodName:item.name goodnum:item.num goodPrice:item.price specName:item.spec andimgurl:item.product_image];
        
    }
    
    if (_detailsModel.packing_charge.length!=0&&[_detailsModel.packing_charge doubleValue]!=0) {
        
        [self leftName:@"餐盒费" righttitle:[NSString stringWithFormat:@"¥%@",_detailsModel.packing_charge]];
        
    }
    
    if (_detailsModel.freight_charge.length!=0&&[_detailsModel.freight_charge doubleValue]!=0) {
        
        [self leftName:@"配送费" righttitle:[NSString stringWithFormat:@"¥%@",_detailsModel.freight_charge]];
    }
    
    
    if (_discounDetails.count!=0) {
        
        for (StoreDetailsdisCount *item  in _discounDetails) {
            
            [self leftName:item.desc righttitle:[NSString stringWithFormat:@"-¥%@",item.minus]];
            
        }
        
    }
    
    UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,_load_PointY,(_mscrollView.frame.size.width-20)/2,30)];
    leftlabel.textAlignment=NSTextAlignmentLeft;
    leftlabel.font = TR_Font_Mdeium(14);
    leftlabel.textColor = TR_COLOR_RGBACOLOR_A(40, 40, 40, 1);
    leftlabel.text=[NSString stringWithFormat:@"已优惠 ¥%@",_detailsModel.minus_price];
    [_bottomView addSubview:leftlabel];
    
    UILabel *rightlabel=[[UILabel alloc]initWithFrame:CGRectMake(_mscrollView.frame.size.width/2,_load_PointY,(_mscrollView.frame.size.width-20)/2,30)];
    rightlabel.textAlignment=NSTextAlignmentRight;
    
    rightlabel.attributedText = [self attributedText:@[@"小计 ",[NSString stringWithFormat:@"￥%@",_detailsModel.price]]];
    [_bottomView addSubview:rightlabel];
    
    
    _load_PointY=_load_PointY+40;
    
    if (_detailsModel.note.length!=0) {
        
        [self tipstr:@"备注信息:" notes:_detailsModel.note  nextnote:@""];
    }
    
    [self tipstr:@"收货信息:" notes:_detailsModel.address  nextnote:[NSString stringWithFormat:@"%@  %@",_detailsModel.username,_detailsModel.userphone]];
    [self tipstr:@"配送时间:" notes:_detailsModel.expect_use_time nextnote:@""];
    
    if ([_detailsModel.is_pick_in_store integerValue]==0) {
        
        [self tipstr:@"配送方式:" notes:@"点呗专送" nextnote:@""];
        
    }
    
    if ([_detailsModel.is_pick_in_store integerValue]==2) {
        
        [self tipstr:@"配送方式:" notes:@"自提" nextnote:@""];
        
    }
    if ([_detailsModel.is_pick_in_store integerValue]==1) {
        
        [self tipstr:@"配送方式:" notes:@"商家配送" nextnote:@""];
        
    }
    
    [self tipstr:@"订  单  号:" notes:_detailsModel.real_orderid nextnote:@""];
    
    [self tipstr:@"下单时间:" notes:_detailsModel.create_time nextnote:@""];
    
    CGRect rect = _bottomView.frame;
    if (_load_PointY > rect.size.height) {
        
        rect.size.height = _load_PointY;
    }
    _bottomView.frame = rect;
    if ((_load_PointY + rect.origin.y) >_mscrollView.frame.size.height) {
    _mscrollView.contentSize=CGSizeMake(_mscrollView.frame.size.width,_load_PointY + rect.origin.y);
        
    }else{
  _mscrollView.contentSize=CGSizeMake(_mscrollView.frame.size.width,_mscrollView.frame.size.height + 0.01);
    }

}

- (void) loadGoodName:(NSString *)goodname  goodnum:(NSString *)num  goodPrice:(NSString *)goodPrice specName:(NSString *)specname andimgurl:(NSString *)imgurl {
    
    UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(10,_load_PointY,40,40)];
    [imgview sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
    imgview.layer.cornerRadius = 4.0f;
    imgview.layer.masksToBounds = YES;
    
    [_bottomView addSubview:imgview];
    
    UILabel *goodNamelabel=[[UILabel alloc]initWithFrame:CGRectMake(60,_load_PointY,(_mscrollView.frame.size.width-210),20)];
    goodNamelabel.textAlignment=NSTextAlignmentLeft;
    goodNamelabel.font = TR_Font_Mdeium(14);
    goodNamelabel.textColor = TR_COLOR_RGBACOLOR_A(40, 40, 40, 1);
    goodNamelabel.text=goodname;
    [_bottomView addSubview:goodNamelabel];
    
    UILabel *pricelabel=[[UILabel alloc]initWithFrame:CGRectMake(_mscrollView.frame.size.width-70,_load_PointY, 60,20)];
    double allPrice = [goodPrice doubleValue] * [num integerValue];
    
    pricelabel.textAlignment=NSTextAlignmentRight;
    pricelabel.text=[NSString stringWithFormat:@"¥%@",[TRClassMethod stringNumfloat:[NSString stringWithFormat:@"%.2f",allPrice]]];
    [_bottomView addSubview:pricelabel];
    UILabel *centerlabel=[[UILabel alloc]initWithFrame:CGRectMake(_mscrollView.frame.size.width-170,_load_PointY,40,20)];
    centerlabel.textAlignment=NSTextAlignmentRight;
    centerlabel.text=[NSString stringWithFormat:@"x%@",num];
    [_bottomView addSubview:centerlabel];
    
    
    
    if (specname.length!=0) {
        
        UILabel *speclabel=[[UILabel alloc]initWithFrame:CGRectMake(60,_load_PointY + 20,(_mscrollView.frame.size.width-210),20)];
        speclabel.textAlignment=NSTextAlignmentLeft;
        speclabel.textColor = [UIColor grayColor];
        speclabel.font = TR_Font_Gray(11);
        [_bottomView addSubview:speclabel];
        
        speclabel.text=[NSString stringWithFormat:@"%@",specname];
        
        _load_PointY=30+10+30+_load_PointY;
        
    }else{
        
        _load_PointY=_load_PointY=40+10+_load_PointY;
    }
}


- (void)leftName:(NSString *)name  righttitle:(NSString *)title {
    
    UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,_load_PointY,(_mscrollView.frame.size.width-20)/2,20)];
    leftlabel.textAlignment=NSTextAlignmentLeft;
    leftlabel.font = TR_Font_Mdeium(14);
    leftlabel.textColor = TR_COLOR_RGBACOLOR_A(40, 40, 40, 1);
    leftlabel.text=name;
    [_bottomView addSubview:leftlabel];
    
    UILabel *rightlabel=[[UILabel alloc]initWithFrame:CGRectMake((_mscrollView.frame.size.width-20)/2+10, _load_PointY,(_mscrollView.frame.size.width-20)/2,20)];
    rightlabel.textAlignment=NSTextAlignmentRight;
    rightlabel.font = TR_Font_Mdeium(14);
    rightlabel.textColor = TR_COLOR_RGBACOLOR_A(40, 40, 40, 1);

    rightlabel.text=title;
    [_bottomView addSubview:rightlabel];
    
    rightlabel.text=title;
    _load_PointY=20+10+_load_PointY;
}



- (void)tipstr:(NSString *)tipstr  notes:(NSString *)note  nextnote:(NSString *)note2 {
    
    UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,_load_PointY,80,20)];
    leftlabel.textColor=[UIColor grayColor];
    leftlabel.textAlignment=NSTextAlignmentLeft;
    leftlabel.font=[UIFont systemFontOfSize:15];
    leftlabel.text=tipstr;
    [_bottomView addSubview:leftlabel];
    
    UILabel *rightlabel=[[UILabel alloc]init];
    rightlabel.textAlignment=NSTextAlignmentLeft;
    rightlabel.font=[UIFont systemFontOfSize:15];
    rightlabel.numberOfLines=0;
    [_bottomView addSubview:rightlabel];
    
    CGSize size = TR_TEXT_SIZE(note,rightlabel.font,CGSizeMake(_mscrollView.frame.size.width-20-leftlabel.frame.size.width,MAXFLOAT), nil);
    
    
    if (size.height<=20) {
        
        size.height=20;
        
    }else
        size.height=size.height+5;
    
    
    rightlabel.frame=CGRectMake(leftlabel.frame.origin.x+leftlabel.frame.size.width,_load_PointY,_mscrollView.frame.size.width-20-leftlabel.frame.size.width,size.height);
    
    rightlabel.text=note;
    
    _load_PointY=_load_PointY+size.height+10;
    
    if (note2.length!=0) {
        
        UILabel *rightlabel2=[[UILabel alloc]initWithFrame:CGRectMake(rightlabel.frame.origin.x,_load_PointY,_mscrollView.frame.size.width-20-leftlabel.frame.size.width,20)];
        rightlabel2.textAlignment=NSTextAlignmentLeft;
        rightlabel2.font=[UIFont systemFontOfSize:15];
        rightlabel2.text=note2;
        
        [_bottomView addSubview:rightlabel2];
        _load_PointY=_load_PointY+30;
    }
    
    
    if ([tipstr isEqualToString:@"订  单  号:"]) {
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(_mscrollView.frame.size.width - 40,rightlabel.frame.origin.y,30,20);
        rightBtn.layer.borderWidth = 1.0f;
        rightBtn.layer.borderColor = GRAYCLOLOR.CGColor;
        [rightBtn setTitle:@"复制" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = TR_Font_Gray(13);
        [_bottomView addSubview:rightBtn];
        
        [rightBtn addTarget:self action:@selector(clickCopyOrderNumber:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect rect = _mscrollView.frame;
    if (scrollView == _mscrollView) {
        
        if (rect.origin.y > _startpointY) {
            
            rect.origin.y = _startpointY;
            _mscrollView.frame = rect;
            [_mscrollView setContentOffset:CGPointZero];
            return;
        }
        
        if (rect.origin.y > LimitHeight) {
            
            rect.origin.y = rect.origin.y -scrollView.contentOffset.y;
            _mscrollView.frame = rect;
            [_mscrollView setContentOffset:CGPointZero];
        }else{
            
            if (scrollView.contentOffset.y < 0) {
                
                if (rect.origin.y > _startpointY) {
                   
                    rect.origin.y = _startpointY;
                     _mscrollView.frame = rect;
                    
                }else{
                    
                    rect.origin.y = rect.origin.y - scrollView.contentOffset.y;
                    _mscrollView.frame = rect;
                }
                
               
            }
        }
    }
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (fabs(scrollView.origin.y - self.startpointY) < 30) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.mscrollView.frame = CGRectMake(10,self.startpointY,SCREEN_WIDTH-20,SCREEN_HEIGHT-70);
        }];
        
    }
    
    if (fabs(scrollView.origin.y - LimitHeight) < 30) {
        
        CGRect rect = CGRectMake(_mscrollView.frame.origin.x, LimitHeight, _mscrollView.frame.size.width, _mscrollView.frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.mscrollView.frame = rect;
        }];
    }
}


-(void)designTopView:(UIView *)topView{
    
    UIImageView *lineimgview=[[UIImageView alloc]initWithFrame:CGRectMake(topView.frame.size.width/2-20,3,40,4)];
    lineimgview.backgroundColor = [UIColor colorWithHexValue:0XC3C3C3 alpha:1];
    [topView addSubview:lineimgview];
    
    UILabel *sendTimeL = [[UILabel alloc]init];
    NSArray *timeArray = [_detailsModel.expect_use_time componentsSeparatedByString:@" "];
    
    sendTimeL.attributedText = [self setText2:[NSString stringWithFormat:@"预计%@送达",[timeArray lastObject]] andText2:[timeArray lastObject]];
    
    if ([_state integerValue] == 0) {
        
        sendTimeL.text = @"请尽快支付";
        sendTimeL.font = TR_Font_Cu(17);
        
    }
    
    [topView addSubview:sendTimeL];
    
    [sendTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(15);
        
    }];
    
    
    UILabel *sendTypeL = [[UILabel alloc]init];
    
    sendTypeL.font = TR_Font_Gray(14);
    
    if ([_detailsModel.deliver_str isEqualToString:@"商家自配送"]) {
        
        sendTypeL.text = @"由商家提供配送服务";
        
        _qsStatelabel.font = TR_Font_Gray(15);
        
        if ([_state integerValue] != 0) {
            
            
            UIView *hideV = [[UIView alloc]init];
            
            hideV.backgroundColor = [UIColor whiteColor];
            
            [_detailView addSubview:hideV];
            
            [hideV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.left.right.bottom.mas_equalTo(0);
                
            }];
            
            UIImageView *imageV = [[UIImageView alloc]init];
            
            imageV.image = [UIImage imageNamed:@"shop_notic"];
            
            [hideV addSubview:imageV];
            
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(10);
                
                make.centerY.mas_equalTo(0);
                
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            
            
            UILabel *titleLabel = [[UILabel alloc]init];
            
            titleLabel.text = @"商家配送订单无物流信息，请耐心等候";
            
            titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
            
            titleLabel.textColor = TR_COLOR_RGBACOLOR_A(85, 85, 85, 1);
            
            [hideV addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(imageV.mas_right).offset(10);
                make.centerY.mas_equalTo(imageV);
                
            }];
            
        }
        
        
        
    }else{
        
        sendTypeL.text = @"由点呗提供配送服务";
        
    }
    
    
    sendTypeL.textColor = [UIColor grayColor];
    
    [topView addSubview:sendTypeL];
    
    [sendTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(sendTimeL.mas_bottom).offset(10);
        make.left.mas_equalTo(sendTimeL);
        make.height.mas_equalTo(10);
    }];
    
    NSArray *titleArray = @[@"申请退款",@"催单",@"确认收货"];
    
    if ([_state integerValue ] == 0) {
        
        titleArray = @[@"取消订单",@"立即支付"];
    }
    
    
    CGFloat btnWidth = (topView.frame.size.width - 4 * 15) / 3;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton * tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [tempBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        
        tempBtn.layer.cornerRadius = 5.0f;
        
        tempBtn.layer.masksToBounds = YES;
        
        tempBtn.titleLabel.font = TR_Font_Gray(14);
        
        [tempBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:tempBtn];
        
        if (i < 2) {
            
            tempBtn.layer.borderWidth = 1.0f;
            
            tempBtn.layer.borderColor = LITTLEGRAY.CGColor;
            
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }else{
            
            
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            tempBtn.backgroundColor = ORANGECOLOR;
            
        }
        
        if (i == 2) {
            
            if ([_state integerValue] < 5) {
                
                tempBtn.backgroundColor = GRAYCLOLOR;
                
                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                tempBtn.userInteractionEnabled = NO;
                
            }
        }
        
        
        if ([titleArray[i] isEqualToString:@"立即支付"]) {
            
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            tempBtn.backgroundColor = ORANGECOLOR;
            
        }
        
        [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo((15+btnWidth) * i + 15);
            
            make.top.mas_equalTo(sendTypeL.mas_bottom).offset(20);
            
            make.size.mas_equalTo(btnWidth);
            
            make.height.mas_equalTo(30);
        }];
        
    }
    
}



-(void)clickCopyOrderNumber:(UIButton *)sender{
    
    if (_detailsModel.real_orderid.length > 0) {
        
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = _detailsModel.real_orderid;
        TR_Message(@"复制成功");
    }else{
        
        TR_Message(@"复制失败");
        
    }
    
    
}

-(void)clickBtn:(UIButton *)sender{
    
    
    if ([sender.titleLabel.text isEqualToString:@"申请退款"]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确定申请操作吗?" message:@"申请退款将会取消该订单" delegate:self cancelButtonTitle:@"申请退款" otherButtonTitles:@"不申请", nil];
        
        alert.tag = 1000;
        
        [alert show];
        
    }
    
    
    if ([sender.titleLabel.text isEqualToString:@"催单"]) {
        
        NSString *phone;
        
        if ([_detailsModel.deliver_str isEqualToString:@"商家自配送"]) {
            
            phone = [_detailsModel.store.store_phone firstObject];
            
        }else{
            
            if (_detailsModel.deliver_info.count > 0) {
                
                phone = _detailsModel.deliver_info[@"phone"];
                
            }else{
                
                phone = [_detailsModel.store.store_phone firstObject];
            }
            
            
        }
        
        if (!phone || phone.length == 0) {
            
            TR_Message(@"获取手机号码失败");
            
            return;
        }
        
        
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]]];
        [self.view addSubview:callWebview];
        
    }
    
    
    if ([sender.titleLabel.text isEqualToString:@"确认收货"]) {
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"确认收货" message:@"请确认收到您的商品" delegate:self cancelButtonTitle:@"确认收货" otherButtonTitles:@"取消", nil];
        
        alter.tag = 1001;
        
        [alter show];
        
    }
    
    
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"取消订单" message:@"确定取消订单吗？" delegate:self cancelButtonTitle:@"取消订单" otherButtonTitles:@"暂不取消", nil];
        
        alter.tag = 1002;
        
        [alter show];
        
    }
    
    if ([sender.titleLabel.text isEqualToString:@"立即支付"]) {
        
        
        [self confirmOrderMessageOrder:_detailsModel.order_id andGreattime:_detailsModel.create_time];
    }
    
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex==0 && alertView.tag == 1000) {
        
        NSString *phone;
        
        phone = [_detailsModel.store.store_phone firstObject];
        
        
        if (!phone || phone.length == 0) {
            
            TR_Message(@"获取手机号码失败");
            
            return;
        }
        
        
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]]];
        [self.view addSubview:callWebview];
    }
    
    
    if (buttonIndex == 0 && alertView.tag == 1001) {
        
        //确认收货
        
        NSString *deliver_uid = [TRClassMethod isEmpty:_detailsModel.deliver_info[@"uid"]] ? @"":_detailsModel.deliver_info[@"uid"];
        
        [HBHttpTool post:SHOP_SUREORDER body:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_detailsModel.order_id,@"deliver_uid":deliver_uid,@"store_id":_detailsModel.store.store_id} success:^(id responseDic){
            
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        TR_Message(@"确认收货成功");
                        
                        [self back];
                        
                    });
                    
                }else
                    
                    TR_Message([dataDict objectForKey:@"errorMsg"]);
                
                
            }
            
        }failure:^(NSError *error){
            
        }];
        
        
    }
    
    
    if (buttonIndex == 0 && alertView.tag == 1002) {
        
        //取消订单
        
        [HBHttpTool post:SHOP_CANCELORDER body:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_detailsModel.order_id} success:^(id responseDic){
            
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        TR_Message([dataDict objectForKey:@"result"]);
                        [self back];
                    });
                    
                }else
                    TR_Message([dataDict objectForKey:@"errorMsg"]);
                
                
            }
            
        }failure:^(NSError *error){
            
        }];
    }
    
}



-(void)callStoreIphone:(UIButton *) button {
    
    
    
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[_storeIphones firstObject]]]]];
    
    [self.view addSubview:callWebview];
    
}

- (void)qsCallIphonebtn:(UIButton *) button {
    
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_detailsModel.deliver_info[@"phone"]]]]];
    [self.view addSubview:callWebview];
}





- (NSAttributedString *)attributedText:(NSArray*)stringArray{
    
    
    NSDictionary *attributesExtra = @{NSFontAttributeName:TR_Font_Gray(13),NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *attributesPrice = @{NSFontAttributeName:TR_Font_Cu(17),
                                      NSForegroundColorAttributeName:[UIColor blackColor]};
    
    NSArray *attributeAttay = @[attributesExtra,attributesPrice];
    NSString * string = [stringArray componentsJoinedByString:@""];
    
    
    
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc]initWithString:string];
    
    for(NSInteger i = 0; i < stringArray.count; i++){
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    
    
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}






- (NSMutableAttributedString *)setText2:(NSString *)text andText2:(NSString *)mtext2 {
    
    NSString *text1=text;
    
    NSString *text2=mtext2;
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor blackColor],
                              NSFontAttributeName:TR_Font_Gray(17)
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    
    NSRange redTextRange =[text1 rangeOfString:text2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:ORANGECOLOR,NSFontAttributeName:TR_Font_Cu(16)} range:redTextRange];
    
    return attributedText;
    
}


- (NSMutableAttributedString *)setText3:(NSString *)text andText3:(NSString *)mtext2 {
    
    NSString *text1=text;
    
    NSString *text2=mtext2;
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor blackColor],
                              NSFontAttributeName:TR_Font_Gray(15)
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    
    NSRange redTextRange =[text1 rangeOfString:text2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:ORANGECOLOR,NSFontAttributeName:TR_Font_Cu(15)} range:redTextRange];
    
    return attributedText;
    
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


//保存订单成功后  确认订单信息

-(void)confirmOrderMessageOrder:(NSString *)order_id andGreattime:(NSString *)time{
    
    if (_orderId.length == 0) {
        
        return;
    }
    
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"app_type":@"1",@"app_version":@"200",@"order_id":order_id,@"system_coupon_id":@"2",@"type":@"shop"};
    
    [HBHttpTool post:SHOP_CONFIRMORDER params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"]isEqualToString:@"success"]) {
            
            //确认价格  有没有算错  如果有出入  以服务器返回为准
            NSString* returnTotolPrice = responseObj[@"result"][@"order_info"][@"order_total_money"];
            
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
