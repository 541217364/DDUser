//
//  ShopSearchView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopSearchView.h"

@implementation ShopSearchView

-(UITableView *)mytable{
    if (_mytable == nil) {
        _mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.frame.size.width, self.frame.size.height)];
        _mytable.delegate = self;
        _mytable.dataSource = self;
        _mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mytable;
}

-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 1.5);
        _hideView.hidden = YES;
        _hideView.alpha = TR_Alpha;
        _hideView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaction)];
        [_hideView addGestureRecognizer:tap];
        [self addSubview:_hideView];
    }
    return _hideView;
}

-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}
-(NSMutableArray *)nameArray{
    if (_nameArray == nil) {
        _nameArray = [NSMutableArray array];
       
    }
     return _nameArray;
}

-(NSMutableArray *)chooseArray{
    
    if (_chooseArray == nil) {
        
        _chooseArray = [NSMutableArray array];
    }
    return _chooseArray;
}
-(UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width - 80, 40)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"奶茶";
        
    }
    return _searchBar;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mytable];
       
        [self desgignSearchBar];
        
    }
    return self;
}


-(void)updataView{
    [self.datasource removeAllObjects];
    [self.nameArray removeAllObjects];
    [self.chooseArray removeAllObjects];
    self.searchBar.text = @"";
    for (NSArray *temp in [GoodsListManager shareInstance].goodsListArray) {
        for (ProductItem *model in temp) {
            [self.datasource addObject:model];
            [self.nameArray addObject:model.product_name];
        }
    }
    
    [self.mytable reloadData];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar endEditing:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (self.chooseArray.count > 0) {
//
//        return self.chooseArray.count;
//
//    }
//    return self.datasource.count;
    return self.chooseArray.count;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *searchStr = [searchBar text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd]%@",searchStr];
    
  NSArray *tempArray = [NSMutableArray arrayWithArray:[self.nameArray filteredArrayUsingPredicate:predicate]];
    [self.chooseArray removeAllObjects];
    for (NSString * tempStr in tempArray) {
        NSInteger index = [self.nameArray indexOfObject:tempStr];
        [self.chooseArray addObject:self.datasource[index]];
    }
    [self.mytable reloadData];
    
    if (self.chooseArray.count > 0) {
        [self.searchBar endEditing:YES];
    }
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
   
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
     NSLog(@"返回");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"取消");
    [searchBar endEditing:YES];
}


//定制一下搜索框的样式
-(void)desgignSearchBar{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:self.searchBar];
    UIButton *cansureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cansureBtn setTitle:@"取消" forState:UIControlStateNormal];
    cansureBtn.frame = CGRectMake(self.frame.size.width - 70, 20, 60, 40);
    cansureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cansureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cansureBtn addTarget:self action:@selector(clickcansure:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cansureBtn];
    self.mytable.tableHeaderView = view;
    
    //1. 设置背景颜色
    _searchBar.backgroundImage = [[UIImage alloc]init];
    _searchBar.barTintColor = [UIColor whiteColor];
    //2. 设置圆角和边框颜色
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:GRAYCLOLOR];
        searchField.layer.cornerRadius = 5.0f;
        searchField.layer.masksToBounds = YES;
    }
    
    
    
}

-(void)clickcansure:(UIButton *)sender{
    [self.searchBar endEditing:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CHANGESHOPCARSTATE" object:nil];
    }];
}




























- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[BusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    ProductItem *model;
    
//    if (self.chooseArray.count > 0) {
//
//        model = self.chooseArray[indexPath.row];
//
//    }else{
//
//        model = self.datasource[indexPath.row];
//    }
    
    model = self.chooseArray[indexPath.row];
    cell.indexpath = indexPath;
    [cell parseDatasourceWithModel:model];
    
    return cell;
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}






//选择规格操作
-(void)addFoodType:(NSArray *)typeArray{
    
    NSIndexPath *indexpath = typeArray[0];
    
    ProductItem *model = self.chooseArray[indexpath.row];
    
    GoodItem *goodItem =[[GoodsListManager shareInstance] transformModelFrom:model withShopID:self.shopModel.store_id];
    SpecAttributeView *specAttributeView=[[SpecAttributeView alloc]init];
    specAttributeView.storeDict=[_shopModel toDictionary];
    [specAttributeView loadGoodId:model.product_id goodName:model.product_name withGoodPrice:model.product_price goodData:[goodItem toDictionary]];
    
    [specAttributeView showInView];
    
}

//点击添加商品  数字

-(void)clickCountView:(NSString *)clickType withIndexpath:(NSIndexPath *)indexpath{
    
    ProductItem *model;
    
//    if (self.chooseArray.count > 0) {
//
//        model = self.chooseArray[indexpath.row];
//
//    }else{
//
//        model = self.datasource[indexpath.row];
//    }
    
     model = self.chooseArray[indexpath.row];
    
    if ([clickType isEqualToString:@"jia"]) {
        //添加数量
        [[GoodsListManager shareInstance]setSelctModelCount:model withCount:[NSString stringWithFormat:@"%ld",[model.selectCount integerValue] + 1]];
       
        
    }else{
        //减少数量
      [[GoodsListManager shareInstance]setSelctModelCount:model withCount:[NSString stringWithFormat:@"%ld",[model.selectCount integerValue] - 1]];
    }
    
   // [self updataView];
    
   
    
    StoreDataModel *storeModel = [[GoodsListManager shareInstance]transformModelFrom4:self.shopModel];
    
    GoodsShopModel *goodModel = [[GoodsListManager shareInstance]transformModelFrom3:model withShopID:self.shopModel.store_id];
    
    if ([model.selectCount isEqualToString:@"0"]) {
        
        [[GoodShopManagement shareInstance]deleteStore:storeModel andGoodshopmodel:goodModel];
        
    }else{
        
        [[GoodShopManagement shareInstance]addStore:storeModel andGoodshopmodel:goodModel];
    
        
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATASHOPCAR" object:nil];
    
}


-(void)tapaction{
    
    if (_isShowType ) {
        
        self.hideView.hidden = YES;
        _isShowType = NO;
        
    }
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.searchBar endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
