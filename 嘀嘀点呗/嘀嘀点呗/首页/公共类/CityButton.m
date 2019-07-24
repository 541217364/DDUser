//
//  CityButton.m
//  送小宝
//
//  Created by xgy on 2017/4/7.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "CityButton.h"

@implementation CityButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        _citylabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,frame.size.width-20,frame.size.height)];
        _citylabel.numberOfLines = 0;
        
        _arrImgView=[[UIImageView alloc]initWithFrame:CGRectMake(_citylabel.frame.origin.x+_citylabel.frame.size.width,(frame.size.height-5)/2-2,11,6)];
        _arrImgView.image=[UIImage imageNamed:@"address_arrow"];
        _arrImgView.transform=CGAffineTransformMakeRotation(M_PI);
        [self addSubview:_citylabel];
        
        [self addSubview:_arrImgView];
        
        
    }
    
    return self;
}


- (void) setCitystr:(NSString *)citystr {
    
    
    _citystr=citystr;
    
    NSDictionary *attribute = @{NSFontAttributeName:_citylabel.font};
    
    CGSize retSize = [citystr boundingRectWithSize:CGSizeMake(0,_citylabel.frame.size.height)
                                                    options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                 attributes:attribute
                                                    context:nil].size;
    _citylabel.text=citystr;
    _citylabel.frame=CGRectMake(10, 0, retSize.width+5,self.frame.size.height);
    
    _arrImgView.frame=CGRectMake(_citylabel.frame.origin.x+_citylabel.frame.size.width,(self.frame.size.height-5)/2,11,6);
    
    self.frame=CGRectMake(self.frame.origin.x,self.frame.origin.y,_citylabel.frame.size.width+20,self.frame.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
