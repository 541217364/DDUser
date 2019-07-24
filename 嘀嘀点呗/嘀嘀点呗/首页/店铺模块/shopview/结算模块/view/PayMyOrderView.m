//
//  PayMyOrderView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PayMyOrderView.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface PayMyOrderView()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger mnum;

@property (nonatomic, assign) NSInteger smum;

@end


@implementation PayMyOrderView

{
    NSIndexPath *selectIndexpath;
}
-(UITableView *)mytable{
    if (_mytable == nil) {
        _mytable = [[UITableView alloc]init];
        _mytable.frame = self.bounds;
        _mytable.delegate = self;
        _mytable.dataSource = self;
        _mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytable.backgroundColor = [UIColor whiteColor];
    }
    return _mytable;
}

-(UILabel *)payTimeLabel{
    if (_payTimeLabel == nil) {
        _payTimeLabel = [[UILabel alloc]init];
        _payTimeLabel.textAlignment=NSTextAlignmentCenter;
        _payTimeLabel.font = TR_Font_Gray(15);
        _payTimeLabel.hidden = YES;
        _payTimeLabel.text = @"支付剩余时间14:50";
        _payTimeLabel.textColor = [UIColor grayColor];
    }
    return _payTimeLabel;
}

-(UIButton *)payBtn{
    if (_payBtn == nil) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.backgroundColor = [UIColor orangeColor];
        _payBtn.layer.cornerRadius = 5.0f;
        _payBtn.layer.masksToBounds = YES;
        [_payBtn addTarget:self action:@selector(payMyOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}


-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mytable];
        [self designView];
    }
    return self;
}

- (void)loadMinusStarTime:(NSString *)startime {
    
    [_timer invalidate];
   
    _timer=nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//@"yyyy-MM-dd HH:mm:ss"
    
    NSDate *star= [formatter dateFromString:startime];
    
    NSDate *nowdate=[NSDate date];
    
    NSInteger starnum=900-(nowdate.timeIntervalSince1970-star.timeIntervalSince1970);
    
    _mnum= starnum/60;
   
    _smum=starnum-_mnum*60;
 
    _timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadDateMinus:) userInfo:nil repeats:YES];
    [_timer fire];
}


- (void)loadDateMinus:(NSTimer *)timer {
    
    _smum--;
    
    if (_mnum<10) {
        
        if (_smum<10) {
            _payTimeLabel.text=[NSString stringWithFormat:@"支付剩余时间0%ld:0%ld",_mnum,_smum];
        }else
            _payTimeLabel.text=[NSString stringWithFormat:@"支付剩余时间0%ld:%ld",_mnum,_smum];
    }else{
        
        if (_smum<10) {
            _payTimeLabel.text=[NSString stringWithFormat:@"支付剩余时间%ld:0%ld",_mnum,_smum];
        }else
            _payTimeLabel.text=[NSString stringWithFormat:@"支付剩余时间%ld:%ld",_mnum,_smum];
    }

    
    if (_smum==0) {
        
        _mnum--;
     
        _smum=60;
        
    }
    
    if (_smum==0&&_mnum==0) {
        
        [_timer invalidate];
    }
}


-(void)designView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    self.mytable.tableHeaderView = headView;
    
    UIButton *retunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    retunBtn.layer.cornerRadius = 10.0f;
    retunBtn.layer.masksToBounds = YES;
    [retunBtn setImage:[UIImage imageNamed:@"pay-cancle"] forState:UIControlStateNormal];
    retunBtn.backgroundColor = [UIColor clearColor];
    [headView addSubview:retunBtn];
    [retunBtn addTarget:self action:@selector(canclePay:) forControlEvents:UIControlEventTouchUpInside];
    [retunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [headView addSubview:self.payTimeLabel];
   
    [self.payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, 30));
    }];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    footView.backgroundColor = [UIColor whiteColor];
    self.mytable.tableFooterView = footView;
    
    [footView addSubview:self.payBtn];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 80, 50));
    }];
    
}




-(void)canclePay:(UIButton *)sender{
    
    //取消支付
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickReturnToTop)]) {
        [self.delegate clickReturnToTop];
    }
    
}


-(void)payMyOrder:(UIButton *)sender{
    
    //确定付款  返回支付的类型
    NSString *payType = selectIndexpath.row == 0 ? @"weixin":@"alipay";
        
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickPayMyOrder:)]) {
            
        if (payType.length > 0) {
                
            [self.delegate clickPayMyOrder:payType];
        }
            
   }

    
}







-(void)weixinParyOrder{
    
}










-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[PayOrderTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (indexPath.row == 0) {
        cell.rightImageView.hidden = NO;
        cell.leftImageView.image = [UIImage imageNamed:@"pay-weixin"];
        cell.titleNameLabel.text = @"微信支付";
        selectIndexpath = indexPath;
    }else{

        cell.leftImageView.image = [UIImage imageNamed:@"pay-alipay"];
        cell.titleNameLabel.text = @"支付宝支付";
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (selectIndexpath != indexPath) {
        
        PayOrderTypeCell *cell = [self.mytable cellForRowAtIndexPath:selectIndexpath];
        if (cell) {
            cell.rightImageView.hidden = YES;
        }
        
        PayOrderTypeCell *cell2 = [self.mytable cellForRowAtIndexPath:indexPath];
        
        if (cell2) {
            cell2.rightImageView.hidden = NO;
        }
        selectIndexpath = indexPath;
    }
    
}


-(void)designViewWithdatasour:(NSArray *)datasource{
    
    if (datasource.count > 0) {
       [self.payBtn setTitle:[NSString stringWithFormat:@"确定支付￥%@元",datasource[0]] forState:UIControlStateNormal];
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
