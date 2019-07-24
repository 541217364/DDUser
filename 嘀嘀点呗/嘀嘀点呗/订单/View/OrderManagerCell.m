//
//  OrderManagerCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "OrderManagerCell.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

#define  scrale   SCREEN_WIDTH/375

#define SpareWidth 10

@interface OrderManagerCell()<BMKMapViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)BMKMapView *mapView;

@property (nonatomic, strong) OrderListModel *model;

@end

@implementation OrderManagerCell

{
    NSArray *foodArray;
    NSArray *countArray;
    float  cellHeight;
    // 根据订单状态选择下面的点击按键
    NSArray *typeBtn;
}

-(BMKMapView *)mapView{
   
    if (_mapView == nil) {
        
        _mapView = [[BMKMapView alloc]init];
        _mapView.delegate=self;
        _mapView.gesturesEnabled=NO;
        //设置为卫星地图
        [_mapView setMapType:BMKMapTypeSatellite];
        //设置为普通地图,系统默认为普通地图
        [_mapView setMapType:BMKMapTypeStandard];
        
        _mapView.minZoomLevel=10;
        
        _mapView.maxZoomLevel=20;
        
        _mapView.zoomLevel=15;
        
        [_mapView setBaiduHeatMapEnabled:NO];
        
        _mapView.zoomEnabled =YES;
        
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
    
    return _mapView;
}

- (void)dealloc {
    
    if (_mapView) {
        _mapView = nil;
    }
}


- (BMKAnnotationView*)mapView:(BMKMapView*)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    BMKAnnotationView* view = nil;
    
    BMKPointAnnotation *point=(BMKPointAnnotation*)annotation;
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"my_node"];
        if (view == nil) {
            view = [[BMKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"my_node"];
            view.image = [UIImage imageNamed:@"list_qspic"];
           // view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            view.canShowCallout = TRUE;
//            UIImageView *imgView=[[UIImageView alloc]init];
//
//            imgView.frame=CGRectMake(3,2,25,25);
//            imgView.layer.cornerRadius=12.5;
//            imgView.layer.masksToBounds=YES;
//            // [imgView sd_setImageWithURL:[NSURL URLWithString:_detailmodel.user_pic] placeholderImage:[UIImage imageNamed:@"qs_point"]];
//
//            [view addSubview:imgView];
        }
        
        view.bounds=CGRectMake(0,0,view.frame.size.width*0.8,view.frame.size.height*0.8);
        
        point.title=@"骑士";
        
        view.annotation = point;
        
        return view;
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



- (UILabel*)stateMsgLabel {
    
    if (!_stateMsgLabel) {
        _stateMsgLabel=[[UILabel alloc]init];
        _stateMsgLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _stateMsgLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
          __weak typeof(self) weakSelf = self;
        //布局订单界面
        self.mainView = [[UIView alloc]init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        self.mainView.layer.cornerRadius = 10.0f;
        self.mainView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.mainView];
       
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(1);
            make.width.mas_equalTo(weakSelf.mas_width);
            make.bottom.mas_equalTo(weakSelf.mas_bottom);
            
        }];
        
        self.busphoto = [[UIImageView alloc]init];
        self.busphoto.image = [UIImage imageNamed:@"nostore_pic"];
        self.busphoto.layer.cornerRadius = 5.0f;
        self.busphoto.layer.masksToBounds = YES;
        self.busphoto.tag=4000;
        self.busphoto.contentMode = UIViewContentModeScaleAspectFill;
        [self.mainView addSubview:self.busphoto];
        [self.busphoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth*2);
            make.size.mas_equalTo(CGSizeMake(40,40));
        }];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.text = @"肯德基(萧山店) >";
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.tag=4001;
        [self.mainView addSubview:self.titleLabel];
       
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.left.mas_equalTo(weakSelf.busphoto.mas_right).offset(SpareWidth);
            make.centerY.mas_equalTo(weakSelf.busphoto.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(180, 15));
        }];
        
        self.arrowImgView=[[UIImageView alloc]init];
       
        self.arrowImgView.image=[UIImage imageNamed:@"right_arrow"];
        self.arrowImgView.tag=4003;
        [self.mainView addSubview:self.arrowImgView];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.titleLabel.mas_right).offset(5);
           
   
            make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);

            make.size.mas_equalTo(CGSizeMake(7,13));
            
        }];
       
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.numberOfLines = 0;
        _stateLabel.tag=4002;
        _stateLabel.font = [UIFont systemFontOfSize:13];
        _stateLabel.backgroundColor = [UIColor whiteColor];
        [self.mainView addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-SpareWidth);
            
            make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
          
            make.size.mas_equalTo(CGSizeMake(50,20));
        }];
        
        _orderStateListbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _orderStateListbtn.backgroundColor=[UIColor clearColor];
     
        _orderStateListbtn.tag=4004;
      
        [self.mainView addSubview:_orderStateListbtn];
        
        [_orderStateListbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-SpareWidth);
            
            make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
            
            make.size.mas_equalTo(CGSizeMake(40,20));
        }];
        
        
        
//        UIButton *sotrebutton =[[UIButton alloc]init];
//
//        sotrebutton.backgroundColor=[UIColor redColor];
//
//        [sotrebutton addTarget:self action:@selector(storebtnclick:) forControlEvents:UIControlEventTouchUpInside];
//
//        [self.mainView addSubview:sotrebutton];
//
//        [sotrebutton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakSelf.busphoto.mas_left).offset(SpareWidth);
//            make.top.mas_equalTo(weakSelf.busphoto.mas_top);
//            make.size.mas_equalTo(CGSizeMake(180,20));
//       }];
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [rightBtn addTarget:self action:@selector(orderTrackAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.tag=4009;


        [self.contentView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(50, 40));
        }];
   
    }
    
    return  self;
}


-(void)orderTrackAction:(UIButton *)sender{
    
//    OrderTrackingView *orderTrack = [[OrderTrackingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [orderTrack handleWithOrderListModel:self.model];
//    [ROOTVIEW addSubview:orderTrack];
    
}



- (void)setOrderState:(NSString *)state andOrderModel:(OrderListModel *)model {
    _model=model;
    for (UIView * view in self.mainView.subviews) {
        
        if (view.tag/1000!=4) {
            [view removeFromSuperview];
        }
    }
    
    if ([state integerValue]==0) {
        
        self.OrderType=orderTypeUserNotPay;
    }
    
    if ([state integerValue]==1) {
        
        self.OrderType=orderTypeBuessinessNot;
    }
    
    if ([state integerValue]==2) {
        
        self.OrderType=orderTypeQSDone;
    }
    
    
    if ([state integerValue]==3) {
        
        self.OrderType=orderTypeStore;
    }
    
    
    if ([state integerValue]==4) {
        
        self.OrderType=orderTypeQSTakeDone;
    }
    
    if ([state integerValue]==5) {
        
        self.OrderType=orderTypeDistributioning;
    }
    
    if ([state integerValue]==6) {
        
        self.OrderType=orderTypeDistributionDone;
    }
    
    if ([state integerValue]==7) {
        
        self.OrderType=orderTypeNoCommentDone;
    }
    
    if ([state integerValue]==8) {
        
        self.OrderType=orderTypeCommentDone;
    }
    
    if ([state integerValue]==10) {
        
        self.OrderType=orderTypeCancelDone;
    }
    
    if ([state integerValue]==9) {
        
        self.OrderType=orderTypeRefundDone;
    }
 
    [self designbottomVwithOrderTypeData:model];
}

//根据订单类型布局下面的视图
-(void)designbottomVwithOrderTypeData:(OrderListModel *)model {
    
    CGFloat width=SCREEN_WIDTH-105;
    
    self.titleLabel.text=model.name;
    
    if (model.name.length!=0) {
        
        NSString *strname=model.name;
        
        if (strname.length>8) {
            
            strname=[strname substringWithRange:NSMakeRange(0, 8)];
            self.titleLabel.text=[NSString stringWithFormat:@"%@...",strname];
            
        }else
            self.titleLabel.text=strname;
     
        CGSize size = TR_TEXT_SIZE(strname, self.titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        
        if ((size.width+5)<=180) {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(size.width+5,15));
            }];
        }
    }
    
    
    [self.busphoto sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
    
    //根据订单类型改变 标题

    switch (self.OrderType) {
            //配送中
        case orderTypeDistributioning:
            
           _stateLabel.textColor =[UIColor blackColor];
            typeBtn = @[@"再来一单",@"催单",@"取消订单"];
            break;
            
        case orderTypeDistributionDone:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单",@"评价晒单"];
            break;
            
        case orderTypeCancelDone:
            _stateLabel.textColor =[UIColor blackColor];
            typeBtn = @[@"再来一单"];
            break;
            
        case orderTypeRefundDone:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单"];
            break;
            
        case orderTypeUserNotPay:
            _stateLabel.textColor = [UIColor blackColor];
            _stateLabel.text = @"待支付";
            typeBtn = @[@"去支付",@"取消订单"];
            break;
            
        case orderTypeBuessinessNot:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单",@"取消订单"];
            break;
            
        case orderTypeQSDone:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单",@"催单",@"取消订单"];
            break;
            
        case orderTypeStore:
            _stateLabel.textColor = [UIColor blackColor];
            _stateLabel.text = @"待到店";
            typeBtn = @[@"再来一单",@"催单",@"取消订单"];
            break;
            
        case orderTypeQSTakeDone:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单",@"催单",@"取消订单"];
            break;
            
        case orderTypeNoCommentDone:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单",@"评价晒单"];
            break;
        case orderTypeCommentDone:
            _stateLabel.textColor = [UIColor blackColor];
            typeBtn = @[@"再来一单"];
            break;
            
        default:
            break;
    }
    
     __weak typeof(self) weakSelf = self;
    if (model.goods_list.count==0) {
        return;
    }
    
    NSInteger count=model.goods_list.count>=3?3:model.goods_list.count;
   
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:centerView];
    [centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.busphoto.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 25 *count));
    }];
    
    for (int i = 0; i < count; i ++ ) {
        
        OrderListItem *item=model.goods_list[i];
        UILabel *tempLabel = [[UILabel alloc]init];
        tempLabel.textColor = [UIColor blackColor];
        tempLabel.text = item.goods_name;
        tempLabel.textAlignment = NSTextAlignmentLeft;
        tempLabel.numberOfLines = 0;
        tempLabel.font = [UIFont systemFontOfSize:13];
        tempLabel.backgroundColor = [UIColor whiteColor];
        [centerView addSubview:tempLabel];
        [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo((SpareWidth  + 15) * i + SpareWidth);
            make.size.mas_equalTo(CGSizeMake(width/2,15));
        }];
        
        UILabel *titleLabel2 = [[UILabel alloc]init];
        titleLabel2.text = [NSString stringWithFormat:@"x%@",item.goods_num];
        titleLabel2.textAlignment = NSTextAlignmentRight;
        titleLabel2.numberOfLines = 0;
        titleLabel2.font = [UIFont systemFontOfSize:13];
        titleLabel2.textColor=TR_TEXTGrayCOLOR;
        titleLabel2.backgroundColor = [UIColor clearColor];
        [centerView addSubview:titleLabel2];
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.stateLabel.mas_left).offset(0);
            make.centerY.mas_equalTo(tempLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
    }
    NSInteger num=0;
    if (model.goods_list&&model.goods_list.count!=0) {
        
        for (OrderListItem *item in model.goods_list) {
            
            num+=[item.goods_num integerValue];
            
        }
        
    }
    
    UILabel *refundcountLabel2 = [[UILabel alloc]init];
    refundcountLabel2.textColor = [UIColor grayColor];
    refundcountLabel2.text =[NSString stringWithFormat:@"共%ld件商品,",num];
    refundcountLabel2.textAlignment = NSTextAlignmentRight;
    refundcountLabel2.numberOfLines = 0;
    refundcountLabel2.font = [UIFont systemFontOfSize:13];
    refundcountLabel2.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:refundcountLabel2];
    [refundcountLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(centerView.mas_bottom).offset(SpareWidth);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *refundcountLabel = [[UILabel alloc]init];
    refundcountLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    refundcountLabel.textAlignment = NSTextAlignmentLeft;
    refundcountLabel.numberOfLines = 0;
    refundcountLabel.font = [UIFont boldSystemFontOfSize:18];
    refundcountLabel.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:refundcountLabel];
    
    [refundcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(refundcountLabel2.mas_right).offset(10);
        make.top.equalTo(refundcountLabel2.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    self.bottomV = [[UIView alloc]init];
    self.bottomV.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.bottomV];
  
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.equalTo(refundcountLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 40));
    }];
    
    
    // 下面的按钮
    
    CGFloat btnwidth=75*scrale;
    
    CGFloat interval=(width -btnwidth*3)/2;
    
    for (int i = 0 ; i < typeBtn.count ; i++) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setTitle:typeBtn[i] forState:UIControlStateNormal];
        [tempBtn setTitleColor:TR_COLOR_RGBACOLOR_A(45,45,45,1) forState:UIControlStateNormal];
        tempBtn.self.self.titleLabel.textAlignment = NSTextAlignmentCenter;
        tempBtn.self.self.titleLabel.font = [UIFont systemFontOfSize:14*scrale];
        tempBtn.layer.borderColor=TR_COLOR_RGBACOLOR_A(240,240,240,1).CGColor;
        tempBtn.layer.borderWidth=1;
        [_bottomV addSubview:tempBtn];
        tempBtn.tag = 100 + i;
        [tempBtn addTarget:self action:@selector(orderChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((interval+btnwidth)*i);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(btnwidth,30));
        }];

        if ([tempBtn.titleLabel.text isEqualToString:@"取消订单"]) {
            
            [tempBtn setTitleColor:TR_TEXTGrayCOLOR forState:UIControlStateNormal];
            tempBtn.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
        }
        
        if ([tempBtn.titleLabel.text isEqualToString:@"去支付"]) {
            
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            tempBtn.backgroundColor=TR_COLOR_RGBACOLOR_A(250,122,58,1);
            tempBtn.layer.borderWidth=0;
            
        }
        
        
        
    }
   
    [self.mainView addSubview:self.stateMsgLabel];
   
    self.stateMsgLabel.hidden=YES;
   
    [self.stateMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        
        make.bottom.mas_equalTo(-20);
        
       // make.size.mas_equalTo(CGSizeMake(width,40));
        make.height.mas_equalTo(40);
        make.right.equalTo(weakSelf.stateLabel.mas_left).offset(0);
    }];

    if (self.OrderType == orderTypeDistributioning||self.OrderType == orderTypeQSTakeDone) {
        
        [self.mainView addSubview:self.mapView];
        
        self.stateMsgLabel.backgroundColor=[UIColor whiteColor];
       
        self.mapView.hidden = NO;
        
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.bottomV.mas_bottom).offset(15);
            //make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 3* SpareWidth-35,100));
            make.height.mas_equalTo(100);
            make.right.equalTo(weakSelf.stateLabel.mas_left).offset(0);
        }];
        
        if (model.deliver_place) {

            if ([model.deliver_place[@"lines"] isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dict=model.deliver_place[@"lines"];
                
                if (![dict[@"lat"] isKindOfClass:[NSNull class]] && ![dict[@"lng"] isKindOfClass:[NSNull class]]) {
                    
                    double lat=[dict[@"lat"] doubleValue];
                    
                    double lng=[dict[@"lng"] doubleValue];
                    
                    CLLocationCoordinate2D qscoor=CLLocationCoordinate2DMake(lat,lng);
                    
                    BMKPointAnnotation * mypoint=[[BMKPointAnnotation alloc]init];
                    
                    mypoint.coordinate=qscoor;
                    
                    mypoint.title=@"骑士";
                    
                    [_mapView addAnnotation:mypoint];
                    
                    _mapView.centerCoordinate=qscoor;
                    
                }
                
               
            }
        }
        
//        if (self.OrderType == orderTypeQSTakeDone) {
//            self.stateMsgLabel.text=@"正在赶往商家";
//        }
//
//
//        if (self.OrderType == orderTypeDistributioning) {
//            self.stateMsgLabel.text=@"正在为您送货";
//        }
        
    }else{
    }
    self.mapView.hidden = YES;

//    if (self.OrderType == orderTypeQSDone) {
//        self.stateMsgLabel.text=@"正在等待骑士接单";
//    }
//
//    if (self.OrderType == orderTypeBuessinessNot) {
//        self.stateMsgLabel.text=@"等待商家接单";
//        self.stateMsgLabel.backgroundColor=TR_COLOR_RGBACOLOR_A(242,242,242,1);
//
//    }
    
    if (self.OrderType == orderTypeUserNotPay||self.OrderType == orderTypeRefundDone||self.OrderType == orderTypeCancelDone||self.OrderType == orderTypeDistributionDone||self.OrderType == orderTypeNoCommentDone||self.OrderType == orderTypeCommentDone) {
        self.stateMsgLabel.hidden=YES;
    }else{
        self.stateMsgLabel.hidden=YES;
    }
}

- (void)storebtnclick:(UIButton *) button {
    
    if (_delegate&&[_delegate respondsToSelector:@selector(nextstore:)]) {
        
        [_delegate nextstore:_model];
    }
    
}

//点击下面的Btn
-(void)orderChooseAction:(UIButton *)sender {
   
    NSLog(@"%lu %@ %u",sender.tag,sender.self.self.titleLabel.text,self.OrderType);
   
    OrderStateItem *item=[_model.status firstObject];

    if ([sender.titleLabel.text isEqualToString:@"催单"]) {
        
        if (self.OrderType==orderTypeQSDone) {
          
            NSString *phone=[_model.phone firstObject];
            
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]]];
            [self addSubview:callWebview];
            
        }else{
            
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",item.phone]]]];
            [self addSubview:callWebview];
            
        }
    }
    
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        
        if(self.OrderType==orderTypeUserNotPay||self.OrderType==orderTypeBuessinessNot){
        
//            if (self.OrderType==orderTypeQSTakeDone||self.OrderType==orderTypeQSTakeDone||self.OrderType==orderTypeDistributioning) {
//                UIAlertView *alerview=[[UIAlertView alloc]initWithTitle:@"" message:@"是否联系骑士?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alerview.tag=2000;
//                [alerview show];
//            }else{
             sender.tag=90000;
            
          //  }
        }else{
            


            UIAlertView *alerview=[[UIAlertView alloc]initWithTitle:@"" message:@"商家已接单,请联系商家取消" delegate:self cancelButtonTitle:@"不取消" otherButtonTitles:@"联系商家", nil];
            alerview.tag=2001;
            [alerview show];
        }
        
    }
   
    
    if (_delegate&&[_delegate respondsToSelector:@selector(orderManagerCell:selectOrderModel:andclickbtn:)]) {
        
        [_delegate orderManagerCell:self selectOrderModel:_model andclickbtn:sender];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==2000) {
        
        OrderStateItem *item=[_model.status firstObject];
            
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",item.phone]]];
        
        
        if (buttonIndex==1) {
            
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",item.phone]]]];
            [self addSubview:callWebview];
        }
        
    }
    
    if (alertView.tag==2001) {
        
        OrderStateItem *item=[_model.status firstObject];
        
        if (buttonIndex==1) {
            NSString *phone=[_model.phone firstObject];
            
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]]]];
            [self addSubview:callWebview];
        }
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",item.phone]]];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
