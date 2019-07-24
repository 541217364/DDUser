//
//  BusDetailView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/3/26.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "BusDetailView.h"
#import "BusinessCell.h"
#define ViewHeight self.frame.size.height - 100
@implementation BusDetailView

-(UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, ViewHeight)];
        _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
        _contentScrollView.tag = 1000;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentScrollView;
}

-(UIView *)busiView {
    if (_busiView == nil) {
        _busiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ViewHeight)];
        _busiView.backgroundColor = [UIColor whiteColor];
        [self.busiView addSubview:self.leftTab];
        [self.busiView addSubview:self.rightTab];
    }
    return _busiView;
}
-(UITableView *)disgussView{
    if (_disgussView == nil) {
        _disgussView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH ,0 , SCREEN_WIDTH, ViewHeight)];
        _disgussView.delegate = self;
        _disgussView.dataSource = self;
        _disgussView.backgroundColor = [UIColor whiteColor];
    }
    return _disgussView;
    
}


-(UITableView *)leftTab {
    if (_leftTab == nil) {
        _leftTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80 , ViewHeight)];
        _leftTab.backgroundColor = [UIColor whiteColor];
        _leftTab.dataSource = self;
        _leftTab.delegate=self;
        _leftTab.showsVerticalScrollIndicator = NO;
        _leftTab.showsHorizontalScrollIndicator = NO;
        _leftTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _leftTab;
}
-(UITableView *)rightTab{
    if (_rightTab == nil) {
        _rightTab = [[UITableView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH -80, ViewHeight)];
        _rightTab.backgroundColor = [UIColor whiteColor];
        _rightTab.dataSource = self;
        _rightTab.delegate = self;
        _rightTab.showsVerticalScrollIndicator = NO;
        _rightTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rightTab;
}
-(UIView*)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _headView.backgroundColor = [UIColor whiteColor];
        NSArray * namearray = @[@"商品",@"评价",@"商家"];
        for (int i = 0; i < 3; i ++ ) {
            UIButton *btn = [[UIButton alloc]init];
            [_headView addSubview:btn];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn setTitle:namearray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(chooseaction:) forControlEvents:UIControlEventTouchUpInside];
            [_headView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(i * SCREEN_WIDTH / 3);
                make.top.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3, 23));
            }];
            
            if (i == 0) {
                btn.selected = YES;
            }
        }
        
        
        _topScrollView = [[UIScrollView alloc]init];
        _topScrollView.backgroundColor = [UIColor whiteColor];
        _topScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1);
        [_headView addSubview:_topScrollView];
        [_topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(28);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 2));
        }];
        
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor orangeColor];
        self.number = 101;
        [_topScrollView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3, 1));
        }];
    }
        
  
    return _headView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headView];
        [self addSubview:self.contentScrollView];
        [self.contentScrollView addSubview:self.busiView];
        [self.contentScrollView addSubview:self.disgussView];
        
    }
    return self;
}



//点击选择分类
-(void)chooseaction:(UIButton *)sender {
    if (self.number != sender.tag) {
        UIButton * btn = [self.headView viewWithTag:self.number];
        btn.selected = !btn.selected;
        sender.selected = YES;
        self.number = sender.tag;
        __weak typeof(self) weakSelf = self;
        [_topScrollView setContentOffset:CGPointMake(- SCREEN_WIDTH/ 3 * (weakSelf.number - 101), 0) animated:YES];
            weakSelf.contentScrollView.contentOffset =CGPointMake(SCREEN_WIDTH *(weakSelf.number - 101) , 0);
   
  
    
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTab) {
        return 40;
    }
    if (tableView == _rightTab) {
        return 100;
    }
    if (tableView == _disgussView) {
        return 40;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTab) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            UIView *lineV = [[UIView alloc]init];
            lineV.backgroundColor = GRAYCLOLOR;
            [cell.contentView addSubview:lineV];
            [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.bottom.mas_equalTo(cell.mas_bottom).offset(-2);
                make.size.mas_equalTo(CGSizeMake(cell.bounds.size.width, 1));
            }];
        }
         cell.textLabel.text = [NSString stringWithFormat:@"分类%ld",indexPath.row];
        return cell;
    }
    
    if (tableView == _rightTab) {
        BusinessCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2 == nil) {
            cell2 = [[BusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell2;
    }
    
    if (tableView == _disgussView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
    cell.textLabel.text = [NSString stringWithFormat:@"分类%ld",indexPath.row];
        return cell;
    }
    
    return nil;
}



//   uiscrollView 协议

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
        if (!self.canscroll && scrollView != _contentScrollView) {
           [scrollView setContentOffset:CGPointZero];
            
            return;
        }


    if (scrollView.contentOffset.y < 0 &&  self.canscroll && scrollView != _contentScrollView) {
        self.canscroll = NO;
        if ([self.delegate respondsToSelector:@selector(scrollToTopView)]) {
            [self.delegate scrollToTopView];
        }
        
        
    }
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        if (_contentScrollView.contentOffset.x /SCREEN_WIDTH == 0 || _contentScrollView.contentOffset.x /SCREEN_WIDTH == 1 || _contentScrollView.contentOffset.x /SCREEN_WIDTH == 2 ) {
            if (self.number -101 != _contentScrollView.contentOffset.x /SCREEN_WIDTH ) {
                UIButton * btn = [self.headView viewWithTag:self.number];
                btn.selected = !btn.selected;
                UIButton *sender = [self.headView viewWithTag:101+_contentScrollView.contentOffset.x /SCREEN_WIDTH];
                sender.selected = YES;
                self.number = sender.tag;
               [_topScrollView setContentOffset:CGPointMake(- SCREEN_WIDTH/ 3 * (_contentScrollView.contentOffset.x / SCREEN_WIDTH), 0) animated:YES];
            }
            
            
            
        }
    
}

-(void)changescrolltype{
    self.canscroll = YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
