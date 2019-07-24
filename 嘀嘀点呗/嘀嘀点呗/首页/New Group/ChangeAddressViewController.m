//
//  ChangeAddressViewController.m
//  送小宝
//
//  Created by xgy on 2017/4/8.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ChangeAddressViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "ChangeViewCell.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "CityButton.h"
#import "CityLocationView.h"



@interface ChangeAddressViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDelegate,UITableViewDataSource,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton *seachBtn;

@property (nonatomic, strong) UITextField *seachText;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) UITableView *mtableView;

@property (nonatomic, strong) BMKGeoCodeSearch* geocodesearch;

@property (nonatomic, assign) CLLocationCoordinate2D ptPoint;

@property (nonatomic, strong) NSArray *mDataAarray;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

@property (nonatomic, strong) NSString *cityStr;

@property (nonatomic, strong) NSMutableArray *arrayview;

@property (nonatomic, strong) ChangeViewCell *selectcell;

@property (nonatomic , strong) NSString *detailaddress;

@property (nonatomic, strong) CityButton *citybtn;

@property (nonatomic, strong) CityLocationView *cityLocationView;

@property (nonatomic, strong) UIView * backgatview;


@end

@implementation ChangeAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    _arrayview=[NSMutableArray array];
    
    self.isBackBtn=YES;
    
   // self.fd_interactivePopDisabled=YES;
    
    [self.backbtn setImage:[UIImage imageNamed:@"root_backArrow"] forState:UIControlStateNormal];
    self.topBackView.backgroundColor=[UIColor whiteColor];
    self.topImageView.backgroundColor=[UIColor whiteColor];
   
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
 	
    _poisearch = [[BMKPoiSearch alloc]init];


    _backgatview=[[UIView alloc]initWithFrame:CGRectMake(125,5,SCREEN_WIDTH -140,30)];
    
    _backgatview.backgroundColor=TR_COLOR_RGBACOLOR_A(240,241,242,1);
    
    _backgatview.layer.cornerRadius=2;
    
    _backgatview.layer.masksToBounds=YES;
    
    [self.topImageView addSubview:_backgatview];
    
    
    _seachText=[[UITextField alloc]initWithFrame:CGRectMake(_backgatview.frame.origin.x+15,12,_backgatview.frame.size.width-20,20)];
    
    _seachText.textAlignment=NSTextAlignmentLeft;
    _seachText.delegate=self;
    _seachText.placeholder=@"请输入送货地址";
    _seachText.returnKeyType=UIReturnKeySearch;
    [self.topImageView addSubview:_seachText];
    
    _citybtn=[[CityButton alloc]initWithFrame:CGRectMake(40,5,70,30)];
    
    _citybtn.citystr=_cityStr;
    
    [_citybtn addTarget:self action:@selector(selcetCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:_citybtn];
    
  
    
    
    UIButton *titlebutton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    titlebutton.frame=CGRectMake(SCREEN_WIDTH-60,5,50,30);
    
    [titlebutton setTitle:@"搜索" forState:UIControlStateNormal];
    
    [titlebutton setTitleColor:TR_COLOR_RGBACOLOR_A(254,60,0,1) forState:UIControlStateNormal];
    
    titlebutton.layer.borderColor=TR_COLOR_RGBACOLOR_A(254,60, 0,1).CGColor;
    
    titlebutton.layer.borderWidth=1;
    
    titlebutton.layer.cornerRadius=5;
    titlebutton.layer.masksToBounds=YES;
     [titlebutton addTarget:self action:@selector(seachbtnclick:) forControlEvents:UIControlEventTouchUpInside];
   // [self.topImageView addSubview:titlebutton];
    
    
    _locService = [[BMKLocationService alloc]init];
    
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0,self.superY,SCREEN_WIDTH,240)];
    _mapView.zoomLevel=18;
    [_mapView setMapType:BMKMapTypeStandard];

    [self.view  addSubview:_mapView];
    
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = YES;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    displayParam.locationViewImgName=@"xx";
    [_mapView updateLocationViewWithParam:displayParam];

    
    _mtableView=[[UITableView alloc]initWithFrame:CGRectMake(0,_mapView.frame.origin.y+_mapView.frame.size.height,CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)-_mapView.frame.origin.y-_mapView.frame.size.height) style:UITableViewStylePlain];
    _mtableView.delegate = self;
    _mtableView.dataSource = self;
    _mtableView.showsVerticalScrollIndicator = NO;
    _mtableView.showsHorizontalScrollIndicator = NO;
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.backgroundColor=TR_COLOR_RGBACOLOR_A(232,233,234,1);
    [self.view addSubview:_mtableView];
    
    
    if (_lng.length!=0&&_lat.length!=0) {
      
        [self loadloactionAddress];
    }else {
    
        [self loadLocation];
    }
    
    _cityLocationView=[[CityLocationView alloc]initWithFrame:CGRectMake(0,self.superY,SCREEN_WIDTH,SCREEN_HEIGHT -self.superY)];
    _cityLocationView.citystr=_cityStr;
    [self.view addSubview:_cityLocationView];
    _cityLocationView.hidden=YES;
    __weak typeof(self) weakSelf=self;

    _cityLocationView.addcityNameBlock = ^(NSString *cityname) {
        
        __strong typeof(weakSelf) strongSelf=weakSelf;
        
        strongSelf.citybtn.citystr=cityname;
        strongSelf.cityStr=cityname;
        strongSelf.cityLocationView.hidden = YES;
        [weakSelf selcetCity:weakSelf.citybtn];
        
        strongSelf.seachText.frame = CGRectMake(strongSelf.citybtn.frame.origin.x + strongSelf.citybtn.frame.size.width + 10, strongSelf.seachText.frame.origin.y, strongSelf.seachText.frame.size.width, strongSelf.seachText.frame.size.height);
        
        CGRect rect = strongSelf.seachText.frame;
        
        strongSelf.backgatview.frame = CGRectMake(rect.origin.x, rect.origin.y-2.5, rect.size.width, rect.size.height + 5);
    } ;
    
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mDataAarray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier = @"cellIdentifier";
    ChangeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[ChangeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    if (_mDataAarray&&_mDataAarray.count) {
        
        BMKPoiInfo *info=_mDataAarray[indexPath.row];
        
        cell.adresslabel.text=info.address;
        
        
            if ([_adressName isEqualToString:[NSString stringWithFormat:@"%@",info.name]]) {
                cell.locationimgView.hidden=NO;
                cell.namelabel.textColor=TR_COLOR_RGBACOLOR_A(249,151,46, 1);
                
               // cell.adresslabel.textColor=TR_COLOR_RGBACOLOR_A(254,60,0,1);
                _selectcell=cell;
                
                cell.namelabel.text=info.name;
            //    cell.adresslabel.text=info.address;
               // _addressblck (info.name,info.pt);

            }else{
               
                cell.namelabel.text=[NSString stringWithFormat:@"%@",info.name];
                cell.adresslabel.text=info.address;

                cell.namelabel.textColor=TR_COLOR_RGBACOLOR_A(100,101,102,1);
                cell.locationimgView.hidden=YES;

              //  cell.adresslabel.textColor=TR_COLOR_RGBACOLOR_A(100,101,102,1);
            }
        
    }
    
    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_selectcell) {
        
        _selectcell.namelabel.textColor=TR_COLOR_RGBACOLOR_A(100,101,102,1);
        
        _selectcell.adresslabel.textColor=TR_COLOR_RGBACOLOR_A(100,101,102,1);
        
    }
    
    BMKPoiInfo *info=_mDataAarray[indexPath.row];
    
    _ptPoint=info.pt;
   
    _mapView.centerCoordinate = info.pt;
    
    ChangeViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
   
    cell.namelabel.textColor=TR_COLOR_RGBACOLOR_A(254,60,0,1);
  
    cell.adresslabel.textColor=TR_COLOR_RGBACOLOR_A(254,60,0,1);
   
    _selectcell=cell;
    
    _addressblck (info.name,info.pt);
    
    [self back];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放


}



-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    
    _geocodesearch.delegate=self;
    _mapView.delegate = nil; // 不用时，置nil
    _poisearch.delegate = nil; // 不用时，置nil


}


- (void) loadLocation {

    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层

}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    _mapView.centerCoordinate = userLocation.location.coordinate;
    _ptPoint=userLocation.location.coordinate;
    
    [_locService stopUserLocationService];
    
    
    [self loadReverseGeocode];

}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    BMKAnnotationView* view = nil;
    
    BMKPointAnnotation *point=(BMKPointAnnotation*)annotation;
        view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
        if (view == nil) {
            view = [[BMKAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"start_node"];
            view.image = [UIImage imageNamed:@"maplocation_pic"];
            view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
            
        }
    
        view.annotation = point;
        
        return view;
    
    
}


- (void)loadloactionAddress {
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){[_lat doubleValue],[_lng doubleValue]};
    
    _mapView.centerCoordinate = pt;
    _ptPoint=pt;
    
    [_locService stopUserLocationService];
    
    [self loadReverseGeocode];


}


//反地理检索
- (void)loadReverseGeocode {
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    pt=_ptPoint;
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
   
    [[CycleHud sharedView] partShow];

    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        [[CycleHud sharedView] stop];

    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    TR_Singleton.HuDCount=0;
    [[CycleHud sharedView] stop];

    //    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    //    [_mapView removeAnnotations:array];
    //    array = [NSArray arrayWithArray:_mapView.overlays];
    //    [_mapView removeOverlays:array];
    if (error == 0) {
       // NSMutableArray *annotations = [NSMutableArray array];
        //for (int i = 0; i < result.poiList.count; i++) {
          //BMKPoiInfo* poi = [result.poiList objectAtIndex:i];
            //BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            //item.coordinate = poi.pt;
            //item.title = poi.name;
            //[annotations addObject:item];
            
        //}
        //[_mapView addAnnotations:annotations];
  
        //[_mapView showAnnotations:annotations animated:YES];
        
        
        _detailaddress=[NSString stringWithFormat:@"%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district];
        
        NSArray *array=result.poiList;
    
        _mDataAarray=array;
    
        _cityStr=result.addressDetail.city;
        _citybtn.citystr=_cityStr;
        
        _seachText.frame = CGRectMake(_citybtn.frame.origin.x + _citybtn.frame.size.width + 10, _seachText.frame.origin.y, _seachText.frame.size.width, _seachText.frame.size.height);
        
        CGRect rect = _seachText.frame;
        
        _backgatview.frame = CGRectMake(rect.origin.x, rect.origin.y-2.5, rect.size.width, rect.size.height + 5);
        
        
        
      //  NSIndexPath * indexpath=[NSIndexPath indexPathForRow:0 inSection:0];
        
        //[_mtableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionNone];
   
        [_mtableView reloadData];
        
    }
}


#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    TR_Singleton.HuDCount=0;
    [[CycleHud sharedView] stop];

    if (error == BMK_SEARCH_NO_ERROR) {
       // NSMutableArray *annotations = [NSMutableArray array];
        //for (int i = 0; i < result.poiInfoList.count; i++) {
          //  BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            //BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            //item.coordinate = poi.pt;
           // item.title = poi.name;
            //[annotations addObject:item];
            
        //}
      //[_mapView addAnnotations:annotations];
        //[_mapView showAnnotations:annotations animated:YES];
        
        
        _mDataAarray=result.poiInfoList;
        BMKPoiInfo *info=_mDataAarray[0];
        
        _mapView.centerCoordinate = info.pt;
        
        [_mtableView reloadData];
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
            TR_Message(@"搜索不到数据");
    }
}





- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        
    }else{
        
        TR_Message(@"输入位置有误,未查询到改地址");
        
    }
}



- (void)mapStatusDidChanged:(BMKMapView *)mapView {

    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
   
    [_mapView removeAnnotations:array];

    
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate=mapView.centerCoordinate;
    [_mapView addAnnotation:item];
    

    _ptPoint=mapView.centerCoordinate;
    
    [self loadReverseGeocode];


}



- (void) seachbtnclick:(UIButton *) button {
    
    [_seachText resignFirstResponder];
    
//    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
//    citySearchOption.pageCapacity = 10;
//    citySearchOption.city=_cityStr;
//    citySearchOption.keyword = _seachText.text;
//    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityStr;
    geocodeSearchOption.address = _seachText.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    
   // [[CycleHud sharedView] partShow];

    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    if (textField.text.length==0) {
        return NO;
    }
    [textField resignFirstResponder];

    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityStr;
    geocodeSearchOption.address = _seachText.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    
   // [[CycleHud sharedView] partShow];
    
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }

    return YES;
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    
    if (_poisearch != nil) {
        _poisearch = nil;
    }

}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}


- (void) selcetCity:(CityButton *) button {
    
    button.selected=!button.isSelected;
    
    
    
    if (button.isSelected) {
        
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
          
            _cityLocationView.hidden=NO;
            
            button.arrImgView.transform=CGAffineTransformMakeRotation(0);

            
        }completion:^(BOOL finished) {
            
        }];
    }else {
        
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            
            _cityLocationView.hidden=YES;
            
            button.arrImgView.transform=CGAffineTransformMakeRotation(M_PI);

        }completion:^(BOOL finished) {
            
        }];
        
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
