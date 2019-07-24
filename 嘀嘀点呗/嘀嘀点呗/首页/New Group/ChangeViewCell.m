//
//  ChangeViewCell.m
//  送小宝
//
//  Created by xgy on 2017/4/9.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ChangeViewCell.h"

@implementation ChangeViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *locationimgview=[[UIImageView alloc]initWithFrame:CGRectMake(15,17,12,16)];
        
        locationimgview.image=[UIImage imageNamed:@"location_pic"];
        
        [self addSubview:locationimgview];
        _locationimgView=locationimgview;
        _namelabel=[[UILabel alloc]initWithFrame:CGRectMake(locationimgview.frame.origin.x+locationimgview.frame.size.width+10,15,SCREEN_WIDTH-(locationimgview.frame.origin.x+locationimgview.frame.size.width+10),20)];
        _namelabel.textAlignment=NSTextAlignmentLeft;
        _namelabel.textColor=TR_COLOR_RGBACOLOR_A(100,101,102, 1);
        [self addSubview:_namelabel];
        
        _adresslabel=[[UILabel alloc]initWithFrame:CGRectMake(_namelabel.frame.origin.x,_namelabel.frame.origin.y+_namelabel.frame.size.height+10,_namelabel.frame.size.width,40)];
        _adresslabel.font=[UIFont systemFontOfSize:15];
        _adresslabel.textColor=TR_COLOR_RGBACOLOR_A(100,101,102,1);
   //     [self addSubview:_adresslabel];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(_namelabel.frame.origin.x,_namelabel.frame.origin.y+_namelabel.frame.size.height+15,_namelabel.frame.size.width,1)];
        line.backgroundColor=TR_COLOR_RGBACOLOR_A(242,243,243,1);
        
        [self addSubview:line];
        
        
        
    }

    return  self;
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
