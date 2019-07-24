//
//  MyRefundCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "MyRefundCell.h"
#define SpareWidth 10
@implementation MyRefundCell
{
    NSArray *typeArray;
    NSArray *contentArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = GRAYCLOLOR;
       //  __weak typeof(self) weakSelf = self;
    //布局退款界面
        UIView *mainView = [[UIView alloc]init];
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.layer.cornerRadius = 10.0f;
        mainView.layer.masksToBounds = YES;
        [self.contentView addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 250));
        }];
        
        UIImageView *busphoto = [[UIImageView alloc]init];
        busphoto.backgroundColor = [UIColor redColor];
        busphoto.image = [UIImage imageNamed:@"51514284697_.pic_hd.jpg"];
        busphoto.layer.cornerRadius = 5.0f;
        busphoto.layer.masksToBounds = YES;
        [mainView addSubview:busphoto];
        [busphoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = @"肯德基(萧山店)";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [mainView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(busphoto.mas_right).offset(SpareWidth );
            make.centerY.mas_equalTo(busphoto.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 10));
        }];
        
        UILabel *stateLabel = [[UILabel alloc]init];
        stateLabel.textAlignment = NSTextAlignmentLeft;
        stateLabel.numberOfLines = 0;
        stateLabel.font = [UIFont systemFontOfSize:13];
        stateLabel.backgroundColor = [UIColor whiteColor];
        if (/* DISABLES CODE */ (1)) {
            stateLabel.textColor = TR_COLOR_RGBACOLOR_A(225,115,83,1);
            stateLabel.text = @"退款中";
        }else {
            stateLabel.textColor = [UIColor blackColor];
            stateLabel.text = @"退款完成";
        }
        
        [mainView addSubview:stateLabel];
        [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(SpareWidth);
            make.centerY.mas_equalTo(busphoto.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
       
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [mainView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(busphoto.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
        }];
        typeArray = @[@"退款时间",@"退款原因",@"退款周期",@"退款方式",@"退款编号",];
        
        for (int i = 0; i < 5; i ++ ) {
            UILabel *tempLabel = [[UILabel alloc]init];
            tempLabel.textColor = [UIColor grayColor];
            tempLabel.text = typeArray[i];
            tempLabel.textAlignment = NSTextAlignmentLeft;
            tempLabel.numberOfLines = 0;
            tempLabel.font = [UIFont systemFontOfSize:13];
            tempLabel.backgroundColor = [UIColor whiteColor];
            [mainView addSubview:tempLabel];
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SpareWidth);
                make.top.mas_equalTo(lineView.mas_bottom).offset((SpareWidth  + 15) * i + SpareWidth);
                make.size.mas_equalTo(CGSizeMake(80, 15));
            }];
            
            contentArray = @[@"2017.11.21 20:30:00",@"商家未接单",@"1-5个工作日",@"原路退回",@"900000000000123456",];
            UILabel *titleLabel2 = [[UILabel alloc]init];
            titleLabel2.textColor = [UIColor grayColor];
            titleLabel2.text = contentArray[i];
            titleLabel2.textAlignment = NSTextAlignmentRight;
            titleLabel2.numberOfLines = 0;
            titleLabel2.font = [UIFont systemFontOfSize:13];
            titleLabel2.backgroundColor = [UIColor clearColor];
            [mainView addSubview:titleLabel2];
            [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo( - SpareWidth / 2 );
                make.centerY.mas_equalTo(tempLabel.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(200, 15));
            }];
        }
    
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = GRAYCLOLOR;
        [mainView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(200);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 1));
        }];
        
        UILabel *refundcountLabel = [[UILabel alloc]init];
        refundcountLabel.textColor = TR_COLOR_RGBACOLOR_A(225,115,83,1);
        refundcountLabel.text = @"￥156.20";
        refundcountLabel.textAlignment = NSTextAlignmentRight;
        refundcountLabel.numberOfLines = 0;
        refundcountLabel.font = [UIFont systemFontOfSize:15];
        refundcountLabel.backgroundColor = [UIColor whiteColor];
        [mainView addSubview:refundcountLabel];
        [refundcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo( - SpareWidth / 2 );
            make.bottom.mas_equalTo( - SpareWidth / 2 );
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        UILabel *refundcountLabel2 = [[UILabel alloc]init];
        refundcountLabel2.textColor = [UIColor blackColor];
        refundcountLabel2.text = @"退款金额";
        refundcountLabel2.textAlignment = NSTextAlignmentRight;
        refundcountLabel2.numberOfLines = 0;
        refundcountLabel2.font = [UIFont systemFontOfSize:13];
        refundcountLabel2.backgroundColor = [UIColor whiteColor];
        [mainView addSubview:refundcountLabel2];
        [refundcountLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(refundcountLabel.mas_left);
            make.centerY.mas_equalTo(refundcountLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 15));
        }];
    }
    return self;
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
