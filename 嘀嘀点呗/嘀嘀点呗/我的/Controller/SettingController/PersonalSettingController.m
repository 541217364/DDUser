//
//  PersonalSettingController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/28.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PersonalSettingController.h"
#import "FeedBackController.h"
#import "ServiceTermsController.h"
#import "AboutUsController.h"

@interface PersonalSettingController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *mytableView;

@end

@implementation PersonalSettingController

-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.backgroundColor = GRAYCLOLOR;
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mytableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"设置";
    self.view.backgroundColor = GRAYCLOLOR;
    self.isBackBtn = YES;
    [self.view addSubview:self.mytableView];
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(HeightForNagivationBarAndStatusBar + 10);
        make.bottom.mas_equalTo(HOME_INDICATOR_HEIGHT);
        make.right.mas_equalTo(0);
    }];
    
   // [self setUI];
    
    
}



-(void)setUI{
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    bottomBtn.backgroundColor = [UIColor whiteColor];
    
    bottomBtn.layer.cornerRadius = 5.0f;
    
    bottomBtn.layer.masksToBounds = YES;
    
    [bottomBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    NSString *isProduct = [[TRClassMethod getwebServer] isEqualToString:@"https://www.dianbeiwaimai.cn/appapi.php"] ? @"正式服":@"测试服";
    
    [bottomBtn setTitle:[NSString stringWithFormat:@"开发者选项%@",isProduct] forState:UIControlStateNormal];
    
    [bottomBtn addTarget:self action:@selector(changeWebState:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomBtn];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 50));
        
        make.bottom.mas_equalTo(-50);
    }];
}


-(void)changeWebState:(UIButton *)sender{
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"开发者选项" preferredStyle:UIAlertControllerStyleActionSheet];
   
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"正式服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
         [TRClassMethod changewebServer:YES];
        
        [sender setTitle:@"开发者选项正式服" forState:UIControlStateNormal];
        
    }];
    
    [alterVC addAction:action1];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"测试服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
         [TRClassMethod changewebServer:NO];
        
         [sender setTitle:@"开发者选项测试服" forState:UIControlStateNormal];
        
    }];
    
    [alterVC addAction:action2];
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alterVC addAction:action3];
    
    
    [self presentViewController:alterVC animated:YES completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self designCellWith:indexPath With:cell];
    return cell;
}








-(void)designCellWith:(NSIndexPath *)indexpath With:(UITableViewCell *)cell{
    NSArray *titleArray = @[@"清除缓存",@"意见反馈",@"服务条款",@"关于我们",@"退出"];
    //添加分割线
    
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(1);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        }];

    
    //添加文字
  
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = titleArray[indexpath.row];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = TR_Font_Gray(15);
        CGSize titleLsize = TR_TEXT_SIZE(titleArray[indexpath.row], titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10 );
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(titleLsize.width + 10, 15));
        }];

    
    //右边的控件设置
    
    NSArray *leftArray = @[@"计算中...",@"",@"",@"",@"",@""];
  
    if (indexpath.row == 0) {
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Btn setTitle:leftArray[indexpath.row] forState:UIControlStateNormal];
        Btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Btn.titleLabel.font = TR_Font_Gray(14);
        Btn.tag = 1000+ 1;
        [cell.contentView addSubview:Btn];
         CGSize size = TR_TEXT_SIZE(leftArray[indexpath.row], Btn.titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(size.width + 10, 30));
        }];
        
    }
    
  
    
    
    if (indexpath.row != 0) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"setting-forword"];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(10, 15));
        }];
    }
    

    
    
    if (indexpath.row == 4) {
        UIView *tempV = [[UIView alloc]init];
        tempV.backgroundColor = GRAYCLOLOR;
        tempV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        [cell.contentView addSubview:tempV];
        
    }
}






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 60;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
        
        if (indexPath.row == 0) {
            
            UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"清除缓存" message:@"确定清理缓存吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alterView.tag = 200;
            [alterView show];
           
            
        }
        
        if (indexPath.row == 1) {
            //意见反馈
            FeedbackController *tempC = [[FeedbackController alloc]init];
            [self.navigationController pushViewController:tempC animated:YES];
        }
        
        if (indexPath.row == 2) {
            //服务条款
            ServiceTermsController *tempC = [[ServiceTermsController alloc]init];
            [self.navigationController pushViewController:tempC animated:YES];
        }
        
        if (indexPath.row == 3) {
            //关于我们
            AboutUsController *tempC = [[AboutUsController alloc]init];
            [self.navigationController pushViewController:tempC animated:YES];
        }
        
        if (indexPath.row == 4) {
            
            SetUser_Login_State(NO);
            
            [Singleton shareInstance].userInfo = nil;
            [USERDEFAULTS removeObjectForKey:@"userinfo"];
            TR_Message(@"退出登录成功");
            [self back];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDtataUserMessage" object:nil];
        }
        
    }



-(void)back{
    [APP_Delegate.rootViewController setTabBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 200) {
        
        if (buttonIndex == 0) {
            //清除缓存
            [self removeCache];
            UITableViewCell *cell = [self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            UIButton *tempBtn = [cell.contentView viewWithTag:1000+1];
            [tempBtn setTitle:@"0MB" forState:UIControlStateNormal];
            TR_Message(@"清除缓存成功");
        }
    }
}


-(void)getMomorySize{
    
    UITableViewCell *cell = [self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIButton *tempBtn = [cell.contentView viewWithTag:1000+1 ];
    
    CGFloat foldSize = [self folderSize];

    [tempBtn setTitle:[NSString stringWithFormat:@"%.1fM",foldSize] forState:UIControlStateNormal];
}



-(CGFloat)folderSize{
     CGFloat folderSize = 0.0;
     //获取路径
     NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
     //获取所有文件的数组
     NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath]; NSLog(@"文件数：%ld",files.count);
     for(NSString *path in files) { NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
         //累加
         folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize; } //转换为M为单位
     CGFloat sizeM = folderSize /1024.0/1024.0;
     
     return sizeM;
     
 }
    



- (void)removeCache{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){ NSError*error;
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager]fileExistsAtPath:path]) { BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
        if(isRemove) { NSLog(@"清除成功");
        //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
            
        }else{
            NSLog(@"清除失败");
            
        }
        
    }
        
    }
    
}
    
    
-(void)viewDidAppear:(BOOL)animated{
    [self getMomorySize];
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
