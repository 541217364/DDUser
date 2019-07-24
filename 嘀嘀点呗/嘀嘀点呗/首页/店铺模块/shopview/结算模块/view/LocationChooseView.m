//
//  LocationChooseView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "LocationChooseView.h"

#define SpareWidth 80


@implementation LocationChooseView
{
    CGRect  oriRect;
}

-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableView.backgroundColor = [UIColor whiteColor];
    }
    return _mytableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self designView];
        
    }
    return self;
}


-(void)designView{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"选择地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = TR_Font_Gray(20);
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setImage:[UIImage imageNamed:@"setting-ad"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addLocationDone:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self addSubview:self.mytableView];
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(rightBtn.mas_bottom).offset(10);
        make.bottom.mas_equalTo(0);
    }];;
}

-(void)addLocationDone:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNewLocation)]) {
        [self.delegate addNewLocation];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray = self.datasource[section];
    
    return tempArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[LocationItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellStyleDefault;
        [cell.designBtn addTarget:self action:@selector(fixlocationAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    UserAddressModel *model = self.datasource[indexPath.section][indexPath.row];
    
    if (model) {
       [cell designViewWithMode:model];
        
    }
    
    if (indexPath.section == 0) {
        cell.locationLabel.textColor = [UIColor blackColor];
    }else{
        cell.locationLabel.textColor = [UIColor grayColor];
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *imagePath;
    NSString *contentStr;
    
    if (section == 0) {
        imagePath = @"setting-smile";
        contentStr = @"可选收货地址";
    }else if (section == 1){
        imagePath = @"setting-cry";
        contentStr = @"不在配送范围地址";
    }
    
    if (section > 1) {
        return nil;
    }
    
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *tempImage = [[UIImageView alloc]init];
    tempImage.image = [UIImage imageNamed:imagePath];
    [headView addSubview:tempImage];
    [tempImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    UILabel *tempLabel = [[UILabel alloc]init];
    tempLabel.textColor = [UIColor grayColor];
    tempLabel.text = contentStr;
    [headView addSubview:tempLabel];
    CGSize size = TR_TEXT_SIZE(tempLabel.text, tempLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tempImage.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(size.width + 10, 20));
    }];
    

    return headView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        UserAddressModel *model = self.datasource[indexPath.section][indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickCellInCorrecSite:)]) {
            [self.delegate clickCellInCorrecSite:model];
        }
    }
}





#pragma mark   网络请求数据

-(void)startNetWork:(NSString *)shopID{
    
    if (shopID.length ==0) {
        return;
    }
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    
    [HBHttpTool post:SHOP_RESERVESITE params:@{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID,@"store_id":shopID,@"lng":lng,@"lat":lat} success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            [self parseDatasource:responseObj[@"result"]];
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)parseDatasource:(NSArray *)result{
    
    NSMutableArray *deliver1 = [NSMutableArray array];
    NSMutableArray *deliver2 = [NSMutableArray array];
    NSMutableArray *datasource = [UserAddressModel arrayOfModelsFromDictionaries:result];
    
    for (UserAddressModel *model in datasource) {
        
        if ([model.is_deliver isEqualToString:@"1"]) {
            
            [deliver1 addObject:model];
            
        }else{
            
            [deliver2 addObject:model];
        }
    }
    
    [self.datasource removeAllObjects];
    [self.datasource addObjectsFromArray:@[deliver1,deliver2]];
    [self.mytableView reloadData];
    oriRect = self.frame;
}




-(void)fixlocationAction:(UIButton *)sender {
    
    LocationItemCell *cell = (LocationItemCell *)sender.superview.superview;
    NSIndexPath *indexpath = [self.mytableView indexPathForCell:cell];
    if (indexpath) {
        
        UserAddressModel *model = self.datasource[indexpath.section][indexpath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(fixMyLocation:)]) {
            [self.delegate fixMyLocation:model];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _mytableView ) {
        
        CGRect rect = self.frame;
        
        if (rect.origin.y > SpareWidth) {
            
            rect.origin.y = rect.origin.y - scrollView.contentOffset.y;
            
            self.frame = rect;
            
            if (rect.origin.y > oriRect.origin.y) {
                
                self.frame = oriRect;
            }
            
            [_mytableView setContentOffset:CGPointZero];
            
        }else{
            
            
            if (scrollView.contentOffset.y < 0) {
                
                rect.origin.y = rect.origin.y - scrollView.contentOffset.y;
                
                self.frame = rect;
                
                [_mytableView setContentOffset:CGPointZero];
                
            }
            
            
        }
        
        
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (fabs(self.frame.origin.y -oriRect.origin.y) < 20) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = self->oriRect;
        }];
        
    }
    
    if (fabs(self.frame.origin.y - SpareWidth) < 20) {
        
        CGRect rect = CGRectMake(self.frame.origin.x, SpareWidth, self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = rect;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
