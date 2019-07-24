//
//  SeachGoodsTableViewCell.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "SeachGoodsTableViewCell.h"

@implementation SeachGoodsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _picimgView=[[UIImageView alloc]init];
        _picimgView.backgroundColor=[UIColor redColor];
        __weak typeof(self) weakSelf=self;
        
        [self addSubview:_picimgView];
        [_picimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            // __strong typeof(weakSelf) strongSelf=weakSelf;
            
            make.left.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(70,60));
            
        }];
        
        _storenamelabel=[[UILabel alloc]init];
        _storenamelabel.font=[UIFont systemFontOfSize:14];
        _storenamelabel.text=@"肯德基(萧山店)";
        [self addSubview:_storenamelabel];
        [_storenamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_right).offset
            (10);
            make.top.equalTo(weakSelf.picimgView.mas_top).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        _tiplabel=[[UILabel alloc]init];
        
        _tiplabel.backgroundColor=TR_COLOR_RGBACOLOR_A(250,174,96,1);
        
        _tiplabel.textColor=[UIColor whiteColor];
        _tiplabel.layer.cornerRadius=4;
        _tiplabel.layer.masksToBounds=YES;
        _tiplabel.font=[UIFont systemFontOfSize:10];
        _tiplabel.text=@"品牌";
        _tiplabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_tiplabel];
        
        [_tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.storenamelabel.mas_right).offset(5);
            
            make.top.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(30,15));
            
        }];
        
      //  TQStarRatingView *starRating=[[TQStarRatingView alloc]initWithFrame:CGRectZero numberOfStar:5 large:NO];
        //starRating.backgroundColor=[UIColor orangeColor];
        //[self addSubview:starRa\ting];
        
        _starRatingView=[[CJTStarView alloc]initWithFrame:CGRectMake(0,0,80,20) starCount:5];
        
        [self addSubview:_starRatingView];

        
        
        _salelabel=[[UILabel alloc]init];
        _salelabel.font=[UIFont systemFontOfSize:14];
        
        _salelabel.text=@"月售3365";
        [self addSubview:_salelabel];
        
        [_salelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
           // make.left.equalTo(weakSelf.starRating.mas_right).offset(5);
          //  make.top.equalTo(weakSelf.starRating.mas_top).offset(3);
            make.height.mas_equalTo(11);
            
        }];
        
        _peiTipImgview=[[UIImageView alloc]init];
        
        [self addSubview:_peiTipImgview];
        
        
        [_peiTipImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(44);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.size.mas_equalTo(CGSizeMake(45,12));
            
            
        }];
        
        _pricePeilabel=[[UILabel alloc]init];
        _pricePeilabel.font=[UIFont systemFontOfSize:11];
        [self addSubview:_pricePeilabel];
        
        _pricePeilabel.text=@"¥20起送|¥5配送";
        
        [_pricePeilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.picimgView.mas_right).offset(10);
            
            make.top.equalTo(_salelabel.mas_bottom).offset(10);
            
            make.height.mas_equalTo(15);
            
        }];
        
        _distanceMiniutslabel=[[UILabel alloc]init];
       
        _distanceMiniutslabel.font=[UIFont systemFontOfSize:11];
        
        [self addSubview:_distanceMiniutslabel];
        
        _distanceMiniutslabel.text=@"362米|7分钟";
        
        [_distanceMiniutslabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(weakSelf.pricePeilabel).offset(0);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.height.mas_equalTo(15);
            
        }];
        
        _activityEhibitintView=[[ActivityEhibitionView alloc]init];
       
        _activityEhibitintView.backgroundColor=[UIColor redColor];
      
        [self addSubview:_activityEhibitintView];
        
        [_activityEhibitintView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.equalTo(weakSelf.picimgView.mas_bottom).offset(10);
            
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width-80,20));
            
        }];
        
        _activityBtn=[UIButton buttonWithType:UIButtonTypeCustom];
      
        [_activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        [self addSubview:_activityBtn];
        
        [_activityBtn setTitle:@"3个活动" forState:UIControlStateNormal];
       
        _activityBtn.titleLabel.font=[UIFont systemFontOfSize:12];
       
        [_activityBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0,30)];
       
        _activityBtn.selected=NO;
      
        [_activityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.trailing.mas_equalTo(-10);
            make.top.equalTo(weakSelf.activityEhibitintView.mas_top).offset(0);
            make.size.mas_equalTo(CGSizeMake(60,20));
            
        }];
       
        
        
        
    }
    
    return self;
}

- (void) upActivityData:(NSArray *) data {
    
    __weak typeof(self) weakSelf=self;
    
    for (int i=1; i<data.count; i++) {
        
        ActivityEhibitionView * activityView=[[ActivityEhibitionView alloc]init];
        
        [self addSubview:activityView];
        
        [activityView mas_makeConstraints:^(MASConstraintMaker *make){
            
            make.bottom.equalTo(weakSelf.mas_bottom).offset(10+(i-1)*20);
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width-20,20),20);
            make.left.mas_equalTo(10);
            
        }];
    }
    
    [_activityEhibitintView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(weakSelf.mas_bottom).offset((data.count-1)*20);
        
    }];
    
    [_activityBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).offset(0);
        
    }];
    
}

- (void)removeActivity {
    
    __weak typeof(self) weakSelf=self;

    [_activityEhibitintView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.picimgView.mas_bottom).offset(10);
        
    }];
    
    
    
    
    
    
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
