//
//  ShopBottomView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/4/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "ShopBottomView.h"
#import "GoodsChooseModel.h"
#import "MJRefresh.h"

#define leftTableWidth 80

@implementation ShopBottomView

{
    BOOL isclick;   // 点击左边分类滑动视图
    NSInteger btnTag; //分类的tag
    NSIndexPath *currentIndexPath;//左边table选中的位置
    NSString *all_count;  //总的评价数
    NSString *good_count; //好评数
    NSString *wrong_count;//差评数
    NSString *pic_count;//有图数
    NSString *total;//评论总页数
    NSString *selectTab;
    
}

-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.frame = self.bounds;
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:self.leftTab];
        [_contentView addSubview:self.rightCollection];
    }
    return _contentView;
}
//底部商品
-(UITableView *)leftTab {
    if (_leftTab == nil) {
        _leftTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftTableWidth , self.frame.size.height)];
        _leftTab.backgroundColor = [UIColor whiteColor];
        _leftTab.dataSource = self;
        _leftTab.delegate=self;
        _leftTab.alwaysBounceVertical = YES;
        _leftTab.showsHorizontalScrollIndicator = NO;
        _leftTab.showsVerticalScrollIndicator = NO;
        _leftTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        CGFloat height = IS_RETAINING_SCREEN ? 110:80;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftTableWidth, height)];
        footView.tag = 3000;
        footView.backgroundColor = [UIColor whiteColor];
        _leftTab.tableFooterView = footView;
    }
    return _leftTab;
}
-(UICollectionView *)rightCollection{
    if (_rightCollection == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init]; //UICollectionViewFlowLayout是UICollectionViewLayout的一种具体的子类布局，实现的是九宫格的布局样式。
        //修改集合视图的背景颜色
        //1:设置每一个cell的宽度
        layout.itemSize = CGSizeMake((SCREEN_WIDTH -leftTableWidth- 30) / 2, 215);
        //2:设置每一个分区的显示范围
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //3:设置cell之间的间距
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        //4:设置集合视图每一个分区区头的尺寸
        layout.headerReferenceSize = CGSizeMake((SCREEN_WIDTH -leftTableWidth) / 2, 30);
        
        layout.footerReferenceSize = CGSizeMake((SCREEN_WIDTH -leftTableWidth) / 2, 50);
        
        _rightCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(leftTableWidth, 0, SCREEN_WIDTH -leftTableWidth, self.frame.size.height) collectionViewLayout:layout];
        _rightCollection.backgroundColor = [UIColor whiteColor];
        _rightCollection.dataSource = self;
        _rightCollection.delegate = self;
        [_rightCollection registerClass:[GoodsItemCell class] forCellWithReuseIdentifier:@"cell"];
        [_rightCollection registerClass:[GoodsItemReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionheader"];
        
        [_rightCollection registerClass:[GoodsItemReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collectionfooter"];
        
        _rightCollection.alwaysBounceVertical = YES;
        _rightCollection.showsHorizontalScrollIndicator = NO;
        
    }
    return _rightCollection;
}

-(NSMutableDictionary *)myIndexDic{
    if (_myIndexDic == nil) {
        _myIndexDic = [NSMutableDictionary dictionary];
    }
    return _myIndexDic;
}

-(NSMutableArray *)commentArray{
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

-(NSMutableArray *)nameDataArray{
    if (_nameDataArray == nil) {
        _nameDataArray = [NSMutableArray array];
    }
    return _nameDataArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.commentScrollView];
        
        [self addSubview:self.contentView];
    
        UIPanGestureRecognizer *up = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
        up.delegate = self;
        [self addGestureRecognizer:up];
        
        _moveTopbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_moveTopbtn setImage:[UIImage imageNamed:@"shop_top"] forState:UIControlStateNormal];
        _moveTopbtn.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 4, 0);
        _moveTopbtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        _moveTopbtn.frame=CGRectMake(0,SCREEN_HEIGHT-50,SCREEN_WIDTH,40);
        [_moveTopbtn addTarget:self action:@selector(moveTopbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [APP_Delegate.window addSubview:_moveTopbtn];
        
        UIPanGestureRecognizer *up2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(movebtnHandleSwipes:)];
        [_moveTopbtn addGestureRecognizer:up2];
        
        _moveTopbtn.hidden=YES;
        
        btnTag = 1000;
        selectTab = @"";
        
        
    }
    return self;
}




//tabview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTab) {
        return self.datasource.count;
    }
    
    if (tableView == _commentScrollView) {
        return self.commentArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    if (tableView == _leftTab) {
        return 1;
    }
    
    if (tableView == _commentScrollView) {
        return 1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTab) {
        ShopTypeModel *model = self.datasource[indexPath.row];
        NSString *title = model.cat_name;
        CGSize size = TR_TEXT_SIZE(title, TR_Font_Cu(15), CGSizeMake(60, 0), nil);
        return  size.height + 30;
    }
  
    if (tableView == _commentScrollView) {
        StoreCommentModel *model = self.commentArray[indexPath.row];
        
        CGSize size = TR_TEXT_SIZE(model.comment, [UIFont systemFontOfSize:15], CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
        
        if (model.comment.length > 0) {
            
            size.height = size.height + 10;
        }else{
            
            size.height = 0;
        }
        
        CGFloat imageWidth = (SCREEN_WIDTH - 65 - 4 * 5) /3; // 图片的宽度
        
        
        NSDate *nowDate=[NSDate dateWithTimeIntervalSince1970:model.merchant_reply_time.intValue];
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init] ;
        
        [dateformatter setDateFormat:@"MM-dd HH:mm"];
        
        NSString *dateStr = [dateformatter stringFromDate:nowDate];
        
        NSString *shop_comment = [NSString stringWithFormat:@"商家回复(%@):%@",dateStr,model.merchant_reply_content];
        
        CGSize textSize = TR_TEXT_SIZE(shop_comment, [UIFont systemFontOfSize:12], CGSizeMake(SCREEN_WIDTH - 65, 0), nil);
        
        if (model.merchant_reply_content.length > 0) {
            
            textSize.height = textSize.height + 10;
            
        }else{
            
            textSize.height = 0.0f;
        }
        
        CGFloat height = 0.0;
        
        if (model.goods.count > 0) {
            
            height = 25;
        }
        
        if (model.pic.count > 0) {
            
            return  size.height + imageWidth + textSize.height + 80 + height;
        }
        
        
        
        return size.height + textSize.height + 70 + height;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTab) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(5);
                make.right.mas_equalTo(-5);
                make.centerY.mas_equalTo(0);
                
            }];
            
        }
        ShopTypeModel *model = self.datasource[indexPath.row];
        cell.textLabel.text = model.cat_name;
        cell.textLabel.font =  TR_Font_Gray(15);
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor grayColor];
        if (indexPath == currentIndexPath) {
            cell.textLabel.font = TR_Font_Cu(15);
            cell.textLabel.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor whiteColor];
            
        }else{
            
            cell.backgroundColor = [UIColor colorWithHexValue:0xFF2F2F2 alpha:1];
        }
        if ([model.cat_name isEqualToString:@"热销"]) {
            cell.imageView.image = [UIImage imageNamed:@"hotsale"];
            cell.imageView.hidden = NO;
            [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(5);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(15, 15));
            }];
        }else{
           cell.imageView.hidden = YES;
        }
        return cell;
    }
    
    if (tableView == _commentScrollView) {
        EvaluateCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (cell3 == nil) {
            cell3 = [[EvaluateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            
            cell3.backgroundColor = [UIColor whiteColor];
            
        }
        
        StoreCommentModel *model = self.commentArray[indexPath.row];
        [cell3 designViewWith:model];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
    return nil;
}



//点击到tableview
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTab) {
        isclick = YES;
        if (indexPath != currentIndexPath) {
            UITableViewCell *cell = [_leftTab cellForRowAtIndexPath:currentIndexPath];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = TR_Font_Gray(15);
            cell.backgroundColor = [UIColor colorWithHexValue:0xFF2F2F2 alpha:1];
            UITableViewCell *cell2 = [_leftTab cellForRowAtIndexPath:indexPath];
            cell2.textLabel.font = TR_Font_Cu(15);
            cell2.backgroundColor = [UIColor whiteColor];
            cell2.textLabel.textColor = [UIColor blackColor];
            currentIndexPath = indexPath;
        }
      
        [self segmentedAction:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
        
    }
}






-(void)clickHeadimageAction:(UITapGestureRecognizer *)sender{
    
    GoodsItemCell *cell = (GoodsItemCell *)[sender view].superview.superview;
    
    NSIndexPath *indexpath = [self.rightCollection indexPathForCell:cell];
    
    if (indexpath) {
        
        if ([self.delegate respondsToSelector:@selector(tableViewSelectIndexpath:WithDatasource:WithDataArray:)]) {
            [self.delegate tableViewSelectIndexpath:indexpath WithDatasource:self.titleDic WithDataArray:self.datasource];
        }
    }
    
    
    
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!self.canScroll && !isclick) {
        [scrollView setContentOffset:CGPointZero];
        
    }
    if (!isclick) {
        NSIndexPath *topindexpath = [_rightCollection indexPathsForVisibleItems].firstObject;
        if (topindexpath.section != currentIndexPath.row) {
            UITableViewCell *cell = [_leftTab cellForRowAtIndexPath:currentIndexPath];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = TR_Font_Gray(15);
            cell.backgroundColor = [UIColor colorWithHexValue:0xFF2F2F2 alpha:1];
            UITableViewCell *cell2 = [_leftTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:topindexpath.section inSection:0]];
            cell2.textLabel.textColor = [UIColor blackColor];
            cell2.textLabel.font = TR_Font_Cu(15);
            cell2.backgroundColor = [UIColor whiteColor];
            currentIndexPath = [NSIndexPath indexPathForRow:topindexpath.section inSection:0];
            [_leftTab scrollToRowAtIndexPath:currentIndexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        }
        
    }
    
    CGFloat offSetY = scrollView.contentOffset.y;
    
    if (offSetY < 0) {
        if ([self.delegate respondsToSelector:@selector(scrollToTopView)]) {
            [self.delegate scrollToTopView];
            [self.leftTab scrollsToTop];
            self.canScroll = NO;
            
        }
        
    }
}


-(void)changescrolltype{
    self.canScroll = YES;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (isclick) {
        isclick = NO;
    }
}


//评论界面

-(UITableView *)commentScrollView{
    if (_commentScrollView == nil) {
        _commentScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _commentScrollView.delegate = self;
        _commentScrollView.dataSource = self;
        _commentScrollView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentScrollView.backgroundColor = [UIColor whiteColor];
        [self addFreshAndGetMoreView];
        
        
    }
    return _commentScrollView;
}

-(void)movebtnHandleSwipes:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:APP_Delegate.window];
    
    if (recognizer.state==UIGestureRecognizerStateChanged) {
        
        if (fabs(translation.y)>20) {
            
            CGRect rect=self.contentView.frame;
            
            rect.origin.y=0;
            
            [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                
                self.contentView.frame=rect;
                
            }completion:^(BOOL finished) {
                
            }];
            
            if (_delegate&&[_delegate respondsToSelector:@selector(taplistMoveScale:)]) {
                
                [_delegate taplistMoveScale:0];
            }
            _moveTopbtn.hidden=YES;
            
        }
    }
    
}

-(void)handleSwipes:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint translation = [recognizer translationInView:APP_Delegate.window];
    
    CGFloat maxMoveHeight=120;
    
    if (recognizer.state==UIGestureRecognizerStateChanged) {
        
        if (translation.y>0&&translation.y<=maxMoveHeight&&self.contentView.frame.origin.y!=self.frame.size.height) {
            
            CGRect rect=self.contentView.frame;
            
            rect.origin.y=translation.y;
            
            [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                
                self.contentView.frame=rect;
                
            }completion:^(BOOL finished) {
                
            }];
            
            if (_delegate&&[_delegate respondsToSelector:@selector(taplistMoveScale:)]) {
                
                [_delegate taplistMoveScale:translation.y/maxMoveHeight];
            }
            
            
        }else{
            
            if (self.contentView.frame.origin.y == 0) {
                
                return;
                
            }
            
            CGRect rect=self.self.contentView.frame;
            
            rect.origin.y=self.frame.size.height;
            
            [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                
                self.contentView.frame=rect;
                
            }completion:^(BOOL finished) {
                
            }];
            
            if (_delegate&&[_delegate respondsToSelector:@selector(taplistMoveScale:)]) {
                
                [_delegate taplistMoveScale:1];
            }
            _moveTopbtn.hidden=NO;
        }
        
    }
    
    if (recognizer.state==UIGestureRecognizerStateEnded||recognizer.state==UIGestureRecognizerStateCancelled) {
        
        if (translation.y>0&&translation.y<=maxMoveHeight&&self.contentView.frame.origin.y!=self.frame.size.height){
            
            CGRect rect=self.contentView.frame;
            
            rect.origin.y=0;
            
            [UIView animateWithDuration:ANIMATIONDURATION animations:^{
                
                self.contentView.frame=rect;
                
            }completion:^(BOOL finished) {
                
            }];
            
            if (_delegate&&[_delegate respondsToSelector:@selector(taplistMoveScale:)]) {
                
                [_delegate taplistMoveScale:0];
            }
            _moveTopbtn.hidden=YES;
            
        }
        
    }
}

- (void) moveTopbtnclick:(UIButton *) button {
    
    CGRect rect=self.contentView.frame;
    
    rect.origin.y=0;
    
    
    _moveTopbtn.hidden=YES;
    
    [UIView animateWithDuration:ANIMATIONDURATION animations:^{
        
        self.contentView.frame=rect;
        if (self->_delegate&&[self->_delegate respondsToSelector:@selector(taplistMoveScale:)]) {
            
            [self->_delegate taplistMoveScale:0];
        }
        
    }completion:^(BOOL finished) {
        
    }];
    
    
    
}

//界面和数据处理

-(void)designWithCommentView{
    
    UIView *tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 320)];
    tableHeadView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArray = @[self.model.delivery_type,@"营业执照",@"餐饮许可证"];
    
    CGFloat btnWidth = 80;
    CGFloat spare = 10;
    
    for (int i = 0; i < 3; i ++) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.backgroundColor = GRAYCLOLOR;
        tempBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        tempBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tempBtn.tag = 3000+ i;
        
        if (i != 0) {
            
            if (self.model.auth_files.count == 0) {
                
                [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
        [tempBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [tableHeadView addSubview:tempBtn];
        [tempBtn addTarget:self action:@selector(clickThreeTips:) forControlEvents:UIControlEventTouchUpInside];
        
        [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(spare / 2 );
            make.size.mas_equalTo(CGSizeMake(btnWidth, 30));
            make.centerX.mas_equalTo((btnWidth + spare) * i - (btnWidth + spare)  );
        }];
        
        
        
        //地址  电话  营业时间
        NSArray *titleArray2 = @[@"营业时间:",@"电话:",@"地址:"];
        
        NSArray *contentArray2 = @[self.model.time,self.model.phone,self.model.adress];
        for (int i = 0; i < contentArray2.count; i ++) {
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.text = titleArray2[i];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.font = TR_Font_Gray(15);
            titleLabel.textColor = [UIColor grayColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            CGSize size = TR_TEXT_SIZE(titleLabel.text, titleLabel.font, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
            [tableHeadView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(2 * spare );
                make.top.mas_equalTo((spare + 30)* i + 40 );
                make.size.mas_equalTo(CGSizeMake(size.width + 10, 40));
            }];
            
          
            UILabel *titleLabel2 = [[UILabel alloc]init];
            titleLabel2.text = contentArray2[i];
            titleLabel2.textAlignment = NSTextAlignmentLeft;
            titleLabel2.font = [UIFont systemFontOfSize:14];
            titleLabel2.numberOfLines = 0;
            titleLabel2.textColor =  [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
            titleLabel2.backgroundColor = [UIColor clearColor];
            [tableHeadView addSubview:titleLabel2];
            [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(titleLabel.mas_right).offset(spare / 2);
                make.centerY.mas_equalTo(titleLabel.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - size.width -40, 40));
            }];
        }
        
    }
    
    //虚线
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = GRAYCLOLOR;
    [tableHeadView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.bottom.mas_equalTo(-150);
    }];
    
    UIView * lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = GRAYCLOLOR;
    [tableHeadView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 50));
        make.top.mas_equalTo(lineView1.mas_bottom).offset(spare);
    }];
    
    
    
    //综合评分
    NSArray *scoreArray= @[self.model.star,@"综合评分"];
    for (int i = 0; i < 2; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = scoreArray[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            titleLabel.font = [UIFont systemFontOfSize:25];
            titleLabel.textColor = ORANGECOLOR;
        }else {
            titleLabel.font = [UIFont systemFontOfSize:14];
        }
        
        titleLabel.backgroundColor = [UIColor clearColor];
        [tableHeadView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(-SCREEN_WIDTH / 4);
            make.top.mas_equalTo(lineView1.mas_bottom).offset((spare + 20)* i + spare);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2, 20));
        }];
    }
    
    //口味 品质
    NSArray *tastArray = @[@"口味",@"品质"];
    NSArray *scoreArray2 = @[self.model.star,self.model.star];
    
    for (int i = 0; i < 2; i ++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = tastArray[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.backgroundColor = [UIColor clearColor];
        [tableHeadView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView2.mas_right).offset(spare);
            make.top.mas_equalTo(lineView1.mas_bottom).offset((spare + 20)* i + spare);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        
        CJTStarView *starView   = [[CJTStarView alloc]initWithFrame:CGRectMake(0, 0, 80 , 15) starCount:5];
        [tableHeadView addSubview:starView];
        [starView setnowStart:[self.model.star doubleValue]];
        [starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right);
            make.centerY.mas_equalTo(titleLabel.mas_centerY);
            make.size.height.mas_equalTo(15);
        }];
        
        
        UILabel *titleLabel2 = [[UILabel alloc]init];
        titleLabel2.textColor = [UIColor blackColor];
        titleLabel2.text = scoreArray2[i];
        
        if (SCREEN_WIDTH < 375) {
            titleLabel2.textAlignment = NSTextAlignmentRight;
        }else {
            titleLabel2.textAlignment = NSTextAlignmentCenter;
        }
        
        titleLabel2.font = [UIFont systemFontOfSize:12];
        titleLabel2.backgroundColor = [UIColor clearColor];
        [tableHeadView addSubview:titleLabel2];
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-spare);
            make.top.mas_equalTo(lineView1.mas_bottom).offset((spare + 20)* i + spare);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    [tableHeadView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(90);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 5));
    }];
    
    
    // 全部  有图  好评  差评
    
    CGFloat widthBtn = (SCREEN_WIDTH - 20* 5) /4;
    NSArray *contentArray = @[[NSString stringWithFormat:@"全部%@",all_count],[NSString stringWithFormat:@"有图%@",pic_count],[NSString stringWithFormat:@"好评%@",good_count],[NSString stringWithFormat:@"差评%@",wrong_count]];
    for (int i = 0; i < 4; i ++) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        tempBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        tempBtn.layer.cornerRadius = 10.0f;
        tempBtn.layer.masksToBounds = YES;
        tempBtn.layer.borderWidth = 1.0f;
        tempBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tempBtn.tag = 1000 + i;
        
        if (tempBtn.tag == btnTag) {
            tempBtn.backgroundColor = ORANGECOLOR;
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        tempBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tempBtn setTitle:contentArray[i] forState:UIControlStateNormal];
        [tableHeadView addSubview:tempBtn];
        [tempBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [tempBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-spare);
            make.size.mas_equalTo(CGSizeMake(widthBtn, 25));
            make.left.mas_equalTo((spare + widthBtn)* i + spare);
        }];
    }
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,10)];
    footView.backgroundColor = [UIColor whiteColor];
    
    self.commentScrollView.tableFooterView = footView;
    
    
    self.commentScrollView.tableHeaderView = tableHeadView;
}



//点击点呗专送 商家资质 等三个

-(void)clickThreeTips:(UIButton *)sender{
    
    NSMutableArray *bannerImageArray = [NSMutableArray array];
    
    if (sender.tag > 3000) {
        for (int i = 0; i < self.model.auth_files.count; i++) {
            UIImageView *imageview = [[UIImageView alloc] init];
            
            NSString *imageUrl = self.model.auth_files[i];
            
            if ([imageUrl isKindOfClass:[NSNull class]]) {
                
                imageUrl = @"";
                
            }
            
            imageview.frame = CGRectMake(0, 0, 100, 100);
            
            [imageview sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
            
            [bannerImageArray addObject:imageview];
        }
        
        if (bannerImageArray.count == 0) {
            
            TR_Message(@"暂无此类照片");
            
            return;
        }
        
        
        
        self.moveTopbtn.hidden = YES;
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        mg.viewController = APP_Delegate.rootViewController.childViewControllers[APP_Delegate.rootViewController.selectedIndex];
        [mg showNetworkPhotoViewer:bannerImageArray urlStrArr:self.model.auth_files selecView:bannerImageArray[sender.tag - 3001]];
    }
    
}


-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex{
    
     self.moveTopbtn.hidden = NO;
}





//点击 全部 有图 好评  差评
-(void)clickAction:(UIButton *)sender {
    if (btnTag != sender.tag) {
        UIButton *tempBtn = [self.commentScrollView.tableHeaderView viewWithTag:btnTag];
        tempBtn.backgroundColor = [UIColor clearColor];
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sender.backgroundColor = ORANGECOLOR;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnTag = sender.tag;
        
        if (btnTag == 1000) {
            
            selectTab = @"";
            
        }else if (btnTag == 1001){
            
            selectTab = @"withpic";
            
        }else if (btnTag == 1002){
            
            selectTab = @"good";
            
        }else if (btnTag == 1003){
            
            selectTab = @"wrong";
        }
        self.page = @(1);
        [self getStoreComment:[self.page stringValue] withCommentType:selectTab];
    }
    
    
}



#pragma mark GoodsItemReusableViewDelegate


-(void)reloadViewData{
    
    [_rightCollection reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
}



#pragma mark GoodsItemCellDelegate
//选择类型

-(void)addFoodType:(NSArray *)typeArray{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(addchoosefoodtype:)]) {
        NSIndexPath *indexpath = typeArray[0];
        NSArray *contentarray = [GoodsListManager shareInstance].goodsListArray[indexpath.section];
        ProductItem *model = contentarray[indexpath.row];
        [self.delegate addchoosefoodtype:@[model,indexpath]];
        
    }
}

//添加数量
-(void)clickCountView:(NSString *)clickType withIndexpath:(NSIndexPath *)indexpath{
    
    NSArray *goodsArray = [GoodsListManager shareInstance].goodsListArray[indexpath.section];
    
    if (goodsArray) {
        
        ProductItem *model = goodsArray[indexpath.row];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(addGoodsToShopAction:)]) {
            NSDictionary *tempDic = @{clickType:model};
            NSArray *tempArray = @[tempDic];
            [self.delegate addGoodsToShopAction:tempArray];
            
            
        }
        
    }
    
}


-(NSMutableArray *)reportAddGoodsCountAction{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < [GoodsListManager shareInstance].goodsListArray.count; i++) {
        
        for (ProductItem *model in [GoodsListManager shareInstance].goodsListArray[i]) {
            if (![model.has_format isEqualToString:@"1"] && [model.selectCount integerValue] > 0) {
                GoodsChooseModel *selectModel = [[GoodsChooseModel alloc]init];
                selectModel.productName = model.product_name;
                selectModel.productId = model.product_id;
                selectModel.goodsPrice = model.o_price;
                selectModel.shopName = self.shop_Name;
                selectModel.shopID = self.shop_ID;
                selectModel.goodsCount = model.selectCount;
                [dataArray addObject:selectModel];
                
            }
            
        }
    }
    
    
    
    return dataArray;
}



-(NSMutableArray *)datasource {
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(NSMutableDictionary *)titleDic{
    if (_titleDic == nil) {
        _titleDic = [NSMutableDictionary dictionary];
    }
    return _titleDic;
}


#pragma mark -  下拉刷新和上拉加载更多
//添加下拉刷新
-(void)addFreshAndGetMoreView
{
    
    
    
    __weak __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.commentScrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=[NSNumber numberWithInt:1];
        
        [_commentArray removeAllObjects];
        TR_Singleton.isRefresh=YES;
        
        [weakSelf getStoreComment:self.page.stringValue withCommentType:@""];
        // 结束刷新
    }];
    
    
    // 上拉刷新
    self.commentScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.commentScrollView.mj_footer.hidden = NO;
        
        self.page=[NSNumber numberWithInteger:[self.page integerValue]+1];
        TR_Singleton.isRefresh=YES;
        
        if ([self.page integerValue] > [total integerValue]) {
            TR_Message(@"没有更多数据了");
            [weakSelf.commentScrollView.mj_footer endRefreshing];
            return ;
        }
        
        [weakSelf getStoreComment:self.page.stringValue withCommentType:@""];
        
    }];
    
    
}


//数据解析
-(void)parseDasourceWith:(NSDictionary *)result{
    [self getStoreComment:@"1" withCommentType:@""];
    
    self.model = [[StoreModel alloc]initWithDictionary:result[@"store"] error:nil];
    NSDictionary *product_list = result[@"product_list"];
    [[GoodsListManager shareInstance].goodsListArray removeAllObjects];
    for (NSDictionary *temp in product_list) {
        
        if (temp) {
            NSMutableArray *tempArray;
            tempArray = [ProductItem arrayOfModelsFromDictionaries:temp[@"product_list1"] error:nil];
            [self.titleDic setObject:tempArray forKey:temp[@"cat_id"]];
            [self.nameDataArray addObject:temp[@"cat_id"]];
            ShopTypeModel *model = [[ShopTypeModel alloc]initWithDictionary:temp error:nil];
            [self.datasource addObject:model];
            [[GoodsListManager shareInstance].goodsListArray addObject:tempArray
             ];
            
        }
    }
    
    [self loadDataSource];
    
}


-(void)loadDataSource{
    
    [[GoodsListManager shareInstance]setGoodsSelectCount:self.shop_ID];
    [self.leftTab reloadData];
    [self.rightCollection reloadData];
    currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
}

//评论界面数据

-(void)parseShopCommentList:(NSDictionary *)result{
    if (result) {
        [self.commentArray addObjectsFromArray:[StoreCommentModel arrayOfModelsFromDictionaries:result[@"list"] error:nil]];
        
        
        all_count = result[@"all_count"];
        good_count =result[@"good_count"];
        wrong_count = result[@"wrong_count"];
        pic_count = result[@"pic_count"];
        total = result[@"total"];
        
        
        [self designWithCommentView];
        [self.commentScrollView reloadData];
    }
}


-(void)getStoreComment:(NSString *)index withCommentType:(NSString *)type{
    
    [HBHttpTool post:SHOP_STORECOMMENT_LIST params:@{@"Device-Id":DeviceID,@"store_id":self.shop_ID,@"page":index,@"tab":type} success:^(id responseObj) {
        if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
            
            if ([self.page integerValue] == 1) {
                [self.commentArray removeAllObjects];
                [self.commentScrollView.mj_header endRefreshing];
                
            }else{
                
                [self.commentScrollView.mj_footer endRefreshing];
            }
            [self parseShopCommentList:responseObj[@"result"]];
            
        }else{
            [self.commentScrollView.mj_header endRefreshing];
            [self.commentScrollView.mj_footer endRefreshing];
            TR_Message(responseObj[@"errorMsg"]);
        }
        [self.commentScrollView.mj_header endRefreshing];
        [self.commentScrollView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
        [self.commentScrollView.mj_header endRefreshing];
        [self.commentScrollView.mj_footer endRefreshing];
    }];
}






// 改变之后的界面修改


#pragma mark uicollection

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *tempArray = [GoodsListManager shareInstance].goodsListArray[section];
    
    if (tempArray) {
        
        return tempArray.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.datasource.count;
}




-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    GoodsItemReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionheader" forIndexPath:indexPath];
    
    if (header == nil) {
        
        header = [[GoodsItemReusableView alloc]init];
    }
    
    ShopTypeModel *model = self.datasource[indexPath.section];
   
    if (model.cat_name) {
        
        header.mytitle = model.cat_name;
        
    }
    
    
    
    //    if (indexPath.section == 0) {
    //
    //        [header shopDiscountListView];
    //
    //        header.delegate = self;
    //
    //    }else{
    //
    //        for (UIView *tempView in header.shopDisView.subviews) {
    //
    //            [tempView removeFromSuperview];
    //
    //        }
    //
    //        [header.shopDisView mas_updateConstraints:^(MASConstraintMaker *make) {
    //
    //            make.height.mas_equalTo(0);
    //        }];
    //
    //        [header layoutIfNeeded];
    //
    //    }
    
    return  header;
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    ShopTypeModel *model = self.datasource[section];
    NSString *title = model.cat_name;
    CGSize size = TR_TEXT_SIZE(title, TR_Font_Cu(15), CGSizeMake(60, 0), nil);
    return CGSizeMake((SCREEN_WIDTH -130) / 2, size.height + 30);
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    if (section != self.datasource.count - 1) {
        
        return CGSizeMake((SCREEN_WIDTH -130) / 2, 0);
        
    }
    
    CGFloat height = IS_RETAINING_SCREEN ? 120:60;
    
    return CGSizeMake((SCREEN_WIDTH -130) / 2, height);
    
}







-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[GoodsItemCell alloc]init];
        cell.backgroundColor = [UIColor redColor];
        
    }
    
    NSArray *tempArray = [GoodsListManager shareInstance].goodsListArray[indexPath.section];
    
    if (tempArray) {
        
        ProductItem *model = tempArray[indexPath.row];
        
        cell.indexpath = indexPath;
        
        cell.delegate = self;
        
        cell.isPlay = YES;
        
        [cell parseDatasourceWithModel:model];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeadimageAction:)];
        [cell.goodImageV addGestureRecognizer:tap];
        
        
    }
    
    return cell;
}



-(void)scrollToAimSection:(NSInteger)is_mandatory{
    
    if (is_mandatory == 0) {
        
        return;
    }
    
    for (ShopTypeModel *model in self.datasource) {
        
        if ([model.cat_id integerValue] == is_mandatory) {
            
            NSInteger section = [self.datasource indexOfObject:model];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                 [self tableView:self.leftTab didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0]];
            });
            return;
        }
    }
}




- (void) segmentedAction:(NSIndexPath *)indexpath {
   
    UICollectionViewLayoutAttributes* attr = [_rightCollection.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexpath];
                     UIEdgeInsets insets = _rightCollection.scrollIndicatorInsets;
                     
                     CGRect rect = attr.frame;
                     rect.size = _rightCollection.frame.size;
                     rect.size.height -= insets.top + insets.bottom;
                     CGFloat offset = (rect.origin.y + rect.size.height) - _rightCollection.contentSize.height;
                     if ( offset > 0.0 ) rect = CGRectOffset(rect, 0, -offset);
                     isclick = YES;
                     [_rightCollection scrollRectToVisible:rect animated:YES];
    
    
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [[touch view] isKindOfClass:[self class]] || [touch view].tag == 3000) {
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
