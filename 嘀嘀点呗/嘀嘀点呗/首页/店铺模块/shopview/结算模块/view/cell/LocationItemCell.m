//
//  LocationItemCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/22.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "LocationItemCell.h"
#define GreenColor TR_COLOR_RGBACOLOR_A(207, 222, 247, 1)
#define TextColor TR_COLOR_RGBACOLOR_A(65, 148, 251, 1)

@implementation LocationItemCell

-(UILabel *)typeLocationLabel{
    if (_typeLocationLabel == nil) {
        _typeLocationLabel = [[UILabel alloc]init];
        _typeLocationLabel.backgroundColor = GreenColor;
        _typeLocationLabel.textColor = TextColor;
        _typeLocationLabel.textAlignment = NSTextAlignmentCenter;
        _typeLocationLabel.text = @"公司";
         [self.contentView addSubview:_typeLocationLabel];
    }
    return _typeLocationLabel;
}


-(UILabel *)locationLabel{
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc]init];
        _locationLabel.numberOfLines = 0;
        _locationLabel.text = @"杭州市萧山区博地中心2503  ";
        _locationLabel.font = TR_Font_Gray(16);
         [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}


-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"张三疯  先生";
        _nameLabel.font = TR_Font_Gray(15);
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.textColor = [UIColor grayColor];
         [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UILabel *)userPhoneLabel{
    
    if (_userPhoneLabel == nil) {
        _userPhoneLabel = [[UILabel alloc]init];
        _userPhoneLabel.text = @"12345678911";
        
        _userPhoneLabel.font = TR_Font_Gray(15);
        _userPhoneLabel.textColor = [UIColor grayColor];
        
         [self.contentView addSubview:_userPhoneLabel];
    }
    return _userPhoneLabel;
}


-(UIButton *)designBtn{
    
    if (_designBtn == nil) {
        _designBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_designBtn setImage:[UIImage imageNamed:@"setting-ending"] forState:UIControlStateNormal];
        [self.contentView addSubview:_designBtn];
    }
    return _designBtn;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
         __weak typeof(self) weakSelf = self;
        
        
        [self.typeLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
        [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(weakSelf.typeLocationLabel.mas_right).offset(10);
            make.centerY.mas_equalTo(weakSelf.typeLocationLabel.mas_centerY);
            make.right.mas_equalTo(-30);
        }];
        
        CGSize size2 = TR_TEXT_SIZE(self.nameLabel.text, self.nameLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.typeLocationLabel.mas_left);
        make.top.mas_equalTo(weakSelf.typeLocationLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(size2.width + 10, 20));
        }];
        
        CGSize size3 = TR_TEXT_SIZE(self.userPhoneLabel.text, self.userPhoneLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        
        [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(10);
           make.centerY.mas_equalTo(weakSelf.nameLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(size3.width + 10, 20));
        }];
        
        [self.designBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
    }
    
    UIView *lineV = [[UIView alloc]init];
    
    lineV.backgroundColor = GRAYCLOLOR;
    
    [self addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        
        make.bottom.mas_equalTo(-1);
        
        make.height.mas_equalTo(1);
    }];
    
    return self;
}


-(void)designViewWithMode:(UserAddressModel *)model{
    
    self.typeLocationLabel.text = model.often_label;
    self.locationLabel.text = [NSString stringWithFormat:@"%@ %@",model.adress,model.detail];
    
    if (model.often_label.length == 0) {
        self.typeLocationLabel.hidden = YES;
        [self.locationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
        }];
        
    }else{
        
        self.typeLocationLabel.hidden = NO;
        [self.locationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
        make.left.mas_equalTo(70);
        }];
    }
    
         
    
    if ([model.sex isEqualToString:@"1"]) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@  先生",model.name];
    }else{
        
        self.nameLabel.text = [NSString stringWithFormat:@"%@  女士",model.name];
    }

    self.userPhoneLabel.text = model.phone;
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
