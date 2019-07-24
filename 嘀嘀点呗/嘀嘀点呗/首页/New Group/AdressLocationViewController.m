//
//  AdressLocationViewController.m
//  送小宝
//
//  Created by xgy on 2017/4/7.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "AdressLocationViewController.h"
#import "AdressShippingCell.h"
#import "CityButton.h"
//#import "AddressListModel.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "CityLocationView.h"
#import "SeachStoreListViewController.h"
#import "ModifyAddressViewController.h"
#import "CityListModel.h"
#import "AdressListModel.h"
#import "AdressHistoryView.h"
#import "LocationBtnView.h"

@interface AdressLocationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKPoiSearchDelegate,UISearchBarDelegate,BMKSuggestionSearchDelegate,UITextFieldDelegate,AdressHistorydelegate>
@property (nonatomic, strong) UITableView *mytableView;

@property (nonatomic, strong) UITextField *seachtextField;

@property (nonatomic, strong) CityButton *cityBtn;

@property (nonatomic, strong) UIButton *locationBtn;

@property (nonatomic, strong) NSArray *adressArray;

@property (nonatomic, strong) NSArray *nearAdressArray;

@property (nonatomic, strong) BMKGeoCodeSearch* geocodesearch;

@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) NSString *adressStr;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) CityLocationView *cityLocationView;

@property (nonatomic, strong) NSString *addressName;

@property (nonatomic, strong) BMKPoiSearch *poisearch;

@property (nonatomic, strong) BMKSuggestionSearch *suggestionSearch;

@property (nonatomic, strong) NSArray *dataPoiArray;

@property (nonatomic, assign) BOOL ispoi;

@property (nonatomic, strong) UISearchBar *seachBar;

// 搜索控制器
@property (nonatomic, retain) UISearchController *searchController;
// 搜索使用的表示图控制器
@property (nonatomic, retain) SeachStoreListViewController *searchTVC;

@property (nonatomic, assign) BOOL isnowLocation;

@property (nonatomic, assign) BOOL isShowMoreAddress;

@property (nonatomic, strong) AdressHistoryView *adressHistoryView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) LocationBtnView *mlocationbtn;

@end

@implementation AdressLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    _poisearch = [[BMKPoiSearch alloc]init];

    _suggestionSearch=[[BMKSuggestionSearch alloc]init];
    
    self.isBackBtn=YES;
    
    [self.backbtn setImage:[UIImage imageNamed:@"root_backArrow"] forState:UIControlStateNormal];
    
    self.backbtn.frame=CGRectMake(0,10,30,20);
    self.topBackView.backgroundColor=[UIColor whiteColor];
    
    self.topImageView.backgroundColor=[UIColor whiteColor];
    
   // self.mtitlelabel.textColor=TR_COLOR_RGBACOLOR_A(84,40,15,1);
    
    
    self.titleName=@"选择收货地址";
    
    UIButton *newAdressbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    newAdressbtn.frame=CGRectMake(SCREEN_WIDTH-50,0,40,40);

    [newAdressbtn setImage:[UIImage imageNamed:@"black_plus"] forState:UIControlStateNormal];
    newAdressbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [newAdressbtn setTitleColor:TR_COLOR_RGBACOLOR_A(152,153,154,1) forState:UIControlStateNormal];
    [newAdressbtn addTarget:self action:@selector(newAdressbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:newAdressbtn];
    
    
    self.view.backgroundColor=TR_COLOR_RGBACOLOR_A(231,232,233,1);
    
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0,self.superY,SCREEN_WIDTH,1)];
    
    line.backgroundColor=TR_COLOR_RGBACOLOR_A(241,242,243,1);
    
    [self.view addSubview:line];
    
    UIView *backWhite=[[UIView alloc]initWithFrame:CGRectMake(0,line.frame.origin.y+line.frame.size.height,SCREEN_WIDTH,50)];
    backWhite.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:backWhite];
    
    UIView *backgrayview=[[UIView alloc]initWithFrame:CGRectMake(60,5,SCREEN_WIDTH-80,40)];
    
    backgrayview.backgroundColor=TR_COLOR_RGBACOLOR_A(240,241,242,1);
    backgrayview.layer.cornerRadius=15;
    
    backgrayview.layer.masksToBounds=YES;
    
    _cityBtn=[[CityButton alloc]initWithFrame:CGRectMake(5,10,70,30)];
   
    _cityBtn.citystr=_cityStr;
    [_cityBtn addTarget:self action:@selector(selcetCity:) forControlEvents:UIControlEventTouchUpInside];
    _cityBtn.arrImgView.transform=CGAffineTransformMakeRotation(0);

    [backWhite addSubview:_cityBtn];
    
    
    
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(_cityBtn.frame.origin.x+_cityBtn.frame.size.width+30,10, backgrayview.frame.size.width-30-_cityBtn.frame.origin.x-_cityBtn.frame.size.width,30)];
    _textField.placeholder=@"请输入收货地址";
    _textField.delegate=self;
    [_textField addTarget:self action:@selector(seachChangeValue:) forControlEvents:UIControlEventEditingChanged];
    
    [backWhite addSubview:_textField];
    

    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0,backWhite.frame.origin.y+backWhite.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - (backWhite.frame.origin.y+backWhite.frame.size.height)) style:UITableViewStylePlain];
    
    _mytableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _mytableView.sectionIndexColor = [UIColor grayColor];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.showsVerticalScrollIndicator = NO;
    _mytableView.showsHorizontalScrollIndicator = NO;
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
    [self.view addSubview:_mytableView];
    
    
    __weak typeof(self) weakSelf=self;
    
    _adressHistoryView=[[AdressHistoryView alloc]initWithFrame:CGRectMake(0,backWhite.frame.origin.y+backWhite.frame.size.height,SCREEN_WIDTH, SCREEN_HEIGHT - (backWhite.frame.origin.y+backWhite.frame.size.height))];
    _adressHistoryView.delegate=self;
    [self.view addSubview:_adressHistoryView];
    
    _adressHistoryView.hidden=YES;
    
    _cityLocationView=[[CityLocationView alloc]initWithFrame:CGRectMake(0,backWhite.frame.origin.y+backWhite.frame.size.height,SCREEN_WIDTH,SCREEN_HEIGHT -backWhite.frame.origin.y-backWhite.frame.size.height)];
    _cityLocationView.citystr=_cityStr;
    [self.view addSubview:_cityLocationView];
    _cityLocationView.addcityNameBlock=^(NSString *cityname) {
        
        __strong typeof(weakSelf) strongSelf=weakSelf;
        
        strongSelf.cityStr=cityname;
        
        [strongSelf loadcityname:cityname];
        strongSelf.cityLocationView.hidden=YES;
        
        weakSelf.cityBtn.arrImgView.transform=CGAffineTransformMakeRotation(0);
            weakSelf.mlocationbtn.hidden=NO;
        
    };
    
    _cityLocationView.hidden=YES;
    
  
    [self loadMapManager];
}




- (void) loadMapManager {
    
    if (!_locationService) {
       
        _locationService = [[BMKLocationService alloc]init];
        
        _locationService.delegate =self;
    }
    
    [_locationService startUserLocationService];
}



- (void)viewDidDisappear:(BOOL)animated {
    
   

}


- (void) loadNowLocation {

    _isnowLocation=YES;
    
  
    [self loadMapManager];

  
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    _poisearch.delegate=self;

    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _suggestionSearch.delegate=self;
   
    if ([Singleton shareInstance].userInfo) {
     
        [HBHttpTool post:SHOP_ORDERADRESS params:@{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID} success:^(id responseDic){
                                                           
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                    
                    NSArray *data=[dataDict objectForKey:@"result"];
                    
                    _adressArray=[AdressListModel arrayOfModelsFromDictionaries:data];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_mytableView reloadData];
                    });
                    
                }
            }
            
        }failure:^(NSError *error){
            
        }];
        
    }
    
  }


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [Singleton shareInstance].centercoordinate=userLocation.location.coordinate;
    
    [self loadReverseGeocode];
    
    [_locationService stopUserLocationService];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!_ispoi) {
    
    if (indexPath.section==0) {
        
        if (_adressArray.count > 3) {
            
            if (_isShowMoreAddress && indexPath.row == _adressArray.count - 1) {
                
                return 140;
                
            }
            
            if (!_isShowMoreAddress && indexPath.row == 2) {
                
                return 140;
            }
        }
        return 90;
    }else
        return 60;
    }else
        return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {


    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *withite=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,30)];
    
    withite.backgroundColor=[UIColor whiteColor]; //TR_COLOR_RGBACOLOR_A(246,246,246,1);
    
    UIImageView *pic_imgview=[[UIImageView alloc]init];
    pic_imgview.frame=CGRectMake(15,10,10,10);
    
    [withite addSubview:pic_imgview];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(40,5,SCREEN_WIDTH-40,20)];
    title.font=[UIFont systemFontOfSize:15];
    title.textAlignment=NSTextAlignmentLeft;
    title.textColor=TR_TEXTGrayCOLOR;
    
    [withite addSubview:title];
    
    if (section==0) {
        title.text=@"您的收货地址";
        pic_imgview.image=[UIImage imageNamed:@"my_pic"];
    }else{
        title.text=@"附近地址";
        pic_imgview.image=[UIImage imageNamed:@"mylocation_pic"];

    }
    return withite;
}




- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_ispoi) {
        return 0;
    }else
        return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_ispoi) {
        
        return _dataPoiArray.count;
        
    }else{
    
        if (section==0&&_adressArray&&_adressArray.count!=0) {
            
            if (_adressArray.count > 3) {
                
                if (_isShowMoreAddress) {
                    
                    return _adressArray.count;
                }else{
                    
                    return 3;
                }
            }
        
        return _adressArray.count;
      
        }else if(section==1){
    
        return _nearAdressArray.count;
        
        }else
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (_ispoi) {
        
        NSString * cellName = @"UITableViewCell2";
        
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell1) {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,59,SCREEN_WIDTH,1)];
            line.backgroundColor=TR_COLOR_RGBACOLOR_A(240,240,240,1);
            [cell1 addSubview:line];
            UILabel *titlelabel1=[[UILabel alloc]initWithFrame:CGRectMake(40,20,SCREEN_WIDTH-40,20)];
            titlelabel1.textAlignment=NSTextAlignmentLeft;
            titlelabel1.tag=1000;
            titlelabel1.font=[UIFont systemFontOfSize:15];
            [cell1 addSubview:titlelabel1];
        }
        
        if (_dataPoiArray&&_dataPoiArray.count) {
        
            UILabel *titlelabel1=[cell1 viewWithTag:1000];

            BMKPoiInfo *info=_dataPoiArray[indexPath.row];
            
            titlelabel1.text=info.name;
        }
        
        return cell1;
        
    }else{
    
    if (indexPath.section==0) {
        
        NSString * cellName = @"UITableViewCell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            AdressShippingCell *adressShippingcell=[[AdressShippingCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,90)];
     
            adressShippingcell.tag=7000;
           
            [cell addSubview:adressShippingcell];
        }
        
        AdressShippingCell *adressShippingcell=(AdressShippingCell *)[cell viewWithTag:7000];

        if (_adressArray&&_adressArray.count) {
            
            AdressListModel *model=_adressArray[indexPath.row];

            adressShippingcell.addresslabel.text=model.adress;
            
            NSString *sex=[model.sex integerValue]==1?@"男":@"女";
            
            adressShippingcell.buyerPhonelabel.text=[NSString stringWithFormat:@"%@  %@  %@",model.name,sex,model.phone];
            adressShippingcell.showMoreBtn.hidden = YES;;
            
            [adressShippingcell layoutIfNeeded];
            
            if (_adressArray.count > 3) {
                
                
                if (!_isShowMoreAddress) {
                    
                    if (indexPath.row == 2) {
                        
                        adressShippingcell.showMoreBtn.hidden = NO;
                        
                        adressShippingcell.showMoreBtn.selected = _isShowMoreAddress;
                        
                        adressShippingcell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
                        
                        [adressShippingcell.showMoreBtn addTarget:self action:@selector(showMoreAddress:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                }else{
                    
                    
                    if (indexPath.row == _adressArray.count - 1) {
                        
                        adressShippingcell.showMoreBtn.hidden = NO;
                        
                        adressShippingcell.showMoreBtn.selected = _isShowMoreAddress;
                        
                        adressShippingcell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
                        
                        [adressShippingcell.showMoreBtn addTarget:self action:@selector(showMoreAddress:) forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                }
                
                
                
            }
           
            if (model.often_label.length!=0) {
                
                adressShippingcell.tiplabel.hidden=NO;
            
                adressShippingcell.tiplabel.text=model.often_label;
                
            }else
                adressShippingcell.tiplabel.hidden=YES;
            
           
            
            
         }
        
         return cell;

    }else {
        
        NSString * cellName = @"UITableViewCell1";
        
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell1) {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(40,59,SCREEN_WIDTH-40,1)];
            line.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
            [cell1 addSubview:line];
            
            UILabel *titlelabel1=[[UILabel alloc]initWithFrame:CGRectMake(40,20,SCREEN_WIDTH-40,20)];
            titlelabel1.textAlignment=NSTextAlignmentLeft;
            titlelabel1.tag=1000;
            titlelabel1.font=[UIFont systemFontOfSize:15];
            [cell1 addSubview:titlelabel1];
            
            UILabel *titlelabel2=[[UILabel alloc]initWithFrame:CGRectMake(40,30,SCREEN_WIDTH-40,20)];
            titlelabel2.tag=1001;
            titlelabel2.font=[UIFont systemFontOfSize:12];
            titlelabel2.textAlignment=NSTextAlignmentLeft;
            titlelabel2.textColor=TR_COLOR_RGBACOLOR_A(152,152,152,1);
            titlelabel2.text=@"当前定位地址";
            [cell1 addSubview:titlelabel2];
            titlelabel2.hidden=YES;
           
           
       
            
            
        }
        
        if (indexPath.row == 0) {
            
            if (!_mlocationbtn) {
                _mlocationbtn=[[LocationBtnView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80,0,70,60)];
                
                [_mlocationbtn addTarget:self action:@selector(loacationbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            }
          
            [cell1 addSubview:_mlocationbtn];
        }
        
        if (_nearAdressArray&&_nearAdressArray.count) {
            
            BMKPoiInfo *info=_nearAdressArray[indexPath.row];
           // cell1.textLabel.text=info.name;
            UILabel *titlelabel1=[cell1 viewWithTag:1000];
            UILabel *titlelabel2=[cell1 viewWithTag:1001];
            titlelabel1.text=info.name;
            if ([info.name isEqualToString:APP_Delegate.addressName]) {
                
                titlelabel2.hidden=NO;
               
                titlelabel1.frame=CGRectMake(40,7,SCREEN_WIDTH-40,20);
                
            }else{
                titlelabel2.hidden=YES;
                titlelabel1.frame=CGRectMake(40,20,SCREEN_WIDTH-40,20);

            }

        }
        
        return cell1;
    }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
       
        AdressListModel *model=_adressArray[indexPath.row];


        _adressStr=model.detail;

        _addressName=model.adress;


        if (_cityStr.length!=0&&_adressStr.length!=0) {

            double lat=[model.lat doubleValue];

            double lng=[model.lng doubleValue];

            CLLocationCoordinate2D userLocation=(CLLocationCoordinate2D){lat,lng};
            _cityAdressblock (_addressName,userLocation);

            [self back];


        }
    }
    
    if (indexPath.section==1) {
        
        BMKPoiInfo *info=_nearAdressArray[indexPath.row];

        _adressStr=info.address;
        
        _addressName=info.name;
        
        if (_cityStr.length!=0&&_adressStr.length!=0) {
            
         //   APP_Delegate.addressname=_addressName;

            _cityAdressblock (_addressName,info.pt);
            
            [self back];
            
            
        }


    }
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    if (section == 0 && _adressArray.count > 3) {
//
//
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        tempBtn.tag = 2000;
//        tempBtn.titleLabel.font = TR_Font_Cu(15);
//        [tempBtn setTitle:@"显示更多地址" forState:UIControlStateNormal];
//        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [tempBtn setTitle:@"收起地址" forState:UIControlStateSelected];
//        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        tempBtn.frame = CGRectMake(10, 0, 150, 20);
//
//        tempBtn.selected = _isShowMoreAddress;
//        [tempBtn addTarget:self action:@selector(showMoreAddress:) forControlEvents:UIControlEventTouchUpInside];
//
//        [view addSubview:tempBtn];
//
//
//        return view;
//    }
//
//    return nil;
//}




-(void)showMoreAddress:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    _isShowMoreAddress = sender.selected;
    
    [self.mytableView reloadData];
    
}



//反地理检索
- (void)loadReverseGeocode {
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    if (_userLocation.location) {

        pt=[Singleton shareInstance].centercoordinate;
    }

    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
    
}


//地理检索
- (void)loadGeocode {
    
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityStr;
    geocodeSearchOption.address = _adressStr;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
    
    
}


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
      if (error == 0) {
       
          BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
      
          item.coordinate = result.location;
       
          item.title = result.address;
   
     }
}


-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
       if (error == 0) {
       
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
       
           
        _nearAdressArray=result.poiList;
        
        [self loadcityname:result.addressDetail.city];
       
        [_mytableView reloadData];
           
           if (_isnowLocation) {
            
               _isnowLocation=NO;
              
               if (_nearAdressArray&&_nearAdressArray.count!=0) {
                  
                   BMKPoiInfo *info=_nearAdressArray[0];
                  // APP_Delegate.addressname=info.name;
                  _cityAdressblock (info.name,info.pt);
                   
                  [self back];
               }
           }
    }
}


#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    
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
        
        _dataPoiArray=result.poiInfoList;
        
        _adressHistoryView.dataArr=[NSMutableArray arrayWithArray:result.poiInfoList];
   
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        //各种情况的判断。。。
    }
}



- (void) textFieldDidEndEditing:(UITextField *)textField {

    if (textField.text.length==0) {
        _ispoi=NO;
        [_mytableView reloadData];
    }
    
}


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    if (!aString) {
        return @"";
    }
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


- (void)dealloc {
    
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    
    if (_poisearch!=nil) {
        _poisearch=nil;
    }

}


- (void) loadcityname:(NSString *)namestr{
    
    _cityStr=namestr;
    
    _cityLocationView.citystr=namestr;
    
    _cityBtn.citystr=namestr;
 _textField.frame=CGRectMake(_cityBtn.frame.origin.x+_cityBtn.frame.size.width + 5,_cityBtn.frame.origin.y,SCREEN_WIDTH-_cityBtn.frame.origin.x-_cityBtn.frame.size.width-30,30);
}


- (void) selcetCity:(CityButton *) button {
    
    button.selected=!button.isSelected;
    
    if (button.isSelected) {
        
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            _cityLocationView.hidden=NO;
            
            button.arrImgView.transform=CGAffineTransformMakeRotation(M_PI);

            _mlocationbtn.hidden=YES;

        }completion:^(BOOL finished) {
            
        }];
    }else {
    
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            
            _cityLocationView.hidden=YES;
            
           
            button.arrImgView.transform=CGAffineTransformMakeRotation(0);

            _mlocationbtn.hidden=NO;

        }completion:^(BOOL finished) {
            
        }];

    }

}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)seachChangeValue:(UITextField *)text {
    
    if (text.text.length==0) {
        
        _adressHistoryView.dataArr=nil;
        
        return;
    }
    
    
    NSString * inputText = text.text;
    
    _adressHistoryView.seachStr=inputText;
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity =20;
    citySearchOption.city= _cityStr;
    citySearchOption.keyword = inputText;
    
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
}



- (void)loacationbtnclick:(UIButton *)button {
    
    [self loadNowLocation];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _adressHistoryView.hidden=NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    //_adressHistoryView.hidden=YES;
    [textField resignFirstResponder];
    return YES;
}


- (void)newAdressbtnclick:(UIButton *) button {

    ModifyAddressViewController *modifyAdressVC=[[ModifyAddressViewController alloc]init];
   
    modifyAdressVC.isNewAdress=YES;
    modifyAdressVC.mtitlename=@"新增地址";
    [self.navigationController pushViewController:modifyAdressVC animated:YES];

}


- (void)adressHistory:(AdressHistoryView *)historyView andPoint:(BMKPoiInfo *)pointinfo {
    
    
    BMKPoiInfo *info=pointinfo;
 
    _cityAdressblock (info.name,info.pt);
    
    [self back];
}

- (void)adressHistory:(AdressHistoryView *)historyView andSeachstr:(NSString *)seachStr {
    
    _adressHistoryView.seachStr=seachStr;
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity =20;
    citySearchOption.city= _cityStr;
    citySearchOption.keyword = seachStr;
    
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
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
