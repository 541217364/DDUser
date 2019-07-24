//
//  CityLocationCell.m
//  送小宝
//
//  Created by xgy on 2017/4/8.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "CityLocationCell.h"

@implementation CityLocationCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor=[UIColor whiteColor];
        _letterlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,10,20,20)];
        
        _letterlabel.textAlignment=NSTextAlignmentLeft;
        
        [self addSubview:_letterlabel];
        
        _citylabel=[[UILabel alloc]initWithFrame:CGRectMake(_letterlabel.frame.origin.x+_letterlabel.frame.size.width+5,10,SCREEN_WIDTH-35,20)];
        
        _citylabel.textAlignment=NSTextAlignmentLeft;
        
        [self addSubview:_citylabel];
        
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(_citylabel.frame.origin.x,39,SCREEN_WIDTH-35,1)];
        line.backgroundColor=TR_COLOR_RGBACOLOR_A(245,246,246,1);
        
        [self addSubview:line];
        
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
