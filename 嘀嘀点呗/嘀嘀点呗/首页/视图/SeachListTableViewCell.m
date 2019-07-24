//
//  SeachListTableViewCell.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "SeachListTableViewCell.h"
#import "GoodItemView.h"

@interface SeachListTableViewCell()



@end

@implementation SeachListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _picimgView=[[UIImageView alloc]init];
     //   _picimgView.backgroundColor=[UIColor redColor];
        //  _picimgView.layer.cornerRadius=5;
        //  _picimgView.layer.masksToBounds=YES;
        __weak typeof(self) weakSelf=self;
        
        [self addSubview:_picimgView];
        
        [_picimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            // __strong typeof(weakSelf) strongSelf=weakSelf;
            
            make.left.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(80,70));
            
        }];
        
        _closelabel=[[UILabel alloc]init];
        _closelabel.backgroundColor=[UIColor grayColor];
        _closelabel.textColor=[UIColor whiteColor];
        _closelabel.font = TR_Font_Gray(14);
        _closelabel.textAlignment=NSTextAlignmentCenter;
        _closelabel.text=@"休息中";
        [_picimgView addSubview:_closelabel];
        
        [_closelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.bottom.equalTo(weakSelf.picimgView.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(80,15));
            
        }];
        
        _storenamelabel=[[UILabel alloc]init];
        //  _storenamelabel.font=[UIFont systemFontOfSize:14];
        _storenamelabel.text=@"肯德基(萧山店)";
        _storenamelabel.font = TR_Font_Cu(16);
        _storenamelabel.textColor = TR_COLOR_RGBACOLOR_A(80, 80, 80, 1);

        [self addSubview:_storenamelabel];
        
        [_storenamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_right).offset
            (10);
            make.top.equalTo(weakSelf.picimgView.mas_top).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        _tiplabel=[[UILabel alloc]init];
        _tiplabel.backgroundColor=TR_COLOR_RGBACOLOR_A(250,174,96,1);
        _tiplabel.textColor=[UIColor blackColor];
        _tiplabel.font=[UIFont systemFontOfSize:12];
        _tiplabel.text=@"品牌";
        _tiplabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_tiplabel];
        
        [_tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.picimgView.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(30,15));
        }];
        
        
        _salelabel=[[UILabel alloc]init];
        _salelabel.font=[UIFont systemFontOfSize:14];
        
        _salelabel.text=@"月售3365";
       
        [self addSubview:_salelabel];
        
        [_salelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.storenamelabel.mas_left);
            make.top.equalTo(weakSelf.storenamelabel.mas_bottom).offset(13);
            
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(SCREEN_WIDTH-170);
        }];
        
        _peiTipImgview=[[UIImageView alloc]init];
        
        [self addSubview:_peiTipImgview];
        
        
        [_peiTipImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(44);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.size.mas_equalTo(CGSizeMake(45,12));
            
            
        }];
        
        _pricePeilabel=[[UILabel alloc]init];
        _pricePeilabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_pricePeilabel];
        
        _pricePeilabel.text=@"¥20起送|¥5配送";
        
        [_pricePeilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_right).offset(10);
            
            make.top.equalTo(weakSelf.salelabel.mas_bottom).offset(10);
            
            make.height.mas_equalTo(15);
            
        }];
        
        _morebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_morebtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_morebtn setTitleColor:TR_COLOR_RGBACOLOR_A(85,85,85,1) forState:UIControlStateNormal];
        [_morebtn setImage:[UIImage imageNamed:@"address_arrow"] forState:UIControlStateNormal];        
        [_morebtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-180)];
        [self addSubview:_morebtn];
       
        [_morebtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo(0);

            make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);

            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,40));

        }];
        
      
        _customCapacityView=[[CustomCapacityView alloc]init];
       
    //    _customCapacityView.backgroundColor=[UIColor greenColor];
        
        [self addSubview:_customCapacityView];
    
        _backView=[[UIView alloc]init];
        
        [self addSubview:_backView];
        
        [_customCapacityView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.pricePeilabel.mas_bottom).offset(15);
            
            make.left.equalTo(weakSelf.pricePeilabel.mas_left).offset(0);
            
            make.right.equalTo(weakSelf.mas_right).offset(-40);
            
            make.height.mas_equalTo(30);
           // make.bottom.equalTo(weakSelf.backView.mas_bottom).offset(-10);
        }];
        
        
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.pricePeilabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.customCapacityView.mas_bottom).offset(5);
            
            make.bottom.equalTo(weakSelf.morebtn.mas_top).offset(-5);
            
            make.right.equalTo(weakSelf.mas_right).offset(-5);

        }];
        
     
       
      
        _arrowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_arrowBtn setImage:[UIImage imageNamed:@"address_arrow"] forState:UIControlStateNormal];

        [self addSubview:_arrowBtn];
        
        [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.customCapacityView).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(15,15));
            
        }];
        
        
        UIView *line=[[UIView alloc]init];

        line.backgroundColor=TR_COLOR_RGBACOLOR_A(238,238,238,1);
      
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {

            make.bottom.equalTo(weakSelf.mas_bottom).offset(-1);

            make.left.mas_equalTo(0);

            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,1));

        }];
        
    }
    
    return self;
}


- (void) loadsetGoodsItem:(NSArray *) goodsData  isyes:(BOOL) isyes{
    
    __weak typeof(self) weakSelf=self;
    
    for (UIView *view in _backView.subviews) {
        
        [view removeFromSuperview];
    }
    
    UIFont *font=[UIFont systemFontOfSize:16];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(40,40,40,1),
                              NSFontAttributeName:font
                              };
    if (goodsData.count==0) {
        _morebtn.hidden=YES;
        
        [_morebtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        return;
    }
    
    if (goodsData.count<=2) {
       
        _morebtn.hidden=YES;
        
        [_morebtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        for (int i=0; i<goodsData.count; i++) {
            
            GoodItemView *gooditem=[[GoodItemView alloc]init];
            
            GoodItem *item=goodsData[i];
            gooditem.tag=3000+i;
            gooditem.item=item;
            gooditem.seachmodel=_model;
            [_backView addSubview:gooditem];
            
           
            
            NSMutableAttributedString *attributedText =
            [[NSMutableAttributedString alloc] initWithString:item.name
                                                   attributes:attribs];
            
            NSRange bgTextRange =[item.name rangeOfString:_seachstr options:NSCaseInsensitiveSearch];

            [attributedText setAttributes:@{NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(252,122,46,1),NSFontAttributeName:font} range:bgTextRange];
            
            gooditem.goodnamelabel.attributedText=attributedText;
            [gooditem.goodImgView sd_setImageWithURL:[NSURL URLWithString:item.g_image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
            gooditem.pricelabel.text=[NSString stringWithFormat:@"¥ %@",item.price];
            gooditem.goodSalelabel.text=[NSString stringWithFormat:@"月售 %@%@",item.sell_count,item.unit];
            
            [gooditem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(0);
                
                make.top.mas_equalTo(10+80*i);
                
                make.height.mas_equalTo(70);
                
                make.width.mas_equalTo(weakSelf.backView.mas_width);
            }];
        
        }
   
    }else{
        
        if (isyes) {
            
            _morebtn.hidden=NO;
            [_morebtn setTitle:@"收起" forState:UIControlStateNormal];
            
            _morebtn.imageView.transform=CGAffineTransformMakeRotation(M_PI);
            [_morebtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-100)];
            [_morebtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40);
            }];
            for (int i=0; i<goodsData.count; i++) {
                
                GoodItemView *gooditem=[[GoodItemView alloc]init];
                
                GoodItem *item=goodsData[i];
              
                gooditem.item=item;
               
                gooditem.seachmodel=_model;

                [_backView addSubview:gooditem];
                 gooditem.tag=3000+i;
                NSMutableAttributedString *attributedText =
                [[NSMutableAttributedString alloc] initWithString:item.name
                                                       attributes:attribs];
                
                NSRange bgTextRange =[item.name rangeOfString:_seachstr options:NSCaseInsensitiveSearch];

                [attributedText setAttributes:@{NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(252,122,46,1),NSFontAttributeName:font} range:bgTextRange];
                
                gooditem.goodnamelabel.attributedText=attributedText;
                [gooditem.goodImgView sd_setImageWithURL:[NSURL URLWithString:item.g_image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];

                gooditem.pricelabel.text=[NSString stringWithFormat:@"¥ %@",item.price];
               
                gooditem.goodSalelabel.text=[NSString stringWithFormat:@"月售 %@%@",item.sell_count,item.unit];
                                             
                
                [gooditem mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(0);
                    
                    make.top.mas_equalTo(10+80*i);
                    
                    make.height.mas_equalTo(70);
                    
                    make.width.mas_equalTo(weakSelf.backView.mas_width);
                }];
            }
            
        }else{
           
            _morebtn.hidden=NO;
            [_morebtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40);
            }];
            [_morebtn setTitle:@"查看更多" forState:UIControlStateNormal];
            _morebtn.imageView.transform=CGAffineTransformMakeRotation(0);
            [_morebtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-180)];
         
            for (int i=0; i<2; i++) {
            
                GoodItemView *gooditem=[[GoodItemView alloc]init];
            
                GoodItem *item=goodsData[i];
                gooditem.item=item;
                gooditem.seachmodel=_model;
                 gooditem.tag=3000+i;
                [_backView addSubview:gooditem];
                
                NSMutableAttributedString *attributedText =
                [[NSMutableAttributedString alloc] initWithString:item.name
                                                       attributes:attribs];
                
                NSRange bgTextRange =[item.name rangeOfString:_seachstr options:NSCaseInsensitiveSearch];
                
                [attributedText setAttributes:@{NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(252,122,46,1),NSFontAttributeName:font} range:bgTextRange];
                
                gooditem.goodnamelabel.attributedText=attributedText;
                [gooditem.goodImgView sd_setImageWithURL:[NSURL URLWithString:item.g_image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
                gooditem.pricelabel.text=[NSString stringWithFormat:@"¥ %@",item.price];
                gooditem.goodSalelabel.text=[NSString stringWithFormat:@"月售 %@%@",item.sell_count,item.unit];
              
           
                [gooditem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                    make.left.mas_equalTo(0);
                    
                    make.top.mas_equalTo(10+80*i);
                    
                    make.height.mas_equalTo(70);
                    
                    make.width.mas_equalTo(weakSelf.backView.mas_width);
                }];
            }
            
        }
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
