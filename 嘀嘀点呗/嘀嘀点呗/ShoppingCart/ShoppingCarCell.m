//
//  ShoppingCarCell.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/3.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "ShopGoodItemView.h"

@interface ShoppingCarCell()<ShopGoodItemdelegate>

@property (nonatomic, strong) UILabel *titlelabel;


@end

@implementation ShoppingCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        __weak typeof(self) weakSelf=self;
        
        _storePicImgView=[[UIImageView alloc]init];
       // _storePicImgView.backgroundColor=[UIColor redColor];
        
        [self addSubview:_storePicImgView];
        
        [_storePicImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            
            make.top.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(30,30));
            
        }];
        
        _clearbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_clearbtn setImage:[UIImage imageNamed:@"histroydelete_pic"] forState:UIControlStateNormal];
        [self addSubview:_clearbtn];
        [_clearbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.top.mas_equalTo(10);
            
            make.size.mas_equalTo(CGSizeMake(20,30));
            
        }];
        
        _storeNamelabel=[[UILabel alloc]init];
      
        _storeNamelabel.textAlignment=NSTextAlignmentLeft;
        
        [self addSubview:_storeNamelabel];
      
        [_storeNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.storePicImgView.mas_right).offset(5);
            
            make.right.equalTo(weakSelf.clearbtn.mas_left).offset(-10);
            
            make.top.mas_equalTo(10);
            
            make.height.mas_equalTo(30);
            
        }];
        
        _rightImgView = [[UIImageView alloc]init];
        _rightImgView.image = [UIImage imageNamed:@"sy_arrow"];
        [self.storeNamelabel addSubview:_rightImgView];
        [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.storeNamelabel.mas_left).offset(5);
            make.centerY.mas_equalTo(weakSelf.storeNamelabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(10, 12));
        }];
        

        _backView=[[UIView alloc]init];
        
        [self addSubview:_backView];
        
        
        _ordernbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _ordernbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(195,195,195,1);
        _ordernbtn.layer.cornerRadius=5;
        _ordernbtn.layer.masksToBounds=YES;
        _ordernbtn.titleLabel.font=[UIFont systemFontOfSize:14];
       
        [self addSubview:_ordernbtn];
        
        _totlelabel=[[UILabel alloc]init];
        _totlelabel.textAlignment=NSTextAlignmentLeft;
        [self addSubview:_totlelabel];
        
        
        [_ordernbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.height.mas_equalTo(25);
            
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-15);
            
            make.width.mas_equalTo(50);
            
        }];
        
        [_totlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.ordernbtn.mas_top).offset(0);
            
            make.height.mas_equalTo(30);
            
            make.right.equalTo(weakSelf.ordernbtn.mas_left).offset(-10);
            
        }];
        
        UILabel *tippricelabel=[[UILabel alloc]init];
        tippricelabel.textAlignment=NSTextAlignmentRight;
        tippricelabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:tippricelabel];
        tippricelabel.text=@"小计";
        [tippricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.totlelabel.mas_top).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(50,30));
            
            make.right.equalTo(weakSelf.totlelabel.mas_left).offset(-5);
            
        }];
        
        _customCapacityView=[[CustomCapacityView alloc]init];
        [self addSubview:_customCapacityView];
        
    
        [_customCapacityView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(weakSelf.totlelabel.mas_top).offset(-10);
            
            make.left.equalTo(weakSelf.storeNamelabel.mas_left).offset(0);
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-45,30));
      
        }];
        
        
        
        _activitylabel=[[UILabel alloc]init];
        _activitylabel.textAlignment=NSTextAlignmentRight;
        _activitylabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_activitylabel];
        
        _titlelabel2 =[[UILabel alloc]init];
        _titlelabel2.textAlignment=NSTextAlignmentLeft;
        _titlelabel2.font=[UIFont systemFontOfSize:12];
        _titlelabel2.text=@"满减优惠";
        [self addSubview:_titlelabel2];
       
        [_titlelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.storeNamelabel.mas_left).offset(0);
            
            make.bottom.equalTo(weakSelf.customCapacityView.mas_top).offset(-10);
            
            make.size.mas_equalTo(CGSizeMake(100,20));
            
        }];
        
        [_activitylabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.titlelabel2.mas_top).offset(0);
            
            make.left.equalTo(weakSelf.titlelabel2.mas_right).offset(0);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.height.mas_equalTo(20);
            
        }];
        
        _titlelabel=[[UILabel alloc]init];
        _titlelabel.textAlignment=NSTextAlignmentLeft;
        _titlelabel.text=@"打包费";
        _titlelabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:_titlelabel];
        
        _packpricelabel=[[UILabel alloc]init];
        _packpricelabel.textAlignment=NSTextAlignmentRight;
        _packpricelabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_packpricelabel];
        
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(weakSelf.titlelabel2.mas_top).offset(-10);
            
            make.left.equalTo(weakSelf.titlelabel2.mas_left).offset(0);
            
            make.width.mas_equalTo(weakSelf.titlelabel2.mas_width);
            
            make.height.mas_equalTo(weakSelf.titlelabel2.mas_height);
            
        }];
        
        [_packpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.titlelabel.mas_top).offset(0);
            
            make.left.equalTo(weakSelf.titlelabel.mas_right).offset(0);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.height.mas_equalTo(20);
            
        }];
        
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.storeNamelabel.mas_bottom).offset(0);
            
            make.left.equalTo(weakSelf.storePicImgView.mas_right).offset(5);
            
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            
            make.bottom.equalTo(weakSelf.titlelabel.mas_top).offset(-10);
            
        }];
        
        UIView *line=[[UIView alloc]init];
       
        line.backgroundColor=TR_COLOR_RGBACOLOR_A(245,245,245,1);
        
        [self addSubview:line];
     
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            
            make.bottom.mas_equalTo(0);
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH,1));
            
        }];
    }
    
    
    return self;
}



- (void)LoadStoreShoppingGoods:(NSArray *)goods {
    
    NSInteger num=0;
    
    for (UIView *view in _backView.subviews) {
        
        if (view.tag/1000==5) {
           
            [view removeFromSuperview];
        }
    }
    
    for (int i=0; i<goods.count; i++) {
    
                GoodsShopModel *model=goods[i];
        
                ShopGoodItemView *shopGoodView=[[ShopGoodItemView alloc]init];
                shopGoodView.delegate=self;
                 shopGoodView.tag=5000+i;
                [_backView addSubview:shopGoodView];
                
                [shopGoodView loadStoreData:_model andGoodData:model];
                
                [shopGoodView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.mas_equalTo(num*90+10);
                    
                    make.left.mas_equalTo(0);
                    
                    make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-45,80));
                    
                }];
                num++;
                
        }
}


- (CGFloat) loadTotalPrice:(CGFloat )orderPrice {
    
    NSInteger activitysNum=_activitys.count;
    
    double manPrice=0;
    
    double jianPrice=0;
    
    for (NSInteger i=0;i<activitysNum; i++) {
        
        NSString * activityPrice=_activitys[i];
        BOOL iscontent = [activityPrice containsString:@"首单"];
       activityPrice=[activityPrice stringByReplacingOccurrencesOfString:@"满" withString:@""];
       
        NSArray *priceArr=[activityPrice componentsSeparatedByString:@"减"];
        
        NSString *price=priceArr[0];
       
        double mprice =[price doubleValue];
        
        if (mprice<=orderPrice) {
            manPrice=mprice;
            jianPrice=[priceArr[1] doubleValue];
            if (iscontent) {
                jianPrice = 0.0f;
            }
        }
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (jianPrice > 0) {
            
           _activitylabel.text=[NSString stringWithFormat:@"-¥%.2f",jianPrice];
            
        }else{
            
            _activitylabel.text=@"￥0";
        }
        

    });
    
    if (orderPrice >= jianPrice) {
        
        return orderPrice-jianPrice;
    }

    return orderPrice;
}


- (void) storeDataForPrice{
    
    NSArray *array=_model.goods;
    
    double packPrice=0;
    
    double totalPrice=0;
    
    for (GoodsShopModel*model  in  array) {
        
        
        if (model.specId.length==0) {
            
            packPrice+= [model.goodpick doubleValue]*[model.goodnum integerValue];
            
            totalPrice+=[model.goodprice doubleValue]*[model.goodnum integerValue];
        }else{
            
            
                packPrice+=[model.specpick doubleValue]*[model.goodnum integerValue];
               
                totalPrice+=[model.specprice doubleValue]*[model.goodnum integerValue];
            
        }
    }
    
    
    
    double lastPrice=[self loadTotalPrice:totalPrice+packPrice];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _packpricelabel.text=[NSString stringWithFormat:@"¥%.1f",packPrice];
        _totlelabel.text=[NSString stringWithFormat:@"¥%.2f",lastPrice];

    });
    
    double diverPrice=[_model.sendprice doubleValue];
    
    if (diverPrice<lastPrice) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            [_ordernbtn setTitle:@"下单" forState:UIControlStateNormal];
            _ordernbtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _ordernbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(252,122,46,1);
            _ordernbtn.selected=YES;
           // CGSize size = TR_TEXT_SIZE(_ordernbtn.titleLabel.text,_ordernbtn.titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
            
            [_ordernbtn mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(50);
            }];
            
        });
   
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [_ordernbtn setTitle:[NSString stringWithFormat:@"差¥%.2f起送",diverPrice-lastPrice] forState:UIControlStateNormal];
            _ordernbtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _ordernbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(252,122,46,1);
            
            CGSize size = TR_TEXT_SIZE(_ordernbtn.titleLabel.text,_ordernbtn.titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
            
            [_ordernbtn mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(size.width+10);
            }];
            _ordernbtn.selected=NO;
            _ordernbtn.backgroundColor=TR_COLOR_RGBACOLOR_A(195,195,195,1);;
        });
    }
    
}

- (void)loadshopGood:(GoodsShopModel *)model {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self storeDataForPrice];
    });
    
    _selectclearloadlistBlock(model);
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
