//
//  ModifyAdresslocationView.m
//  送小宝
//
//  Created by xgy on 2017/3/13.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ModifyAdresslocationView.h"

@implementation ModifyAdresslocationView


-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        _locationimgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,10,15,20)];
        
       // _locationimgview.backgroundColor=[UIColor redColor];
        
        _locationimgview.image=[UIImage imageNamed:@"adress_location"];
        
        [self addSubview:_locationimgview];
        
        _locationlabel=[[UILabel alloc]initWithFrame:CGRectMake(_locationimgview.frame.origin.x+_locationimgview.frame.size.width+5,0,frame.size.width-_locationimgview.frame.origin.x-_locationimgview.frame.size.width-30,frame.size.height)];
        _locationlabel.adjustsFontSizeToFitWidth=YES;
        _locationlabel.textAlignment=NSTextAlignmentLeft;
        _locationlabel.numberOfLines=0;
        [self addSubview:_locationlabel];
        
        
        UIImageView *arrowimgview=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-20,_locationlabel.frame.origin.y+15,10,10)];
       // arrowimgview.image=[UIImage imageNamed:@"adress_location"];
        
        [self addSubview:arrowimgview];
        
        
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
