//
//  OrderManagerEvaluationViewController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "OrderManagerEvaluationViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
#import  <MobileCoreServices/MobileCoreServices.h>
#import "OrderStarView.h"
#import "OrderDetailsModel.h"
#import "StoreDetailsModel.h"

@interface OrderManagerEvaluationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property(nonatomic,strong)UIScrollView *bottomScrollView;

@property(nonatomic,strong)UIImageView *userimageView;

@property(nonatomic,strong)UILabel *shopnameLabel;

@property(nonatomic,strong)OrderStarView *shopcommentView;

@property(nonatomic,strong)UIView *choosetypeView;

@property(nonatomic,strong)UITextView *descripTextView;

@property(nonatomic,strong)UICollectionView *imagechooseView;

@property(nonatomic,strong)UIView *goodscommentView;

@property(nonatomic,strong)UIImageView *riderimageView;

@property(nonatomic,strong)UILabel *ridernameLabel;

@property(nonatomic,strong)UILabel *sendtimeLabel;

@property(nonatomic,strong)OrderStarView *ridercommentView;

@property(nonatomic,strong)UIView *ridertypeView;

@property(nonatomic,strong)UIButton *nameselectBtn;

@property(nonatomic,strong)UIButton *reportcommentBtn;

@property(nonatomic,strong)NSMutableArray *imageSelectArray;

@property (nonatomic, strong) NSArray *goodsArray;

@property (nonatomic, strong) OrderDetailsModel *detailsModel;

@property (nonatomic, strong) NSMutableArray *selectgoodArray;

@property (nonatomic, strong) NSMutableArray *selesctriderArray;

@end


@implementation OrderManagerEvaluationViewController

{
    UIImagePickerController *_controller;
    
    NSString *statusStr;
    
    NSArray *shopCommentArray;
    
    NSArray *riderCommentArray;
    
    NSMutableSet *shopCommentSet;
    NSMutableSet *riderComentSet;
    
    NSMutableArray *urlDatasource;
}


-(UIScrollView *)bottomScrollView{
    if (_bottomScrollView == nil) {
        _bottomScrollView = [[UIScrollView alloc]init];
        _bottomScrollView.backgroundColor = [UIColor whiteColor];
        _bottomScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.5);
        [self.view addSubview:_bottomScrollView];
    }
    return _bottomScrollView;
    
}

-(UIImageView *)userimageView{
    if (_userimageView == nil) {
        _userimageView = [[UIImageView alloc]init];
        _userimageView.backgroundColor = [UIColor whiteColor];
        _userimageView.layer.cornerRadius = 25.f;
        _userimageView.layer.masksToBounds = YES;
        [_userimageView sd_setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        [_bottomScrollView addSubview:_userimageView];
    }
    return _userimageView;
}

-(UILabel *)shopnameLabel{
    if (_shopnameLabel == nil) {
        _shopnameLabel = [[UILabel alloc]init];
        _shopnameLabel.text = _model.name;
        _shopnameLabel.font = TR_Font_Gray(20);
        _shopnameLabel.textColor = [UIColor blackColor];
        [_bottomScrollView addSubview:_shopnameLabel];
    }
    return _shopnameLabel;
}


-(UIView *)shopcommentView{
    
    if (_shopcommentView == nil) {
        _shopcommentView = [[OrderStarView alloc]init];
        _shopcommentView.backgroundColor = [UIColor whiteColor];
        [_bottomScrollView addSubview:_shopcommentView];
        
    }
    return _shopcommentView;
}


-(UIView *)choosetypeView{
    if (_choosetypeView ==nil) {
        _choosetypeView = [[UIView alloc]init];
        _choosetypeView.backgroundColor = [UIColor whiteColor];
        [_bottomScrollView addSubview:_choosetypeView];
        [self createwithViewWith:_choosetypeView];
    }
    return _choosetypeView;
}


-(UITextView *)descripTextView{
    if (_descripTextView == nil) {
        _descripTextView = [[UITextView alloc]init];
        _descripTextView.text = @"说说对商家的评价";
        _descripTextView.font = TR_Font_Gray(15);
        _descripTextView.delegate = self;
        _descripTextView.textColor = [UIColor grayColor];
        _descripTextView.layer.borderWidth = 1.0f;
        _descripTextView.layer.borderColor = [UIColor grayColor].CGColor;
        [_bottomScrollView addSubview:_descripTextView];
    }
    return _descripTextView;
}

-(UICollectionView *)imagechooseView{
   
    if (_imagechooseView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 5 * 10) / 4, 80);
        
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _imagechooseView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -0, SCREEN_WIDTH,100) collectionViewLayout:layout];;
        _imagechooseView.backgroundColor = [UIColor whiteColor];
        _imagechooseView.delegate = self;
        _imagechooseView.dataSource = self;
        [_bottomScrollView addSubview:_imagechooseView];
    }
    return _imagechooseView;
}

-(UIView *)goodscommentView{
    if (_goodscommentView == nil) {
        _goodscommentView = [[UIView alloc]init];
        _goodscommentView.backgroundColor = [UIColor whiteColor];
        [_bottomScrollView addSubview:_goodscommentView];
        [self designGoodsCommentView:_model.goods_list];
    }
    return _goodscommentView;
}



-(UIImageView *)riderimageView{
    if (_riderimageView == nil) {
        _riderimageView = [[UIImageView alloc]init];
        _riderimageView.backgroundColor = [UIColor whiteColor];
        _riderimageView.layer.cornerRadius = 25.f;
        _riderimageView.layer.masksToBounds = YES;
        _riderimageView.image = [UIImage imageNamed:PLACEHOLDIMAGE];
        [_bottomScrollView addSubview:_riderimageView];
    }
    return _riderimageView;
}


-(UILabel *)ridernameLabel{
    if (_ridernameLabel == nil) {
        _ridernameLabel = [[UILabel alloc]init];
        _ridernameLabel.text = @"骑士 张三丰";
        _ridernameLabel.font = TR_Font_Gray(20);
        _ridernameLabel.textColor = [UIColor blackColor];
        [_bottomScrollView addSubview:_ridernameLabel];
    }
    return _ridernameLabel;
}

-(UILabel *)sendtimeLabel{
    if (_sendtimeLabel == nil) {
        _sendtimeLabel = [[UILabel alloc]init];
        _sendtimeLabel.text = @"送达时间 12:00";
        _sendtimeLabel.font = TR_Font_Gray(15);
        _sendtimeLabel.textColor = [UIColor blackColor];
        [_bottomScrollView addSubview:_sendtimeLabel];
    }
    return _sendtimeLabel;
}

-(OrderStarView*)ridercommentView{
    
    if (_ridercommentView == nil) {
        _ridercommentView = [[OrderStarView alloc]init];
        _ridercommentView.backgroundColor = [UIColor whiteColor];
        [_bottomScrollView addSubview:_ridercommentView];
    }
    return _ridercommentView;
}


-(UIView *)ridertypeView{
    if (_ridertypeView ==nil) {
        _ridertypeView = [[UIView alloc]init];
        _ridertypeView.backgroundColor = [UIColor whiteColor];
        [_bottomScrollView addSubview:_ridertypeView];
        [self createwithViewWith:_ridertypeView];
    }
    return _ridertypeView;
}

-(UIButton *)nameselectBtn{
    
    if (_nameselectBtn == nil) {
        _nameselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nameselectBtn setImage:[UIImage imageNamed:@"comment_niming"] forState:UIControlStateNormal];
        [_nameselectBtn setImage:[UIImage imageNamed:@"order_noselect"] forState:UIControlStateSelected];
        [_nameselectBtn setTitle:@"匿名" forState:UIControlStateNormal];
        [_nameselectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nameselectBtn addTarget:self action:@selector(changeCommentState:) forControlEvents:UIControlEventTouchUpInside];
        _nameselectBtn.titleLabel.font = TR_Font_Gray(15);
        _nameselectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _nameselectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_bottomScrollView addSubview:_nameselectBtn];
        
    }
    return _nameselectBtn;
}

-(UIButton *)reportcommentBtn{
    
    if (_reportcommentBtn == nil) {
        _reportcommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportcommentBtn.backgroundColor = TR_MainColor;
        [_reportcommentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reportcommentBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_reportcommentBtn addTarget:self action:@selector(reportCommentAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_reportcommentBtn];
    }
    return _reportcommentBtn;
}

-(NSMutableArray *)imageSelectArray{
    if (_imageSelectArray == nil) {
        _imageSelectArray = [NSMutableArray array];
    }
    return _imageSelectArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isBackBtn = YES;
    self.titleName = @"评价晒单";
    shopCommentSet = [NSMutableSet set];
    riderComentSet = [NSMutableSet set];
    _selectgoodArray=[NSMutableArray array];
    
    _selesctriderArray=[NSMutableArray array];
    urlDatasource = [NSMutableArray array];
    riderCommentArray = @[@"衣着规范",@"服务热情",@"非常准时",@"态度恶劣",@"餐品损坏",@"未按时送"];
    
    shopCommentArray =@[@"味道极赞",@"包装精美",@"服务周到",@"不新鲜",@"口味难吃",@"包装劣质"];
    
    // Do any additional setup after loading the view.
    [self loadAndRefreshData];
    
}








-(void)designViewWithData:(NSDictionary *)result{
    
    __weak typeof(self) weakSelf=self;
    
    [self.bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.superY+5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT));
    }];
    
    [self.userimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    [self.shopnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userimageView.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.userimageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 80, 20));
    }];
    
    [self.shopcommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.userimageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(220, 50));
    }];
    
    self.shopcommentView.countBlock = ^(CGFloat countnum) {
        [weakSelf fixConmentListWithScore:countnum withType:@"1"];
    };
   
    [self.choosetypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.shopcommentView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
    
    
    
    [self.descripTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.choosetypeView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 100));
        
    }];
    
    
    [self.imagechooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.descripTextView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
   
    [self.imagechooseView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  
    [self.goodscommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.imagechooseView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30 * weakSelf.model.goods_list.count - 10));
        
    }];
    

    [self.riderimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.userimageView.mas_left);
        make.top.mas_equalTo(weakSelf.goodscommentView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    self.ridernameLabel.text=[NSString stringWithFormat:@"%@",_detailsModel.deliver_info[@"name"]];
    
    [self.ridernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.riderimageView.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf.riderimageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(200,20));
    }];
    
    self.sendtimeLabel.text=[NSString stringWithFormat:@"送达时间 %@",_detailsModel.expect_use_time];
    
    [self.sendtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.riderimageView.mas_right).offset(10);
        make.bottom.mas_equalTo(weakSelf.riderimageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.ridercommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.riderimageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(220, 50));
        
    }];
    
    self.ridercommentView.countBlock = ^(CGFloat countnum) {
        [weakSelf fixConmentListWithScore:countnum withType:@"2"];
    };
    
    [self.ridertypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.ridercommentView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
        
    }];
    
    [self.nameselectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(weakSelf.ridertypeView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [self.reportcommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    
    
    if ([self.model.deliver_type isEqualToString:@"1"]) {
       
        [self.riderimageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 0));
        }];
        
       // self.ridernameLabel.text=[NSString stringWithFormat:@"%@",_detailsModel.deliver_info[@"name"]];
        
        [self.ridernameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200,0));
        }];
        
       // self.sendtimeLabel.text=[NSString stringWithFormat:@"送达时间 %@",_detailsModel.expect_use_time];
        
        [self.sendtimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 0));
        }];
        
        [self.ridercommentView removeFromSuperview];
        [self.ridercommentView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(220, 0));
            
        }];
        
        [self.ridertypeView removeFromSuperview];
        
        [self.ridertypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0));
            
        }];
        
        _bottomScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
        
    }
    
    [self.view layoutIfNeeded];
    
}



-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)fixConmentListWithScore:(CGFloat)score withType:(NSString *)type{
    
    if ([type isEqualToString:@"1"]) {
        //商家评价
        if (score < 3) {
            shopCommentArray = @[@"不新鲜",@"口味难吃",@"包装劣质",@"不卫生",@"接单慢",@"其他原因"];
            
            
        }else{
            
            shopCommentArray = @[@"味道极赞",@"包装精美",@"独具特色",@"服务周到",@"干净卫生",@"其他原因"];
        }
        [shopCommentSet removeAllObjects];
        [self createwithViewWith:_choosetypeView];
    }
    
    if ([type isEqualToString:@"2"]) {
        //骑士评价
        
        if (score < 3) {
          riderCommentArray = @[@"衣着脏乱",@"态度恶劣",@"餐品损坏",@"未按时送",@"不送上楼",@"其他原因"];
            
        }else{
          riderCommentArray = @[@"衣着规范",@"服务热情",@"非常准时",@"餐品完好",@"配送专业",@"其他原因"];
            
        }
        
        [riderComentSet removeAllObjects];
        [self createwithViewWith:_ridertypeView];
    }
    
    
}


-(void)createwithViewWith:(UIView *)contentView{
    
    for (UIView *temp in contentView.subviews) {
        
        [temp removeFromSuperview];
    }
    
    CGFloat spare = 10;
    CGFloat btnwidth = ( ( SCREEN_WIDTH - 80) - spare * 2) /3;
    CGFloat btnheight = 30;
    
    for (int i = 0; i < 2; i ++) {
        
        for (int j = 0; j < 3; j ++) {
            
            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tempBtn.layer.borderWidth = 1.0f;
            tempBtn.layer.borderColor = [UIColor grayColor].CGColor;
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tempBtn setTitleColor:ORANGECOLOR forState:UIControlStateSelected];
            tempBtn.tag = 1000+ i * 3 +j;
            tempBtn.titleLabel.font = TR_Font_Gray(15);
            [tempBtn addTarget:self action:@selector(clickCommentAction:) forControlEvents:UIControlEventTouchUpInside];
            tempBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [contentView addSubview:tempBtn];
            
            if (contentView == _choosetypeView) {
                [tempBtn setTitle:shopCommentArray[i * 3 + j] forState:UIControlStateNormal];
            }else{
                [tempBtn setTitle:riderCommentArray[i * 3 + j] forState:UIControlStateNormal];
                
            }
            
            [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((btnwidth + spare) * j + 40);
                make.top.mas_equalTo((btnheight + spare) * i);
                make.size.mas_equalTo(CGSizeMake(btnwidth, btnheight));
            }];
        }
    }
    
}


-(void)designGoodsCommentView:(NSArray *)foodsArray{
    
    for (int i = 0; i < foodsArray.count; i ++) {
        
        OrderListItem *item=foodsArray[i];
      
        UILabel *nameLable = [[UILabel alloc]init];
   
        nameLable.text = item.goods_name;
     
        [self.goodscommentView addSubview:nameLable];
        
        UIButton *goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        goodBtn.tag = 1000+ i;
        [goodBtn setImage:[UIImage imageNamed:@"comment_good2"] forState:UIControlStateNormal];
        [goodBtn setImage:[UIImage imageNamed:@"comment_good1"] forState:UIControlStateSelected];
        [goodBtn addTarget:self action:@selector(changeGoodsComment:) forControlEvents:UIControlEventTouchUpInside];
        [self.goodscommentView addSubview:goodBtn];
        
        UIButton *badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        badBtn.tag = 1100+i;
        [badBtn setImage:[UIImage imageNamed:@"comment_bad2"] forState:UIControlStateNormal];
        [badBtn setImage:[UIImage imageNamed:@"comment_bad1"] forState:UIControlStateSelected];
        [badBtn addTarget:self action:@selector(changeGoodsComment:) forControlEvents:UIControlEventTouchUpInside];
        [self.goodscommentView addSubview:badBtn];
        
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.top.mas_equalTo((20 + 10)* i );
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        [badBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.centerY.mas_equalTo(nameLable.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(badBtn.mas_left).offset(-40);
            make.centerY.mas_equalTo(nameLable.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
    }
    
}


-(void)loadAndRefreshData {
    
    [HBHttpTool post:SHOP_ORDERDETAILS params:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_model.order_id} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                
                NSDictionary *dict=[dataDict objectForKey:@"result"];
                
                if (dict) {
                    
                    _detailsModel=[[OrderDetailsModel alloc]initWithDictionary:dict[@"order_details"] error:nil];
                    
                    NSArray*arry=dict[@"goods"];

                    _goodsArray=[StoreDetailsGoodsItem arrayOfModelsFromDictionaries:arry error:nil];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
               
                    [self designViewWithData:@{}];

                });
                
            }
        }
        
    }failure:^(NSError *error){
        
    }];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.imageSelectArray.count == 0) {
        
        return 1;
    }
    
    if (self.imageSelectArray.count == 3) {
        
        return self.imageSelectArray.count;
        
    }
    return self.imageSelectArray.count + 1;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc]init];
        
    }
    
    for (UIView *tempView in cell.contentView.subviews) {
        [tempView removeFromSuperview];
    }
    
    UIImageView *imageView  = [[UIImageView alloc]init];
    imageView.frame = cell.bounds;
    [cell.contentView addSubview:imageView];
    
    if (self.imageSelectArray.count == 0) {
       imageView.image = [UIImage imageNamed:@"comment_photo"];
        return cell;
    }
    
    if (self.imageSelectArray.count == 3) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlDatasource[indexPath.row]] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        [self adddeleteBtn:cell];
        return cell;
    }
    
    if (self.imageSelectArray.count > 0) {
        
        if (indexPath.row == self.imageSelectArray.count) {
            
           imageView.image = [UIImage imageNamed:@"comment_photo"];
            return cell;
        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlDatasource[indexPath.row]] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        
        [self adddeleteBtn:cell];
        return cell;
    }
    
    
    return cell;
}


-(void)adddeleteBtn:(UICollectionViewCell *)cell{
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.layer.cornerRadius = 10.0f;
    tempBtn.layer.masksToBounds = YES;
    [tempBtn setImage:[UIImage imageNamed:@"comment_delete"] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(deleteCellAtIndexpath:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:tempBtn];
    [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}


-(void)deleteCellAtIndexpath:(UIButton *)sender{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)sender.superview.superview;
    NSIndexPath *indexpath = [self.imagechooseView indexPathForCell:cell];
    if (indexpath) {
        
        [self.imageSelectArray removeObjectAtIndex:indexpath.row];
        [urlDatasource removeObjectAtIndex:indexpath.row];
        [self.imagechooseView reloadData];
        
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.imageSelectArray.count == 0) {
        //选图片   暂时
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
    
    if (self.imageSelectArray.count == 4) {
        
        return;
    }
    
    if (self.imageSelectArray.count > 0) {
        
        if (indexPath.row == self.imageSelectArray.count) {
            //还是 选图片  暂时
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
    }
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
    [picker dismissViewControllerAnimated:YES completion:nil];
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



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}






//上传图片成功后存储地址
-(void)saveIMageFile:(id)responseObj {
    
    [self.imageSelectArray addObject:responseObj[@"result"][@"pic"]];
    [urlDatasource addObject:responseObj[@"result"][@"url"]];
    
    [self.imagechooseView reloadData];
    
}


//点击商户 和骑手评价

-(void)clickCommentAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.superview  == _choosetypeView) {
        
        if (![shopCommentSet containsObject:shopCommentArray[sender.tag -1000]]) {
            [shopCommentSet addObject:shopCommentArray[sender.tag -1000]];
        }else{
            
            [shopCommentSet removeObject:shopCommentArray[sender.tag -1000]];
        }
        
    }
    
    if (sender.superview == _ridertypeView) {
        
        if (![riderComentSet containsObject:riderCommentArray[sender.tag -1000]]) {
            
           [riderComentSet addObject:riderCommentArray[sender.tag -1000]];
        }else{
            
            [riderComentSet removeObject:riderCommentArray[sender.tag - 1000]];
        }
        
    }
}


//提交评价
-(void)reportCommentAction:(UIButton *)sender{
    
    if (self.shopcommentView.selectCount == 0) {
        TR_Message(@"缺少商户评价");
        return;
    }
    
    if (self.ridercommentView.selectCount == 0 && ![self.model.deliver_type isEqualToString:@"1"]) {
        TR_Message(@"缺少骑手评价");
        return;
    }
    
    
    NSString *shopcomment = [NSString stringWithFormat:@"%.1f",self.shopcommentView.selectCount];
    NSString *ridercomment = [NSString stringWithFormat:@"%.1f",self.ridercommentView.selectCount];

    NSString *shopdetail ;
    
    if ([self.descripTextView.text isEqualToString:@"说说对商家的评价"]) {
        shopdetail =  @"";
        
    }else{
        shopdetail = self.descripTextView.text;
    }
    
    NSString *pic = [[NSMutableString alloc]init];
    if (self.imageSelectArray.count > 0) {
        
        for (int i = 0; i < self.imageSelectArray.count ; i ++) {
        
            if (i==0) {
                pic=self.imageSelectArray[i];
            }else
                pic=[NSString stringWithFormat:@"%@,%@",pic,self.imageSelectArray[i]];
           
            
        }
    }
   
    
    //店铺评价
    NSMutableString *shopcom = [[NSMutableString alloc]init];
    if (shopCommentSet.count >0) {
        for (NSString * temp in shopCommentSet) {
            [shopcom appendString:[NSString stringWithFormat:@"%@,",temp]];
        }
        [shopcom substringWithRange:NSMakeRange(1,shopcom.length-1)];
    }
    
  //  [shopcom appendString:shopdetail];
    
  //骑手评价
    NSMutableString *ridercom = [[NSMutableString alloc]init];
    if (riderComentSet.count > 0) {
        
        for (NSString *temp in riderComentSet) {
            
            [ridercom appendString:[NSString stringWithFormat:@"%@,",temp]];
        }
      
        [ridercom substringWithRange:NSMakeRange(1,ridercom.length-1)];

    }
    
    
    //是否匿名
    NSString *commentState;
    if (self.nameselectBtn.selected) {
        commentState = @"1";
        
    }else{
        
        commentState = @"0";
    }
    
    
    NSString *goodstr=@"";
    
    for (int i=0; i<_model.goods_list.count; i++) {
        
        OrderListItem *item=_model.goods_list[i];
        
        if ([item.good_comment isEqualToString:@"good"]) {
            
            goodstr=[NSString stringWithFormat:@"%@,%@",goodstr,item.goods_id];
        }
    }
    
    
    
    NSDictionary *body = @{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":_model.order_id,@"goods_ids":goodstr,@"deliver_comment":ridercom,@"textAre":shopdetail,@"pic":pic,@"whole":shopcomment,@"send_core":ridercomment,@"shop_label":shopcom,@"status":commentState};
    
    [HBHttpTool post:ORDER_COMMENTORDER params:body success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            TR_Message(@"评论成功");
            [self back];
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }

    } failure:^(NSError *error) {

    }];
    
    
}


//修改商品的点赞 差评

-(void)changeGoodsComment:(UIButton *)sender{
  
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        if (sender.tag < 1100) {
            UIButton *tempBtn = [self.goodscommentView viewWithTag:sender.tag + 100];
            tempBtn.selected = NO;
            OrderListItem *item=_model.goods_list[sender.tag-1000];
            item.good_comment = @"good";
         
        }else{
            
            UIButton *tempBtn = [self.goodscommentView viewWithTag:sender.tag - 100];
            tempBtn.selected = NO;
            
            OrderListItem *item=_model.goods_list[sender.tag-1100];
            item.good_comment = @"bad";
            
        }
    }
    
}




//是否匿名
-(void)changeCommentState:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
}

#pragma mark textView-delegate


- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"说说对商家的评价"]) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.textColor = [UIColor grayColor];
        textView.text = @"说说对商家的评价";
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.descripTextView endEditing:YES];
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
