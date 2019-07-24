//
//  SeachStoreListViewController.m
//  点呗
//
//  Created by xgy on 2017/4/13.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SeachStoreListViewController.h"
#import "SeachGoodsValueView.h"
#import "StoreSeachModel.h"
#import "SeachListTableViewCell.h"
#import "GoodShopManagement.h"
#import "BusinessViewController.h"

@interface SeachStoreListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *mytableView;

@property (nonatomic, strong) NSArray *mdataArray;

@property (nonatomic, strong) UITextField *seachTextfield;

@property (nonatomic, strong) SeachGoodsValueView *seachGoodsView;

@property (nonatomic, strong) NSString *sort_url;

@property (nonatomic, strong) UIView *backview;

@property (nonatomic, strong) UIButton *exitbtn;

@property (nonatomic, strong) NSMutableArray *storesArray;

@property (nonatomic, strong) UIView *myHideView;

@end

@implementation SeachStoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isBackBtn=YES;
    
    _storesArray= [[GoodShopManagement shareInstance] getStoresdataInfo];
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(60,0,SCREEN_WIDTH-120,40)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.borderColor=TR_COLOR_RGBACOLOR_A(246,246,246,1).CGColor;
    backView.layer.borderWidth=1;
    [self.topImageView addSubview:backView];
    
    _seachTextfield=[[UITextField alloc]initWithFrame:CGRectMake(70,5,SCREEN_WIDTH-130,30)];
    _seachTextfield.placeholder=_tipseach;
    _seachTextfield.returnKeyType=UIReturnKeySearch;
    _seachTextfield.delegate=self;
    [_seachTextfield addTarget:self action:@selector(seachChangeValue:) forControlEvents:UIControlEventEditingChanged];
    [self.topImageView addSubview:_seachTextfield];
    
    
    _exitbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_exitbtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [_exitbtn setTitleColor:TR_COLOR_RGBACOLOR_A(45,45,45,1) forState:UIControlStateNormal];
    _exitbtn.frame=CGRectMake(SCREEN_WIDTH-50,5,40,30);
    [_exitbtn addTarget:self action:@selector(exitbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:_exitbtn];
    
    _exitbtn.hidden=YES;
    
    
    _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0,self.superY,SCREEN_WIDTH,self.view.frame.size.height-self.superY) style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.showsVerticalScrollIndicator = NO;
    _mytableView.showsHorizontalScrollIndicator = NO;
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mytableView];
    
    _seachGoodsView=[[SeachGoodsValueView alloc]initWithFrame:CGRectMake(0,self.superY,SCREEN_WIDTH,SCREEN_HEIGHT-self.superY)];
    
    [self.view addSubview:_seachGoodsView];
    
    __weak typeof(self) weakSelf=self;
    
    _seachGoodsView.selectValueBlock = ^(NSString *value) {
        
        weakSelf.seachTextfield.text=value;
        
        [weakSelf textFieldShouldReturn:weakSelf.seachTextfield];
    };
    
    _sort_url=@" ";
    
    _myHideView = [[UIView alloc]initWithFrame:_mytableView.frame];
    
    _myHideView.backgroundColor = [UIColor whiteColor];
    
    _myHideView.hidden = YES;
    
    [self.view addSubview:_myHideView];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.image = [UIImage imageNamed:@"no_store"];
    
    [_myHideView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        
        make.top.mas_equalTo(50);
        
        make.size.mas_lessThanOrEqualTo(CGSizeMake(120, 120));
    }];
    
    
    UILabel *contentLable = [[UILabel alloc]init];
    
    contentLable.text = @"抱歉，没有找到适合的商户!";
    
    contentLable.font = TR_Font_Gray(15);
    
    contentLable.textColor = TR_COLOR_RGBACOLOR_A(101, 101, 101, 1);
    
    [_myHideView addSubview:contentLable];
    
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        
        make.height.mas_equalTo(15);
        
    }];
    
    
    
}

-(void)loadAndRefreshData {
    
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    NSString *ticket = [Singleton shareInstance].userInfo.ticket ? [Singleton shareInstance].userInfo.ticket :@"";
    
    [HBHttpTool post:SHOP_SEACHGOODSSTORE params:@{@"Device-Id":DeviceID,@"ticket":ticket,@"user_lat":lat,@"user_long":lng,@"page":@(1),@"key":_seachTextfield.text,@"sort_url":_sort_url} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSDictionary *dict=[dataDict objectForKey:@"result"];
                
                NSArray *dataArr=[dict objectForKey:@"store_list"];
                
                _mdataArray=[StoreSeachModel arrayOfModelsFromDictionaries:dataArr];
                
                [self compeLoadStoreArray:_mdataArray];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_mytableView reloadData];
                    
                });
                
            }
        }
        
    }failure:^(NSError *error){
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self loadAndRefreshData];
    
    _seachGoodsView.hidden=YES;
    
    _exitbtn.hidden=NO;
    
    NSMutableArray *array=[NSMutableArray array];
    
    NSArray *data= [USERDEFAULTS objectForKey:@"seachValues"];
    
    if (data&&data.count!=0) {
        
        [array addObjectsFromArray:data];
        
        if ([data containsObject:textField.text]) {
            
            [array removeObject:textField.text];
        }
    }
    
    if (array.count==10) {
        
        [array removeObjectAtIndex:0];
    }
    
    [array addObject:textField.text];
    
    [USERDEFAULTS setObject:array forKey:@"seachValues"];
    [textField resignFirstResponder];
    return YES;
}


- (void)seachChangeValue:(UITextField *)textfield {
    
    if (textfield.text.length==0) {
        
        _seachGoodsView.hidden=NO;
        
        [_seachGoodsView getHistoryData];
        _exitbtn.hidden=YES;
    }else
        _exitbtn.hidden=NO;
    
}

- (void)exitbtnclick:(UIButton *) button {
    
    _seachTextfield.text=@"";
    
    [self seachChangeValue:_seachTextfield];
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (!_backview) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40)];
        
        view.backgroundColor=[UIColor whiteColor];
        _backview=view;
        NSArray *array=@[@"推荐",@"销量",@"距离"];
        
        for (int i=0; i<array.count; i++) {
            
            NSString *str=array[i];
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:str forState:UIControlStateNormal];
            [button setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag=2000+i;
            
            button.frame=CGRectMake(10+70*i,0,50,30);
            
            [view addSubview:button];
            
            if (i==0)
                [button setTitleColor:TR_COLOR_RGBACOLOR_A(45,45,45,1) forState:UIControlStateNormal];
            
        }
    }
    
    return _backview;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_mdataArray&&_mdataArray.count!=0) {
        
        StoreSeachModel *item=_mdataArray[indexPath.row];
        
        NSArray *data=item.tag;
        
        CGFloat goodheight=0;
        
        if (item.goods_list.count<=2) {
            
            goodheight=item.goods_list.count*80;
            
        }else{
            
            if ([item.ismore integerValue]!=0) {
                
                goodheight=item.goods_list.count*80+50;
                
            }else
                goodheight=2*80+50;
        }
        
        if (item.goods_list.count==0) {
            goodheight=0;
        }
        
        if (item.tag.count!=0) {
            
            if ([item.isyes integerValue]!=0) {
                
                return 95+[self strHeighData:data]+goodheight;
                
            }else{
                return 95+30+goodheight;
            }
            
        }else
            return 95+goodheight;
        
    }else
        return 145;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mdataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellName = @"UITableViewCell";
    
    SeachListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell) {
        
        cell = [[SeachListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.arrowBtn addTarget:self action:@selector(activitybtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.morebtn addTarget:self action:@selector(morebtnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_mdataArray&&_mdataArray.count!=0) {
        cell.seachstr=_seachTextfield.text;
        StoreSeachModel *model=_mdataArray[indexPath.row];
        cell.model=model;
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(40,40,40,1),
                                  NSFontAttributeName:cell.storenamelabel.font
                                  };
        
        
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:model.name
                                               attributes:attribs];
        
        NSRange bgTextRange =[model.name rangeOfString:_seachTextfield.text];
        
        [attributedText setAttributes:@{NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(252,122,46,1),NSFontAttributeName:cell.storenamelabel.font} range:bgTextRange];
        
        cell.storenamelabel.attributedText=attributedText;
        
        if ([model.is_close integerValue]==1) {
            cell.closelabel.hidden=NO;
        }else
            cell.closelabel.hidden=YES;
        
        
        if ([model.is_brand integerValue] == 1) {
            
            cell.tiplabel.hidden = NO;
            
        }else
            cell.tiplabel.hidden = YES;
        
        [cell.picimgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
        
        
        cell.salelabel.text=[NSString stringWithFormat:@"月销%@ | %@%@ | %@",model.month_sale_count,model.delivery_time,model.delivery_time_type,model.range];
        
        cell.pricePeilabel.text=[NSString stringWithFormat:@"起送¥%@ | 配送费¥%@ | 人均¥%@",model.delivery_price,model.delivery_money,model.permoney];
        
        if (model.coupon_list.count!=0&&model.tag.count!=0) {
            
            NSArray *data=model.tag;
            
            CGFloat height= [self strHeighData:model.tag];
            
            if ([model.isyes integerValue]!=0) {
                
                [cell.customCapacityView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(height);
                    
                }];
                cell.arrowBtn.transform=CGAffineTransformMakeRotation(M_PI);
                
                [cell.customCapacityView loadActivitys:data withisYes:YES andWidth:SCREEN_WIDTH- 100 -40] ;
                
            }else{
                
                [cell.customCapacityView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(30);
                }];
                
                cell.arrowBtn.transform=CGAffineTransformMakeRotation(0);
                
                [cell.customCapacityView loadActivitys:data withisYes:NO andWidth:SCREEN_WIDTH- 100 -40];
            }
            
            cell.customCapacityView.hidden=NO;
            
            if (height>30) {
                
                cell.arrowBtn.hidden=NO;
                
            }else
                cell.arrowBtn.hidden=YES;
            
        }else{
            cell.customCapacityView.hidden=YES;
            [cell.customCapacityView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
            cell.arrowBtn.hidden=YES;
        }
        
        if ([model.ismore integerValue]!=0) {
            
            [cell loadsetGoodsItem:model.goods_list isyes:YES];
            [cell.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.customCapacityView.mas_bottom).offset(5);
                
                make.bottom.equalTo(cell.morebtn.mas_top).offset(-5);
            }];
        }else{
            
            [cell loadsetGoodsItem:model.goods_list isyes:NO];
            
            [cell.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.customCapacityView.mas_bottom).offset(0);
                
                make.bottom.equalTo(cell.morebtn.mas_top).offset(0);
            }];
            
        }
        
        
        
    }
    
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreSeachModel *model=_mdataArray[indexPath.row];
    
    BusinessViewController *businessVC=[[BusinessViewController alloc]init];
    businessVC.storeID=model.store_id;
    [self.navigationController pushViewController:businessVC animated:YES];
}

- (void) activitybtnclick:(UIButton *) button {
    
    
    SeachListTableViewCell *cell=(SeachListTableViewCell *)button.superview;
    
    NSIndexPath *indexpath=[_mytableView indexPathForCell:cell];
    
    StoreSeachModel *model=_mdataArray[indexpath.row];
    
    
    if ([model.isyes integerValue]!=0) {
        
        model.isyes=@"0";
        
        
        [_mytableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        model.isyes=@"1";
        
        [_mytableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}




- (void)morebtnclick:(UIButton *) button {
    
    SeachListTableViewCell *cell=(SeachListTableViewCell *)button.superview;
    
    NSIndexPath *indexpath=[_mytableView indexPathForCell:cell];
    
    StoreSeachModel *model=_mdataArray[indexpath.row];
    
    if ([model.ismore integerValue]!=0) {
        
        model.ismore=@"0";
        
        [_mytableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        model.ismore=@"1";
        
        
        [_mytableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    
}


- (CGFloat)strHeighData:(NSArray *)data {
    
    CGFloat total=SCREEN_WIDTH- 100 -40;
    
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


- (void)buttonclick:(UIButton *) button {
    
    UIView *view=button.superview;
    
    [button setTitleColor:TR_COLOR_RGBACOLOR_A(45,45,45,1) forState:UIControlStateNormal];
    
    if (button.tag==2000) {
        _sort_url=@" ";
        UIButton *btn1=[view viewWithTag:2001];
        
        UIButton *btn2=[view viewWithTag:2002];
        
        [btn1 setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
        [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
        
    }
    
    if (button.tag==2001) {
        _sort_url=@"sale_count";
        UIButton *btn1=[view viewWithTag:2000];
        
        UIButton *btn2=[view viewWithTag:2002];
        
        [btn1 setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
        [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
        
    }
    if (button.tag==2002) {
        _sort_url=@"juli";
        UIButton *btn1=[view viewWithTag:2001];
        
        UIButton *btn2=[view viewWithTag:2000];
        
        [btn1 setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
        [btn2 setTitleColor:TR_COLOR_RGBACOLOR_A(183,183,183,1) forState:UIControlStateNormal];
        
    }
    
    [self loadAndRefreshData];
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)compeLoadStoreArray:(NSArray *)dataArray {
    
    if (dataArray.count == 0) {
        
        _myHideView.hidden = NO;
        
    }else{
        
        _myHideView.hidden = YES;
    }
    
    
    
    if (_storesArray.count!=0&&dataArray.count!=0) {
        
        for (StoreSeachModel *model in  dataArray) {
            
            for (StoreDataModel *model2 in _storesArray) {
                
                if ([model.store_id isEqualToString:model2.store_id]) {
                    
                    if (model.goods_list.count!=0) {
                        
                        for (GoodsShopModel *goodmodel in  model2.goods) {
                            
                            for (GoodItem *goodmodel2 in model.goods_list) {
                                
                                if ([goodmodel.goodId isEqualToString:goodmodel2.goods_id]&&goodmodel.specId.length==0&&goodmodel.attributeId.length==0) {
                                    
                                    goodmodel2.goodnum=goodmodel.goodnum;
                                }
                                
                            }
                        }
                    }
                }
            }
            
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
