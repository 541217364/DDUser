//
//  OrderStarView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "OrderStarView.h"

@implementation OrderStarView


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self designView];
    }
    return self;
}




-(void)designView{
    
    CGFloat btnwidth = (220 -20) / 5;
    CGFloat height = 40;
    self.selectCount = 0;
    for (int i = 0; i < 5; i ++) {
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"star_unselect"];
        imageV.tag = 1000 + i;
        imageV.userInteractionEnabled = YES;
        [self addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((btnwidth + 5) * i);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(btnwidth, height));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickStatView:)];
        [imageV addGestureRecognizer:tap];
        
        
    }
    
    UIPanGestureRecognizer *up = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    [self addGestureRecognizer:up];
    
}

-(void)handleSwipes:(UIPanGestureRecognizer *)recognizer {
   
    CGFloat btnwidth = (220 -20) / 5;

    CGPoint point= [recognizer locationInView:self];
  
    CGFloat scaln=point.x/btnwidth;
    NSInteger scalnnum=scaln;
    UIImageView *imageView1 = [self viewWithTag:1000+scalnnum];
    self.selectCount=scalnnum;
    for (NSInteger i = 1000; i < 1005; i++) {
            
            UIImageView *imageView = [self viewWithTag:i];
            
            if (i<(scalnnum+1000)) {
                
                imageView.image=[UIImage imageNamed:@"star_select"];
                
            }else{
                
                imageView.image=[UIImage imageNamed:@"star_unselect"];
            }
        
        }
    
    if ((scaln-scalnnum)<=0.5&&(scaln-scalnnum)>0) {
        
        imageView1.image=[UIImage imageNamed:@"star_slices"];
        self.selectCount=self.selectCount+0.5;
    }
    
    if ((scaln-scalnnum)<=1&&(scaln-scalnnum)>0.5) {
        
        imageView1.image=[UIImage imageNamed:@"star_select"];
        self.selectCount=self.selectCount+1;
        
    }
    
    self.countBlock(self.selectCount);
    
}


-(void)clickStatView:(UITapGestureRecognizer *)sender{
    
    UIImageView *tempImage = (UIImageView *)[sender view];
    
    [self startWithCount:tempImage.tag];
    self.selectCount = tempImage.tag - 1000 + 1;
    
    self.countBlock(self.selectCount);
}


-(void)startWithCount:(NSInteger )imageTag{
    
    for (NSInteger i = 1000; i < imageTag + 1; i++) {
        
        UIImageView *imageView = [self viewWithTag:i];
        imageView.image = [UIImage imageNamed:@"star_select"];
    }
    
    for (NSInteger i = imageTag + 1; i < 1005; i ++) {
       
        UIImageView *imageView = [self viewWithTag:i];
        imageView.image = [UIImage imageNamed:@"star_unselect"];
        
    }
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    for (NSInteger i = 1000; i < 1005; i ++) {
//
//        UIImageView *imageView = [self viewWithTag:i];
//        imageView.image = [UIImage imageNamed:@"star_unselect"];
//
//    }
//    self.selectCount = 0;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
