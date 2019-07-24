//
//  PersonalMessageCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/28.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PersonalMessageCell.h"

#define  SpareWidth 10

@implementation PersonalMessageCell

-(UILabel *)userNameLabel{
    if (_userNameLabel == nil) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = TR_Font_Gray(17);
        _userNameLabel.backgroundColor = [UIColor clearColor];
    }
    return _userNameLabel;
}



-(UIImageView *)userImage{
    if (_userImage == nil) {
        _userImage = [[UIImageView alloc]init];
        _userImage.image = [UIImage imageNamed:@"登录"];
        _userImage.backgroundColor = [UIColor clearColor];
        _userImage.userInteractionEnabled = YES;
        _userImage.layer.cornerRadius = 25.0f;
        _userImage.layer.masksToBounds = YES;
        _userImage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _userImage;
}

-(UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = TR_Font_Gray(14);
        _contentLabel.backgroundColor = [UIColor clearColor];
    }
    return _contentLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // __weak typeof(self) weakSelf = self;
        
        
        
        
        
        [self.contentView addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
//        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightBtn setTitle:@">" forState:UIControlStateNormal];
//        rightBtn.backgroundColor = [UIColor clearColor];
//        rightBtn.titleLabel.font = TR_Font_Gray(17);
//        [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [self.contentView addSubview:rightBtn];
//        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo( - SpareWidth);
//            make.centerY.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(20, 30));
//        }];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"setting-forword"];
        [self.contentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
           
          make.right.mas_equalTo( - SpareWidth);
          make.centerY.mas_equalTo(0);
          make.size.mas_equalTo(CGSizeMake(10, 15));
        }];
        
        
        [self.contentView addSubview:self.userImage];
        [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageV.mas_left).offset(-SpareWidth / 2);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageV.mas_left).offset(-SpareWidth / 2);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(150, 50));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.right.mas_equalTo(-SpareWidth);
            make.bottom.mas_equalTo(-2);
            make.height.mas_equalTo(1);
        }];
        
        
    }
    return self;
}




-(void)desginCellWithIndexpath:(NSIndexPath *)indexpath{
    
    if (indexpath.row == 0) {
        self.contentLabel.hidden = YES;
        self.userImage.hidden = NO;
        if ([Singleton shareInstance].userInfo.avatar.length > 0) {
           
            [self.userImage sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"personal-user"]];
        }else{
            
            self.userImage.image = [UIImage imageNamed:@"personal-user"];
        }
        
    }
    else{
        
        self.contentLabel.hidden = NO;
        self.userImage.hidden = YES;
    }
    
    
    
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
