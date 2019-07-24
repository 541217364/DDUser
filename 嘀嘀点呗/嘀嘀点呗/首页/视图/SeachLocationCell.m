//
//  SeachLocationCell.m
//  送小宝
//
//  Created by xgy on 2017/4/13.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SeachLocationCell.h"

@implementation SeachLocationCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        
        _adressname=[[UILabel alloc]initWithFrame:CGRectMake(10,10,SCREEN_WIDTH-110,20)];
        
        _adressname.textAlignment=NSTextAlignmentLeft;
    
        [self addSubview:_adressname];
        
        _adresslabel=[[UILabel alloc]initWithFrame:CGRectMake(10,_adressname.frame.origin.y+_adressname.frame.size.height+10,SCREEN_WIDTH,20)];
        _adresslabel.textColor=TR_TEXTGrayCOLOR;
        
        _adresslabel.textAlignment=NSTextAlignmentLeft;
        
        [self addSubview:_adresslabel];
        
        
        _pricelabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110,_adressname.frame.origin.y,100,20)];
        _pricelabel.textColor=TR_TEXTGrayCOLOR;
     
        _pricelabel.textAlignment=NSTextAlignmentRight;
        
        [self addSubview:_pricelabel];
        
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
