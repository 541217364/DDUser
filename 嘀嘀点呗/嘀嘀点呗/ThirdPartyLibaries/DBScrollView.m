//
//  DBScrollView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/24.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "DBScrollView.h"
@implementation DBScrollView


- (instancetype)init {
    
    self=[super init];
    
    if (self) {
        __weak typeof(self) weakSelf=self;

        _myscrollView=[[UIScrollView alloc]init];
        [self addSubview:_myscrollView];
        [_myscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20,weakSelf.frame.size.height));
            
        }];
        
    }
    
    return self;
}


- (void) setScrollViewData:(NSArray *)array {
    
    __weak typeof(self) weakSelf=self;
    CGFloat interval= 5;
    CGFloat width=(SCREEN_WIDTH - 4 * interval)/3;
    
    for (int i=0; i<array.count; i++) {
        
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor=TR_COLOR_RGBACOLOR_A(22,174, 96,1);
//        [self addSubview: button];
//        [button addTarget:self action:@selector(chooseaction:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 1001 + i ;
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo((width+interval)*i + interval);
//        make.top.mas_equalTo(0);
//       // make.bottom.mas_equalTo(interval);
//        make.size.mas_equalTo(CGSizeMake(width,weakSelf.frame.size.height- 2 * interval));
//        }];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = TR_COLOR_RGBACOLOR_A(22, 174, 96, 1);
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 1001 + i;
        
        [self addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseaction:)];
        [imageView addGestureRecognizer:tap];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
          
        make.left.mas_equalTo((width+interval)*i + interval);
            
        make.top.mas_equalTo(0);
            
        make.size.mas_equalTo(CGSizeMake(width,weakSelf.frame.size.height- 2 * interval));
        }];
        
    }
}

-(void)chooseaction:(UITapGestureRecognizer *)sender {
    self.LoadDataBlock(@[], sender.view.tag -1001);
    NSLog(@"%ld 点击了第%ld",[sender view].tag,[sender view].tag -1001);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
