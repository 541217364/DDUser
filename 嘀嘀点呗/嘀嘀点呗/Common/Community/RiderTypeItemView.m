//
//  RiderTypeItemView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/7/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "RiderTypeItemView.h"
#import "OrderBroadcastModel.h"

#define viewWidth 200

#define viewHeight 50


@implementation RiderTypeItemView


-(NSMutableArray *)datasource{
    
    if (_datasource == nil) {
        
        _datasource = [NSMutableArray array];
    }
    
    return _datasource;
}


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.hidden = YES;
        
        self.backgroundColor = ORANGECOLOR;
        
        self.layer.cornerRadius = 25.0f;
        
        self.layer.masksToBounds = YES;
        
        UIScrollView *myscrollView = [[UIScrollView alloc]init];
        
        _myscrollView = myscrollView;
        
        [self addSubview:myscrollView];
        
        [myscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(viewWidth, viewHeight));
        }];
        
        
        
        
    }
    
    return self;
}





-(void)setIsShowView:(BOOL)isShowView{
    
    _isShowView = isShowView;
    
}



-(void)addDatatoView{
    
    __weak typeof(self) weakSelf=self;
    
    [HBHttpTool post:SHOP_BROADCAST body:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket} success:^(id responseObj) {
        
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            weakSelf.datasource = [OrderBroadcastModel arrayOfModelsFromDictionaries:responseObj[@"result"] error:nil];
            [weakSelf parseWithData];
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}




-(void)parseWithData{
    
    
    if (self.datasource.count == 0 && self.datasource) {
        
        self.hidden = YES;
        
        return;
    }
    
    
    
    self.hidden = NO;
    
    self.isShowView = YES;
    

    if (self.datasource.count > 0) {
        
        if (self.timer == nil && self.datasource.count != 1) {
            
            self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(showMoreRiderMessage) userInfo:nil repeats:YES];
            
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
        
        for (UIView *tempView in _myscrollView.subviews) {
            
            [tempView removeFromSuperview];
        }
        
        
        NSInteger count = self.datasource.count == 1 ? 1:self.datasource.count + 2;
        
        _myscrollView.contentSize = CGSizeMake(0, viewHeight * count);
        
        for (int i = 0; i < count; i ++) {
            
            UIView *riderView = [[UIView alloc]init];
            
            riderView.backgroundColor = ORANGECOLOR;
            
            riderView.tag = 1000+ i;
            
            [_myscrollView addSubview:riderView];
            
            OrderBroadcastModel *model;
            
            if (i == 0) {
                
                model = [self.datasource lastObject];
                
            }else if (i == count - 1){
                
                model = [self.datasource firstObject];
                
            }else{
                
                model = self.datasource[i - 1];
                
            }
            
            
            [self designViewWithModel:model withView:riderView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOrderAction:)];
            
            [riderView addGestureRecognizer:tap];
            
            
            [riderView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(i * viewHeight);
                make.size.mas_equalTo(CGSizeMake(viewWidth, viewHeight));
            }];
        }
        
    }else{
        
        if (self.timer) {
            
            [self.timer invalidate];
            
            self.timer = nil;
        }
        
    }
    
}



-(void)designViewWithModel:(OrderBroadcastModel *)model withView:(UIView *)contentView{
    
            UIImageView *myImageV = [[UIImageView alloc]init];
    
            myImageV.layer.cornerRadius = 22.0f;
    
            myImageV.layer.masksToBounds = YES;
    
            myImageV.backgroundColor = GRAYCLOLOR;
    
            myImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    [myImageV sd_setImageWithURL:[NSURL URLWithString:model.store_img] placeholderImage:[UIImage imageNamed:@"qs_headpic"]];
    
            [contentView addSubview:myImageV];
    
            [myImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(2);
                make.centerY.mas_equalTo(0);
                make.width.mas_equalTo(44);
                make.height.mas_equalTo(44);
            }];
    
    
           UILabel *mytopLabel = [[UILabel alloc]init];
    
            mytopLabel.textColor = [UIColor whiteColor];
    
            mytopLabel.text = model.status_des;
    
            mytopLabel.textAlignment = NSTextAlignmentCenter;
    
            mytopLabel.adjustsFontSizeToFitWidth = YES;
    
            mytopLabel.font = TR_Font_Gray(14);
    
            [contentView addSubview:mytopLabel];
    
            [mytopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
                make.left.mas_equalTo(myImageV.mas_right).offset(10);
    
                make.top.mas_equalTo(5);
    
                make.height.mas_equalTo(20);
    
            }];
    
    
           UILabel *mybottomLabel = [[UILabel alloc]init];
    
            mybottomLabel.textColor = [UIColor whiteColor];
    
    NSDate *nowDate=[NSDate dateWithTimeIntervalSince1970:model.expect_use_time.intValue];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init] ;
    
    [dateformatter setDateFormat:@"HH:mm"];
    
    NSString *dateStr = [dateformatter stringFromDate:nowDate];
    
    mybottomLabel.attributedText = [self setText2:[NSString stringWithFormat:@"预计送达 %@",dateStr] andText2:dateStr];
    
            mybottomLabel.textAlignment = NSTextAlignmentCenter;
    
            mybottomLabel.font = TR_Font_Gray(12);
    
            [contentView addSubview:mybottomLabel];
    
            [mybottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
                make.left.mas_equalTo(myImageV.mas_right).offset(10);
    
                make.bottom.mas_equalTo(-5);
    
                make.height.mas_equalTo(20);
    
            }];
    
    
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
            [rightBtn setImage:[UIImage imageNamed:@"rider_right"] forState:UIControlStateNormal];
    
            rightBtn.layer.cornerRadius = 10.0f;
    
            rightBtn.layer.masksToBounds = YES;
    
            rightBtn.userInteractionEnabled = NO;
    
   // [rightBtn addTarget:self action:@selector(clickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
            [contentView addSubview:rightBtn];
    
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-5);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(20, 20));
    
            }];
    
    
}



-(void)clickOrderAction:(UITapGestureRecognizer *)sender{
    
    if (!self.hidden) {
        
        CGRect rect = self.frame;
        
        if (rect.origin.x == SCREEN_WIDTH - 50) {
            
            [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                
                self.frame = CGRectMake(SCREEN_WIDTH - 210, rect.origin.y, rect.size.width, rect.size.height);
                
            }];
            
            return;
            
        }
    }

    
    UIView *tempView = sender.view;
    
    if (tempView) {
        
        OrderBroadcastModel *model;
        
        if (tempView.tag - 1000 == 0) {
            
            model = [self.datasource lastObject];
            
        }else if (tempView.tag - 1000 == self.datasource.count  + 1){
          
            model = [self.datasource firstObject];
            
        }else{
            
            model = self.datasource[tempView.tag - 1001];
            
        }
            
        
        OrderMapDetailsViewController *orderMapVC=[[OrderMapDetailsViewController alloc]init];
        
        
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        
        orderMapVC.orderId=model.order_id;
        
            orderMapVC.state= model.status;
            
            [APP_Delegate.rootViewController.viewControllers[APP_Delegate.rootViewController.selectedIndex] pushViewController:orderMapVC animated:YES];
        
        
        
    }
    
    
    
    
}


-(void)showMoreRiderMessage{
    
    
    NSInteger index = _myscrollView.contentOffset.y / viewHeight;
    
    NSInteger sizeIndex = self.datasource.count + 1;
    
    
    if (index != sizeIndex) {

    [_myscrollView setContentOffset:CGPointMake(0, viewHeight *(index + 1)) animated:YES];
        

    }else{

        [_myscrollView setContentOffset:CGPointMake(0, viewHeight *(index + 1)) animated:YES];
        [_myscrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        [self showMoreRiderMessage];
    }
    
}


- (NSMutableAttributedString *) setText2:(NSString *)text andText2:(NSString *)mtext2 {
    
    NSString *text1=text;
    
    NSString *text2=mtext2;
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:TR_Font_Gray(12)
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    
    NSRange redTextRange =[text1 rangeOfString:text2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:TR_Font_Gray(12)} range:redTextRange];
    
    return attributedText;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
