//
//  CustomCapacityView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/7.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "CustomCapacityView.h"

@implementation CustomCapacityView


- (id)init {
    
    self=[super init];
    
    if (self) {
        
    }
    return self;
}


- (void) loadActivitys:(NSArray *)array withisYes:(BOOL)isyes  andWidth:(CGFloat)width{
    
    for (UIView *view in self.subviews) {
        
        if (view.tag/1000==3) {
            
            [view removeFromSuperview];
        }
        
    }
    
    //SCREEN_WIDTH- 100 -40
    CGFloat total=width;

    NSInteger num=0;
   
    NSInteger j=0;
    
    CGFloat totalwidth=0;
    
    for (int i=0;i<array.count; i++) {
        
        NSString *str=array[i];
        if (str.length!=0) {
            UILabel *titlelabel=[[UILabel alloc]init];
            
            titlelabel.font=[UIFont systemFontOfSize:12];
            
            titlelabel.textColor=TR_COLOR_RGBACOLOR_A(246,92,85,1);
            titlelabel.layer.borderColor=TR_COLOR_RGBACOLOR_A(246,92,85,1).CGColor;
            titlelabel.textAlignment=NSTextAlignmentCenter;
            titlelabel.layer.borderWidth=1.0;
            
            titlelabel.layer.masksToBounds=YES;
            titlelabel.text=str;
            titlelabel.tag=3000+i;
            [self addSubview:titlelabel];
            NSDictionary *attribute = @{NSFontAttributeName:titlelabel.font};
            
            CGSize retSize = [str boundingRectWithSize:CGSizeMake(0,20)
                                               options:\
                              NSStringDrawingTruncatesLastVisibleLine |
                              NSStringDrawingUsesLineFragmentOrigin |
                              NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
            
            titlelabel.frame=CGRectMake(totalwidth,10*j+20*j,retSize.width+5,20);
            totalwidth+=retSize.width+5+10;
            
            if (totalwidth>=total) {
                num=0;
                j++;
                titlelabel.frame=CGRectMake(0,10*j+20*j,retSize.width+5,20);
                totalwidth=retSize.width+5+10;
                
            }else{
                num++;
                
            }
            if (!isyes&&j>0) {
                
                titlelabel.hidden=YES;
            }
        }
      
        
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
