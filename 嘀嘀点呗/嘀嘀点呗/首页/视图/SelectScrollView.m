//
//  SelectScrollView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/2.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SelectScrollView.h"

@interface SelectScrollView ()

@property (nonatomic, strong) UIView *shoppingView;

@end

@implementation SelectScrollView


- (id) initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        NSArray *titlearray=@[@"商品",@"评价",@"商家"];
        
        for (int i=0;i<titlearray.count; i++) {
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:titlearray[i] forState:UIControlStateNormal];
            button.titleLabel.textAlignment=NSTextAlignmentCenter;
            button.frame=CGRectMake(i*SCREEN_WIDTH/3,0,SCREEN_WIDTH/3,40);
            button.tag=1000+i;
            [self addSubview:button];
        }
        
        _myscrollView=[[UIScrollView alloc]init];
        
        _myscrollView.frame=CGRectMake(0,40,frame.size.width,frame.size.height-40);
        
        
        _myscrollView.contentSize=CGSizeMake(_myscrollView.frame.size.width*3,_myscrollView.frame.size.height);
        
        _myscrollView.pagingEnabled=YES;
        
        [self addSubview:_myscrollView];
        
       
        [self initCommodityView];
    }
    
    return self;
}


- (void)initCommodityView {
    
    _goodshowView=[[GoodsShowView alloc]initWithFrame:CGRectMake(0,0,_myscrollView.frame.size.width,_myscrollView.frame.size.height)];
    _goodshowView.mytableView.scrollEnabled=NO;
   
    [_myscrollView addSubview:_goodshowView];
    
    
    _shoppingView =[[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-55,SCREEN_WIDTH,55)];
    
    _shoppingView.backgroundColor=[UIColor blackColor];
    
    [_myscrollView addSubview:_shoppingView];
    
    
    _shopEvaluationView=[[ShopEvaluationView alloc]initWithFrame:CGRectMake(_myscrollView.frame.size.width,0,_myscrollView.frame.size.width,_myscrollView.frame.size.height)];
    
    [_myscrollView addSubview:_shopEvaluationView];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
