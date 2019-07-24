//
//  ShopEvaluationView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/4.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ShopEvaluationView.h"
#import "CJTStarView.h"
#import "EvaluationModel.h"

@interface ShopEvaluationView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mytableview;

@end

@implementation ShopEvaluationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor=TR_COLOR_RGBACOLOR_A(214,214,214,1);
        [self initSubDataView];
        
        _mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0,90,SCREEN_WIDTH,frame.size.height-90)];
        
        _mytableview.delegate=self;
        
        _mytableview.dataSource=self;
        
        [self addSubview:_mytableview];
        
        
    }
    
    return self;
}

- (void) loadMydata {
    
  
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return  120;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor=[UIColor whiteColor];
        
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}


- (void)initSubDataView {
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,80)];
    
    backView.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:backView];
    
    CGFloat width=SCREEN_WIDTH/3;
    
    
    UILabel *storeplabel=[[UILabel alloc]initWithFrame:CGRectMake(0,10,width,40)];
    
    storeplabel.textAlignment=NSTextAlignmentCenter;
    storeplabel.text=@"4.9";
    [backView addSubview:storeplabel];
    
    UILabel *storetiplabel=[[UILabel alloc]initWithFrame:CGRectMake(0,storeplabel.frame.origin.y+storeplabel.frame.size.height,width,20)];
    storetiplabel.textAlignment=NSTextAlignmentCenter;
    storetiplabel.text=@"商家评分";
    
    [backView addSubview:storetiplabel];
    
    UILabel *fwlabel=[[UILabel alloc]initWithFrame:CGRectMake(width,20,40,20)];
    fwlabel.textAlignment=NSTextAlignmentLeft;
    fwlabel.text=@"服务";
    [backView addSubview:fwlabel];
    
  //  TQStarRatingView * starRatingView=[[TQStarRatingView alloc]initWithFrame:CGRectZero numberOfStar:5 large:NO];
  //  starRatingView.frame=CGRectMake(width+40,20,width-40,20);
  //  starRatingView.backgroundColor=[UIColor orangeColor];
  //  [self addSubview:starRatingView];
    
    UILabel *splabel=[[UILabel alloc]initWithFrame:CGRectMake(width,fwlabel.frame.origin.y+fwlabel.frame.size.height,40,20)];
    splabel.textAlignment=NSTextAlignmentLeft;
    splabel.text=@"商品";
    [backView addSubview:splabel];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(2*width,10,0.5,60)];
    
    line.backgroundColor=TR_COLOR_RGBACOLOR_A(231,231,231,1);
    
    [backView addSubview:line];
    
    UILabel *pslabel=[[UILabel alloc]initWithFrame:CGRectMake(2*width+0.5,10,width-0.5,40)];
    pslabel.textAlignment=NSTextAlignmentCenter;
    pslabel.text=@"4.6";
    [backView addSubview:pslabel];
    
    UILabel *psflabel=[[UILabel alloc]initWithFrame:CGRectMake(pslabel.frame.origin.x,pslabel.frame.origin.y+pslabel.frame.size.height,pslabel.frame.size.width,20)];
    psflabel.textAlignment=NSTextAlignmentCenter;
    
    psflabel.text=@"配送评分";
    
    [backView addSubview:psflabel];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
