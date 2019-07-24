//
//  GoodsChooseViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/1.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "GoodsChooseViewController.h"
#import "SelectScrollView.h"
#import "ActivityEhibitionView.h"
#import "StoreInfo.h"

@interface GoodsChooseViewController ()

@property (nonatomic, strong) UIButton *seachbtn;

@property (nonatomic, strong) UIScrollView *superScrollView;

@property (nonatomic, strong) UIScrollView *myscrollView;

@property (nonatomic, strong) UIImageView *headimgview;

@property (nonatomic, strong) UIImageView *storeimgview;

@property (nonatomic, strong) UILabel *storenamelabel;

@property (nonatomic, strong) UILabel *sendPricelabel;

@property (nonatomic, strong) UILabel *storeTip;

@property (nonatomic, strong) UILabel *distancelabel;

@property (nonatomic, strong) UIButton *arrowBtn;

@property (nonatomic, strong) SelectScrollView *gestureView;

@property (nonatomic, assign) CGRect myrect;

@property (nonatomic, strong) ActivityEhibitionView *oneActiviEhibitonView;

@property (nonatomic, strong) NSMutableArray *activityArray;

@property (nonatomic, assign) CGFloat activtyPonitY;

@property (nonatomic, strong) StoreShopItem *storeShopItem;

@property (nonatomic, strong) NSArray *productData;

@end

@implementation GoodsChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf=self;

    _activityArray=@[@"1",@"2"];
    
    _seachbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    _seachbtn.backgroundColor=[UIColor blackColor];
    
    [self.topImageView addSubview:_seachbtn];
   
    self.topImageView.backgroundColor=[UIColor clearColor];
   
    [_seachbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.topImageView.mas_right).offset(-10);
        
         make.top.mas_equalTo(5);
        
        make.size.mas_equalTo(CGSizeMake(40,40));
    }];
    
    _superScrollView=[[UIScrollView alloc]init];
    
    _superScrollView.backgroundColor=[UIColor purpleColor];
   
    _superScrollView.frame=CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.view addSubview:_superScrollView];
    
    [self.view insertSubview:_superScrollView belowSubview:self.topImageView];
   
    [self loadinitStoreInfo];
    
    _myscrollView=[[UIScrollView alloc]init];
   
    _myscrollView.showsVerticalScrollIndicator=NO;
    
    _myscrollView.showsHorizontalScrollIndicator=NO;
   
    _myscrollView.backgroundColor=[UIColor orangeColor];
  
    [_superScrollView addSubview:_myscrollView];
    
    [_superScrollView insertSubview:_myscrollView belowSubview:_storeimgview];
   
    _myscrollView.frame=CGRectMake(0,130,SCREEN_WIDTH,SCREEN_HEIGHT-130);
    
    _arrowBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    _arrowBtn.backgroundColor=[UIColor greenColor];
    
    _arrowBtn.frame=CGRectMake(SCREEN_WIDTH-30,20, 20,20);
    
    [_myscrollView addSubview:_arrowBtn];
    
    _oneActiviEhibitonView=[[ActivityEhibitionView alloc]init];
    
    _oneActiviEhibitonView.frame=CGRectMake(10,_arrowBtn.frame.origin.y,SCREEN_WIDTH-45,20);
    
    [_myscrollView addSubview:_oneActiviEhibitonView];
    
    _gestureView=[[SelectScrollView alloc]initWithFrame:CGRectMake(0,180,SCREEN_WIDTH,SCREEN_HEIGHT-self.superY)];
    
    _gestureView.backgroundColor=[UIColor brownColor];
    
    [self.view addSubview:_gestureView];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlepan:)];
    pan.cancelsTouchesInView = NO;

    [_gestureView addGestureRecognizer:pan];
    
    _myrect=_gestureView.frame;
    
    
    CGRect activityrect=[_myscrollView convertRect:_arrowBtn.frame toView:self.view];
    
    _activtyPonitY=activityrect.origin.y+20+(_activityArray.count-1)*30;
    
    [self loadAndRefreshData];
    
}

- (void)loadAndRefreshData {
    
    [HBHttpTool post:SHOP_AJAXSHOP params:@{@"store_id":_storeID} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSDictionary *dict=[dataDict objectForKey:@"result"];
                
                _storeShopItem=[[StoreShopItem alloc]initWithDictionary:[dict objectForKey:@"store"] error:nil];
                
                _productData=[StoreProductItem arrayOfModelsFromDictionaries:[dict objectForKey:@"product_list"] error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _storenamelabel.text=_storeShopItem.name;
                    
                    [_storeimgview sd_setImageWithURL:[NSURL URLWithString:_storeShopItem.image]];
                    
                    _sendPricelabel.text=[NSString stringWithFormat:@"%@起送|%@配送",_storeShopItem.delivery_price,_storeShopItem.delivery_money];
                    
                    [_gestureView.goodshowView loadGoodsPics:_storeShopItem.images withData:_productData];
                                        
                });
            }
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
    [HBHttpTool post:SHOP_AJAXSREPLY params:@{@"store_id":@"2"} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSDictionary *dict=[dataDict objectForKey:@"result"];
                
                
              
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                  
                    
                });
            }
            
        }
        
    }failure:^(NSError *error){
        
    }];
    
    
}

- (void)handlepan:(UIPanGestureRecognizer *) sender {
    
    CGPoint point= [sender translationInView:self.view];

        [UIView animateWithDuration:0.1 animations:^{
       
            CGRect rect=_myrect;
        
            rect.origin.y=rect.origin.y+point.y;
            
            if (rect.origin.y<=self.superY) {
                rect.origin.y=self.superY;
                _gestureView.goodshowView.mytableView.scrollEnabled=YES;
            }
            
            if (rect.origin.y>=_activtyPonitY) {
             
                rect.origin.y=_activtyPonitY;
                _gestureView.goodshowView.mytableView.scrollEnabled=NO;

            }
            
            [self intsetActivityArrayPointY:rect.origin.y];
            
            _gestureView.frame=rect;
            
        }];
}


- (void)intsetActivityArrayPointY:(CGFloat)pointy {
    
    
    
    
    
}




- (void)loadinitStoreInfo  {
    
    __weak typeof(self) weakSelf=self;
    
    _headimgview=[[UIImageView alloc]init];
   
    _headimgview.backgroundColor=[UIColor purpleColor];
   
    [_superScrollView addSubview:_headimgview];
    
    [_headimgview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(0);
        
        make.size.mas_equalTo(CGSizeMake(weakSelf.superScrollView.frame.size.width,100));
        
    }];
    
    _storeimgview=[[UIImageView alloc]init];
    
    _storeimgview.layer.cornerRadius=5;
  
    _storeimgview.layer.masksToBounds=YES;
   
    _storeimgview.backgroundColor=[UIColor blueColor];
   
    [_superScrollView addSubview:_storeimgview];
    
    [_storeimgview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        
        make.top.mas_equalTo(70);
        
        make.size.mas_equalTo(CGSizeMake(70,70));
        
    }];
    
    _storenamelabel=[[UILabel alloc]init];
    
    _storenamelabel.font=[UIFont systemFontOfSize:14];
  
    _storenamelabel.text=@"肯德基(萧山店)";
    
    [_superScrollView addSubview:_storenamelabel];
   
    [_storenamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.storeimgview.mas_right).offset(10);
        
        make.top.equalTo(weakSelf.storeimgview.mas_top).offset(0);

        make.size.height.mas_equalTo(20);
        
    }];
    
    
    _storeTip=[[UILabel alloc]init];
    _storeTip.layer.cornerRadius=5;
    _storeTip.layer.masksToBounds=YES;
    _storeTip.backgroundColor=TR_COLOR_RGBACOLOR_A(250,174,96,1);
    _storeTip.font=[UIFont systemFontOfSize:14];
    _storeTip.textColor=[UIColor whiteColor];
    
    _storeTip.text=@"品牌";
   
    [_superScrollView addSubview:_storeTip];
    
    [_storeTip mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.storenamelabel.mas_right).offset(5);
        
        make.top.equalTo(weakSelf.storenamelabel.mas_top).offset(2);
        
        make.size.mas_equalTo(CGSizeMake(30,15));
        
    }];
    
    
    _sendPricelabel=[[UILabel alloc]init];
    
    _sendPricelabel.textAlignment=NSTextAlignmentLeft;
   
    _sendPricelabel.text=@"¥20起送|¥5配送";
   
    [_superScrollView addSubview:_sendPricelabel];
    
    [_sendPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.storenamelabel.mas_bottom).offset(10);
        
        make.left.equalTo(weakSelf.storenamelabel.mas_left).offset(0);
        
        make.height.mas_equalTo(20);
        
    }];
    
    _distancelabel=[[UILabel alloc]init];
    
    _distancelabel.textAlignment=NSTextAlignmentRight;
    
    _distancelabel.text=@"362|7分钟";
    
    [_superScrollView addSubview:_distancelabel];
    
    [_distancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.sendPricelabel.mas_top).offset(0);
        
        make.right.mas_equalTo(weakSelf.superScrollView.mas_right).offset(-10);
        
        make.size.height.mas_equalTo(20);
        
    }];
}



- (void)initShoppingCart {
    
    
    
    
    
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
