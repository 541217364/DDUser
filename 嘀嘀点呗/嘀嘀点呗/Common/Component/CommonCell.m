//
//  CommonCell.m
//  ELoanIos
//
//  Created by administrator on 14-9-4.
//  Copyright (c) 2014年 研信科技. All rights reserved.
//

#import "CommonCell.h"
#import "UIImageView+WebCache.h"

@interface CommonCell()
@property (nonatomic) int type;
@end

@implementation CommonCell

- (id)initWithType:(CommonCellType)type reuseIdentifier:(NSString *)identifier{
    _type = type;
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    switch (type) {
        case type1:
        {
            _imv = [[UIImageView alloc] initWithFrame:CGRectZero];
            [self addSubview:_imv];
            
            _titleLB = [[UILabel alloc] initWithFrame:CGRectZero];
            _titleLB.font = CommonFont;
            _titleLB.backgroundColor = [UIColor whiteColor];
            [self addSubview:_titleLB];
            
            _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(240, (CommonCellHeight - 20) / 2.0, 40, 20)];
            _contentLB.font = CommonFont;
            _contentLB.backgroundColor = [UIColor whiteColor];
            _contentLB.highlightedTextColor = [UIColor whiteColor];
            _contentLB.textColor = [UIColor blackColor];
            [self addSubview:_contentLB];
            _contentLB.hidden = YES;
            
            _accessoryImv = [[UIImageView alloc] initWithFrame:CGRectZero];
            _accessoryImv.userInteractionEnabled = NO;
            [self addSubview:_accessoryImv];
        }
            break;
        case type2:
        {
            
            _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(5, (CommonCellHeight - 20) / 2.0, SCREEN_WIDTH-100, 20)];
            _titleLB.font = CommonFont;
            _titleLB.backgroundColor = [UIColor whiteColor];
            [self addSubview:_titleLB];
            
            _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLB.frame), (CommonCellHeight - 20) / 2.0, 60, 20)];
            _contentLB.font = CommonFont;
            _contentLB.textAlignment = NSTextAlignmentRight;
            _contentLB.backgroundColor = [UIColor whiteColor];
            _contentLB.highlightedTextColor = [UIColor whiteColor];
            _contentLB.textColor = [UIColor blackColor];
            [self addSubview:_contentLB];

        }
            break;
        case type3://首页-> 按医院找
        {
            float originX = 10;
            float originY = 10;
            _imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, originY, 60, 60)];
            [_imv.layer setMasksToBounds:YES];
            _imv.layer.cornerRadius =  CGRectGetHeight(_imv.bounds)/2;
            [self addSubview:_imv];
            
            originX += 80;
            originY = 10;
            _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, SCREEN_WIDTH - 100, 20)];
            _titleLB.textColor = [UIColor grayColor];
            _titleLB.font = [UIFont systemFontOfSize:13];
            [self addSubview:_titleLB];
            
            originY += 25;
            _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, SCREEN_WIDTH - 100, 20)];
            _contentLB.textColor = [UIColor grayColor];
            _contentLB.font = [UIFont systemFontOfSize:13];
            [self addSubview:_contentLB];
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(75, CGRectGetMaxY(_contentLB.frame)+5, SCREEN_WIDTH-80, 1)];
            view.backgroundColor = TR_MainColor;
            [self addSubview:view];
            
            _btn1 =  [TRButton buttonWithType:UIButtonTypeCustom];
            _btn1.backgroundColor =[UIColor clearColor];
            _btn1.tr_tag = 0;
            _btn1.frame  =CGRectMake(70, CGRectGetMaxY(view.frame), (SCREEN_WIDTH-70)/2, 30);
            _btn1.titleLabel.font = TR_Font_Cu(11);
            [_btn1 setImage:[UIImage imageNamed:@"ezt_cm_wb"] forState:UIControlStateNormal];
            [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
            [_btn1 setTitle:@"出诊表" forState:UIControlStateNormal];
            [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_btn1];
            
            _btn2 =  [TRButton buttonWithType:UIButtonTypeCustom];
            _btn2.backgroundColor =[UIColor clearColor];
            _btn2.tr_tag = 1;
            _btn2.frame  =CGRectMake((SCREEN_WIDTH-70)/2+70, CGRectGetMaxY(view.frame), (SCREEN_WIDTH-70)/2, 30);
            _btn2.titleLabel.font = TR_Font_Cu(11);
            [_btn2 setImage:[UIImage imageNamed:@"ezt_cm_dh"] forState:UIControlStateNormal];
            [_btn2 setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
            [_btn2 setTitle:@"电话医生" forState:UIControlStateNormal];
            [_btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_btn2];
        }
            break;
        case type4://首页-> 电话医生
        {
            float originX = 5;
            float originY = 5;
            _imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
            [_imv.layer setMasksToBounds:YES];
            _imv.layer.cornerRadius =  CGRectGetHeight(_imv.bounds)/2;
            [self addSubview:_imv];
            
            originX += 70;
            originY = 10;
            _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, SCREEN_WIDTH - 100, 20)];
            _titleLB.textColor = [UIColor grayColor];
            _titleLB.font = [UIFont systemFontOfSize:11];
            [self addSubview:_titleLB];
            
            originY += 25;
            _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, SCREEN_WIDTH - 100, 20)];
            _contentLB.textColor = [UIColor grayColor];
            _contentLB.font = [UIFont systemFontOfSize:11];
            [self addSubview:_contentLB];
            
            _label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, 50, 40)];
            _label1.textColor = [UIColor grayColor];
            _label1.numberOfLines = 0;
            _label1.font = [UIFont systemFontOfSize:11];
            _label1.textColor = TR_MainColor;
            [self addSubview:_label1];
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(75, CGRectGetMaxY(_contentLB.frame)+5, SCREEN_WIDTH-80, 1)];
            view.backgroundColor = TR_MainColor;
            [self addSubview:view];
            
            _btn1 =  [TRButton buttonWithType:UIButtonTypeCustom];
            _btn1.backgroundColor =[UIColor clearColor];
            _btn1.tr_tag = 0;
            _btn1.tr_touch = NO;
            _btn1.frame  =CGRectMake(70, CGRectGetMaxY(view.frame), (SCREEN_WIDTH-70)/2, 30);
            _btn1.titleLabel.font = TR_Font_Cu(11);
            [_btn1 setImage:[UIImage imageNamed:@"ezt_cm_dh"] forState:UIControlStateNormal];
            [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
            [_btn1 setTitle:@"立即通话" forState:UIControlStateNormal];
            [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_btn1];
            
            _btn2 =  [TRButton buttonWithType:UIButtonTypeCustom];
            _btn2.backgroundColor =[UIColor clearColor];
            _btn2.tr_tag = 1;
            _btn2.tr_touch = NO;
            _btn2.frame  =CGRectMake((SCREEN_WIDTH-70)/2+70, CGRectGetMaxY(view.frame), (SCREEN_WIDTH-70)/2, 30);
            _btn2.titleLabel.font = TR_Font_Cu(11);
            [_btn2 setImage:[UIImage imageNamed:@"ezt_cm_dh"] forState:UIControlStateNormal];
            [_btn2 setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
            [_btn2 setTitle:@"预约通话" forState:UIControlStateNormal];
            [_btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_btn2];

        }
            break;
        case type5:// 找医->按医院找
        {
            _imv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 50)];
            [self addSubview:_imv];
            
            _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imv.frame)+10, 10, SCREEN_WIDTH-85, 20)];
            _titleLB.font = [UIFont systemFontOfSize:14];
            _titleLB.textColor = [UIColor blackColor];
            _titleLB.text = @"测试测试测试测试测试测试测试";
            _titleLB.backgroundColor = [UIColor whiteColor];
            [self addSubview:_titleLB];
            
            _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imv.frame)+10, CGRectGetMaxY(_titleLB.frame)+3, SCREEN_WIDTH-100, 20)];
            _contentLB.text = @"试测试测";
            _contentLB.font = [UIFont systemFontOfSize:13];
            _contentLB.backgroundColor = [UIColor whiteColor];
            _contentLB.textColor = [UIColor grayColor];
            [self addSubview:_contentLB];
        }
            break;
        case type6:// 我->我的记录->me
        {
            _imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 50, 50)];
            [self addSubview:_imv];
            
            _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imv.frame)+10, 10, SCREEN_WIDTH-100, 20)];
            _titleLB.font = [UIFont systemFontOfSize:15];
            _titleLB.textColor = [UIColor blackColor];
            _titleLB.text = @"测试";
            _titleLB.backgroundColor = [UIColor whiteColor];
            [self addSubview:_titleLB];
            
            _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imv.frame)+10, CGRectGetMaxY(_titleLB.frame)+10, SCREEN_WIDTH-100, 20)];
            _contentLB.text = @"试测试测";
            _contentLB.font = CommonFont;
            _contentLB.backgroundColor = [UIColor whiteColor];
            _contentLB.highlightedTextColor = [UIColor whiteColor];
            _contentLB.textColor = [UIColor grayColor];
            [self addSubview:_contentLB];
            
            _label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLB.frame)+10, 10, 150, 15)];
            _label1.textColor = [UIColor grayColor];
            _label1.text = @"主治医师";
            _label1.font = [UIFont systemFontOfSize:12];
            _label1.textColor = [UIColor grayColor];
            [self addSubview:_label1];
            
            _label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imv.frame)+10, CGRectGetMaxY(_contentLB.frame)+10, 50, 15)];
            _label2.textColor = [UIColor grayColor];
            _label2.text = @"2015-04-12 13:30-15:50";
            _label2.font = [UIFont systemFontOfSize:12];
            _label2.textColor = [UIColor grayColor];
            [self addSubview:_label2];
            
            _btn1 =  [TRButton buttonWithType:UIButtonTypeCustom];
            _btn1.backgroundColor =[UIColor clearColor];
            _btn1.tr_tag = 0;
            _btn1.tr_Border = YES;
            _btn1.frame  =CGRectMake(SCREEN_WIDTH-80, 30, 60, 30);
            _btn1.titleLabel.font = TR_Font_Cu(11);
            [_btn1 setTitle:@"退号" forState:UIControlStateNormal];
            [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_btn1];
            
        }
            break;
            
        default:
            break;
    }
    
    return self;
}

- (void) refreshData:(id)data{
    switch (_type) {
        case type1:
            
            break;
        case type2:
            
            break;

        case type3:
        {
//            DoctorInfo *info =  data;
//
//            [_imv trm_setImageWithURL:Merger(EZTImage_DOC_PHOTO, info.edPic) placeholderImage:TR_Image_Default1];
//            NSString *ys = info.edName;
//            NSString *zw = info.edLevelName;
//            NSString *ks = info.dptName;
//            
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@",ys,zw,ks]];
//            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(0,ys.length)];
//            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,ys.length)];
//            _titleLB.attributedText = attributedString;
//            _contentLB.text = info.ehName;
//            if (info.daysPools && info.daysPools.count) {
//                [_btn1 setImage:[UIImage imageNamed:@"ezt_cm_wb_s"] forState:UIControlStateNormal];
//                [_btn1 setTitleColor:TR_MainColor forState:UIControlStateNormal];
//            }else{
//                [_btn1 setImage:[UIImage imageNamed:@"ezt_cm_wb"] forState:UIControlStateNormal];
//                [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            }
        }
            
            break;

        case type4:
        {
//            CallDoctorInfo *info = data;
//            [_imv trm_setImageWithURL:Merger(EZTImage_DOC_PHOTO, info.regDoctoredPic) placeholderImage:TR_Image_Default1];
//            NSString *ys = info.regDoctoredName;
//            
//            ShipsubInfo * info1 =  [TRClassMethod getShipsubInfo:@[@"enName",@"doctorLevel",@"value",info.regDoctoredLevel]];
//            NSString *zw = info1.label;
//             
//            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",ys,zw]];
//            [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(0,ys.length)];
//            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,ys.length)];
//            _titleLB.attributedText = attributedString;
//            _contentLB.text = [NSString stringWithFormat:@"%@ %@",info.regHospitalehName,info.regDeptdptName];
//            
//            _label1.text =[NSString stringWithFormat:@"%@医通币\n  (%@分钟)",info.ctdCallGearciGuaranteedRate,info.ctdCallGearciGuaranteedTime];
//            if ([info.ctdCallInfociYnOnline intValue]) {
//                [_btn1 setImage:[UIImage imageNamed:@"ezt_cm_dh_s"] forState:UIControlStateNormal];
//                [_btn1 setTitle:@"立即通话" forState:UIControlStateNormal];
//                _btn1.tr_touch = YES;
//                [_btn1 setTitleColor:TR_MainColor forState:UIControlStateNormal];
//            }else{
//                [_btn1 setImage:[UIImage imageNamed:@"ezt_cm_dh"] forState:UIControlStateNormal];
//                [_btn1 setTitle:@"立即通话" forState:UIControlStateNormal];
//                _btn1.tr_touch = NO;
//                [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            }
//            
//            if ([info.ctdCallInfociYnAppointment intValue]) {
//                _btn2.tr_touch = YES;
//                [_btn2 setImage:[UIImage imageNamed:@"ezt_cm_dh_s"] forState:UIControlStateNormal];
//                [_btn2 setTitle:@"预约通话" forState:UIControlStateNormal];
//                [_btn2 setTitleColor:TR_MainColor forState:UIControlStateNormal];
//            }else{
//                _btn2.tr_touch = NO;
//                [_btn2 setImage:[UIImage imageNamed:@"ezt_cm_dh"] forState:UIControlStateNormal];
//                [_btn2 setTitle:@"预约通话" forState:UIControlStateNormal];
//                [_btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            }
            
        }
            break;

        case type5:
        {
//            EZTHospitalInfo *info = data;
//            [_imv trm_setImageWithURL:EZTImage_HOSP_QJ_IMG([info.mid intValue]) placeholderImage:TR_Image_Default_HospitalLogo];
//            _titleLB.text = info.ehName?info.ehName:@"";
//            
//            ShipsubInfo * info1 =  [TRClassMethod getShipsubInfo:@[@"enName",@"ehLevel",@"value",info.ehLevel?info.ehLevel:@""]];
//            
//            _contentLB.text = [NSString stringWithFormat:@"%@ 患者数:%.1f万",info1.label?info1.label:@"",[info.mid intValue]/10.0];
            
            
        }
            
            break;
        case type6:
        {
        }
            break;

            
        default:
            break;
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //选择背影
//        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
//        selectedBackgroundView.backgroundColor = [UIColor colorWithHexValue:0xacacac alpha:1.0];
//        self.selectedBackgroundView = selectedBackgroundView ;
    }
    return self;
}

- (void)BtnClick:(TRButton *)btn{
    if (btn.tr_touch) {
        if (_cell_delegate && [_cell_delegate respondsToSelector:@selector(CommonCellClick:withRow:)]){
            [_cell_delegate CommonCellClick:btn withRow:_cell_row];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
