//
//  MyRedBaoTablView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/23.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyRedBaoTablView.h"
#import "MyRedBaoCell.h"
#import "RedBaoModel.h"
@implementation MyRedBaoTablView

-(UITableView *)mytablView{
    if (_mytablView == nil) {
        _mytablView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mytablView.delegate = self;
        _mytablView.dataSource = self;
        _mytablView.backgroundColor = [UIColor whiteColor];
        _mytablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mytablView;
}

-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(UIScrollView *)myscrollView{
    if (_myscrollView == nil) {
        _myscrollView = [[TouchScrollViewExtent alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _myscrollView.showsHorizontalScrollIndicator = NO;
        _myscrollView.showsVerticalScrollIndicator = NO;
        _myscrollView.bounces = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideVIewAction:)];
        [_myscrollView addGestureRecognizer:tap];
        _myscrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT* 1.45);
        _myscrollView.delegate =self;
    }
    return _myscrollView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.myscrollView];
        [self.myscrollView addSubview:self.mytablView];
        self.backgroundColor = [UIColor clearColor];
        self.mytablView.dataSource = self;
        self.mytablView.delegate = self;
        self.mytablView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addTableFootView];
    }
    return self;
}





-(void)addTableFootView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    footView.backgroundColor = [UIColor whiteColor];
    self.mytablView.tableFooterView = footView;
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 2 * 10, 20)];
    footLabel.text = @"没有更多了";
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.font = TR_Font_Gray(14);
    footLabel.textColor = [UIColor grayColor];
    [footView addSubview:footLabel];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRedBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MyRedBaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([self.titleName isEqualToString:@"红包"]) {
        RedBaoModel *model = self.datasource[indexPath.row];
        
        [cell parseWithDataModel:self.titleName withModel:model];
    }else{
        //代金券
        ShopDis *model = self.datasource[indexPath.row];
        
        [cell parseWithtitle:self.titleName withModel:model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}


-(void)hideVIewAction:(UITapGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickHideRedView:)]) {
        [self.delegate clickHideRedView:@""];
    }
}



-(void)designViewWith:(NSString *)viewType{
    
    if (!GetUser_Login_State) {
        TR_Message(@"请先登录账号");
        return;
    }
    NSString *url ;
    
    if ([viewType isEqualToString:@"红包"]) {
        url = PERSONAL_REDBAO_LIST;
        
    }else{
        
       url = PERSONAL_SHOP_DISCOUNT;
    }
    
    
    [HBHttpTool post:url params:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket} success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            [self dealWithDatasource:responseObj[@"result"]];
            
        }else{
            
           // TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}


-(void)dealWithDatasource:(NSArray *)result{
    
    self.datasource = [RedBaoModel arrayOfModelsFromDictionaries:result error:nil];
    
    if (self.datasource.count > 0) {
        
        [self.mytablView reloadData];
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
