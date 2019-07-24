//
//  MyRedBaoCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyRedBaoCell.h"
#define SpareWidth 10
@implementation MyRedBaoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.contentView.backgroundColor =[UIColor clearColor];
        UIView *bottom = [[UIView alloc]init];
        bottom.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottom];
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 120));
        }];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.text = @"通用红包";
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [bottom addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.text = @"有效期至2018.1.20";
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.numberOfLines = 0;
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.backgroundColor = [UIColor whiteColor];
        [bottom addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
          make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(SpareWidth);
          make.size.mas_equalTo(CGSizeMake(150, 10));
        }];
        
       
        
        NSDictionary *attributesExtra = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
        NSDictionary *attributesPrice = @{NSFontAttributeName:[UIFont systemFontOfSize:25],
                                            NSForegroundColorAttributeName:[UIColor redColor]};
        NSAttributedString *attributedString = [self attributedText:@[@"￥", @"15"]
        attributeAttay:@[attributesExtra,attributesPrice]];
        self.moneyLabel = [[UILabel alloc]init];
        self.moneyLabel.textColor = [UIColor redColor];
        self.moneyLabel.attributedText = attributedString;
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel.numberOfLines = 0;
        [bottom addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- SpareWidth);
            make.top.mas_equalTo(SpareWidth );
            make.size.mas_equalTo(CGSizeMake(80, SpareWidth * 4));
        }];
    
        self.moneycountLabel = [[UILabel alloc]init];
        self.moneycountLabel.textColor = [UIColor grayColor];
        self.moneycountLabel.text = @"满30可用";
        self.moneycountLabel.textAlignment = NSTextAlignmentRight;
        self.moneycountLabel.numberOfLines = 0;
        self.moneycountLabel.font = TR_Font_Gray(12);
        self.moneycountLabel.backgroundColor = [UIColor whiteColor];
        [bottom addSubview:self.moneycountLabel];
        [self.moneycountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo( - SpareWidth );
          make.top.mas_equalTo(weakSelf.moneyLabel.mas_bottom).offset(SpareWidth / 2 );
          make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
        
       
        
        self.phoneLabel = [[UILabel alloc]init];
        self.phoneLabel.textColor = [UIColor grayColor];
        self.phoneLabel.text = @"限外卖订单使用，仅限制12345678913使用";
        self.phoneLabel.textAlignment = NSTextAlignmentLeft;
        self.phoneLabel.numberOfLines = 0;
        self.phoneLabel.font = [UIFont systemFontOfSize:12];
        self.phoneLabel.backgroundColor = [UIColor whiteColor];
        [bottom addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.moneycountLabel.mas_top);
            make.right.mas_equalTo(weakSelf.moneycountLabel.mas_left).offset(-SpareWidth);
            make.height.mas_equalTo(30);
        }];
        
        self.goStoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goStoreBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.goStoreBtn setTitle:@"去使用 >" forState:UIControlStateNormal];
        self.goStoreBtn.titleLabel.font = TR_Font_Gray(12);
        [self.goStoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.goStoreBtn addTarget:self action:@selector(gotouseticket:) forControlEvents:UIControlEventTouchUpInside];
        [bottom addSubview:self.goStoreBtn];
        [self.goStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.moneycountLabel.mas_right);
        make.top.mas_equalTo(weakSelf.moneycountLabel.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
        
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [bottom addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.phoneLabel.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 4 * SpareWidth, 1));
        }];
        
        
        
    }
    return self;
}




- (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay{
    NSString * string = [stringArray componentsJoinedByString:@""];
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++){
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}



//数据处理
-(void)parseWithDataModel:(NSString *)title withModel:(RedBaoModel *)model{
     __weak typeof(self) weakSelf = self;
    if ([title isEqualToString:@"红包"]) {
        self.titleLabel.text = model.name;
        self.timeLabel.text =  [NSString stringWithFormat:@"有效期至%@",model.end_time];
        self.phoneLabel.text = [NSString stringWithFormat:@"限外卖订单使用，仅限制%@使用",model.phone];
        self.phoneLabel.hidden = YES;
        [self.goStoreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(weakSelf.timeLabel.mas_left).offset(-5);
       make.top.mas_equalTo(weakSelf.timeLabel.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
        
    }
    
    
    
}

-(void)parseWithtitle:(NSString *)title withModel:(ShopDis *)model{
    
    if ([title isEqualToString:@"代金券"]) {
        
        self.titleLabel.text = model.name;
        self.timeLabel.text =  [NSString stringWithFormat:@"有效期至%@",model.end_time];

        
        self.phoneLabel.hidden = NO;
         __weak typeof(self) weakSelf = self;
        [self.goStoreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.moneycountLabel.mas_right);
        make.top.mas_equalTo(weakSelf.moneycountLabel.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
    }
}


//点击去使用调用
-(void)gotouseticket:(UIButton *)sender{
    NSLog(@"11111111");
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
