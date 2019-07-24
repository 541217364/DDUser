//
//  ViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#define MenuBtnWidth 70
#define MenuBtnHeigh 60

#define BlackColor TR_COLOR_RGBACOLOR_A(10,10,10,1)

#import "ViewController.h"
#import "HomeTableViewCell.h"
#import "MenuItem.h"
#import "CCPScrollView.h"
#import "XRCarouselView.h"
#import "DBScrollView.h"
#import "QualityStoreView.h"
#import "GoodsChooseViewController.h"
#import "VariousDataModel.h"
#import "StoreModel.h"
#import "BusinessViewController.h"
#import "DDShop_DB.h"
#import "SeachBtn.h"
#import "AdressLocationViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "SeachStoreListViewController.h"
#import "ShoppingCarViewController.h"
#import "MJRefresh.h"
#import "MyRefreshHeader.h"
#import "GoodShopManagement.h"
#import "PersonalWebController.h"
#import "CycleHud.h"
#import "RiderTypeItemView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,XRCarouselViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *mytableview;

@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) SeachBtn *locationbtn;

@property (nonatomic, strong) UIButton *seachBtn;

@property (nonatomic, strong) UIButton *seachButton;

@property (nonatomic, strong) CCPScrollView *ccpScrpllView;

@property (nonatomic, strong) XRCarouselView *carouselView;

@property (nonatomic, strong) DBScrollView *dbscrollView;

@property (nonatomic, strong) UIScrollView *qualituStoreView;

@property (nonatomic, strong) VariousDataModel *dataModel;

@property (nonatomic, strong) NSMutableArray *dataStoreArr;

@property (nonatomic, strong)UIScrollView *classStoreView;

@property (nonatomic, strong)NSString *cat_url;

@property (nonatomic, strong)NSString *sort_url;

@property (nonatomic, strong)UIView *locationView;

@property (nonatomic, strong)UIView *saleBackView;

@property (nonatomic, strong)NSMutableArray *shopDataArray;

@property (nonatomic, strong)UILabel *shoptiplabel;

@property (nonatomic, strong)MenuItem *nearbtn;

@property (nonatomic, strong)NSArray *classArray;

@property (nonatomic, strong)NSArray *picClassArray;

@property (nonatomic, strong)NSArray *classcatArray;

@property (nonatomic, strong)UIView *notworkBackView;

@property (nonatomic, assign) CGFloat sortPointY;

@property (nonatomic, strong) UILabel *seachlabel;

@property (nonatomic, strong) UIView *nostoreBackView;

@property (nonatomic, strong) UIView *jionBackView;

@property(nonatomic,strong) RiderTypeItemView *rideTypeView;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    _cat_url=@"all";
   
    _sort_url=@"";
   
    self.page=@(1);

    _classArray=@[@"附近",@"美食",@"超市购",@"生鲜果蔬",@"下午茶"];
 
 _picClassArray=@[@"shouye_fujin",@"shouye_meishi",@"shouye_cs",@"shouye_gs",@"shouye_xwc"];
   
    _classcatArray=@[@"all",@"kcjc",@"csg",@"sgsx",@"xwc"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatelocationmess:) name:@"UpDateLocationMessage" object:nil];
    
    self.topBackView.backgroundColor=[UIColor whiteColor];
   
    _selectedArray=[NSMutableArray array];

    _mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    _mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    _mytableview.delegate=self;

    _mytableview.dataSource=self;
    

    [self.view addSubview:_mytableview];
   
    if (@available(iOS 11.0, *)) {
        _mytableview.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - HOME_INDICATOR_HEIGHT);
        _mytableview.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        _mytableview.estimatedRowHeight = 0;

        _mytableview.estimatedSectionFooterHeight = 0;

        _mytableview.estimatedSectionHeaderHeight = 0;
    }
    
    if (GetUser_Login_State) {
        
        //获取用户登录状态 已经登录过的 获取用户信息
        if (![Singleton shareInstance].userInfo) {
            
            NSString * userMessage = [USERDEFAULTS valueForKey:@"userinfo"];
            if (userMessage) {
                
                [Singleton shareInstance].userInfo = [[UserInfo alloc]initWithString:userMessage error:nil];
            }
            
        }
    }
    
    [self addFreshAndGetMoreView];
    
    _rideTypeView = [[RiderTypeItemView alloc]init];
    
    _rideTypeView.frame = CGRectMake(SCREEN_WIDTH - 210, SCREEN_HEIGHT - 120 - HOME_INDICATOR_HEIGHT, 200, 50);
    
    [self.view addSubview:_rideTypeView];
    
}


- (void)nostoresData {
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:2 inSection:0];
    
    CGRect mrect=[_mytableview rectForRowAtIndexPath:indexpath];
    
    CGFloat pointY=mrect.origin.y+130;
    
    if (!_nostoreBackView) {
        
        CGFloat height=50;
        
        CGFloat bheight=44;
        
        UIImage *notimg=[UIImage imageNamed:@"no_stores"];
       
        _nostoreBackView=[[UIView alloc]initWithFrame:CGRectMake(0, height,SCREEN_WIDTH,SCREEN_HEIGHT-height-bheight)];
        _nostoreBackView.backgroundColor=[UIColor whiteColor];
        [_mytableview addSubview:_nostoreBackView];
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-notimg.size.width*0.8/2,10,notimg.size.width*0.8, notimg.size.height*0.8)];
      
        imgview.image=notimg;
        
        [_nostoreBackView addSubview:imgview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, imgview.frame.origin.y+imgview.frame.size.height+15,SCREEN_WIDTH,20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=TR_TEXTGrayCOLOR;
        label.font=[UIFont systemFontOfSize:14];
        label.text=@"暂无店铺,敬请期待";
        
        [_nostoreBackView addSubview:label];
    }
    
    _nostoreBackView.frame=CGRectMake(0,pointY,SCREEN_WIDTH,200);
    
    _nostoreBackView.hidden=NO;
    _mytableview.mj_footer.hidden=YES;
    
}


-(void) loadjiondata {
    
        
        if (!_jionBackView) {
            
            CGFloat height=120;
            
            CGFloat bheight=44;
            
            UIImage *notimg=[UIImage imageNamed:@"store_pics"];
            
            _jionBackView=[[UIView alloc]initWithFrame:CGRectMake(0, height,SCREEN_WIDTH,SCREEN_HEIGHT-height-bheight)];
            _jionBackView.backgroundColor=[UIColor whiteColor];
        
            [_mytableview addSubview:_jionBackView];
            
            UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-notimg.size.width/2,40,notimg.size.width, notimg.size.height)];
            imgview.image=notimg;
            
            [_jionBackView addSubview:imgview];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, imgview.frame.origin.y+imgview.frame.size.height+15,SCREEN_WIDTH,20)];
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=TR_TEXTGrayCOLOR;
            label.font=[UIFont systemFontOfSize:18];
            label.text=@"代理点呗外卖,携手共创辉煌";
            
            [_jionBackView addSubview:label];
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"申请成为城市代理商" forState:UIControlStateNormal];
            button.backgroundColor=TR_COLOR_RGBACOLOR_A(252,122,46,1);
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            button.frame=CGRectMake(SCREEN_WIDTH/2-125,label.frame.origin.y+label.frame.size.height+15,250,44);
            [button addTarget:self action:@selector(jionbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            [_jionBackView addSubview:button];
           
        }
    
        _mytableview.mj_footer.hidden=YES;
        _jionBackView.hidden=NO;
    
}




- (void)loadNotworkdata {
    
    if (!_notworkBackView) {
       
        CGFloat height=50;
        
        CGFloat bheight=44;
        
        UIImage *notimg=[UIImage imageNamed:@"norwork_pic"];
        
        _notworkBackView=[[UIView alloc]initWithFrame:CGRectMake(0, height,SCREEN_WIDTH,SCREEN_HEIGHT-height-bheight)];
        _notworkBackView.backgroundColor=[UIColor whiteColor];
        
        [_mytableview addSubview:_notworkBackView];
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-notimg.size.width/2,200,notimg.size.width, notimg.size.height)];
        imgview.image=notimg;
        
        [_notworkBackView addSubview:imgview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, imgview.frame.origin.y+imgview.frame.size.height+15,SCREEN_WIDTH,20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=TR_TEXTGrayCOLOR;
        label.font=[UIFont systemFontOfSize:14];
        label.text=@"网络太调皮,点击刷新下看看...";
        
        [_notworkBackView addSubview:label];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaction)];
        [_notworkBackView addGestureRecognizer:tap];
    }
    _mytableview.mj_header.hidden=YES;
    _mytableview.mj_footer.hidden=YES;

    _notworkBackView.hidden=NO;


}

-(void)tapaction {
    
    if (TR_IsNetWork) {
    
        _notworkBackView.hidden=YES;
     
        _mytableview.mj_header.hidden=NO;
        _mytableview.mj_footer.hidden=NO;
        [self loaddataManagementwithshow:YES];
      
        [APP_Delegate loadMapManager];
        
    }else
        TR_Message(@"暂无网络请查看系统设置");    
}

- (void)jionbtnclick:(UIButton *) button {
    
    PersonalWebController *webvc=[[PersonalWebController alloc]init];
    webvc.weburl=@"http://www.dianbeiwaimai.cn/wap.php?c=Agencypartner&a=deliver_recruit";
    [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
    
    [self.navigationController pushViewController:webvc animated:YES];
    
}


- (void)loaddataManagementwithshow:(BOOL)isshow {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f", APP_Delegate.mylocation.longitude];
    
    [HBHttpTool post:SHOP_INDEX params:@{@"user_long":lng,@"user_lat":lat} showHUD:isshow success:^(id responseDic) {
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                weakSelf.dataModel=[[VariousDataModel alloc]initWithDictionary:[dataDict objectForKey:@"result"] error:nil];
                
                [weakSelf.mytableview reloadData];
                
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)loadActivityData {
    
    __weak typeof(self) weakSelf = self;
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f", APP_Delegate.mylocation.longitude];
        [HBHttpTool post:SHOP_INDEX body:@{@"user_long":lng,@"user_lat":lat} success:^(id responseDic){
            
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                    
                    weakSelf.dataModel=[[VariousDataModel alloc]initWithDictionary:[dataDict objectForKey:@"result"] error:nil];
                    
                    [weakSelf.mytableview reloadData];
                    
                }
            }
        }failure:^(NSError *error){
            
            [weakSelf.mytableview.mj_header endRefreshing];

        }];
    
}

#pragma mark -  下拉刷新和上拉加载更多
//添加下拉刷新
-(void)addFreshAndGetMoreView
{
    __weak __typeof(self) weakSelf = self;
    
    MyRefreshHeader*header = [MyRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.mytableview.mj_footer.hidden=NO;

        weakSelf.page=@(1);
        [weakSelf loadGoodsData];

        [weakSelf loadActivityData];
        
    }];
    
    _mytableview.mj_header=header;
    
    MyRefreshFooter*foot = [MyRefreshFooter footerWithRefreshingBlock:^{
        
        NSInteger num=[self.page integerValue];
        num++;
        
        weakSelf.page=@(num);
        
        [weakSelf loadGoodsData];
        
    }];
    
    _mytableview.mj_footer=foot;
    
}



-(void)viewWillAppear:(BOOL)animated {
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];

    
    _shopDataArray=[[GoodShopManagement shareInstance] getStoresdataInfo];
    
    if (!TR_IsNetWork) {
        _dataStoreArr=nil;
       
        [self loadNotworkdata];
    }
    
    [_mytableview reloadData];
    
    [self addOrederinfoBroadcast];

}

-(void)viewDidAppear:(BOOL)animated {
    

}


- (void) loadshoptip {
    
    if (!_shoptiplabel) {
        _shoptiplabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,10,10)];
       
        _shoptiplabel.layer.cornerRadius=5;
        _shoptiplabel.textAlignment=NSTextAlignmentCenter;
        _shoptiplabel.backgroundColor=[UIColor redColor];
        _shoptiplabel.font=[UIFont systemFontOfSize:10];
        _shoptiplabel.textColor=[UIColor whiteColor];
        
    }
    
   
  
    
    
    NSInteger number=0;
    
    for (StoreDataModel *model in  _shopDataArray) {
        
        for (GoodsShopModel *goodmodel in model.goods) {
            number+=[goodmodel.goodnum integerValue];
        }
    }
    NSString *numstr=[NSString stringWithFormat:@"%ld",number];
    
    CGSize size = TR_TEXT_SIZE(numstr,_shoptiplabel.font,CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    CGFloat height = IS_RETAINING_SCREEN ? 40:30;
    _shoptiplabel.frame=CGRectMake(0,0,size.width+5,size.width+5);
    _shoptiplabel.layer.cornerRadius=(size.width+5)/2;
    _shoptiplabel.layer.masksToBounds=YES;
    _shoptiplabel.center=CGPointMake(SCREEN_WIDTH-10,height);
    [_locationView addSubview:_shoptiplabel];
    if (_shopDataArray.count==0) {
      
        _shoptiplabel.hidden=YES;
        
    }else{
       
        _shoptiplabel.hidden=NO;

        _shoptiplabel.text=[NSString stringWithFormat:@"%ld",number];
    }
    
}


- (void)loadAndRefreshDatawithshow:(BOOL)isshow {
    
    self.page=@(1);
  
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f", APP_Delegate.mylocation.longitude];
    
    [HBHttpTool post:SHOP_STORELIST params:@{@"user_long":lng,@"user_lat":lat,@"page":self.page,@"cat_url":_cat_url,@"sort_url":_sort_url} showHUD:isshow success:^(id responseDic) {
        [self.mytableview.mj_header endRefreshing];
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSArray *dataarr=[dataDict objectForKey:@"result"];
                
                self.dataStoreArr=[NSMutableArray arrayWithArray:[StoreModel arrayOfModelsFromDictionaries:dataarr error:nil]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.mytableview reloadData];
                    
                    if (dataarr.count==0) {
                        
                        [self.mytableview.mj_footer  endRefreshingWithNoMoreData];
                        
                        [self nostoresData];
                    }else{
                        self.nostoreBackView.hidden=YES;
                        
                        self.mytableview.mj_footer.hidden=NO;
                    }
                    
                    
                });
                
            }
            
            if ([[dataDict objectForKey:@"errorCode"] integerValue]==20180613) {
                self.dataStoreArr=nil;
                [self loadjiondata];
                
            }else
                self.jionBackView.hidden=YES;
            
        }
        
    } failure:^(NSError *error) {
        
         [self.mytableview.mj_header endRefreshing];
        
    }];
    

}


- (void)loadGoodsData {
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f", APP_Delegate.mylocation.longitude];
    [HBHttpTool post:SHOP_STORELIST body:@{@"user_long":lng,@"user_lat":lat,@"page":self.page,@"cat_url":_cat_url,@"sort_url":_sort_url} success:^(id responseDic){
        [self.mytableview.mj_footer endRefreshing];
        [self.mytableview.mj_header endRefreshing];

        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSArray *dataarr=[dataDict objectForKey:@"result"];
                
                if (dataarr.count!=0) {
                    
                    
                    if ([self.page integerValue]==1) {
                       
                        self.dataStoreArr=[NSMutableArray arrayWithArray:[StoreModel arrayOfModelsFromDictionaries:dataarr error:nil]];
                    }else
                        [self.dataStoreArr addObjectsFromArray:[StoreModel arrayOfModelsFromDictionaries:dataarr error:nil]];
                 
                }else{
                    
                    [self.mytableview.mj_footer  endRefreshingWithNoMoreData];
                }
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.mytableview reloadData];
                  
                    if (dataarr.count==0) {
                       
                        if ([self.page integerValue]==1) {
                            self.dataStoreArr=nil;
                             [self.mytableview reloadData];
                            [self nostoresData];
                        }else{
                            self.nostoreBackView.hidden=YES;

                        }
                    }
                });
                
            }
            
            if ([[dataDict objectForKey:@"errorCode"] integerValue]==20180613) {
                self.dataStoreArr=nil;

                [self loadjiondata];
                
            }else
                self.jionBackView.hidden=YES;
        }
        
    }failure:^(NSError *error){
        
        [self.mytableview.mj_footer endRefreshing];
        [self.mytableview.mj_header endRefreshing];

    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 110;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (!_locationView) {
      
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,120)];
     
        view.backgroundColor=[UIColor whiteColor];
        
        _locationView=view;
      
        [self designView:view];
    }
    _seachlabel.text=_dataModel.search_words;
    
    [self loadshoptip];
   
    return _locationView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _dataStoreArr.count==0?4:_dataStoreArr.count+3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
     
        return  _dataModel.banner_list.count==0?0:160;
   
    }else if(indexPath.row==1){
        
        return  _dataModel.adver_list.count==0?0:180;
        
    }else if(indexPath.row==2){
        
        return 130;
        
    } else{
            if (_dataStoreArr&&_dataStoreArr.count) {
            
            StoreModel *item=_dataStoreArr[indexPath.row-3];
            
            NSArray *data=item.tag;
                
                if (item.tag.count!=0) {
                    if ([item.isyes integerValue]!=0) {
                     
                        return 100+[self strHeighData:data];
                        
                    }else{
                        return 100+20;
                    }
                }else
                    return 100;
        }else
            return 260;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row==0) {
        
        static NSString *cellIdentifier = @"cellIdentifier1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        if (!_carouselView) {
            _carouselView = [[XRCarouselView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 150)];
            _carouselView.delegate = self;
            _carouselView.time = 3.0f;
            [cell addSubview:_carouselView];
        }
        
        if (_dataModel&&_dataModel.banner_list.count!=0) {
           
            NSArray *array=_dataModel.banner_list;
            
            _carouselView.hidden = NO;
            
            NSMutableArray *marray=[NSMutableArray array];
            
            for (BannerItem *item in array) {
                
                [marray addObject:item.pic];
            }
            _carouselView.imageArray=marray;
        }else{
            
            _carouselView.hidden = YES;
        }
        
        
        return cell;
        
    }else if(indexPath.row==1){
        
        static NSString *cellIdentifier = @"cellIdentifier2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
           
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        
        if (_dataModel.adver_list&&_dataModel.adver_list.count!=0) {
            
            [self loaddata:_dataModel.adver_list AdverList:cell];
            
        }else{
            
            for (UIView *tempView in cell.subviews) {
                
                [tempView removeFromSuperview];
                
            }
        }

        
        return cell;
        
    }else if(indexPath.row==2) {
        
        static NSString *cellIdentifier = @"cellIdentifier3";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if (!_myScrollView) {
                
                _myScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(80,10,SCREEN_WIDTH-100,100)];
                
                [cell addSubview:_myScrollView];
            }

            
            MenuItem *item=[[MenuItem alloc]initWithFrame:CGRectMake(2,10,60,MenuBtnHeigh)];
            [item addTarget:self action:@selector(menubtnclick:) forControlEvents:UIControlEventTouchUpInside];
         //   item.backgroundColor=TR_COLOR_RGBACOLOR_A(250,250,250,1);
            item.tag=1000;
            item.btnTieleLabel.textColor=[UIColor blackColor];
            item.btnTieleLabel.font=[UIFont systemFontOfSize:15];
            [cell addSubview:item];
            _nearbtn=item;
          
            _saleBackView=[[UIView alloc]initWithFrame:CGRectMake(0,item.frame.origin.y+item.frame.size.height+10,SCREEN_WIDTH,30)];
            _saleBackView.backgroundColor=[UIColor whiteColor];
        
            [cell addSubview:_saleBackView];

            UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setTitle:@"推荐" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.frame=CGRectMake(10,5,40,20);
            [btn1 addTarget:self action:@selector(sortbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            btn1.tag=2001;
            btn1.titleLabel.font=[UIFont systemFontOfSize:15];
            [btn1 setTitleColor:BlackColor forState:UIControlStateNormal];
            [_saleBackView addSubview:btn1];
            
            
            UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setTitle:@"销量" forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(sortbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            btn2.tag=2002;
            btn2.titleLabel.font=[UIFont systemFontOfSize:15];

            [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
            btn2.frame=CGRectMake(btn1.frame.origin.x+btn1.frame.size.width+30,5,40,20);
            [_saleBackView addSubview:btn2];

            UIButton *btn3=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn3 setTitle:@"距离" forState:UIControlStateNormal];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn3 addTarget:self action:@selector(sortbtnclick:) forControlEvents:UIControlEventTouchUpInside];
            btn3.tag=2003;
            [btn3 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
            btn3.titleLabel.font=[UIFont systemFontOfSize:15];

            btn3.frame=CGRectMake(btn2.frame.origin.x+btn2.frame.size.width+30,btn2.frame.origin.y,40,20);
            
             [_saleBackView addSubview:btn3];
            
            CGRect rect=[_saleBackView convertRect:_saleBackView.frame toView:_mytableview];
            
            _sortPointY=rect.origin.y+80;
            
        }
        

        
        if (_dataModel.slider_list.count!=0) {
           
            SliderItem *slitem1=_dataModel.slider_list[0];
            
            MenuItem *item =[cell viewWithTag:1000];
            
           // item.btnTieleLabel.text= [_classArray firstObject];  //slitem1.name;
            
            item.btnTieleLabel.text = slitem1.name;;
            
            [item.btnImgView sd_setImageWithURL:[NSURL URLWithString:slitem1.pic] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
           // item.btnImgView.image=[UIImage imageNamed:[_picClassArray firstObject]];
            
            for (int i=1; i<_dataModel.slider_list.count; i++) {

                SliderItem *slitem=_dataModel.slider_list[i];
                
                MenuItem * mitem= (MenuItem *) [_myScrollView viewWithTag:1000+i];
                if (!mitem) {
                    mitem=[[MenuItem alloc]initWithFrame:CGRectMake((MenuBtnWidth+10)*(i-1),0,MenuBtnWidth,MenuBtnHeigh)];
                }
                
                mitem.tag=1000+i;
                mitem.selected=NO;
                [mitem.btnImgView sd_setImageWithURL:[NSURL URLWithString:slitem.pic] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
                [mitem addTarget:self action:@selector(menubtnclick:) forControlEvents:UIControlEventTouchUpInside];
                mitem.btnTieleLabel.text = slitem.name;
                [_myScrollView addSubview:mitem];
            }
           _myScrollView.contentSize=CGSizeMake((_dataModel.slider_list.count)*(MenuBtnWidth),100);
         
        }
        
        return cell;
        
    }else {
    
        static NSString *cellIdentifier = @"cellIdentifier";
        
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell==nil) {
            cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            [cell.arrowBtn addTarget:self action:@selector(activitybtnclick:) forControlEvents:UIControlEventTouchUpInside];
        }

        if (_dataStoreArr&&_dataStoreArr.count!=0&&indexPath.row>=3) {
            
            StoreModel *model=_dataStoreArr[indexPath.row-3];
            
            cell.storenamelabel.text=model.name;
            
            cell.shopTypeimageV.hidden = [model.delivery_system isEqualToString:@"1"] ? NO:YES;
            
            [self loadsetTip:model andtipCell:cell];
            
            [cell.picimgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
            
            [cell setstartnum: [model.star integerValue]];
            
            cell.salelabel.text=[NSString stringWithFormat:@"月销%@ | %@%@ | %@",model.month_sale_count,model.delivery_time,model.delivery_time_type,model.range];
            
            cell.pricePeilabel.text=[NSString stringWithFormat:@"起送¥%@ | 配送费¥%@ | 人均¥%@",model.delivery_price,model.delivery_money,model.permoney];
            
            if ([model.is_close integerValue]==1) {
                cell.closelabel.hidden=NO;
            }else
                cell.closelabel.hidden=YES;
            
            if (model.coupon_list.count!=0&&model.tag.count!=0) {

                NSArray *data=model.tag;

                if ([model.isyes integerValue]!=0) {
                    
                    cell.arrowBtn.transform=CGAffineTransformMakeRotation(M_PI);

                    [cell.customCapacityView loadActivitys:data withisYes:YES andWidth:SCREEN_WIDTH- 100 -40];

                }else{
                    cell.arrowBtn.transform=CGAffineTransformMakeRotation(0);

                    [cell.customCapacityView loadActivitys:data withisYes:NO andWidth:SCREEN_WIDTH- 100 -40];
                }

               
                cell.customCapacityView.hidden=NO;
                
                CGFloat heigh=[self strHeighData:data];
                
                if (heigh>30) {
                    
                    cell.arrowBtn.hidden=NO;
                    
                }else
                    cell.arrowBtn.hidden=YES;
                                
            }else{
                cell.customCapacityView.hidden=YES;
                cell.arrowBtn.hidden=YES;
            }
            
            if ([model.is_new_shop integerValue] == 1) {
                
                cell.tipimageView.image = [UIImage imageNamed:@"newshop"];
                
                cell.tipimageView.hidden = NO;
                
            }else{
                
                if ([model.is_brand integerValue]==1) {
                    
                    cell.tipimageView.image = [UIImage imageNamed:@"plshop"];
                    
                    cell.tipimageView.hidden=NO;
                    
                }else
                    cell.tipimageView.hidden=YES;
                
            }
            
            cell.hidden=NO;

        }else
            cell.hidden=YES;
        
        return cell;
    }
}



- (void) loadsetTip:(StoreModel *)model andtipCell:(HomeTableViewCell *)cell {
  
    cell.tipNumberlabel.hidden=YES;
    for (StoreDataModel *mmodel in _shopDataArray) {
        
        if ([mmodel.store_id isEqualToString:model.store_id]) {
            NSInteger num=0;
            for (GoodsShopModel *xmodel in mmodel.goods) {
                num+=[xmodel.goodnum integerValue];
            };
            
            NSString *str=[NSString stringWithFormat:@"%ld",num];
    
            if (mmodel.goods.count==0) {
               
                cell.tipNumberlabel.hidden=YES;
                
            }else{
              
                cell.tipNumberlabel.hidden=NO;
                cell.tipNumberlabel.text=str;
                cell.tipNumberlabel.layer.cornerRadius=(20)/2;
                cell.tipNumberlabel.layer.masksToBounds=YES;
          
                [cell.tipNumberlabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(20,20));
                }];
            }

        }
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
        if (_dataStoreArr&&_dataStoreArr.count!=0&&indexPath.row>=3) {
            
            StoreModel *model=_dataStoreArr[indexPath.row-3];
    //点击cell 进行转换界面

            BusinessViewController *tempC = [[BusinessViewController alloc]init];
    
            tempC.storeID = model.store_id;
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];

            [self.navigationController pushViewController:tempC animated:YES];
    }
}


- (BOOL)contrastDisplayindexPatj:(NSIndexPath *)indexpath {
    
    if (_selectedArray&&_selectedArray.count!=0) {
        
        for (NSIndexPath *index in _selectedArray) {
            
            if (index.row==indexpath.row==index.section==indexpath.section) {
                
                return YES;
            }
        }
        return NO;
    }else
        return NO;
}


- (void) activitybtnclick:(UIButton *) button {
    
    
    HomeTableViewCell *cell=(HomeTableViewCell *)button.superview;
    
    NSIndexPath *indexpath=[_mytableview indexPathForCell:cell];
    
    StoreModel *model=_dataStoreArr[indexpath.row-3];

    if ([model.isyes integerValue]!=0) {
       
        model.isyes=@"0";
     
        [_mytableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];

    }else{
        model.isyes=@"1";
      
        [_mytableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];

    }
    
}




#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    
    if (_dataModel.banner_list.count!=0) {
        BannerItem *item=_dataModel.banner_list[index];
    
        if ([item.type isEqualToString:@"0"] && item.url.length > 0) {
            //H5
            PersonalWebController *webvc=[[PersonalWebController alloc]init];
            webvc.weburl=item.url;
           webvc.viewName=@"活动";
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
            [self.navigationController pushViewController:webvc animated:YES];
            
        }
        
        
        if ([item.type isEqualToString:@"1"] && item.redirection.length > 0) {
            //分类
            for (SliderItem *model in _dataModel.slider_list) {
                
                if ([model.cat isEqualToString:item.redirection]) {
                    
                    MenuItem *btn = [_myScrollView viewWithTag: 1000 + [_dataModel.slider_list indexOfObject:model]];
                    
                    if (btn) {
                        
                        [self menubtnclick:btn];
                    }
                    
                    break;
                    
                }
            }
            
            
        }
        
        if ([item.type isEqualToString:@"2"] && item.redirection.length > 0) {
            //店铺
            BusinessViewController *tempC = [[BusinessViewController alloc]init];
         
            tempC.storeID = item.redirection;
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
            
            [self.navigationController pushViewController:tempC animated:YES];
            
        }
        
        if ([item.type isEqualToString:@"3"] && item.url.length > 0) {
            
            
        }
        
    }
}

-(void)updatelocationmess:(NSNotification *)object{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.locationArray.count > 0) {
        BMKPoiInfo *poiInfo=[APP_Delegate.locationArray firstObject];
        APP_Delegate.addressName=poiInfo.name;
        [_locationbtn loadDataAdress:poiInfo.name];
    }
}


-(void)designView:(UIView *) view{
    CGFloat height = IS_RETAINING_SCREEN ? 10 : 0;
   UIView *firstV = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, view.frame.size.height)];
    firstV.backgroundColor = [UIColor whiteColor];
    [view addSubview:firstV];
    
    UIImageView *leftlabel=[[UIImageView alloc]init];
    [firstV addSubview:leftlabel];
    
    leftlabel.image=[UIImage imageNamed:@"root_locationpic"];
    [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        
        make.top.mas_equalTo(37);
        
        make.size.mas_equalTo(CGSizeMake(12,15));
        
    }];
    
    _locationbtn=[[SeachBtn alloc]init];
    _locationbtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_locationbtn addTarget:self action:@selector(locationAdressbtn:) forControlEvents:UIControlEventTouchUpInside];
        [firstV addSubview:_locationbtn];
        [_locationbtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(leftlabel.mas_right).offset(10);

            make.top.mas_equalTo(35);

            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH -60, 20));
        }];
    
       [_locationbtn loadDataAdress:@"定位中..."];
    
    UIButton *shoppingcarbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shoppingcarbtn addTarget:self action:@selector(shoppingcarbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [shoppingcarbtn setImage:[UIImage imageNamed:@"root_shoppingcarpic"] forState:UIControlStateNormal];
    [firstV addSubview:shoppingcarbtn];
    
    [shoppingcarbtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH-40);
        
        make.top.mas_equalTo(30);
        
        make.size.mas_equalTo(CGSizeMake(40,30));
        
    }];
    UIView *mview =[[UIView alloc]init];
    mview.layer.borderColor=TR_COLOR_RGBACOLOR_A(240,240,240,1).CGColor;
    mview.layer.borderWidth=1;
    mview.layer.cornerRadius=3;
    mview.layer.masksToBounds=YES;
    
    [firstV addSubview:mview];

    [mview mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(firstV.mas_right).offset(-9);
        make.top.equalTo(firstV.mas_bottom).offset(-51);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20,35));
    }];
    
       _seachBtn=[[UIButton alloc]init];

       [_seachBtn addTarget:self action:@selector(seachbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    
       [firstV addSubview:_seachBtn];
    
      UIImageView *mimgview=[[UIImageView alloc]init];
    
      mimgview.image=[UIImage imageNamed:@"root_seachpic"];
      [_seachBtn addSubview:mimgview];
    
      [mimgview mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(15,15));
        
      }];
    
    UILabel *mtitlelabel=[[UILabel alloc]init];
    mtitlelabel.textAlignment=NSTextAlignmentLeft;
    mtitlelabel.textColor=TR_COLOR_RGBACOLOR_A(85,85,85,1);
    mtitlelabel.text=_dataModel.search_words;
    mtitlelabel.font=[UIFont italicSystemFontOfSize:14];
    [_seachBtn addSubview:mtitlelabel];
    _seachlabel=mtitlelabel;
    [mtitlelabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(mimgview.mas_right).offset(10);
        make.top.mas_equalTo(7);
        make.height.mas_equalTo(20);
    }];
    
       [_seachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(firstV.mas_right).offset(-10);
            make.top.equalTo(firstV.mas_bottom).offset(-50);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20,40));
       }];
    
    
}


- (void)shoppingcarbtnclick:(UIButton *) button {
    ShoppingCarViewController *shoppingVC=[[ShoppingCarViewController alloc]init];
    [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:shoppingVC animated:YES];
    
}


- (void) loaddata:(NSArray *)array AdverList:(UIView *)addView  {
    
    CGFloat interval=15;
    
    CGFloat mwidth=(SCREEN_WIDTH-20-2*interval)/3;
    
        if (array&&array.count!=0) {
            
            for (UIView *view in addView.subviews) {
                
                if (view.tag/2000==0) {
                    
                    [view removeFromSuperview];
                    
                }
            }
            
            for (int i=0; i<array.count; i++) {
                
                AdverItem *item=array[i];
                
                UIImageView *imgview=[[UIImageView alloc]init];
                imgview.tag=2000+i;
                [imgview sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
                imgview.contentMode=UIViewContentModeScaleAspectFit;
                [addView addSubview:imgview];
                
                imgview.frame=CGRectMake(10+(mwidth+interval)*i,10,mwidth,160);
                
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag=5000+i;
                btn.backgroundColor=[UIColor clearColor];
                [btn addTarget:self action:@selector(adveritembtnclick:) forControlEvents:UIControlEventTouchUpInside];
                btn.frame=CGRectMake(10+(mwidth+interval)*i,10,mwidth,160);
                [addView addSubview:btn];
                
            }
    
    }
    
}

- (void)adveritembtnclick:(UIButton *) button {
    
    if (_dataModel.adver_list.count!=0) {
       
        AdverItem *item=_dataModel.adver_list[button.tag-5000];
        
        if (item.url&&item.url.length!=0) {
            PersonalWebController *webvc=[[PersonalWebController alloc]init];
            
            
            NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
            NSString *lng=[NSString stringWithFormat:@"%f", APP_Delegate.mylocation.longitude];
            
            //ty == 2  ios 设置
            NSString *url = [NSString stringWithFormat:@"https://www.dianbeiwaimai.cn/upload/new_user/?latitude=%@&longitude=%@&ty=2&activity_type=%ld",lat,lng,button.tag-5000 + 1];
            
            webvc.weburl=url;
            
            [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
            
            [self.navigationController pushViewController:webvc animated:YES];
        }
    }
}


- (void)locationAdressbtn:(UIButton *) button {
    
    AdressLocationViewController *adresslocationVC=[[AdressLocationViewController alloc]init];
    BMKPoiInfo *poiInfo=[APP_Delegate.locationArray firstObject];
    adresslocationVC.userLocation=APP_Delegate.userLocation;
    adresslocationVC.cityStr= [poiInfo.city substringWithRange:NSMakeRange(0,poiInfo.city.length-1)];
    [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];
    [self.navigationController pushViewController:adresslocationVC animated:YES];
  
    __weak typeof(self) weakSelf = self;

    adresslocationVC.cityAdressblock = ^(NSString *adressname, CLLocationCoordinate2D userLocation) {
        [weakSelf.locationbtn loadDataAdress:adressname];
        APP_Delegate.addressName=adressname;
        APP_Delegate.mylocation=userLocation;
        [weakSelf.mytableview.mj_footer  resetNoMoreData];
        [weakSelf loadAndRefreshDatawithshow:YES];
        [weakSelf loaddataManagementwithshow:YES];
        [weakSelf.mytableview setContentOffset:CGPointZero animated:YES];
        
    };
}


- (CGFloat)strHeighData:(NSArray *)data {
    
    CGFloat total=SCREEN_WIDTH- 100 -40;
    
    NSInteger num=0;
    
    CGFloat totalwidth=0;
    
    BOOL isyes=NO;
    
    for (int i=0;i<data.count; i++) {

        NSString *str=data[i];
        
        if (str.length!=0) {
         
            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            
            CGSize retSize = [str boundingRectWithSize:CGSizeMake(0,20)
                                               options:\
                              NSStringDrawingTruncatesLastVisibleLine |
                              NSStringDrawingUsesLineFragmentOrigin |
                              NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
            
            totalwidth+=retSize.width+5+10;
            
            if (totalwidth>total) {
                totalwidth=retSize.width+5+10;
                num++;
                isyes=YES;
            }
        }
    }
    
    if (data.count!=0) {
        if (isyes) {
            return  30*(num+1);

        }else
            return 0;
    }else
        return 0;
}


- (void)menubtnclick:(MenuItem *)menuitem {
    
    NSInteger num=menuitem.tag-1000;
    
    SliderItem *slitem=_dataModel.slider_list[num];
    
    if (menuitem.tag==1000) {
        _nearbtn.btnTieleLabel.textColor=[UIColor blackColor];
        _nearbtn.btnTieleLabel.font=[UIFont boldSystemFontOfSize:16];
    }else{
        _nearbtn.btnTieleLabel.textColor=[UIColor grayColor];
        _nearbtn.btnTieleLabel.font=[UIFont systemFontOfSize:12];
        menuitem.btnTieleLabel.textColor=[UIColor blackColor];
        menuitem.btnTieleLabel.font=[UIFont boldSystemFontOfSize:16];
    }
  
    for (MenuItem *item in _myScrollView.subviews) {
        
        if (item.tag/1000==1) {
            if (item.tag!=menuitem.tag) {
                item.backgroundColor=[UIColor whiteColor];
                item.btnTieleLabel.textColor=[UIColor grayColor];
                item.btnTieleLabel.font=[UIFont systemFontOfSize:12];
            }
        }
    }
  
    CGFloat maxoffset=_myScrollView.contentSize.width-_myScrollView.size.width;
    
    CGFloat centerOffset=menuitem.frame.origin.x-_myScrollView.frame.size.width/2+menuitem.frame.size.width;
    
    if (menuitem.tag!=1000) {
        
        [UIView animateWithDuration:ANIMATIONDURATION animations:^{
            
            if (centerOffset>maxoffset) {
                
        self.myScrollView.contentOffset=CGPointMake(maxoffset,menuitem.frame.origin.y);
                
            } else if (centerOffset<=0){
                
                self.myScrollView.contentOffset=CGPointMake(0,menuitem.frame.origin.y);
                
            }else
        self.myScrollView.contentOffset=CGPointMake(centerOffset,menuitem.frame.origin.y);
            
        }completion:^(BOOL finished) {

        }];
    }
    
    _cat_url = slitem.cat;
    [self loaddataManagementwithshow:YES];
    [self loadAndRefreshDatawithshow:YES];

}

- (void)sortbtnclick:(UIButton *) button{
    
    if (button.tag==2001) {
       
        _sort_url=@" ";
        
        [button setTitleColor:BlackColor forState:UIControlStateNormal];
        UIButton *btn1=[_saleBackView viewWithTag:2002];
        
        UIButton *btn2=[_saleBackView viewWithTag:2003];
        [btn1 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
        [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];

        
    }
   
    if (button.tag==2002) {
      
        _sort_url=@"sale_count";
        
        [button setTitleColor:BlackColor forState:UIControlStateNormal];
        UIButton *btn1=[_saleBackView viewWithTag:2001];
        UIButton *btn2=[_saleBackView viewWithTag:2003];
        [btn1 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
        [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
    }
    
    
    if (button.tag==2003) {
        
        _sort_url=@"juli";
        [button setTitleColor:BlackColor forState:UIControlStateNormal];

        UIButton *btn1=[_saleBackView viewWithTag:2001];
        
        UIButton *btn2=[_saleBackView viewWithTag:2002];
        [btn1 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
        [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(152,152,152,1) forState:UIControlStateNormal];
    }
    
    [self loadAndRefreshDatawithshow:YES];
    
}


- (void)seachbtnclick:(UIButton *) button {
    
    SeachStoreListViewController *seachStoreVC=[[SeachStoreListViewController alloc]init];
    seachStoreVC.tipseach=_dataModel.search_words;
    [APP_Delegate.rootViewController setTabBarHidden:YES animated:YES];

    [self.navigationController pushViewController:seachStoreVC animated:YES];
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (!_rideTypeView.hidden) {
        
        CGRect rect = _rideTypeView.frame;
        
        if (rect.origin.x < SCREEN_WIDTH - 50) {
            
            [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                
                self->_rideTypeView.frame = CGRectMake(SCREEN_WIDTH - 50, rect.origin.y, rect.size.width, rect.size.height);
                
            }];
            
        }
        
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:2 inSection:0];
    
    CGRect mrect=[_mytableview rectForRowAtIndexPath:indexpath];
 
    if (scrollView.contentOffset.y>=(mrect.origin.y-35)) {
        
       CGRect rect=mrect;
     
        rect.origin.y=120;
        rect.size.height=_saleBackView.frame.size.height;
        _saleBackView.frame=rect;
       
        [self.view addSubview:_saleBackView];
        
    }else{
       
        _saleBackView.frame=CGRectMake(0,20+MenuBtnHeigh,SCREEN_WIDTH,30);
        
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:2 inSection:0];
        
        UITableViewCell *cell=[_mytableview cellForRowAtIndexPath:indexpath];
        
        [cell addSubview:_saleBackView];
        
    }
}





-(void)addOrederinfoBroadcast{
    
    if (!GetUser_Login_State) {
        
        return;
        
    }
    
    [_rideTypeView addDatatoView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

