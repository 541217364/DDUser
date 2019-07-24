//
//  TasteNotesView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/10.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseDescriptionDelegate<NSObject>


-(void)chooseDescriptionSuccess:(NSString *)chooseTime;

@end



@interface TasteNotesView : UIView<UITextViewDelegate>

@property(nonatomic,strong)UITextView *mytextView;

@property(nonatomic,strong)UIView *countView;

@property(nonatomic,assign)id<ChooseDescriptionDelegate>delegate;

@property(nonatomic,strong)NSMutableSet *myset;

@property(nonatomic,strong)UILabel *numlabel;

@property(nonatomic) int count;


-(void)designViewWith:(NSDictionary *)contentDic;


@end
