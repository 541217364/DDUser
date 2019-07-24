//
//  EvaluateViewController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "EvaluateViewController.h"
#import "EvalutModel.h"

@interface EvaluateViewController ()

@property(nonatomic,strong)NSMutableArray *datasource;

@property(nonatomic,strong)UIView *hideView;

@end

@implementation EvaluateViewController

-(NSMutableArray *)datasource {
    if (_datasource == nil) {
        _datasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _datasource;
}


-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, SCREEN_WIDTH, self.view.frame.size.height - HeightForNagivationBarAndStatusBar)];
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
    }
    return _mytableView;
}

-(UIView *)hideView{
    
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.frame = CGRectMake(0, HeightForNagivationBarAndStatusBar, SCREEN_WIDTH, SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar);
        _hideView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"mydiscussnom"];
        [_hideView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(SCREEN_HEIGHT / 6);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        
        UILabel *detailL = [[UILabel alloc]init];
        detailL.text = @"您还没有评价过任何商家哟";
        detailL.font = [UIFont systemFontOfSize:15];
        detailL.textColor = [UIColor grayColor];
        detailL.textAlignment = NSTextAlignmentCenter;
        [_hideView addSubview:detailL];
        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageV.mas_bottom).offset(20);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
    }
    return _hideView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"我的评价";
    self.isBackBtn = YES;
    
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.mytableView];
    [self.view addSubview:self.hideView];
    
    
    
    if (GetUser_Login_State) {
        
      [self startNetWorking];
        
    }else{
        
        TR_Message(@"请先登录账号");
    }
    
   
}

//网络请求
-(void)startNetWorking {
    __weak typeof(self) weakSelf = self;
    [HBHttpTool post:PERSONAL_COMMENT_LIST params:@{
    @"Device-Id":DeviceID,
    @"ticket":[Singleton shareInstance].userInfo.ticket
    
                                                }
     
   success:^(id responseObj) {
       if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
           [weakSelf parseDataWith:responseObj];
       }
       
    } failure:^(NSError *error) {
        
    }];
}
//解析数据
-(void)parseDataWith:(NSDictionary *)response {
    NSArray *result = response[@"result"];

    [self.datasource removeAllObjects];
    
    self.datasource = [EvalutModel arrayOfModelsFromDictionaries:result error:nil];
    
    if (self.datasource.count > 0) {
        self.hideView.hidden = YES;
    }
    
    [self.mytableView reloadData];
    //刷新界面
}

//返回上一个界面
-(void)returntopView{
     [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)back{
    
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datasource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EvalutModel *model = self.datasource[indexPath.row];
    
    CGSize size = TR_TEXT_SIZE(model.comment, [UIFont systemFontOfSize:15], CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
    CGFloat imageWidth = (SCREEN_WIDTH - 65 - 4 * 5) /3; // 图片的宽度
    
    CGSize textSize = TR_TEXT_SIZE(model.merchant_reply, [UIFont systemFontOfSize:15], CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
    
    CGFloat height = 0.0;
    
    if (model.goods.count > 0) {
        
        height = 30;
    }
    
    if (model.pic.count > 0) {
        
        return  size.height + imageWidth + textSize.height + 100 + height;
    }
    
    
    
    return size.height + textSize.height + 80 + height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluateCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[EvaluateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EvalutModel *model = self.datasource[indexPath.row];
    [cell handleWithModel:model];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
