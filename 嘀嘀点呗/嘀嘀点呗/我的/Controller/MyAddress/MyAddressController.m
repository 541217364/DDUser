//
//  MyAddressController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/13.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyAddressController.h"
#import "AddAddressController.h"
#import "UserAddressModel.h"
#import "LocationItemCell.h"
#import "ModifyAddressViewController.h"
#define SpareWidth 10
@interface MyAddressController ()<AddAddressControllerDelegate>
@property(nonatomic,strong)NSMutableArray *touchPoints;
@property(nonatomic,strong)NSMutableArray *datasource;  //存储地址model

@property(nonatomic,strong)UIView *hideView;

@end

@implementation MyAddressController
{
   
}
-(NSMutableArray *)datasource {
    if (_datasource == nil) {
        _datasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _datasource;
}
-(NSMutableArray *)touchPoints {
    if (_touchPoints == nil) {
        _touchPoints = [NSMutableArray array];
    }
    return _touchPoints;
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
        detailL.text = @"您还没有添加过地址哟";
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


-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.frame = CGRectMake(0, HeightForNagivationBarAndStatusBar, SCREEN_WIDTH, SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar);
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
    }
    return _mytableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName =@"我的地址";
    self.mtitlelabel.textColor = [UIColor blackColor];
    self.isBackBtn = YES;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"setting-ad"] forState:UIControlStateNormal];
    CGFloat height = IS_RETAINING_SCREEN ? STATUS_BAR_HEIGHT:20;
    
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 50, height, 30, 30);
    [rightBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    [self.view addSubview:self.mytableView];
    [self.view addSubview:self.hideView];
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setLongPressDrag];
    
  

}

//网络请求
-(void)startNetWork {
    [HBHttpTool post:PERSONAL_ADRESS params:@{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID} success:^(id responseObj) {
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            NSArray *dic = responseObj[@"result"];
            [self.datasource removeAllObjects];
           self.datasource = [UserAddressModel arrayOfModelsFromDictionaries:dic];
            if (self.datasource.count > 0) {
                self.hideView.hidden = YES;
                
            }
            [self.mytableView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}





//点击完成 返回上一个界面

- (void)back{
     [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAddress {
    //点击添加地址  先判断用户是否登录
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"USER_IS_LOGIN"]) {
        ModifyAddressViewController *tempC = [[ModifyAddressViewController alloc]init];
        tempC.isNewAdress = YES;
        tempC.mtitlename = @"新增地址";
        [self.navigationController pushViewController:tempC animated:YES];
    }
    else {
        UIAlertController *tempC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [tempC addAction:action];
        [self presentViewController:tempC animated:YES completion:nil];
    }
    
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
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[LocationItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.designBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UserAddressModel *model = self.datasource[indexPath.row];
    [cell designViewWithMode:model];
    return cell;
}


//编辑已经有的地址
-(void)editAddress:(UIButton *)sender {
    LocationItemCell *cell = (LocationItemCell *)[[sender superview] superview];
    NSIndexPath * indexpath = [self.mytableView indexPathForCell:cell];
    UserAddressModel *model = self.datasource[indexpath.row];
    ModifyAddressViewController *tempC = [[ModifyAddressViewController alloc]init];
    tempC.model = model;
    tempC.mtitlename = @"修改地址";
    tempC.mtitlelabel.textColor = [UIColor blackColor];
    [self.navigationController pushViewController:tempC animated:YES];
}

//添加地址或者修改地址成功后进行网络请求
//-(void)startnetwork {
//    [self startNetWork];
//}



- (void)setLongPressDrag
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.mytableView addGestureRecognizer:longPress];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //数据请求 先判断用户是否已经登录
    if (GetUser_Login_State) {
        [self startNetWork];
        
    }
    else {
        
        TR_Message(@"请先登录账号");
    }
}

#pragma mark 创建cell的快照
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    // 用cell的图层生成UIImage，方便一会显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的样子（下面的一些参数可以自己随意设置）
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}
#pragma mark 长按手势方法
- (void)longPressGestureRecognized:(id)sender {
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    CGPoint location = [longPress locationInView:self.mytableView];
    NSIndexPath *indexPath = [self.mytableView indexPathForRowAtPoint:location];
    static UIView       *snapshot = nil;
    static NSIndexPath  *sourceIndexPath = nil;
    
    switch (state) {
            // 已经开始按下
        case UIGestureRecognizerStateBegan: {
            // 判断是不是按在了cell上面
            if (indexPath) {
                sourceIndexPath = indexPath;
                UITableViewCell *cell = [self.mytableView cellForRowAtIndexPath:indexPath];
                // 为拖动的cell添加一个快照
                snapshot = [self customSnapshoFromView:cell];
                // 添加快照至tableView中
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.mytableView addSubview:snapshot];
                // 按下的瞬间执行动画
                [UIView animateWithDuration:0.25 animations:^{
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            // 移动过程中
        case UIGestureRecognizerStateChanged: {
            // 这里保持数组里面只有最新的两次触摸点的坐标
            [self.touchPoints addObject:[NSValue valueWithCGPoint:location]];
            if (self.touchPoints.count > 2) {
                [self.touchPoints removeObjectAtIndex:0];
            }
            CGPoint center = snapshot.center;
            // 快照随触摸点y值移动（当然也可以根据触摸点的y轴移动量来移动）
            center.y = location.y;
            // 快照随触摸点x值改变量移动
            CGPoint Ppoint = [[self.touchPoints firstObject] CGPointValue];
            CGPoint Npoint = [[self.touchPoints lastObject] CGPointValue];
            CGFloat moveX = Npoint.x - Ppoint.x;
            center.x += moveX;
            snapshot.center = center;
            NSLog(@"%@---%f----%@", self.touchPoints, moveX, NSStringFromCGPoint(center));
            NSLog(@"%@", NSStringFromCGRect(snapshot.frame));
            // 是否移动了
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                // 更新数组中的内容
//                [self.dataArray exchangeObjectAtIndex:
//                 indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // 把cell移动至指定行
                [self.mytableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // 存储改变后indexPath的值，以便下次比较
                sourceIndexPath = indexPath;
            }
            break;
        }
            // 长按手势取消状态
        default: {
            // 清除操作
            // 清空数组，非常重要，不然会发生坐标突变！
            [self.touchPoints removeAllObjects];
            UITableViewCell *cell = [self.mytableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            // 将快照恢复到初始状态
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
    
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
