//
//  TimeChooseView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/12.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "TimeChooseView.h"

#define SpareWidth 80

@implementation TimeChooseView


{
    NSIndexPath *selectIndexPath;
    CGRect oriRect;
    
}



-(UITableView *)leftTabview {
    if (_leftTabview == nil) {
        _leftTabview = [[UITableView alloc]init];
        _leftTabview.backgroundColor = [UIColor whiteColor];
        _leftTabview.dataSource = self;
        _leftTabview.delegate = self;
        _leftTabview.scrollEnabled = NO;
    }
    return _leftTabview;
}
-(UITableView *)rightTabview {
    if (_rightTabview == nil) {
        _rightTabview = [[UITableView alloc]init];
        _rightTabview.backgroundColor = [UIColor whiteColor];
        _rightTabview.dataSource = self;
        _rightTabview.delegate = self;
    }
    return _rightTabview;
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        UILabel *topLabel = [[UILabel alloc]init];
        topLabel.text = @"选择送达时间";
        topLabel.textAlignment = NSTextAlignmentCenter;
        topLabel.font = TR_Font_Gray(17);
        [self addSubview:topLabel];
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
        }];
        
        self.leftTabview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftTabview];
        
        [self.leftTabview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(30);
            make.size.mas_equalTo(CGSizeMake(60, SCREEN_HEIGHT -SpareWidth));
        }];
    
        self.rightTabview.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.rightTabview];
        [self.rightTabview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(100);
            make.top.mas_equalTo(30);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - SpareWidth));
        }];

        self.leftTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rightTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
     
        
         }
    return  self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTabview) {
        
        return self.dataSource.count;
    }
    
    if (tableView == self.rightTabview) {
        if (self.dataSource.count > 0) {
            NSDictionary *tempDic = self.dataSource[selectIndexPath.row];
            NSArray *tempArray = tempDic[@"date_list"];
            return tempArray.count;
        }else{
            
            return 0;
        }
    }
    
    return 0;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTabview) {
        UITableViewCell *cell = [self.leftTabview dequeueReusableCellWithIdentifier:@"cell1"];
        if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        
        NSDictionary *tempDic = self.dataSource[indexPath.row];
        cell.textLabel.text = tempDic[@"show_date"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor grayColor];
        
        if (indexPath.row == 0) {

            cell.textLabel.textColor = [UIColor blackColor];
            selectIndexPath = indexPath;
        }
        
        
        CGSize size = TR_TEXT_SIZE(cell.textLabel.text, cell.textLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        
        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(size.width + 10, 20));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
        }else if (tableView == self.rightTabview){
            
            UITableViewCell *cell = [self.rightTabview dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
                
            }
            
            
            NSDictionary *tempDic = self.dataSource[selectIndexPath.row];
            NSArray *tempArray = tempDic[@"date_list"];
            cell.textLabel.text = tempArray[indexPath.row][@"hour_minute"];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.backgroundColor = [UIColor whiteColor];
           
            
            UILabel *tempL = [cell.contentView viewWithTag:1000];
            if (tempL) {
                [tempL removeFromSuperview];
            }
            
            
            
            UILabel *tempLable = [[UILabel alloc]init];
            tempLable.tag = 1000;
            tempL.textColor = [UIColor grayColor];
            tempL.font = [UIFont systemFontOfSize:15];
            tempL.textAlignment = NSTextAlignmentCenter;
            tempLable.text = [NSString stringWithFormat:@"￥%@",tempArray[indexPath.row][@"delivery_fee"]];
            [cell.contentView addSubview:tempLable];
            [tempLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(60, 20));
            }];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 0 && selectIndexPath.row == 0) {
                cell.textLabel.text =  [NSString stringWithFormat:@"立即送达 (大约%@)",tempArray[indexPath.row][@"hour_minute"]];
                cell.textLabel.textColor = [UIColor blackColor];
            }
            
            
            return cell;
        }
    
    return nil;
}

-(void)addDatasourceToView:(NSArray *)deliver_time_list{
    
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:deliver_time_list];
    [self.leftTabview reloadData];
    [self.rightTabview reloadData];
    
    oriRect = self.frame;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTabview) {
        
        if (indexPath != selectIndexPath) {
            
            UITableViewCell *cell = [_leftTabview cellForRowAtIndexPath:selectIndexPath];
            cell.textLabel.textColor = [UIColor grayColor];
            
            UITableViewCell *cell2 = [_leftTabview cellForRowAtIndexPath:indexPath];
            cell2.textLabel.textColor = [UIColor blackColor];
            selectIndexPath = indexPath;
            [_rightTabview reloadData];
        }
    }
    
    
    if (tableView == _rightTabview) {
        
        NSDictionary *tempDic = self.dataSource[selectIndexPath.row];
        
        NSDictionary *tempArray = tempDic[@"date_list"][indexPath.row];
        
         NSString *chooseTime = [NSString stringWithFormat:@"%@ %@",tempDic[@"show_date"],tempArray[@"hour_minute"]];
        
        BOOL isfirst = false ;
        
        if (indexPath.row == 0 && selectIndexPath.row == 0) {
            
            isfirst = YES;
        }
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(chooseTimeSuccess:isfirstTime:)]) {
            [self.delegate chooseTimeSuccess:chooseTime isfirstTime:isfirst];
        }
        
    }
    
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _rightTabview ) {
        
        CGRect rect = self.frame;
        
        if (rect.origin.y > SpareWidth) {
            
            rect.origin.y = rect.origin.y - scrollView.contentOffset.y;
            
            self.frame = rect;
           
            if (rect.origin.y > oriRect.origin.y) {
                
                self.frame = oriRect;
            }
            
            [_rightTabview setContentOffset:CGPointZero];
            
        }else{
            
            
            if (scrollView.contentOffset.y < 0) {
                
                rect.origin.y = rect.origin.y - scrollView.contentOffset.y;
                
                self.frame = rect;
                
                  [_rightTabview setContentOffset:CGPointZero];
                
            }
            
            
        }
       
        
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (fabs(self.frame.origin.y -oriRect.origin.y) < 20) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = self->oriRect;
        }];
        
    }
    
    if (fabs(self.frame.origin.y - SpareWidth) < 20) {
        
        CGRect rect = CGRectMake(self.frame.origin.x, SpareWidth, self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = rect;
        }];
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
