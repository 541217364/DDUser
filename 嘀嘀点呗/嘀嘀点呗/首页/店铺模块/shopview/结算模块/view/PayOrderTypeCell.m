//
//  PayOrderTypeCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/11.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PayOrderTypeCell.h"

@implementation PayOrderTypeCell


-(UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor whiteColor];
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.image = [UIImage imageNamed:@"pay-choose"];
        _rightImageView.hidden = YES;
        _rightImageView.backgroundColor = [UIColor whiteColor];
    }
    return _rightImageView;
}


-(UILabel *)titleNameLabel{
    if (_titleNameLabel == nil) {
        _titleNameLabel = [[UILabel alloc]init];
        _titleNameLabel.font = [UIFont systemFontOfSize:17];
        _titleNameLabel.textColor = [UIColor blackColor];
    }
    return _titleNameLabel;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      __weak typeof(self) weakSelf = self;
        
        [self.contentView addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [self.contentView addSubview:self.titleNameLabel];
        [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.leftImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(150, 30));
        }];
        
        [self.contentView addSubview:self.rightImageView];
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- 20);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-2);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
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
