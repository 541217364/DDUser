//
//  LocationBtnView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/27.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "LocationBtnView.h"

@implementation LocationBtnView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-10,5,20,20)];
        imgview.image=[UIImage imageNamed:@"location_arrowpic"];
        
        [self addSubview:imgview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height-25,frame.size.width,20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=TR_COLOR_RGBACOLOR_A(252,122,46,1);
        label.font=[UIFont systemFontOfSize:14];
        label.text=@"重新定位";
        [self addSubview:label];
        
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
