//
//  StoreGoodsCell.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/4.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "StoreGoodsCell.h"

@implementation StoreGoodsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;

        _goodPic=[[UIImageView alloc]init];
        _goodPic.backgroundColor=[UIColor redColor];
        [self addSubview:_goodPic];
       
        [_goodPic mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(87,87));
            
        }];
        
        _goodnamelabel=[[UILabel alloc]init];
        _goodnamelabel.text=@"特价香辣鸡翅汉堡套餐";
        [self addSubview:_goodnamelabel];
        
        [_goodnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.goodPic.mas_right).offset(10);
            
            make.top.equalTo(weakSelf.goodPic.mas_top).offset(0);
            
            make.height.mas_equalTo(15);
                        
        }];
        
        _introducelabel=[[UILabel alloc]init];
        _introducelabel.text=@"香辣鸡翅2对,超级汉堡1个,中可1杯";
        [self addSubview:_introducelabel];
        [_introducelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.goodPic.mas_right).offset(10);
            
            make.top.equalTo(weakSelf.goodnamelabel.mas_bottom).offset(5);
            
            make.height.mas_equalTo(15);
            
            
        }];
        
        _salelabel=[[UILabel alloc]init];
        _salelabel.text=@"月销1000";
        [self addSubview:_salelabel];
        [_salelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.introducelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.introducelabel.mas_bottom).offset(10);
            
            make.height.mas_equalTo(15);
            
        }];
        
        
        _pricelabel=[[UILabel alloc]init];
        _pricelabel.text=@"¥28.99";
        [self addSubview:_pricelabel];
        
        [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.salelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.salelabel.mas_bottom).offset(5);
            
            make.height.mas_equalTo(15);
            
        }];
        
        _plusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [self addSubview:_plusbtn];
        
        [_plusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.pricelabel.mas_top).offset(-5);
            
            make.size.mas_equalTo(CGSizeMake(30,30));
            
        }];
        
        _numberlabel=[[UILabel alloc]init];
        
        [self addSubview:_numberlabel];
        
        [_numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-50);
            
            make.top.equalTo(weakSelf.pricelabel.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(50,20));
            
        }];
        
        _minusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:_minusbtn];
        
        [_minusbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.numberlabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.plusbtn.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(30, 30));
            
        }];
        
        _specificationbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        _specificationbtn.layer.cornerRadius=5;
        
        _specificationbtn.layer.masksToBounds=YES;
        _specificationbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(221,94,43,1);
        [_specificationbtn setTitle:@"选规格" forState:UIControlStateNormal];
        [_specificationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        [self addSubview:_specificationbtn];
        
        [_specificationbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.plusbtn.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(60,30));
            
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
