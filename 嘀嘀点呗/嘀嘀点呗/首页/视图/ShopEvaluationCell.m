//
//  ShopEvaluationCell.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/4.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ShopEvaluationCell.h"

@implementation ShopEvaluationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;

        
        self.backgroundColor=[UIColor whiteColor];
        
        _storePicImgview=[[UIImageView alloc]init];
        
        _storePicImgview.layer.cornerRadius=25;
        
        _storePicImgview.layer.masksToBounds=YES;
        
        [self addSubview:_storePicImgview];
        
        [_storePicImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(15);
            
            make.left.mas_equalTo(10);
          
            make.size.mas_equalTo(CGSizeMake(50,50));
            
        }];
        
        _usernamelabel=[[UILabel alloc]init];
        
        _usernamelabel.textAlignment=NSTextAlignmentLeft;
       
        [self addSubview:_usernamelabel];
        
        [_usernamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.storePicImgview.mas_right).offset(10);
            
            make.top.equalTo(weakSelf.storePicImgview.mas_top).offset(0);
            
            make.height.mas_equalTo(20);
            
        }];
        
        
        _evaluationtimelabel=[[UILabel alloc]init];
        
        [self addSubview:_evaluationtimelabel];
        
        [_evaluationtimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.equalTo(weakSelf.usernamelabel.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(60,15));
            
        }];
        
        
        UILabel *fwlabel=[[UILabel alloc]init];
        
        [self addSubview:fwlabel];
        
        fwlabel.textAlignment=NSTextAlignmentLeft;
        
        fwlabel.text=@"服务";
        
        [fwlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.usernamelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.usernamelabel.mas_bottom).offset(10);
            
            make.size.mas_equalTo(CGSizeMake(40, 20));
            
        }];
        
        _fwstarRating=[[CJTStarView alloc]initWithFrame:CGRectMake(0,0,80,20) starCount:5];
        
        [self addSubview:_fwstarRating];
        
        [_fwstarRating mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(fwlabel.mas_right).offset(0);
            
            make.top.equalTo(fwlabel.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(80,20));
            
        }];
        
        UIView *line=[[UIView alloc]init];
        
        line.backgroundColor=TR_COLOR_RGBACOLOR_A(214,214,214,1);
        
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(fwlabel.mas_top).offset(0);
            
            make.left.equalTo(weakSelf.fwstarRating.mas_right).offset(5);
            
            make.size.mas_equalTo(CGSizeMake(0.5,20));
            
        }];
        
        UILabel *splabel=[[UILabel alloc]init];
        
        splabel.text=@"商品";
        
        [self addSubview:splabel];
       
        [splabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.fwstarRating.mas_right).offset(12);
            
            make.top.equalTo(fwlabel.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(40,20));
            
        }];
        
        _storestarRating=[[CJTStarView alloc]initWithFrame:CGRectMake(0,0,80,20) starCount:5];
        
        [self addSubview:_storestarRating];
        
        
        [_storestarRating mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(splabel.mas_right).offset(10);
            
            make.top.equalTo(splabel.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(80,20));
        }];
        
        _reviewContentlabel=[[UILabel alloc]init];
        
        _reviewContentlabel.numberOfLines=0;
        
        [self addSubview:_reviewContentlabel];
      
        [_reviewContentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.usernamelabel.mas_left).offset(0);
            
            make.top.equalTo(fwlabel.mas_bottom).offset(15);
            
            make.width.mas_equalTo(SCREEN_WIDTH-100);
            
        }];
        
        _helpimgView=[[UIImageView alloc]init];
        
        [_helpimgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.usernamelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.reviewContentlabel.mas_bottom).offset(10);
            
            make.size.mas_equalTo(CGSizeMake(20,15));
        }];
        
        _replybackView=[[UIView alloc]init];
        
        [self addSubview:_replybackView];
        
        [_replybackView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.usernamelabel.mas_left).offset(0);
            
            make.top.equalTo(weakSelf.helpimgView.mas_bottom).offset(10);
            
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
            
            make.width.mas_equalTo(SCREEN_WIDTH-100);
        }];
        
        _replylabel=[[UILabel alloc]init];
        
        [self addSubview:_replylabel];
      
        [_replylabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.replybackView.mas_left).offset(10);
            
            make.top.equalTo(weakSelf.replybackView.mas_top).offset(10);
            
            make.right.equalTo(weakSelf.replybackView.mas_right).offset(-10);
            
            make.bottom.equalTo(weakSelf.replybackView.mas_bottom).offset(-10);
            
        }];
        
    }
    
    return self;
}


- (void) insertGoodsimgviews:(NSArray *)imgsData {
    
    for (int i=0; i<imgsData.count; i++) {
        
        
        
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
