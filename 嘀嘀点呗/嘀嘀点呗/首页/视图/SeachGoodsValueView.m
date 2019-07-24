//
//  SeachGoodsValueView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/18.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "SeachGoodsValueView.h"

@interface SeachGoodsValueView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *mytableView;

@property (nonatomic, strong) NSArray *historyValues;

@property (nonatomic, strong) NSArray *hotValues;

@end

@implementation SeachGoodsValueView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, frame.size.height) style:UITableViewStylePlain];
        _mytableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _mytableView.sectionIndexColor = [UIColor grayColor];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.showsVerticalScrollIndicator = NO;
        _mytableView.showsHorizontalScrollIndicator = NO;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
        
        [self addSubview:_mytableView];
     
        [self loadHotData];
        
        [self getHistoryData];
    }
    
    return self;
}


- (void) loadHotData {
    
    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    NSString *ticket = [Singleton shareInstance].userInfo.ticket.length > 0 ? [Singleton shareInstance].userInfo.ticket :@"";
    
    
    [HBHttpTool post:SHOP_HOTVALUES params:@{@"Device-Id":DeviceID,@"ticket":ticket,@"user_long":lng,@"user_lat":lat} success:^(id responseDic){
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSArray *dataarr=[dataDict objectForKey:@"result"];
                
                self.hotValues=dataarr;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.mytableView reloadData];
                });
                
            }
        }
        
    }failure:^(NSError *error){
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.section==0) {
        NSInteger num=_hotValues.count%3==0?_hotValues.count/3:_hotValues.count/3+1;
        
        CGFloat height=num*45+20;
        
        return height;
    }else
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
  
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *withite=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,30)];
    
    withite.backgroundColor=[UIColor whiteColor];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10,5,SCREEN_WIDTH-40,20)];
    title.font=[UIFont boldSystemFontOfSize:15];
    title.textAlignment=NSTextAlignmentLeft;
    title.textColor=TR_COLOR_RGBACOLOR_A(47,47,47,1);
    [withite addSubview:title];
    if (section==0) {
        title.text=@"热门搜索";

    }else
        title.text=@"搜索历史";
    
    if (section==1) {
        
        UIButton *clearbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        clearbtn.frame=CGRectMake(SCREEN_WIDTH-30,0,20,30);
        [clearbtn setImage:[UIImage imageNamed:@"seach_clearpic"] forState:UIControlStateNormal];
        [clearbtn addTarget:self action:@selector(clearbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [withite addSubview:clearbtn];
    }
    
    
    return withite;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        
       return 1;
        
    }else
       return _historyValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0){
        
        NSString * cellName = @"UITableViewCell";
        
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell1) {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
//            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,69,SCREEN_WIDTH,1)];
//            line.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
//            [cell1 addSubview:line];
            
        }
        
        if (_hotValues&&_hotValues.count!=0) {
            
            [self loadHotData:_hotValues intsetView:cell1];
        }
        return cell1;
        
    }else{
        
        NSString * cellName = @"UITableViewCell1";
        
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
      
        if (!cell1) {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,49,SCREEN_WIDTH,1)];
            line.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
            [cell1 addSubview:line];
            
        }
        
        if (_historyValues&&_historyValues.count!=0) {
            
            NSString *str=_historyValues[indexPath.row];
            
            cell1.textLabel.text=str;
            cell1.textLabel.textColor=TR_COLOR_RGBACOLOR_A(28,28,28,1);
            
        }
        
        return cell1;
        
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1&&_historyValues.count!=0) {
        
        NSString  *value= _historyValues[indexPath.row];
        
        _selectValueBlock(value);
        
    }
}





- (void)getHistoryData {
    
    NSArray *data= [USERDEFAULTS objectForKey:@"seachValues"];
    
    if (data&&data.count!=0) {
        
        _historyValues=data;
        
        [_mytableView reloadData];
    }
}

- (void)loadHotData:(NSArray *)hotdata intsetView:(UIView *)view{
    
    for (UIView *view2 in view.subviews) {
        if (view2.tag/1000==2) {
            [view2 removeFromSuperview];
        }
    }
    
    CGFloat btnwidth=90;
    
    CGFloat interval=(SCREEN_WIDTH-3*btnwidth)/4;
    
    NSInteger j=hotdata.count%3==0?hotdata.count/3:hotdata.count/3+1;
    
    for (int y=0;y< j; y++) {
        
        for (int x=0; x<3; x++) {
            
            if ((x+y*3)<hotdata.count) {
               
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
              
                btn.frame=CGRectMake(x*(interval+btnwidth)+interval,10+45*y,btnwidth,35);
                
                btn.tag=2000+x+y*3;
                
                [view addSubview:btn];
                
                NSString *value=hotdata[x+y*3];
                
                [btn setTitle:value forState:UIControlStateNormal];
                btn.titleLabel.font=[UIFont systemFontOfSize:14];
                [btn addTarget:self action:@selector(menubtnclick:) forControlEvents:UIControlEventTouchUpInside];
                
//                if ((x+y*3)==0) {
//
//                    btn.backgroundColor=TR_COLOR_RGBACOLOR_A(253,236,225,1);
//                    [btn setTitleColor:TR_COLOR_RGBACOLOR_A(252,122,46,1) forState:UIControlStateNormal];
//                }else{
//
                    btn.backgroundColor=TR_COLOR_RGBACOLOR_A(246,246,246,1);
                    [btn setTitleColor:TR_COLOR_RGBACOLOR_A(28,28,28,1) forState:UIControlStateNormal];
               // }
            }
        }
    }

}

- (void)clearbtnclick:(UIButton *) button {
    
     [USERDEFAULTS setObject:@[] forKey:@"seachValues"];
    
    _historyValues=nil;
    
    [_mytableView reloadData];
    
}


- (void)  menubtnclick:(UIButton *) button {
    
    NSString *str=button.titleLabel.text;
    
    _selectValueBlock(str);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
