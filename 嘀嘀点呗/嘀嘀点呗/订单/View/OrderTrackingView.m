//
//  OrderTrackingView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/6/13.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "OrderTrackingView.h"
#import "TouchScrollViewExtent.h"
@interface OrderTrackingView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *mytableView;

@property (nonatomic, strong) UIView *hideView;

@property (nonatomic, strong) UIScrollView * myscrollView;

@property (nonatomic,strong) NSMutableArray *datasource;

@end


@implementation OrderTrackingView

{
    BOOL iscanscroll1;
    BOOL iscanscroll2;
}

-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(UITableView *)mytableView{
    
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.frame = CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, SCREEN_HEIGHT / 2 -HOME_INDICATOR_HEIGHT);
        _mytableView.backgroundColor = [UIColor whiteColor];
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mytableView.dataSource = self;
        _mytableView.delegate = self;
    }
    return _mytableView;
}

-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.frame = self.bounds;
        _hideView.backgroundColor = [UIColor blackColor];
        _hideView.alpha = 0.7;
    }
    return _hideView;
}


-(UIScrollView *)myscrollView{
    if (_myscrollView == nil) {
        _myscrollView = [[TouchScrollViewExtent alloc]initWithFrame:self.bounds];
        _myscrollView.showsHorizontalScrollIndicator = NO;
        _myscrollView.showsVerticalScrollIndicator = NO;
        _myscrollView.bounces = NO;
//        _myscrollView.delegate = self;
//        _myscrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT* 1.5 - STATUS_BAR_HEIGHT);
    }
    return _myscrollView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.hideView];
        
        [self addSubview:self.myscrollView];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideVIewAction:)];
        tap.delegate = self;
        [tap setNumberOfTapsRequired:1];
        tap.cancelsTouchesInView = NO;

        [contentView addGestureRecognizer:tap];
        
        [self.myscrollView addSubview:contentView];
        [contentView addSubview:self.mytableView];
        
        UIView *footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,40)];
        self.mytableView.tableHeaderView = footV;
        UILabel *titleL = [[UILabel alloc]init];
        titleL.text = @"订单跟踪";
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor=TR_TEXTGrayCOLOR;

        [footV addSubview:titleL];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.top.right.bottom.right.mas_equalTo(0);
        }];
        
    }
    return self;
    
}


-(void)hideVIewAction:(UITapGestureRecognizer *)sender{
    
    [self removeFromSuperview];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UILabel *temp in cell.contentView.subviews) {
        [temp removeFromSuperview];
    }
    
    OrderStateItem *model = self.datasource[indexPath.row];
   
    [self designCellWith:cell.contentView withData:model];

    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}



-(void)designCellWith:(UIView *)contentView withData:(OrderStateItem *)model{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"MM月dd号  HH:mm"];//@"yyyy-MM-dd HH:mm:ss"
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[model.dateline integerValue]];
    
    NSString *datestr=[formatter stringFromDate:date];
    
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.text = model.status;
    leftLabel.numberOfLines = 0;
    [contentView addSubview:leftLabel];
    leftLabel.textColor=TR_COLOR_RGBACOLOR_A(46,46,46,1);
    leftLabel.font=[UIFont systemFontOfSize:14];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(10);
        make.width.mas_equalTo(SCREEN_WIDTH/2+50);
    }];

    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.textColor=TR_COLOR_RGBACOLOR_A(46,46,46,1);
    rightLabel.textAlignment=NSTextAlignmentRight;
    rightLabel.font=[UIFont systemFontOfSize:14];

    rightLabel.text = datestr;
   // CGSize size = TR_TEXT_SIZE(rightLabel.text, rightLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
    [contentView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(SCREEN_WIDTH/2-50);
    }];
    
    leftLabel.text = model.status_des;
    
//    switch ([model.status integerValue]) {
//        case 0:
//            leftLabel.text=@"订单已提交";
//            break;
//        case 1:
//             leftLabel.text=@"支付成功";
//            break;
//        case 2:
//            leftLabel.text=@"商家已接单";
//
//            break;
//        case 3:
//            leftLabel.text=@"骑士已接单";
//
//            break;
//        case 4:
//            leftLabel.text=@"骑士已取餐";
//
//            break;
//        case 5:
//            leftLabel.text=@"骑士配送中";
//
//            break;
//        case 6:
//            leftLabel.text=@"商品已送达";
//
//            break;
//        case 7:
//            leftLabel.text=@"订单已完成";
//
//            break;
//
//        case 8:
//            leftLabel.text=@"订单已评论";
//
//            break;
//
//        case 9:
//            leftLabel.text=@"已退款";
//
//            break;
//        case 10:
//            leftLabel.text=[NSString stringWithFormat:@"订单已取消:%@",model.note];
//
//            break;
//
//        default:
//
//            break;
//    }
    
    
}

-(void)handleWithOrderListModel:(OrderListModel *)model{
    
   // OrderStateItem
    
    [self.datasource removeAllObjects];
    
    if (model.status.count > 0) {
        
        [self.datasource addObjectsFromArray:model.status];
    }
    
    [self.mytableView reloadData];
    
}

- (void)loadstatus:(NSArray *)status {
    
    [self.datasource removeAllObjects];
    
    if (status.count > 0) {
        
        [self.datasource addObjectsFromArray:status];
    }
    
    [self.mytableView reloadData];
    
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
