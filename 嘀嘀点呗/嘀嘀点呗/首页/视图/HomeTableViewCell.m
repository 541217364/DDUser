//
//  HomeTableViewCell.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/18.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "HomeTableViewCell.h"
#define TR_COLOR_RGBACOLOR_A(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _picimgView=[[UIImageView alloc]init];
        _picimgView.layer.cornerRadius=4;
        _picimgView.layer.masksToBounds=YES;
        __weak typeof(self) weakSelf=self;

        [self addSubview:_picimgView];
      
        [_picimgView mas_makeConstraints:^(MASConstraintMaker *make) {
           // __strong typeof(weakSelf) strongSelf=weakSelf;

            make.left.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(70,70));
            
        }];
        
        _closelabel=[[UILabel alloc]init];
        _closelabel.backgroundColor=[UIColor grayColor];
        _closelabel.textColor=[UIColor whiteColor];
        _closelabel.textAlignment=NSTextAlignmentCenter;
        _closelabel.font = TR_Font_Gray(14);
        _closelabel.text=@"休息中";
        [_picimgView addSubview:_closelabel];
      
        [_closelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
        make.bottom.equalTo(weakSelf.picimgView.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(70,15));
            
        }];
     
        _storenamelabel=[[UILabel alloc]init];
        _storenamelabel.font=[UIFont boldSystemFontOfSize:15];
        _storenamelabel.text=@"";
        [self addSubview:_storenamelabel];
        
        _shopTypeimageV = [[UIImageView alloc]init];
        _shopTypeimageV.contentMode = UIViewContentModeScaleAspectFill;
        _shopTypeimageV.image = [UIImage imageNamed:@"shop_zhuansong"];
        [self addSubview:_shopTypeimageV];
        [_shopTypeimageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.mas_equalTo(weakSelf.storenamelabel);
            make.size.mas_equalTo(CGSizeMake(30, 15));
        }];
        
        
       
        
        [_storenamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_right).offset
            (10);
            make.right.equalTo(weakSelf.shopTypeimageV.mas_left).offset(-5);
            make.top.equalTo(weakSelf.picimgView.mas_top).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        _tipimageView=[[UIImageView alloc]init];
        _tipimageView.backgroundColor=[UIColor clearColor];
        _tipimageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_tipimageView];
        
        [_tipimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.picimgView.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(25,15));
        }];
        

        _salelabel=[[UILabel alloc]init];
        _salelabel.font=[UIFont systemFontOfSize:12];
        _salelabel.textColor=TR_TEXTGrayCOLOR;
        _salelabel.text=@"";
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
        _pricePeilabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:_pricePeilabel];
        _pricePeilabel.textColor=TR_TEXTGrayCOLOR;
        _pricePeilabel.text=@"";
        
        [_pricePeilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_right).offset(10);
            
            make.top.equalTo(weakSelf.salelabel.mas_bottom).offset(10);
            
            make.height.mas_equalTo(15);
            
        }];
        

        _customCapacityView=[[CustomCapacityView alloc]init];
      
        [self addSubview:_customCapacityView];
        
        [_customCapacityView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.pricePeilabel.mas_bottom).offset(10);
            
            make.left.equalTo(weakSelf.pricePeilabel.mas_left).offset(0);
            
            make.right.equalTo(weakSelf.mas_right).offset(-40);
            
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-20);
            
        }];
        
        _arrowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
       
        [_arrowBtn setImage:[UIImage imageNamed:@"address_arrow"] forState:UIControlStateNormal];

        
        [self addSubview:_arrowBtn];
        
        [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.customCapacityView).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(15,15));
            
        }];
        
        
        _tipNumberlabel=[[UILabel alloc]init];
        _tipNumberlabel.textAlignment=NSTextAlignmentCenter;
        _tipNumberlabel.adjustsFontSizeToFitWidth = YES;
        _tipNumberlabel.textColor=[UIColor whiteColor];
        _tipNumberlabel.backgroundColor=[UIColor redColor];
        _tipNumberlabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:_tipNumberlabel];
        _tipNumberlabel.hidden=YES;
        [_tipNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.picimgView.mas_right).offset(0);
            make.centerY.equalTo(weakSelf.picimgView.mas_top).offset(0);
            make.size.mas_equalTo(CGSizeMake(20,20));
            
        }];
        

    }
    
    return self;
}

-(void)loadcommodityPics:(NSArray *)array {
    
    for (int i =0;i < array.count ; i++) {
        
        UILabel *titlelabel=[[UILabel alloc]init];
        titlelabel.textColor=TR_COLOR_RGBACOLOR_A(246,92,85,1);
        titlelabel.layer.masksToBounds=YES;
        titlelabel.layer.borderColor=TR_COLOR_RGBACOLOR_A(246,92,85,1).CGColor;
        titlelabel.layer.borderWidth=1.0;
        [self addSubview:titlelabel];
    
    }
}


- (void)selectActivitys:(NSArray *)array {
    
    __weak typeof(self) weakSelf=self;

    for (NSInteger i=0; i<array.count; i++) {
        StoreItem *item=array[i];
        ActivityEhibitionView * activityView=[[ActivityEhibitionView alloc]init];
        activityView.tag=2000+i;
        [self addSubview:activityView];
        [activityView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(weakSelf.pricePeilabel.mas_bottom).offset((15+5) * i + 5 * i + 5);
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width-20,15));
            make.left.mas_equalTo(10);
        }];
        activityView.titlelabel.text=item.value;
        activityView.myType=item.type;
    }
}


- (void)setstartnum:(NSInteger )startnum {
    
//    if (_starRatingView == nil  ) {
//
//         _starRatingView=[[CJTStarView alloc]initWithFrame:CGRectMake(_storenamelabel.frame.origin.x,_storenamelabel.frame.origin.y+_storenamelabel.frame.size.height+10,70,15) starCount:5];
//           [self addSubview:_starRatingView];
//    }
   
}

- (void)removeActivitys {
    
    for (UIView *view in self.subviews) {
        
        if (view.tag/1000==2) {
            
            [view removeFromSuperview];
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
