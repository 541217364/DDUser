//
//  SeachGlobalViewController.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SeachGlobalViewController.h"
#import "SeachbarCustom.h"

@interface SeachGlobalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mytableview;

@property (nonatomic, strong) UIScrollView *myscrollView;


@end

@implementation SeachGlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _myscrollView=[[UIScrollView alloc]init];
    
    _mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 20,self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    
    _mytableview.delegate=self;
    
    _mytableview.dataSource=self;
    
    [self.view addSubview:_mytableview];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
        static NSString *cellIdentifier = @"cellIdentifier";
        
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
         
        }
        
        
        return cell;
        
   
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
