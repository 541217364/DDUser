//
//  SeachBtn.h
//  送小宝
//
//  Created by xgy on 2017/3/9.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachBtn : UIButton

@property (nonatomic, strong) UILabel *mtitlelabel;

@property (nonatomic, strong) UIImageView *arrowimgview;

- (void) loadDataAdress:(NSString *)str;
@end
