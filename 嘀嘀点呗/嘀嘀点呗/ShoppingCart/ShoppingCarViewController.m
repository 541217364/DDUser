//
//  ShoppingCarViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "GoodShopManagement.h"
#import "ShoppingCarCell.h"
#import "DDStores_DB.h"
#import "GoodsShonp_DB.h"
#import "BusinessViewController.h"

@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *mdataArray;

@property (nonatomic, strong) ShoppingCarCell *selectcell;

@property (nonatomic, strong) UIView *myHideView;

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isBackBtn=YES;

    self.titleName=@"购物车";
    
    UIButton *clearbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [clearbtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearbtn setTitleColor:TR_COLOR_RGBACOLOR_A(45,45,45,1) forState:UIControlStateNormal];
    clearbtn.frame=CGRectMake(SCREEN_WIDTH-60,10,50,20);
    [clearbtn addTarget:self action:@selector(allclearbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:clearbtn];
    
    
    _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.superY,self.view.frame.size.width,self.view.frame.size.height-self.superY) style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _myTableView.delegate=self;
    
    _myTableView.dataSource=self;
    
    [self.view addSubview:_myTableView];
    
    
    _myHideView = [[UIView alloc]initWithFrame:_myTableView.frame];
    
    [self.view addSubview:_myHideView];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"shop_nogoods"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_myHideView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        
        make.top.mas_equalTo(50);
        
        make.size.mas_lessThanOrEqualTo(CGSizeMake(120, 120));
    }];
    
    
    UILabel *contentLable = [[UILabel alloc]init];
    
    contentLable.text = @"还没有商品，快去逛逛吧!";
    
    contentLable.font = TR_Font_Gray(15);
    
    contentLable.textColor = TR_COLOR_RGBACOLOR_A(101, 101, 101, 1);
    
    [_myHideView addSubview:contentLable];
    
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        
        make.height.mas_equalTo(15);
        
    }];
    
    
    
    NSMutableArray *arry= [[GoodShopManagement shareInstance] getStoresdataInfo];
    
    if (arry&&arry.count!=0) {
        
        _mdataArray=[NSMutableArray arrayWithArray:arry];
       
        [_myTableView reloadData];
        
        _myHideView.hidden = YES;
    }else{
        
        _myHideView.hidden = NO;
    }

}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell=[[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       
        [cell.ordernbtn addTarget:self action:@selector(orderbtnclick:) forControlEvents:UIControlEventTouchUpInside];
      
        [cell.clearbtn addTarget:self action:@selector(clearbtnclick:) forControlEvents:UIControlEventTouchUpInside];
       
        __weak typeof(self) weakSelf=self;

        cell.selectclearloadlistBlock = ^(GoodsShopModel *model) {
            
            if ([model.goodnum integerValue]==0) {
                
                NSMutableArray *arry= [[GoodShopManagement shareInstance] getStoresdataInfo];
                                
                weakSelf.mdataArray=arry;
               
                [weakSelf.myTableView reloadData];
            }

        };
    }
    
    if (_mdataArray&&_mdataArray.count!=0) {
        
        StoreDataModel *model=_mdataArray[indexPath.row];
      
        cell.model=model;
       
        [cell.storePicImgView sd_setImageWithURL:[NSURL URLWithString:model.storeimg] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
      
        cell.storeNamelabel.text=[NSString stringWithFormat:@"%@",model.storename];
        
        CGSize size = TR_TEXT_SIZE(cell.storeNamelabel.text, cell.storeNamelabel.font, cell.storeNamelabel.frame.size, nil);
        
        [cell.rightImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(size.width + 5);
            
        }];
        
        [cell LoadStoreShoppingGoods:model.goods];
        
        if (model.activity.length!=0) {
            
            NSArray *activitys=[model.activity componentsSeparatedByString:@","];
            
            CGFloat height= [self strHeighData:activitys];
            cell.activitys=activitys;
        
            [cell.customCapacityView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-45,height));

            }];
            
            [cell.titlelabel2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(cell.customCapacityView.mas_top).offset(-10);

            }];

            if (height!=0) {
                
                [cell.customCapacityView loadActivitys:activitys withisYes:YES andWidth:SCREEN_WIDTH-45];
            }
            
        }else{

            [cell.customCapacityView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-45,0));
                
            }];
            
            [cell.titlelabel2 mas_updateConstraints:^(MASConstraintMaker *make) {
            
                make.bottom.equalTo(cell.customCapacityView.mas_top).offset(-10);

            }];
            
        }
      
        [cell storeDataForPrice];

    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mdataArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_mdataArray&&_mdataArray.count!=0) {
        
        StoreDataModel *model=_mdataArray[indexPath.row];
        NSInteger num=model.goods.count;
        
        CGFloat height=0;
        if (model.activity.length!=0) {
       
            NSArray *activitys= [model.activity componentsSeparatedByString:@","];
       
            height=[self strHeighData:activitys];
        }
        return 160+100*num+height;
        
    }else
        return 50+30+30+50+100+30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreDataModel *model=_mdataArray[indexPath.row];

    BusinessViewController *busVC=[[BusinessViewController alloc]init];
    busVC.storeID=model.store_id;
    [self.navigationController pushViewController:busVC animated:YES];
    
}


- (void) orderbtnclick:(UIButton *) button {
    
    if (button.isSelected) {
        
        ShoppingCarCell *cell=(ShoppingCarCell *) button.superview;
        
        NSIndexPath *indexpath=[_myTableView indexPathForCell:cell];
        
        StoreDataModel *model=_mdataArray[indexpath.row];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:ORDERTYPE];
        
        BusinessViewController  *businessVC=[[BusinessViewController alloc]init];
        businessVC.storeID=model.store_id;
        [self.navigationController pushViewController:businessVC animated:YES];
    }
   
    
   
}


- (void)clearbtnclick:(UIButton *) button {
    ShoppingCarCell *cell =(ShoppingCarCell*)button.superview;
    _selectcell=cell;
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"是清空该店铺，数据将无法恢复哦～" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertview.tag=1001;
    
    [alertview show];
    
  
}


- (void)allclearbtnclick:(UIButton *) buttn {
    
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"是清空购物车，数据将无法恢复哦～" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertview.tag=1000;
 
    [alertview show];
    
}


- (CGFloat)strHeighData:(NSArray *)data {
    
    CGFloat total=SCREEN_WIDTH-45;
    
    CGFloat totalheigh=0;
    
    NSInteger num=0;
    
    CGFloat totalwidth=0;
    
    
    for (int i=0;i<data.count; i++) {
        
        NSString *str=data[i];
        
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        
        CGSize retSize = [str boundingRectWithSize:CGSizeMake(0,20)
                                           options:\
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
        
        totalwidth+=retSize.width+5+10;
        
        if (totalwidth>=total) {
            totalwidth=retSize.width+5+10;
            num++;
        }
    }
    
    if (data.count!=0) {
        return  30*(num+1);
    }else
        return 0;
}



- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (alertView.tag==1000) {
        
        if (buttonIndex==0) {
            [[GoodsShonp_DB shareInstance] DeleteAll];
            
            [[DDStores_DB shareInstance] DeleteAll];
            
            NSMutableArray *arry= [[GoodShopManagement shareInstance] getStoresdataInfo];
            
            
            _mdataArray=arry;
            
            [_myTableView reloadData];
            
            _myHideView.hidden = NO;
        }
        
   
    }
    
    
    if (alertView.tag==1001) {
        
        if (buttonIndex==0) {
            NSIndexPath *indexPath=[_myTableView indexPathForCell:_selectcell];
            
            StoreDataModel *model=_mdataArray[indexPath.row];
            
            for (GoodsShopModel *gmodel in model.goods) {
                
                [[GoodsShonp_DB shareInstance] deleteFootprintInfo:gmodel];
            }
            
            DBStoreModel *smodel=[[DBStoreModel alloc]initWithDictionary:model.toDictionary error:nil];
            
            [[DDStores_DB shareInstance] deleteFootprintInfo:smodel];
            
            NSMutableArray *arry= [[GoodShopManagement shareInstance] getStoresdataInfo];
            
            
            _mdataArray=arry;
            
            [_myTableView reloadData];

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
