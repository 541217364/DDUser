//
//  PersonalView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/12.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionItemCell.h"
#import "MyCollectionHeadView.h"

@protocol MyCollectionSelectDelegate<NSObject>

-(void)MyCollectionVIewDidSeletedWith:(NSIndexPath *)indexpath WithDatasource:(NSDictionary *)datasource WithTitleArray:(NSArray *)titleArray;


-(void)SelectTopThreeItemWith:(NSString *)titleIndex andStringNumber:(NSString *)strnumber;

-(void)jumpToPersonalMessageView:(NSString *)aimVC;

@end


@interface PersonalView : UIView<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UIImageView *personImage; // 存储用户头像

@property(nonatomic,strong)UITableView *mytableview;

@property(nonatomic,strong)UICollectionView *mycollection;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UIImageView *loginView;

@property(nonatomic,strong)UIView *menuView;

@property(nonatomic,assign)id <MyCollectionSelectDelegate>delegate;

-(void)startNetworkingWithUrl;

@end
