//
//  MySaveShopsView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/8.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MySaveShopsView.h"
#import "HomeTableViewCell.h"

@interface MySaveShopsView()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat starPointY;

@end

@implementation MySaveShopsView


-(UITableView *)mytablView{
    if (_mytablView == nil) {
        _mytablView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT)];
        _mytablView.delegate = self;
        _mytablView.dataSource = self;
        _mytablView.backgroundColor = [UIColor whiteColor];
        _mytablView.bounces = NO;
        _mytablView.tag = 2000;
        _mytablView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        UIPanGestureRecognizer *up = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
//        [_mytablView addGestureRecognizer:up];
        
    }
    return _mytablView;
}

-(UIScrollView *)myscrollView{
    if (_myscrollView == nil) {
        _myscrollView = [[TouchScrollViewExtent alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _myscrollView.showsHorizontalScrollIndicator = NO;
        _myscrollView.showsVerticalScrollIndicator = NO;
        _myscrollView.bounces = NO;
        _myscrollView.delegate = self;
        _myscrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT* 1.5 - STATUS_BAR_HEIGHT);
    }
    return _myscrollView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.myscrollView];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT)];
        contentView.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideVIewAction:)];
        tap.delegate = self;
        [tap setNumberOfTapsRequired:1];
        tap.cancelsTouchesInView = NO;
        
        [self.myscrollView addGestureRecognizer:tap];
        
        [self.myscrollView addSubview:contentView];
        [contentView addSubview:self.mytablView];
    }
    return self;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell.arrowBtn addTarget:self action:@selector(activitybtnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_datasource &&_datasource.count!=0) {
        
        StoreModel *model = self.datasource[indexPath.row];
        
        cell.storenamelabel.text=model.name;
        
        cell.shopTypeimageV.hidden = [model.delivery_type isEqualToString:@"点呗专送"] ? NO:YES;
        
        [cell.picimgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"nostore_pic"]];
        
        [cell setstartnum: [model.star integerValue]];
        
        cell.salelabel.text=[NSString stringWithFormat:@"月销%@ | %@%@ | %@",model.month_sale_count,model.delivery_time,model.delivery_time_type,model.range];
        
        cell.pricePeilabel.text=[NSString stringWithFormat:@"起送¥%@ | 配送费¥%@ | 人均¥%@",model.delivery_price,model.delivery_money,model.permoney];
        
        // cell.distanceMiniutslabel.text=[NSString stringWithFormat:@"%@ | %@%@",model.range,model.delivery_time,model.delivery_time_type];
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
        
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCellAtIndexPath:withShopID:)]) {

         StoreModel *model = self.datasource[indexPath.row];

        [self.delegate clickCellAtIndexPath:indexPath withShopID:model.store_id];
    }
    
}



- (void) activitybtnclick:(UIButton *) button {
    
    
    HomeTableViewCell *cell=(HomeTableViewCell *)button.superview;
    
    NSIndexPath *indexpath=[_mytablView indexPathForCell:cell];
    
    StoreModel *model=_datasource[indexpath.row];
    
    if ([model.isyes integerValue]!=0) {
        
        model.isyes=@"0";
        
        [_mytablView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        model.isyes=@"1";
        
        [_mytablView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
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
        
        if (totalwidth>total) {
            totalwidth=retSize.width+5+10;
            num++;
        }
    }
    
    if (data.count!=0) {
        return  30*(num+1);
    }else
        return 0;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}



-(void)hideVIewAction:(UITapGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickHideView:)]) {
        [self.delegate clickHideView:@""];
    }
    
}



-(void)loadDatasource{
    
    if (!GetUser_Login_State) {
        
        return;
    }
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    
    NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"user_long":lng,@"user_lat":lat};
    
    [HBHttpTool post:PERSONAL_SAVESHOP params:body success:^(id responseObj) {
       
        if ([responseObj[@"errorMsg"]isEqualToString:@"success"]) {
            
            self.datasource = [StoreModel arrayOfModelsFromDictionaries:responseObj[@"result"] error:nil];
            if (self.datasource.count == 0) {
                
                TR_Message(@"该地址无已经收藏的店铺");
            }
            [self.mytablView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [touch view].tag == 2000) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
