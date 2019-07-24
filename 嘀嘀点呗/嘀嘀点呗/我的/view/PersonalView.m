//
//  PersonalView.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/12.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "PersonalView.h"
#import "PersonUserModel.h"
#define SpareWidth 10

#define ViewHeight  (IS_RETAINING_SCREEN ? 250 : 230)

#define LoginViewHeight 150

#define imageViewWidth 60

#define ImageWidth ([UIScreen mainScreen].bounds.size.width - 5 * SpareWidth) / 4


@implementation PersonalView
{
    
    NSArray *titlearray;
    NSArray *menuarray;
    BOOL  iscamera;
    NSDictionary *contentDic;
    NSArray *contentArray;
    NSDictionary *imageDic;
}

-(UIImageView *)personImage{
    if (_personImage == nil) {
        _personImage = [[UIImageView alloc]init];
        _personImage.backgroundColor = [UIColor whiteColor];
        _personImage.layer.cornerRadius = imageViewWidth / 2;
        _personImage.layer.masksToBounds = YES;
        _personImage.image = [UIImage imageNamed:@"personal-user"];
    }
    return _personImage;
}


//布局
-(instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
      self.backgroundColor =  [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startNetworkingWithUrl) name:@"UpDtataUserMessage" object:nil];
     //登录注册
        self.loginView = [[UIImageView alloc]init];
        self.loginView.backgroundColor = TR_COLOR_RGBACOLOR_A(255, 239, 216, 1) ;
        self.loginView.userInteractionEnabled = YES;
        [self addSubview:self.loginView];
        [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, ViewHeight));
        }];
        
        UIView *hideContentView = [[UIView alloc]init];
        hideContentView.alpha = 0.2;
        hideContentView.backgroundColor = [UIColor blackColor];
        [self.loginView addSubview:hideContentView];
        [hideContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, ViewHeight));
        }];
        
        
        
        
        
        
        //设置按钮
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        settingBtn.backgroundColor = [UIColor clearColor];
        [settingBtn setImage:[UIImage imageNamed:@"my_setting"] forState:UIControlStateNormal];
        [self addSubview:settingBtn];
        [settingBtn addTarget:self action:@selector(jumpToAimVC:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat height = IS_RETAINING_SCREEN ? 0:5;
        [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- SpareWidth);
            make.top.mas_equalTo(STATUS_BAR_HEIGHT + height);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        
        //菜单选择
        self.menuView = [[UIView alloc]init];
        self.menuView.backgroundColor = [UIColor whiteColor];
        self.menuView.layer.cornerRadius = 5.0f;
        self.menuView.layer.masksToBounds = YES;
        float widthS = 70;
        float spareW = (SCREEN_WIDTH - widthS * 3) / 4;
        [self addSubview:_menuView];
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SpareWidth);
            make.bottom.mas_equalTo(weakSelf.loginView.mas_bottom).offset(-SpareWidth / 2);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, LoginViewHeight));
        }];
        
        
        [self addSubview:self.personImage];
        
        [self.personImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(weakSelf.menuView.mas_top).offset(imageViewWidth / 2);
            make.size.mas_equalTo(CGSizeMake(imageViewWidth, imageViewWidth));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosephotoimage)];
        self.personImage.userInteractionEnabled = YES;
        [self.personImage addGestureRecognizer:tap];

        
        
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.loginBtn.titleLabel.font = TR_Font_Gray(17);
        self.loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_menuView addSubview:self.loginBtn];
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(weakSelf.personImage.mas_centerY).offset(imageViewWidth / 2 +  2 * SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2 * SpareWidth, 20));
        }];
        
       
        
    
        menuarray = @[@"收藏",@"代金券",@"红包"];
        for (int i = 0 ; i < menuarray.count ; i ++ ) {
            
            UILabel *countLable = [[UILabel alloc]init];
            countLable.textAlignment = NSTextAlignmentCenter;
            countLable.font = TR_Font_Gray(15);
            countLable.textColor = [UIColor grayColor];
            countLable.text = @"0";
            countLable.tag = 1000+i;
            [_menuView addSubview:countLable];
            [countLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo((widthS + spareW) * i - widthS - spareW);
                make.top.mas_equalTo(90);
                make.size.mas_equalTo(CGSizeMake(widthS, 30));
            }];
            UILabel *label1 = [[UILabel alloc]init];
            label1.text = menuarray[i];
            label1.font = TR_Font_Gray(15);
            label1.textColor = [UIColor grayColor];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.userInteractionEnabled = YES;
            [_menuView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo((widthS + spareW) * i - widthS - spareW);
                make.top.mas_equalTo(120);
                make.size.mas_equalTo(CGSizeMake(widthS, 20));
            }];
            
            UIView *hideView = [[UIView alloc]init];
            hideView.tag = 2000+ i;
            hideView.backgroundColor = [UIColor clearColor];
            [_menuView addSubview:hideView];
            [hideView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(countLable.mas_left);
                make.top.mas_equalTo(countLable.mas_top);
                make.right.mas_equalTo(countLable.mas_right);
                make.bottom.mas_equalTo(label1.mas_bottom);
            }];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlemenuaction:)];
            [hideView addGestureRecognizer:tap];
        }
        
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init]; //UICollectionViewFlowLayout是UICollectionViewLayout的一种具体的子类布局，实现的是九宫格的布局样式。
        self.mycollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -0  , SCREEN_WIDTH,SCREEN_HEIGHT) collectionViewLayout:layout];
        //修改集合视图的背景颜色
        self.mycollection.backgroundColor = [UIColor whiteColor];
        //1:设置每一个cell的宽度
        layout.itemSize = CGSizeMake(ImageWidth, 80);
        //2:设置每一个分区的显示范围
        layout.sectionInset = UIEdgeInsetsMake(SpareWidth, SpareWidth, SpareWidth, SpareWidth);
        //3:设置cell之间的间距
        layout.minimumLineSpacing = SpareWidth;
        layout.minimumInteritemSpacing = SpareWidth;
        //4:设置集合视图每一个分区区头的尺寸
        layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
        //设置集合视图的代理人
        self.mycollection.dataSource = self;
        self.mycollection.delegate = self;
        //添加集合视图对象
        [self addSubview:self.mycollection];
        // Do any additional setup after loading the view.
        [self.mycollection registerClass:[MyCollectionItemCell class] forCellWithReuseIdentifier:@"cell"];
        [self.mycollection registerClass:[MyCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.mycollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.menuView.mas_bottom).offset(SpareWidth);
        make.bottom.mas_equalTo(-TabbarHeight - SpareWidth);
        make.right.mas_equalTo(0);
                }];
        
        //构造一份数据
        contentDic = @{@"常用":@[@"我的评价",@"我的地址"],@"推荐":@[@"分享有礼",@"商家入驻",@"骑手招募",@"城市加盟",@"在线客服"]};
        contentArray = @[@"常用",@"推荐"];
        
        imageDic = @{@"常用":@[@"my_dis",@"my_location"],@"推荐":@[@"my_tuijian",@"my_shop",@"my_rider",@"my_jiameng",@"my_kefu"]};
        
        
//       客服电话
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        logoutBtn.backgroundColor = [UIColor whiteColor];
        [logoutBtn setTitle:@"客服:   4000-793-111" forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        logoutBtn.titleLabel.font = TR_Font_Gray(15);
        [self addSubview:logoutBtn];
        [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-TabbarHeight - SpareWidth);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 10));
        }];
        
    }
    return self;
}


//tableview 协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.mytableview.bounds.size.height / 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.mytableview dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = titlearray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor blackColor];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.backgroundColor = [UIColor whiteColor];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    Btn.tag = 101 + indexPath.row;
    [Btn addTarget:self action:@selector(Interfacejump:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == 2) {
        [Btn setTitle:@"0MB" forState:UIControlStateNormal];
    }else if (indexPath.row == 3) {
        [Btn setTitle:@"已绑定" forState:UIControlStateNormal];
    }else {
         [Btn setImage:[UIImage imageNamed:@"下拉 拷贝 2"] forState:UIControlStateNormal];
    }
 
    [cell.contentView addSubview:Btn];
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-SpareWidth);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = GRAYCLOLOR;
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.textLabel.mas_left);
        make.bottom.mas_equalTo(-1);
        make.right.mas_equalTo(Btn.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"JumoToLoginViewController" object:titlearray[indexPath.row]];
}






//collectionview 协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
     NSString *title = contentArray[section];
    NSArray *tempArray =[contentDic valueForKey:title];
    return tempArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [contentDic allKeys].count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionItemCell *cell = [self.mycollection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyCollectionItemCell alloc]init];
       
    }
    NSString *title = contentArray[indexPath.section];
    NSString *imageurl = imageDic[title][indexPath.row];
    [cell designCellWithTitle:contentDic[title][indexPath.row] WithImagePath:imageurl];
    
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        MyCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header designViewWithTitle:contentArray[indexPath.section]];
        return header;
    }
    return nil;
    
}

//点击每一个cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(MyCollectionVIewDidSeletedWith:WithDatasource:WithTitleArray:)]) {
        [self.delegate MyCollectionVIewDidSeletedWith:indexPath WithDatasource:contentDic WithTitleArray:contentArray];
    }
}



//点击上面三个标签
-(void)handlemenuaction:(UIGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(SelectTopThreeItemWith:andStringNumber:)]) {
        
        UILabel *label= [sender.view.superview viewWithTag:sender.view.tag-1000];
        
        [self.delegate SelectTopThreeItemWith:menuarray[sender.view.tag - 2000] andStringNumber:label.text];
    }
    
}

//跳转界面
-(void)jumptologinview {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"JumoToLoginViewController" object:@"登录"];
   
}
-(void)Interfacejump:(UIButton *)sender {
    NSLog(@"%@",titlearray[sender.tag - 101]);
}


-(void)jumpToAimVC:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(jumpToPersonalMessageView:)]) {
        [self.delegate jumpToPersonalMessageView:@"PersonalSettingVC"];
    }
}



//跳转用户信息界面
-(void)choosephotoimage {
    
    if ([self.delegate respondsToSelector:@selector(jumpToPersonalMessageView:)]) {
        [self.delegate jumpToPersonalMessageView:@"PersonalMessageVC"];
    }
    
    
}





-(void)startNetworkingWithUrl{

    
    if (GetUser_Login_State) {
        //获取用户登录状态 已经登录过的 获取用户信息
        
         __weak typeof(self) weakSelf = self;
        
        NSDictionary *body = @{@"ticket":[Singleton shareInstance].userInfo.ticket,@"Device-Id":DeviceID};
        
        [HBHttpTool post:PERSONAL_MESSAGE params:body success:^(id responseObj) {
            
            if ([responseObj[@"errorMsg"] isEqualToString:@"success"]) {
                
                [weakSelf loadDatasourceToView:responseObj[@"result"]];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        
        self.personImage.image = [UIImage imageNamed:@"personal-user"];
        [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        
    }
    
    
    
}


-(void)loadDatasourceToView:(NSDictionary *)result{
    
    if (result) {
        PersonUserModel *model = [[PersonUserModel alloc]initWithDictionary:result error:nil];
       
        if (model.avatar.length > 0) {

            [self.loginView sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].userInfo.avatar]];
            UIVisualEffectView *effectview = [self.loginView viewWithTag:10000];
            if (!effectview) {
                UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
                effectview.tag = 10000;
                effectview.alpha = 0.7;
                effectview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
                [self.loginView addSubview:effectview];
            }
            
           
            
             [self.personImage sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"personal-user"]];
            
        }else{
            
            [self.personImage sd_setImageWithURL:[NSURL URLWithString:[Singleton shareInstance].userInfo.avatar] placeholderImage:[UIImage imageNamed:@"personal-user"]];
        }
        
     
        if (model.nickname.length > 0) {
            
            [self.loginBtn setTitle:model.nickname forState:UIControlStateNormal];
            
        }else if (model.phone.length > 0){
            
             [self.loginBtn setTitle:model.phone forState:UIControlStateNormal];
            
        }else if ([Singleton shareInstance].userInfo.nickname.length > 0){
            
            [self.loginBtn setTitle:[Singleton shareInstance].userInfo.nickname forState:UIControlStateNormal];
        }else{
             [self.loginBtn setTitle:@"" forState:UIControlStateNormal];
        }
        
    

        

        
       
        NSArray  * countArray = @[model.collection,model.cash_coupon,model.coupon];
        
        for (int i = 0; i < 3; i++) {
            
            UILabel *tempL = [_menuView viewWithTag:1000+ i];
            tempL.text = countArray[i];
        }
        
        
    }

}










// 协议
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取用户选择照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.personImage.image = image;
    //把Modal出来的imagePickerController弹出
    
    // 从info中将图片取出，并加载到imageView当中
    // 创建保存图像时需要传入的选择器对象（回调方法格式固定）
    if (iscamera) {
        //如果是拍照的话保存图片
        SEL selectorToCall = @selector(image:didFinishSavingWithError:contextInfo:);
        // 将图像保存到相册（第三个参数需要传入上面格式的选择器对象）
        UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
    }
   [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    // 在此处理图片
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", error);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
