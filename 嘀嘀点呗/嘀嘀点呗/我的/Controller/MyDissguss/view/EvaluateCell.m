//
//  EvaluateCell.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/15.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "EvaluateCell.h"
#import "AdaptiveHeight.h"
#import "CJTStarView.h"
#define SpareWidth 10
@implementation EvaluateCell
{
    NSArray *zanArray;
}
-(UIImageView *)bussinessimage {
    if (_bussinessimage == nil) {
        _bussinessimage = [[UIImageView alloc]init];
        _bussinessimage.backgroundColor = [UIColor clearColor];
        _bussinessimage.layer.cornerRadius = 5.0f;
        _bussinessimage.layer.masksToBounds = YES ;
        _bussinessimage.image = [UIImage imageNamed:PLACEHOLDIMAGE];
        [_topView addSubview:_bussinessimage];
    }
    return _bussinessimage;
}
-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"肯德基 (萧山店)     ";
        [_topView addSubview:self.titleLabel];
    }
    return _titleLabel;
}
-(UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.text = @"2017.11.2";
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_topView addSubview:_timeLabel];
    }
    return _timeLabel;
}
-(UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = @"非常好吃，特别棒。";
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_topView];
    }
    return _topView;
}

-(UILabel *)starL{
    if (_starL == nil) {
        _starL = [[UILabel alloc]init];
        _starL.text = @"评分";
        _starL.font = [UIFont systemFontOfSize:13];
        _starL.textColor = [UIColor grayColor];
        _starL.textAlignment = NSTextAlignmentLeft;
        [_topView addSubview:_starL];
    }
    return _starL;
}
-(CJTStarView *)starView{
    if (_starView == nil) {
        _starView = [[CJTStarView alloc]initWithFrame:CGRectMake(0, 0, 60, 10) starCount:5];
        [_starView setnowStart:2];
        _starView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:self.starView];
    }
   
    return _starView;
}

-(UIView *)photosView{
    if (_photosView == nil) {
        _photosView = [[UIView alloc]init];
        _photosView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_photosView];
    }
    return _photosView;
}

-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = GRAYCLOLOR;
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

-(UIView *)disgussView{
    if (_disgussView == nil) {
        _disgussView = [[UIView alloc]init];
        _disgussView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_disgussView];
    }
    return _disgussView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self) weakSelf = self;
     //布局界面
        
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        }];
    
       
        
        [self.bussinessimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.top.mas_equalTo(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
       
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bussinessimage.mas_right).offset(SpareWidth);
            make.top.mas_equalTo(2 * SpareWidth - 5);
            make.size.mas_equalTo(CGSizeMake(100, 10));
        }];
        
       
        [self.starL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(30, 10));
        }];
        
        
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.starL.mas_right).mas_offset(5);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(60, 10));
        }];
        
        
       
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- SpareWidth);
            make.top.mas_equalTo(SpareWidth + 5);
            make.size.mas_equalTo(CGSizeMake(200, 10));
        }];
        
      
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.starView.mas_bottom).offset(SpareWidth);
            make.right.mas_equalTo(-SpareWidth);
            make.height.mas_equalTo(20);
        }];
        
        
        [self.disgussView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
        }];
        
        
        
         CGFloat imageWidth = (SCREEN_WIDTH - 65 - 4 * 5) /3; // 图片的宽度
        [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.disgussView.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, imageWidth ));
        }];
        
      
        
      

      //布局下面的界面
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.photosView.mas_left);
        make.top.mas_equalTo(weakSelf.photosView.mas_bottom).offset(SpareWidth / 2);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, 30));
        }];
        
        
         UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GRAYCLOLOR;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    
    }
    return self;
}



-(void)handleWithModel:(EvalutModel *)model {
    __weak typeof(self) weakSelf = self;
    
    self.timeLabel.text = model.add_time;
    self.contentLabel.text = model.comment;
    self.titleLabel.text = model.name;
    [self.starView setnowStart:model.score.doubleValue];
    [self.bussinessimage sd_setImageWithURL:[NSURL URLWithString:model.store_pic] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
    
    if (model.comment.length == 0) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.starView.mas_bottom).offset(SpareWidth);
            make.right.mas_equalTo(-SpareWidth);
            make.height.mas_equalTo(0);
        }];
        
    }else{
        CGSize size = TR_TEXT_SIZE(self.contentLabel.text, self.contentLabel.font, CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.starView.mas_bottom).offset(SpareWidth);
            make.right.mas_equalTo(-SpareWidth);
            make.height.mas_equalTo(size.height + 10);
        }];
    }
    
    
    
    
    
    for (UIView *temp in self.disgussView.subviews) {
        [temp removeFromSuperview];
    }
    
    if (model.goods.count == 0) {
        
        [self.disgussView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0));
        }];
        
        
        
    }else{
        
        [self.disgussView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 20));
        }];
        
        UIImageView *zanimageV = [[UIImageView alloc]init];
        zanimageV.image = [UIImage imageNamed:@"shop_goodcomment"];
        
        [_disgussView addSubview:zanimageV];
        [zanimageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentLabel.mas_left);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        //点赞的内容
        
        CGFloat labelWidth = (SCREEN_WIDTH - 65 - 15 - 4 * 5) / 4;
        for (int i = 0; i < model.goods.count; i ++ ) {
            UILabel *tempL = [[UILabel alloc]init];
            tempL.font = [UIFont systemFontOfSize:12];
            tempL.textAlignment = NSTextAlignmentCenter;
            tempL.text= model.goods[i];
            tempL.textColor = TR_COLOR_RGBACOLOR_A(252, 122, 48, 1);
            [_disgussView addSubview:tempL];
            [tempL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.left.mas_equalTo(zanimageV.mas_right).offset((labelWidth + 5)* i + 5);
                make.size.mas_equalTo(CGSizeMake(labelWidth, 15));
            }];
        }
        
    }
    
    
    
    for (UIImageView *temp in self.photosView.subviews) {
        [temp removeFromSuperview];
    }
    
    if (model.pic.count == 0) {

        [self.photosView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, 0 ));
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.disgussView.mas_bottom).offset(SpareWidth);
        }];

    }else{

        CGFloat imageWidth = (SCREEN_WIDTH - 65 - 4 * 5) /3; // 图片的宽度
        [self.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.disgussView.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, imageWidth));
        }];

        NSInteger count = model.pic.count > 3 ? 3:model.pic.count;
        
        for (int i = 0 ; i < count; i ++ ) {
            UIImageView *tempImage = [[UIImageView alloc]init];
            tempImage.backgroundColor = [UIColor clearColor];
            [tempImage sd_setImageWithURL:[NSURL URLWithString:model.pic[i]] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
            tempImage.layer.cornerRadius = 5.0f;
            tempImage.layer.masksToBounds = YES ;
            [self.photosView addSubview:tempImage];
            [tempImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((imageWidth + SpareWidth / 2)* i);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
            }];
            
            tempImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageMessage:)];
            [tempImage addGestureRecognizer:tap];
            
        }

    }
    
    for (UILabel *temp in self.bottomView.subviews) {
        [temp removeFromSuperview];
    }
    
    if (model.merchant_reply.length == 0) {
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, 0));
            make.left.mas_equalTo(weakSelf.photosView.mas_left);
    make.top.mas_equalTo(weakSelf.photosView.mas_bottom).offset(SpareWidth / 2);
        }];

    }else{

        CGSize textSize = TR_TEXT_SIZE(model.merchant_reply, [UIFont systemFontOfSize:15], CGSizeMake(SCREEN_WIDTH - 65, 0), nil);

        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, textSize.height + 20));
            make.left.mas_equalTo(weakSelf.photosView.mas_left);
        make.top.mas_equalTo(weakSelf.photosView.mas_bottom).offset(SpareWidth / 2);
        }];
    
        UILabel *busLabel = [[UILabel alloc]init];
        busLabel.textColor = [UIColor grayColor];
        busLabel.text = [NSString stringWithFormat:@"商家回复:%@",model.merchant_reply];
        busLabel.textAlignment = NSTextAlignmentLeft;
        busLabel.font = [UIFont systemFontOfSize:12];
        busLabel.backgroundColor = [UIColor clearColor];
        [_bottomView addSubview:busLabel];

        [busLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth / 2 );
            make.top.mas_equalTo(SpareWidth / 2 );
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, textSize.height + 10));
        }];
    
    }
    
  
}







-(void)designViewWith:(StoreCommentModel *)model{
    
     __weak typeof(self) weakSelf = self;
    
    self.timeLabel.text = model.add_time_hi;
    self.contentLabel.text = model.comment;
    self.titleLabel.text = model.nickname;
    [self.starView setnowStart:model.score.doubleValue];
    [self.bussinessimage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
    
    if (model.comment.length == 0) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.starView.mas_bottom).offset(SpareWidth);
            make.right.mas_equalTo(-SpareWidth);
            make.height.mas_equalTo(0);
        }];
        
    }else{
        CGSize size = TR_TEXT_SIZE(self.contentLabel.text, self.contentLabel.font, CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
        
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.starView.mas_bottom).offset(SpareWidth);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(size.height + 10);
        }];
    }
    
   
    
    
    
    for (UIView *temp in self.disgussView.subviews) {
        [temp removeFromSuperview];
    }

    if (model.goods.count == 0) {
        
        [self.disgussView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0));
        }];
        
       
        
    }else{
        
        [self.disgussView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.contentLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 20));
        }];
        
        UIImageView *zanimageV = [[UIImageView alloc]init];
        zanimageV.image = [UIImage imageNamed:@"shop_goodcomment"];
        
        [_disgussView addSubview:zanimageV];
        [zanimageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentLabel.mas_left);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        //点赞的内容
        
        CGFloat labelWidth = (SCREEN_WIDTH - 65 - 15 - model.goods.count * 5) / model.goods.count;
        for (int i = 0; i < model.goods.count; i ++ ) {
            UILabel *tempL = [[UILabel alloc]init];
            tempL.font = [UIFont systemFontOfSize:12];
            tempL.textAlignment = NSTextAlignmentLeft;
            tempL.text= model.goods[i];
            tempL.textColor = TR_COLOR_RGBACOLOR_A(252, 122, 48, 1);
            [_disgussView addSubview:tempL];
            [tempL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.left.mas_equalTo(zanimageV.mas_right).offset((labelWidth + 5)* i + 5);
                make.size.mas_equalTo(CGSizeMake(labelWidth, 15));
            }];
        }
        
    }
    
    
    
    for (UIImageView *temp in self.photosView.subviews) {
        [temp removeFromSuperview];
    }
    
    if (model.pic.count == 0) {
        
        [self.photosView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, 0 ));
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
            make.top.mas_equalTo(weakSelf.disgussView.mas_bottom);
        }];
        
    }else{
        
        CGFloat imageWidth = (SCREEN_WIDTH - 65 - 4 * 5) /3; // 图片的宽度
        [self.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.disgussView.mas_bottom).offset(SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, imageWidth));
        }];
        
//        NSArray * tagsArray = [model.pic componentsSeparatedByString:@","];
        NSInteger count = model.pic.count > 3 ? 3 :model.pic.count;
        if (model.pic.count == 0) {
            
            count = 0;
            
        }
        
        for (int i = 0 ; i < count; i ++ ) {
            
            UIImageView *tempImage = [[UIImageView alloc]init];
            tempImage.backgroundColor = [UIColor clearColor];
            [tempImage sd_setImageWithURL:[NSURL URLWithString:model.pic[i]] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
            tempImage.layer.cornerRadius = 5.0f;
            tempImage.layer.masksToBounds = YES ;
            [self.photosView addSubview:tempImage];
            
            tempImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageMessage:)];
            [tempImage addGestureRecognizer:tap];
            
            [tempImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((imageWidth + SpareWidth / 2)* i);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
            }];
        }
        
    }
    
    for (UILabel *temp in self.bottomView.subviews) {
        [temp removeFromSuperview];
    }
    
    if (model.merchant_reply_content.length == 0) {
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, 0));
            make.left.mas_equalTo(weakSelf.photosView.mas_left);
    make.top.mas_equalTo(weakSelf.photosView.mas_bottom).offset(SpareWidth / 2);
        }];
        
    }else{
        
            UILabel *busLabel = [[UILabel alloc]init];
            busLabel.textColor = [UIColor grayColor];
        
        NSDate *nowDate=[NSDate dateWithTimeIntervalSince1970:model.merchant_reply_time.intValue];
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init] ;
        
        [dateformatter setDateFormat:@"MM-dd HH:mm"];
        
        NSString *dateStr = [dateformatter stringFromDate:nowDate];
        
        busLabel.text = [NSString stringWithFormat:@"商家回复(%@):%@",dateStr,model.merchant_reply_content];
            busLabel.textAlignment = NSTextAlignmentLeft;
            busLabel.numberOfLines = 0;
            busLabel.font = [UIFont systemFontOfSize:12];
            busLabel.backgroundColor = [UIColor clearColor];
            [_bottomView addSubview:busLabel];
        
        
        CGSize textSize = TR_TEXT_SIZE(busLabel.text, [UIFont systemFontOfSize:12], CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
        
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 65, textSize.height + 10));
            make.left.mas_equalTo(weakSelf.photosView.mas_left);
            make.top.mas_equalTo(weakSelf.photosView.mas_bottom).offset(SpareWidth / 2);
        }];
        
        
            [busLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SpareWidth / 2 );
                make.top.mas_equalTo(5);
                make.width.mas_equalTo(SCREEN_WIDTH - 65);
            }];
        
    }
    
   
    
}





-(void)showImageMessage:(UITapGestureRecognizer *)sender{
    
    UIImageView *tempImage = (UIImageView *)[sender view];
    
    if (tempImage) {
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        mg.viewController = APP_Delegate.rootViewController.viewControllers[APP_Delegate.rootViewController.selectedIndex];
        [mg showLocalPhotoViewer:self.photosView.subviews selecView:tempImage];
        
        
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
