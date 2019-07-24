//
//  BusinessShopView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "BusinessShopView.h"
#import "GoodsChooseModel.h"
#import "ProductGoodsModel.h"
#import "GoodShopManagement.h"
#import "ProductOrderGoodModel.h"
#import "LogInViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>

#define SpareWidth 10

#define TopHeight  80 + STATUS_BAR_HEIGHT //顶部视图高度  可以调整

#define ViewHeight self.frame.size.height - TopHeight

@implementation BusinessShopView
{
    BOOL isShowCommentView;
    NSString *shopImagePath;
    UIImageView *showArrowimgView;
    UIView *shopColseView;
    BOOL _isShare;
    SSDKPlatformType platformType;
}
//底部滑动视图

-(UIScrollView *)contentScroll{
    if (_contentScroll == nil) {
        _contentScroll = [[TouchScrollViewExtent alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentScroll.delegate = self;
        _contentScroll.bounces=NO;
        _contentScroll.backgroundColor = [UIColor whiteColor];
        _contentScroll.contentSize = CGSizeMake(0, self.frame.size.height + 300);
        _contentScroll.showsVerticalScrollIndicator = NO;
        _contentScroll.showsHorizontalScrollIndicator = NO;
    }
    return _contentScroll;
}

-(ShopBottomView *)bottomContentView {
    if (_bottomContentView == nil) {
        _bottomContentView = [[ShopBottomView alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, self.frame.size.height - TopHeight)];
        _bottomContentView.delegate = self;
        
    }
    return _bottomContentView;
}


-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 1.5);
        _hideView.hidden = YES;
        _hideView.alpha = TR_Alpha;
        _hideView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaction)];
        [_hideView addGestureRecognizer:tap];
        [self addSubview:_hideView];
    }
    return _hideView;
}






//顶部视图
-(UIView *)topTitleView{
    if (_topTitleView ==nil) {
        CGFloat topmargin = IS_RETAINING_SCREEN ? STATUS_BAR_HEIGHT + 20 : STATUS_BAR_HEIGHT ;
        _topTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, topmargin, self.frame.size.width, 50)];
        _topTitleView.backgroundColor = [UIColor clearColor];
        [self designTopView];
    }
    return _topTitleView;
}

-(UILabel *)titleName{
    if (_titleName == nil) {
        _titleName = [[UILabel alloc]init];
        _titleName.font = TR_Font_Cu(17);
        _titleName.textAlignment = NSTextAlignmentCenter;
        _titleName.textColor = [UIColor blackColor];
        _titleName.backgroundColor = [UIColor clearColor];
        _titleName.alpha = 0;
    }
    return _titleName;
}

-(ShopDetailMessageView *)shopDetailView{
    if (_shopDetailView == nil) {
        _shopDetailView = [[ShopDetailMessageView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addSubview:_shopDetailView];
        _shopDetailView.delegate = self;
        _shopDetailView.ShopModel = self.model;
    }
    return _shopDetailView;
}


-(ShopSearchView *)shopSearchView{
    if (_shopSearchView == nil) {
        _shopSearchView = [[ShopSearchView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _shopSearchView.hidden = YES;
        _shopSearchView.shopModel = self.model;
        [self addSubview:_shopSearchView];
        
    }
    return _shopSearchView;
}



-(ShopBotCarView *)shopbotcar{
    
    if (_shopbotcar == nil) {
        
        _shopbotcar = [[ShopBotCarView alloc]initWithFrame:CGRectMake(0, self.frame.size.height -100, 200, 100)];
        
        _shopbotcar.delegate = self;
        
        [self addSubview:_shopbotcar];
        
    }
    return _shopbotcar;
}




-(BusinessDetailView *)settmentView{
    if (_settmentView == nil) {
        _settmentView = [[BusinessDetailView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _settmentView.hidden = YES;
        _settmentView.delegate = self;
        [self addSubview:_settmentView];
    }
    return _settmentView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentScroll];
        [self addSubview:self.topTitleView];
        [self.contentScroll addSubview:self.bottomContentView];
        
        [self addSubview:self.shopbotcar];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeShopCarCcount) name:@"UPDATASHOPCAR" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeShopCarState) name:@"CHANGESHOPCARSTATE" object:nil];
        
    }
    return self;
}

//布局界面
-(void)designTopView{
    //返回上一层界面
    UIImage *image = [UIImage imageNamed:@"下拉"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:image forState:UIControlStateNormal];
    leftButton.tag = 1000;
    self.backBtn = leftButton;
    [self.topTitleView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(returntopView:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    //收藏
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setImage:[UIImage imageNamed:@"shopSave"] forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:@"shop_saved"] forState:UIControlStateSelected];
    saveBtn.tag = 1002;
    self.saveBtn = saveBtn;
    [saveBtn addTarget:self action:@selector(returntopView:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(- SpareWidth /2 );
        make.centerY.mas_equalTo(leftButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    
    //搜索框
    UIButton *searceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searceBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    searceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searceBtn.layer.cornerRadius = 5.0f;
    searceBtn.layer.masksToBounds = YES;
    searceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    searceBtn.backgroundColor = [UIColor clearColor];
    searceBtn.tag = 1001;
    self.searchBtn = searceBtn;
    [searceBtn addTarget:self action:@selector(returntopView:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:searceBtn];
    [searceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(saveBtn.mas_left).offset(- SpareWidth);
        make.centerY.mas_equalTo(leftButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"shop_share"] forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius = 5.0f;
    shareBtn.layer.masksToBounds = YES;
    shareBtn.backgroundColor = [UIColor clearColor];
    shareBtn.tag = 1003;
    self.shareBtn = shareBtn;
    [shareBtn addTarget:self action:@selector(returntopView:) forControlEvents:UIControlEventTouchUpInside];
    [self.topTitleView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(searceBtn.mas_left).offset(- SpareWidth);
        make.centerY.mas_equalTo(saveBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    
    [self.topTitleView addSubview: self.titleName];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.mas_equalTo(leftButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    
}

//布局底部视图

//商家头像

-(UIImageView *)headimage{
    if (_headimage == nil) {
        _headimage = [[UIImageView alloc]init];
        _headimage.backgroundColor = [UIColor clearColor];
        _headimage.contentMode = UIViewContentModeScaleAspectFill;
        _headimage.layer.cornerRadius = 5.0f;
        _headimage.layer.masksToBounds = YES;
        _headimage.userInteractionEnabled = YES;
    }
    return _headimage;
}

//商家名字
-(UILabel *)namelabel{
    if (_namelabel == nil) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.text = @"肯德基(萧山店)";
        _namelabel.font = TR_Font_Cu(18);
        _namelabel.textColor = [UIColor blackColor];
        _namelabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _namelabel;
}
//月售 和 送达时间
-(UILabel *)qisonglabel{
    if (_qisonglabel == nil) {
        _qisonglabel = [[UILabel alloc]init];
        _qisonglabel.text = @"月售1000份   约30分钟送达";
        _qisonglabel.textColor = [UIColor colorWithRed:85.0017/255.0 green:85.0017/255.0 blue:85.0017/255.0 alpha:1];
        _qisonglabel.backgroundColor = [UIColor clearColor];
        _qisonglabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
        _qisonglabel.textAlignment = NSTextAlignmentCenter;
    }
    return _qisonglabel;
}


-(UILabel *)julilabel {
    if (_julilabel == nil) {
        _julilabel = [[UILabel alloc]init];
        _julilabel.textColor = [UIColor grayColor];
        _julilabel.backgroundColor = [UIColor clearColor];
        _julilabel.numberOfLines = 0;
        _julilabel.text = @"公告：欢迎光临，很高兴为您服务~";
        _julilabel.textAlignment = NSTextAlignmentCenter;
        _julilabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    }
    return _julilabel;
}


-(void)designBottomView{
    
    __weak typeof(self) weakSelf=self;
    
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.backgroundColor = [UIColor clearColor];
    
    [self.contentScroll addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 120));
    }];
    
    UIView *hidebackView = [[UIView alloc]init];
    hidebackView.backgroundColor = [UIColor blackColor];
    hidebackView.alpha = 0.3;
    [backImageView addSubview:hidebackView];
    
    [hidebackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 120));
    }];
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor clearColor];
    [self.contentScroll addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SpareWidth);
        make.top.mas_equalTo(backImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 155));
    }];
    
    //商家头像
    
    [self.contentScroll addSubview:self.headimage];
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(centerView.mas_top).offset(-30);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    //商家名字
    [centerView addSubview:self.namelabel];
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 15));
        
    }];
    
    
    //月售 和 送达时间
    
    [centerView addSubview:self.qisonglabel];
    [self.qisonglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.namelabel.mas_bottom).offset(SpareWidth);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 15));
    }];
    
    //公告
    
    [centerView addSubview:self.julilabel];
    [_julilabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.qisonglabel.mas_bottom).offset(SpareWidth /2 );
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 30));
    }];
    
    //数据展示
    
    if (self.model) {
        self.namelabel.text = self.model.name;
        shopImagePath = self.model.image;
        [self.headimage sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        [backImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:PLACEHOLDIMAGE]];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.alpha = 0.7;
        effectview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        [backImageView addSubview:effectview];
        
        self.qisonglabel.text = [NSString stringWithFormat:@"月售%@份  %@约%@分钟送达",self.model.month_sale_count,self.model.delivery_type,self.model.delivery_time];
        
        self.titleName.text = self.model.name;
        
        if (self.model.store_notice.length > 0) {
            self.julilabel.text = [NSString stringWithFormat:@"公告:%@",self.model.store_notice];
        }
        
        
        UIButton *saveBtn = [self.topTitleView viewWithTag:1002];
        
        if ([self.model.is_collection isEqualToString:@"1"]) {
            
            saveBtn.selected = YES;
            
        }else{
            saveBtn.selected = NO;
        }
    }
    
    
    //优惠
    
    if (self.model.tag.count == 1) {
        NSString *tagstr = self.model.tag[0];
        if (tagstr.length == 0) {
            
            CGRect rect = self.bottomContentView.frame;
            
            self.bottomContentView.frame = CGRectMake(rect.origin.x, 240, rect.size.width, rect.size.height + 80);
            
            [centerView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 130));
            }];
            
            return;
        }
    }
    
    if (self.model.tag.count == 0) {
        
        CGRect rect = self.bottomContentView.frame;
        
        self.bottomContentView.frame = CGRectMake(rect.origin.x, 240, rect.size.width, rect.size.height + 80);
        
        [centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 130));
        }];
        
        
    }
    
    [self designDiscountWith:self.model.tag.count  with:centerView];
    
    
}


-(void)designDiscountWith:(NSInteger)count with:(UIView *)contentView{
    
    CGFloat btnWinth = 70; //每个优化的宽度
    CGFloat scare = 10;  //间距
    
    if (count > 4) {
        count = 4;
    }
    
    NSInteger size = count  / 2 ;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.model.tag[i] forState:UIControlStateNormal];
        btn.titleLabel.font = TR_Font_Gray(12);
        btn.layer.borderWidth = 1.0f;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.layer.borderColor = TR_COLOR_RGBACOLOR_A(249, 72, 60, 1).CGColor;
        [btn setTitleColor:TR_COLOR_RGBACOLOR_A(249, 72, 60, 1) forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:btn];
        if (count % 2 == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-SpareWidth);
                make.size.mas_equalTo(CGSizeMake(btnWinth, 20));
                make.centerX.mas_equalTo((btnWinth + scare) * i - (btnWinth + scare) * (size - 0.5) );
                
            }];
            
        }else {
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-SpareWidth);
                make.size.mas_equalTo(CGSizeMake(btnWinth, 20));
                make.centerX.mas_equalTo((btnWinth + scare) * i - (btnWinth + scare) * (size ) );
                
            }];
            
        }
        
    }
    
}



-(void)showcommentView:(UITapGestureRecognizer *)sender {
    if (!isShowCommentView) {
        
        sender.view.transform = CGAffineTransformMakeRotation(M_PI);
        CGRect rect=self.bottomContentView.contentView.frame;
        rect.origin.y=self.bottomContentView.frame.size.height;
        self.bottomContentView.contentView.frame=rect;
        self.bottomContentView.moveTopbtn.hidden=NO;
        isShowCommentView = YES;
        [self taplistMoveScale:1];
    }else {
        
        CGRect rect=self.bottomContentView.contentView.frame;
        rect.origin.y=0;
        self.bottomContentView.contentView.frame=rect;
        isShowCommentView = NO;
        self.bottomContentView.moveTopbtn.hidden=YES;
        [self taplistMoveScale:0];
        
        sender.view.transform = CGAffineTransformMakeRotation(0);
    }
    
}

//titleView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat tableViewOffsetY =  IS_RETAINING_SCREEN ? 180 : 220;
    
    
    tableViewOffsetY = self.model.tag.count == 0 ? tableViewOffsetY - 40 : tableViewOffsetY;
    
    if (self.model.tag.count == 1) {
        NSString *tagstr = self.model.tag[0];
        if (tagstr.length == 0) {
            
            tableViewOffsetY = tableViewOffsetY - 40 ;
        }
        
    }
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    if (contentOffsetY >= TopHeight) {
        self.titleName.alpha = 1.0f;
        self.topTitleView.backgroundColor = [UIColor whiteColor];
        [self.backBtn  setImage:[UIImage imageNamed:@"shop_back2"] forState:UIControlStateNormal];
        [self.searchBtn  setImage:[UIImage imageNamed:@"shop_search2"] forState:UIControlStateNormal];
        [self.saveBtn  setImage:[UIImage imageNamed:@"shop_save2"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"shop_sharegray"] forState:UIControlStateNormal];
        
    }else{
        self.titleName.alpha = 0.f;
        self.topTitleView.backgroundColor = [UIColor clearColor];
        [self.backBtn  setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        [self.searchBtn  setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [self.saveBtn  setImage:[UIImage imageNamed:@"shopSave"] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"shop_share"] forState:UIControlStateNormal];
        
    }
    
    
    if (!self.canScroll) {
        if (contentOffsetY >tableViewOffsetY) {
            [scrollView setContentOffset:CGPointMake(0, tableViewOffsetY)];
            [self.bottomContentView changescrolltype];
            self.canScroll = YES;
            scrollView.scrollEnabled = NO;
            return;
            
        }
    }
    if (self.canScroll) {
        [scrollView setContentOffset:CGPointMake(0, tableViewOffsetY)];
    }
    
    
    
}



#pragma mark --  ScrollOfChooseDelegate

//滑动部分
- (void)scrollToTopView {
    self.canScroll = NO;
    self.contentScroll.scrollEnabled = YES;
    [self.contentScroll setContentOffset:CGPointMake(0, -STATUS_BAR_HEIGHT) animated:YES];
    
}




#pragma mark ShopBottomView -delegate
//点击cell

-(void)tableViewSelectIndexpath:(NSIndexPath *)indexpath WithDatasource:(NSDictionary *)datasource WithDataArray:(NSArray *)dataArray{
    
    if ([GoodsListManager shareInstance].goodsListArray.count > 0) {
        NSArray *contentArray = [GoodsListManager shareInstance].goodsListArray[indexpath.section];
        ProductItem *model = contentArray[indexpath.row];
        
        //动画部分 暂定
        
        GoodsItemCell *cell = (GoodsItemCell *)[self.bottomContentView.rightCollection cellForItemAtIndexPath:indexpath];
        
        UIWindow *window = APP_Delegate.window;
        
        CGRect rect2 = [cell.goodImageV convertRect: cell.goodImageV.bounds toView:window];
        
        if (!_isShowShopDetailView) {
            self.hideView.hidden = NO;
            self.shopDetailView.hidden = NO;
            
            self.shopDetailView.shop_Name = self.model.name;
            self.shopDetailView.shop_ID = self.model.store_id;
            [self.shopDetailView designViewWithShopMessage:@[model,indexpath]];
            [self.shopDetailView startAnimalWithRect:rect2];
            _isShowShopDetailView = YES;
        }
        
    }
}



//点击选规格
-(void)addchoosefoodtype:(NSArray *)typearray{
    
    ProductItem *model = typearray[0];
    
    GoodItem *goodItem =[[GoodsListManager shareInstance] transformModelFrom:model withShopID:self.model.store_id];
    SpecAttributeView *specAttributeView=[[SpecAttributeView alloc]init];
    specAttributeView.storeDict=[self.model toDictionary];
    [specAttributeView loadGoodId:model.product_id goodName:model.product_name withGoodPrice:model.product_price goodData:[goodItem toDictionary]];
    
    [specAttributeView showInView];
}


-(void)addGoodsToShopAction:(NSArray *)datasource{
    
    if (datasource.count > 0) {
        
        NSDictionary *contentDic = datasource[0];
        ProductItem *model = [contentDic allValues][0];
        
        if ([[contentDic allKeys][0] isEqualToString:@"jia"]) {
            
            [[GoodsListManager shareInstance]setSelctModelCount:model withCount:[NSString stringWithFormat:@"%ld",[model.selectCount integerValue] + 1]];
            
        }
        
        
        if ([[contentDic allKeys][0] isEqualToString:@"jian"]) {
            
            [[GoodsListManager shareInstance]setSelctModelCount:model withCount:[NSString stringWithFormat:@"%ld",[model.selectCount integerValue] - 1]];
        }
        
        StoreDataModel *storeModel = [[GoodsListManager shareInstance]transformModelFrom4:self.model];
        
        GoodsShopModel *goodModel = [[GoodsListManager shareInstance]transformModelFrom3:model withShopID:self.model.store_id];
        
        if ([model.selectCount isEqualToString:@"0"]) {
            
            [[GoodShopManagement shareInstance]deleteStore:storeModel andGoodshopmodel:goodModel];
            
        }else{
            
            [[GoodShopManagement shareInstance]addStore:storeModel andGoodshopmodel:goodModel];
        }
        
    }
    
    [self.shopbotcar getGoodsCountAction];
}

-(void)taplistMoveScale:(CGFloat)scale {
    
    //self.shopcar.alpha=1-scale;
    self.shopbotcar.alpha = 1 - scale;
    showArrowimgView.transform = CGAffineTransformMakeRotation(scale*M_PI);
    
}

//搜索商品的选规格
-(void)tapaction{
    
    if (_isShowShopDetail) {
        self.hideView.hidden = YES;
        _isShowShopDetail = NO;
        
        
    }
    
    if (shopColseView) {
        
        [shopColseView removeFromSuperview];
        shopColseView = nil;
        _hideView.hidden = YES;
    }
    
}



#pragma mark ShopBotCarViewDelegate 协议

-(void)clicksettmentaction:(NSArray *)dataArray{
    
    if (dataArray.count == 0) {
        
        
        return;
    }
    
    if (!GetUser_Login_State) {
        
        TR_Message(@"请先登录账号");
        
        UINavigationController *nav=APP_Delegate.rootViewController.viewControllers[0];
        
        LogInViewController *logvc=[[LogInViewController alloc]init];
        
        [APP_Delegate.rootViewController setTabBarHidden:YES animated:NO];
        [nav pushViewController:logvc animated:YES];
        
        return;
    }
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:ORDERTYPE]) {
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:ORDERTYPE];
    }
    
    
    
    if (!_isShowSetmentView) {
        
        self.hideView.hidden = NO;
        self.settmentView.hidden = NO;
        self.settmentView.model = self.model;
        [UIView animateWithDuration:0.2 animations:^{
            self.settmentView.frame = CGRectMake(0, 0, self.settmentView.frame.size.width, self.settmentView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [self.settmentView addDatasourceToView:dataArray];
            
            _isShowSetmentView = YES;
            
        }];
        
    }
}




#pragma mark 界面返回

-(void)clickReturnBtn:(NSInteger)is_mandatory{
    
    if (_isShowShopDetail) {
        
        _isShowShopDetail = NO;
        
    }
    
    if (_isShowSetmentView) {
        
        self.hideView.hidden = YES;
        _isShowSetmentView = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.settmentView.frame = CGRectMake(0, SCREEN_HEIGHT, self.settmentView.frame.size.width, self.settmentView.frame.size.height);
            
        } completion:^(BOOL finished) {
            self.settmentView.hidden = YES;
            [self changeShopCarCcount];
            if (is_mandatory > 0) {
                
                [self.contentScroll setContentOffset:CGPointMake(0, 220) animated:YES];
                [self.bottomContentView scrollToAimSection:is_mandatory];
                
            }
        }];
        
    }
    
    
    if (_isShowShopDetailView) {
        self.hideView.hidden = YES;
        self.shopDetailView.hidden = YES;
        [self.shopbotcar getGoodsCountAction];
        _isShowShopDetailView = NO;
    }
    
}


#pragma mark ShopDetailMessageView delegate

-(void)returnTopViewAction{
    
    if (_isShowShopDetailView) {
        self.hideView.hidden = YES;
        self.shopDetailView.hidden = YES;
        
        _isShowShopDetailView = NO;
        
        [self.shopbotcar getGoodsCountAction];
        [self.bottomContentView loadDataSource];
    }
    
}






//点击 返回上一个界面
-(void)returntopView:(UIButton *)sender {
    
    
    if (sender.tag == 1003) {
        
        //店铺分享
        
        [self  shareMiniProgram];
        
        
    }
    
    
    
    if (sender.tag == 1000) {
        //返回上一个界面
        
        if (shopColseView) {
            [shopColseView removeFromSuperview];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(backView)]) {
            
            [self.delegate backView];
            
        }
    }
    
    if (sender.tag == 1001) {
        //显示搜索界面  通知上一个界面 隐藏底部视图
        self.shopSearchView.hidden = NO;
    
        [self.shopSearchView updataView];
        [UIView animateWithDuration:0.2 animations:^{
            self.shopSearchView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, self.shopSearchView.frame.size.width, self.shopSearchView.frame.size.height);
        }];
    }
    
    if (sender.tag == 1002) {
        
        if (!GetUser_Login_State) {
            TR_Message(@"请先登录账号");
            return;
        }
        
        //收藏或者取消收藏店铺
        NSString *status;
        if (sender.selected) {
            NSLog(@"取消");
            status = @"2";
        }else{
            NSLog(@"收藏");
            status = @"1";
        }
        
        sender.selected = !sender.selected;
        self.userInteractionEnabled = NO;
        [HBHttpTool post:SHOP_STORESAVE params:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"store_id":self.model.store_id,@"status":status} success:^(id responseObj) {
            
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                
                TR_Message(responseObj[@"result"]);
                
            }else{
                
                TR_Message(responseObj[@"errorMsg"]);
            }
            
            self.userInteractionEnabled = YES;
            
        } failure:^(NSError *error) {
            
            self.userInteractionEnabled = YES;
        }];
        
    }
    
}


-(void)startnetworkingwith:(NSString *)shopID{
    
    NSString *userTicket = [Singleton shareInstance].userInfo.ticket ? [Singleton shareInstance].userInfo.ticket :@"";
    
    [HBHttpTool post:SHOP_AJAXSHOP params:@{@"Device-Id":DeviceID,@"ticket":userTicket,@"store_id":shopID} success:^(id responseObj) {
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            self.model = [[StoreModel alloc]initWithDictionary:responseObj[@"result"][@"store"] error:nil];
            self.model.store_id = self.model.id;
            self.bottomContentView.shop_Name = self.model.name;
            self.bottomContentView.shop_ID = self.model.id;
            
            self.shopbotcar.model = self.model;
            [self.shopbotcar getGoodsCountAction];
            
            [self designBottomView];
            [self.bottomContentView parseDasourceWith:responseObj[@"result"]];
            if ([self.model.is_close isEqualToString:@"1"]) {
                
                //已经关店
                [self shopCloseView];
                
            }
            
        }else{
            
            TR_Message(responseObj[@"errorMsg"]);
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(backView)]) {
                [self.delegate backView];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)changeShopCarState{
    
    self.shopbotcar.hidden = NO;
}

-(void)changeShopCarCcount{
    
    [self.shopbotcar getGoodsCountAction];
    [self.bottomContentView loadDataSource];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UPDATASHOPCAR" object:nil];
}



- (void)loadAgainDataOrderId:(NSString *)orderid withStoreID:(NSString *)shopID {
    
    if (orderid.length!=0) {
        
        [[GoodsListManager shareInstance]deleteShopOrder:shopID];
        
        [HBHttpTool post:SHOP_AGAINORDER params:@{@"Device-Id":DeviceID,@"ticket":[Singleton shareInstance].userInfo.ticket,@"order_id":orderid} success:^(id responseDic){
            
            if (responseDic) {
                
                NSDictionary *dataDict=responseDic;
                
                if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]&&![[dataDict objectForKey:@"result"] isEqual:[NSNull null]]) {
                    
                    NSDictionary *mdatadict=[dataDict objectForKey:@"result"];
                    
                    NSArray *data=[mdatadict objectForKey:@"productCart"];
                   
                    if (data&&data.count!=0) {
                        
                        NSArray *againdata=[ProductGoodsModel arrayOfModelsFromDictionaries:data];
                        
                        [self  setShopProductDetailData:againdata];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    });
                }
            }
            
        }failure:^(NSError *error){
            
        }];
    }
}

- (void)setShopProductDetailData:(NSArray *)array{
    
    StoreDataModel *storeModel=[[StoreDataModel alloc]init];
    
    storeModel.store_id=_model.store_id;
    storeModel.storename=_model.name;
    storeModel.sendprice=_model.delivery_price;
    storeModel.storeimg=_model.image;
    
    for (int i=0;i<array.count;i++) {
        
        ProductGoodsModel *model=array[i];
        ProductOrderGoodModel *pmodel= model.infos;
        GoodsShopModel *gmodel=[[GoodsShopModel alloc]init];
        gmodel.storeid=_model.store_id;
        
        NSString *goodCount = model.count;
        
        if ([pmodel.stock integerValue] == 0) {
            
            NSString *tips = [NSString stringWithFormat:@"%@商品库存不足",model.productName];
            
            TR_Message(tips);
            
            goodCount = @"0";
            
            continue;
        }
        
        if ([pmodel.stock integerValue ] < [model.count integerValue]) {
            
            NSString *tips = [NSString stringWithFormat:@"%@商品库存%@份",model.productName,pmodel.stock];
            
            TR_Message(tips);
            
            goodCount = pmodel.stock;
            
        }
        
        
        if ([pmodel.max_num integerValue] < [model.count integerValue] && [pmodel.max_num integerValue] != 0) {
            
            NSString *tips = [NSString stringWithFormat:@"%@商品限购%@份",model.productName,pmodel.max_num];
            
            TR_Message(tips);
            
            goodCount = pmodel.max_num ;
            
            if ([pmodel.max_num integerValue] > [pmodel.stock integerValue]) {
                
                goodCount = pmodel.stock;
            }
            
        }
        
        
        
        gmodel.goodnum=goodCount;
        gmodel.goodname=model.productName;
        gmodel.goodId=model.productId;
        gmodel.goodprice=pmodel.old_price;
        gmodel.goodimg=pmodel.product_image;
        gmodel.atttip = @"0";
        
        if ([pmodel.has_format integerValue]==1) {
            
            NSDictionary *dict=model.productParam[0];
            
            NSArray *marr=dict[@"data"];
            
            NSDictionary *mdict=marr[0];
            
            if ([dict[@"type"] isEqualToString:@"spec"]) {
                
                gmodel.specname=dict[@"name"];
                gmodel.specId=dict[@"id"];
                gmodel.spec_tid=dict[@"spec_id"];
                gmodel.specprice=pmodel.old_price;
                gmodel.specpick=pmodel.packing_charge;
                gmodel.attributename=mdict[@"name"];
                gmodel.attributeId=mdict[@"list_id"];
                gmodel.atttip=mdict[@"id"];
            }
        }else
            gmodel.goodpick=pmodel.packing_charge;
        
        [[GoodShopManagement shareInstance] addStore:storeModel andGoodshopmodel:gmodel];
    }
    
    [self changeShopCarCcount];
}




-(void)shopCloseView{
    
    
    self.hideView.hidden = NO;
    
    shopColseView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 300)];
    shopColseView.backgroundColor = [UIColor whiteColor];
    [APP_Delegate.window addSubview:shopColseView];
    
    
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = TR_Font_Cu(15);
    label.text = @"店铺未开始营业";
    [shopColseView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"shop_close"];
    
    [shopColseView addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    
}





#pragma mark  - 分享





- (void)shareMiniProgram
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *webUrl = [NSString stringWithFormat:@"https://xcx.dianbeiwaimai.cn/static/wx_xcx_js/index.html?store_id=%@",self.model.store_id];
    NSString *pageUrl = [NSString stringWithFormat:@"pages/Merchant/Merchant?store_id=%@",self.model.store_id];
    
    [parameters SSDKSetupWeChatMiniProgramShareParamsByTitle:@"点呗外卖"
                                                 description:@"点呗外卖"
                                                  webpageUrl:[NSURL URLWithString:webUrl]
                                                        path:pageUrl
                                                  thumbImage:self.headimage.image
                                                hdThumbImage:@""
                                                    userName:@"gh_db8baddbf181"
                                             withShareTicket:YES
                                             miniProgramType:0
                                          forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
    [self shareWithParameters:parameters];
}




- (void)shareWithParameters:(NSMutableDictionary *)parameters
{
    if(_isShare)
    {
        return;
    }
    _isShare = YES;
    if(parameters.count == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"请先设置分享参数"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    [ShareSDK share:SSDKPlatformSubTypeWechatSession
         parameters:parameters
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         if(state == SSDKResponseStateBeginUPLoad){
             return ;
         }
         NSString *titel = @"";
         NSString *typeStr = @"";
         UIColor *typeColor = [UIColor grayColor];
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 NSLog(@"分享成功");
                 self->_isShare = NO;
                 titel = @"分享成功";
                 typeStr = @"成功";
                 typeColor = [UIColor blueColor];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 self->_isShare = NO;
                 NSLog(@"error :%@",error);
                 titel = @"分享失败";
                 typeStr = [NSString stringWithFormat:@"%@",error];
                 typeColor = [UIColor redColor];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 self->_isShare = NO;
                 titel = @"分享已取消";
                 typeStr = @"取消";
                 break;
             }
             default:
                 break;
         }
         
         
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titel
                                                             message:typeStr
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
