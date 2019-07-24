//
//  FlavorChooseController.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "FlavorChooseController.h"
#define SpareWidth 10
@interface FlavorChooseController ()<UITextViewDelegate>

@end

@implementation FlavorChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GRAYCLOLOR;
    self.title = @"口味备注";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(returntopView)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.mytableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self designView];
}


//布局界面
-(void)designView{
   // __weak typeof (self)weakself = self;
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(HeightForNagivationBarAndStatusBar);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT / 3));
    }];
    self.flvorTextV.backgroundColor = GRAYCLOLOR;
    self.flvorTextV.textColor = [UIColor grayColor];
    self.flvorTextV.editable = YES;
    self.flvorTextV.delegate = self;
    self.flvorTextV.font = [UIFont systemFontOfSize:14];
    self.flvorTextV.text = @"请输入备注说明(最多20个字)";
    self.flvorTextV.keyboardType = UIKeyboardTypeDefault;
    self.flvorTextV.dataDetectorTypes = UIDataDetectorTypeAll;
    [topView addSubview:self.flvorTextV];
    [self.flvorTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 100));
    }];
    NSArray * titlearray = @[@"不吃辣",@"多点米饭",@"多点香菜",@"别放香菜",@"少放盐",
                             @"不吃葱",@"不吃蒜",@"不要太辣",];
    float btnwidth = (SCREEN_WIDTH - 5 * SpareWidth ) / 4 ;
    float btnhiegh = 20;
    for (int i = 0 ; i < 2; i ++ ) {
        for (int j = 0 ; j < 4; j ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:titlearray[4 * i + j] forState:UIControlStateNormal];
            [btn.layer setBorderColor:[UIColor blackColor].CGColor];
            [btn.layer setBorderWidth:1];
            btn.layer.cornerRadius = 11.5f;
            [btn.layer setMasksToBounds:YES];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(clickflvor:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1001 + 4 * i + j;
            [topView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset((SpareWidth + btnwidth) * j +SpareWidth);
                make.top.mas_equalTo((SpareWidth + btnhiegh) * i +SpareWidth + 110);
                make.size.mas_equalTo(CGSizeMake(btnwidth, btnhiegh));
            }];
        }
    }
    //添加下部的tableview
    [self.view addSubview:self.mytableView];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(topView.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT / 3 * 2 - 2 * SpareWidth - HeightForNagivationBarAndStatusBar));
    }];
    [self.mytableView reloadData];
    
}
//点击选择的口味
-(void)clickflvor:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSNumber * number = [NSNumber numberWithInteger:sender.tag] ;
    if ([self.myset containsObject:number]) {
        [self.myset removeObject:number];
    }else {
        [self.myset addObject:number];
    }
}


-(UITextView *)flvorTextV {
    if (!_flvorTextV) {
        _flvorTextV = [[UITextView alloc]init];
    }
    return _flvorTextV;
}
-(NSMutableSet *)myset {
    if (!_myset) {
        _myset = [NSMutableSet set];
    }
    return _myset;
}
-(UITableView *)mytableView {
    if (!_mytableView) {
        _mytableView = [[UITableView alloc]init];
    }
    return _mytableView;
}
//点击完成 返回上一个界面
-(void)returntopView{
    for (NSNumber * temp  in self.myset) {
        NSLog(@"%@",temp);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入备注说明(最多20个字)";
        textView.textColor = [UIColor grayColor];
    }else {
        self.contentS = textView.text;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入备注说明(最多20个字)"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.flvorTextV resignFirstResponder];
}

//tabviewiew代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headview = [self createheadview];
    
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.mytableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = @"带包烟";
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"图层 10 拷贝.png"];
    return cell;
}
//自定义一个分区头
-(UIView * )createheadview {
    UIView *tempV = [[UIView alloc]init];
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor redColor];
    imageV.frame = CGRectMake(SpareWidth, 5, 2, 20);
    [tempV addSubview:imageV];
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.text = @"历史备注";
    namelabel.frame = CGRectMake(SpareWidth + 10, 5, 60, 20);
    namelabel.font = [UIFont systemFontOfSize:13];
    namelabel.textColor = [UIColor blackColor];
    [tempV addSubview:namelabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - SpareWidth - 40, 5, 50, 20);
    [btn addTarget:self action:@selector(deleteclick) forControlEvents:UIControlEventTouchUpInside];
    [tempV addSubview:btn];
    return tempV;
}
//
-(void)deleteclick{
    NSLog(@"点击了删除");
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
