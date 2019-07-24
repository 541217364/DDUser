//
//  MenuItem.m
//  送小宝
//
//  Created by xgy on 16/6/20.
//  Copyright (c) 2016年 xgy. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
//    UIViewContentModeScaleFill: 会把图片填充到图片视图中；
//    UIViewContentModeScaleAspectFit: 会使得图片以原有的高宽比以适应图片视图；
//    UIViewContentModeScaleAspectFill: 首先要设置图片视图的clipsToBounds属性为YES，使图片以原有高宽比填充整个图片视图，超出的部分会被剪辑掉；
//        因此一般设置图片视图模式为UIViewContentModeScaleAspectFit。
        
        _btnImgView=[[UIImageView alloc]init];
        _btnImgView.frame=CGRectMake(frame.size.width/2-17,10,34,25);
        _btnImgView.image=[UIImage imageNamed:@"grayhead_img"];
        _btnImgView.contentMode=UIViewContentModeScaleAspectFit;
        _btnImgView.backgroundColor=[UIColor clearColor];
        [self addSubview:_btnImgView];
        
        _btnTieleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,_btnImgView.frame.origin.y+_btnImgView.frame.size.height+5,frame.size.width,20)];
        _btnTieleLabel.backgroundColor=[UIColor clearColor];
        _btnTieleLabel.font=[UIFont systemFontOfSize:12];
        _btnTieleLabel.textColor=[UIColor grayColor];  //TR_TEXTGrayCOLOR;
        _btnTieleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_btnTieleLabel];
        
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
