//
//  OrderStateListView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/6/7.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "OrderStateListView.h"

@interface OrderStateListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mytableView;


@end

@implementation OrderStateListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40,frame.size.width,frame.size.height-40) style:UITableViewStylePlain];
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mytableView.delegate=self;
        
        _mytableView.dataSource=self;
        
        [self addSubview:_mytableView];
        
    }
    
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
