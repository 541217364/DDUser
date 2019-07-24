//
//  SeachBtn.m
//  送小宝
//
//  Created by xgy on 2017/3/9.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SeachBtn.h"

@implementation SeachBtn

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        _mtitlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,frame.size.width+5,20)];
        _mtitlelabel.text=@"正在定位，请稍候";
        
       // _mtitlelabel.font=[UIFont systemFontOfSize:13];
        
        [self addSubview:_mtitlelabel];
        
        _arrowimgview=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_mtitlelabel.frame)+5,7,5,8)];
        
        _arrowimgview.image=[UIImage imageNamed:@"sy_arrow"];
        
        [self addSubview:_arrowimgview];
        
    }
    return self;
}


- (void) loadDataAdress:(NSString *)str {

    NSDictionary *attribute = @{NSFontAttributeName:_mtitlelabel.font};
    
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(0,20)
                                                   options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
 
    _mtitlelabel.text=str;
    
    if ((retSize.width+5)>150) {
         _mtitlelabel.frame=CGRectMake(0,0,150,20);
    }else
    _mtitlelabel.frame=CGRectMake(0,0,retSize.width+5,20);
    
    _arrowimgview.frame=CGRectMake(CGRectGetWidth(_mtitlelabel.frame)+5,7,5,8);
    
    self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width+25,self.frame.size.height);


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
