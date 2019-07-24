//
//  ServiceTermsController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/2.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ServiceTermsController.h"

@interface ServiceTermsController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ServiceTermsController
{
    NSArray *contentArray;
}
-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.backgroundColor = [UIColor clearColor];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mytableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"服务条款";
    self.isBackBtn = YES;
    contentArray = @[@"点呗外卖代金券使用规则",@"点呗外卖红包使用规则",@"点呗外卖用户评价规则",@"点呗外卖用户协议"];
    [self.view addSubview:self.mytableView];
    self.mytableView.frame = CGRectMake(0, HeightForNagivationBarAndStatusBar, SCREEN_WIDTH, SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar -HOME_INDICATOR_HEIGHT);
    // Do any additional setup after loading the view.
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"setting-forword"];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.height.mas_equalTo(1);
    }];
    
    
    
    cell.textLabel.text = contentArray[indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return contentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
