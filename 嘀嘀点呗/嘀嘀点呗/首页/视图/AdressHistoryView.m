//
//  AdressHistoryView.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "AdressHistoryView.h"
#import "HistoryAdressModel.h"


@interface AdressHistoryView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mytableView;

@property (nonatomic, strong) NSMutableArray *historyData;

@end


@implementation AdressHistoryView

- (instancetype)initWithFrame:(CGRect)frame {
    
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
        
    }
    return self;
}


- (void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr=dataArr;
  
    [_mytableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_seachStr.length!=0&&_dataArr.count!=0) {
        return 80;
    }else
        return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_seachStr.length!=0&&_dataArr.count!=0) {
        
        return 0;
    
    }else
        return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *withite=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,30)];
    
    withite.backgroundColor=TR_COLOR_RGBACOLOR_A(246,246,246,1);
    
    UIImageView *pic_imgview=[[UIImageView alloc]init];
    pic_imgview.frame=CGRectMake(15,10,10,10);
    
    [withite addSubview:pic_imgview];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(40,5,SCREEN_WIDTH-40,20)];
    title.font=[UIFont systemFontOfSize:15];
    title.textAlignment=NSTextAlignmentLeft;
    title.textColor=TR_TEXTGrayCOLOR;
    
    UIButton *deletebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [deletebtn setImage:[UIImage imageNamed:@"histroydelete_pic"] forState:UIControlStateNormal];
    
    [withite addSubview:deletebtn];
    
    
    [withite addSubview:title];
    
    title.text=@"历史";
    pic_imgview.image=[UIImage imageNamed:@"histroy_pic"];
   
    return withite;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  
        return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    
    if (_seachStr.length!=0&&_dataArr.count!=0) {
        
        return _dataArr.count;
    }else
        return self.historyData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_seachStr.length!=0&&_dataArr.count!=0){
        NSString * cellName = @"UITableViewCell";
        
        UITableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell1) {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,69,SCREEN_WIDTH,1)];
            line.backgroundColor=TR_COLOR_RGBACOLOR_A(233,233,233,1);
            [cell1 addSubview:line];
            
            UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(10,10,SCREEN_WIDTH-20,20)];
            namelabel.textAlignment=NSTextAlignmentLeft;
            namelabel.textColor=TR_COLOR_RGBACOLOR_A(40,40,40,1);
            namelabel.tag=2000;
            [cell1 addSubview:namelabel];
            
            UILabel *adresslabel=[[UILabel alloc]initWithFrame:CGRectMake(10,namelabel.frame.origin.y+namelabel.frame.size.height+5,SCREEN_WIDTH-20,20)];
            adresslabel.textAlignment=NSTextAlignmentLeft;
            adresslabel.textColor=TR_COLOR_RGBACOLOR_A(152,152,152,1);
            adresslabel.font=[UIFont systemFontOfSize:14];
            adresslabel.tag=2001;
            [cell1 addSubview:adresslabel];
            
        }
        
        UILabel *namelabel=[cell1 viewWithTag:2000];
        UILabel *adresslabel=[cell1 viewWithTag:2001];
        
        if (_dataArr&&_dataArr.count!=0) {
            
            BMKPoiInfo *info=_dataArr[indexPath.row];
            
            NSDictionary *attribs = @{
                                      NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(40,40,40,1),
                                      NSFontAttributeName:namelabel.font
                                      };
            
            
            NSMutableAttributedString *attributedText =
            [[NSMutableAttributedString alloc] initWithString:info.name
                                                   attributes:attribs];
            
            NSRange bgTextRange =[info.name rangeOfString:_seachStr options:NSCaseInsensitiveSearch];
            
            [attributedText setAttributes:@{NSForegroundColorAttributeName:TR_COLOR_RGBACOLOR_A(252,122,46,1),NSFontAttributeName:namelabel.font} range:bgTextRange];
            
            namelabel.attributedText=attributedText;
            
            adresslabel.text=info.address;
            
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
            
            UILabel *mtitlelabel=[[UILabel alloc]initWithFrame:CGRectMake(40,15,SCREEN_WIDTH-50,20)];
            
            mtitlelabel.textAlignment=NSTextAlignmentLeft;
            mtitlelabel.tag=1000;
            [cell1 addSubview:mtitlelabel];
            
        }
        
        UILabel *t_label=[cell1 viewWithTag:1000];
        
        if (self.historyData&&self.historyData.count!=0) {
            
            t_label.text=self.historyData[indexPath.row];
            
        }
        
        return cell1;
        
    }
    
    
        
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (_dataArr.count!=0) {
        
        if (_delegate&&[_delegate respondsToSelector:@selector(adressHistory:andPoint:)]) {
            
            [self setHistoryData];

            BMKPoiInfo *info=_dataArr[indexPath.row];
            
            [_delegate adressHistory:self andPoint:info];
        }
        
    }else{
        
        if (_delegate&&[_delegate respondsToSelector:@selector(adressHistory:andSeachstr:)]) {
            
            NSString *seachstr=_historyData[indexPath.row];
            
            [_delegate adressHistory:self andSeachstr:seachstr];
        }
    }
}

- (void)gethistoryData {
    
    NSArray *data= [USERDEFAULTS objectForKey:@"AdressData"];
    
    if (data.count!=0) {
        
        _historyData=[NSMutableArray arrayWithArray:data];
    }else{
        
        if (_historyData) {
            
            [_historyData removeAllObjects];
        }
        
    }
    
}


-(NSMutableArray *)historyData {
    
    [self gethistoryData];
    
    return _historyData;
}

- (void)setHistoryData {
    
  NSArray *data=  [USERDEFAULTS objectForKey:@"AdressData"];
    
    if (data&&data.count!=0) {
        
        NSMutableArray *mdata=[NSMutableArray arrayWithArray:data];
        
        if ([mdata containsObject:_seachStr]) {
            
            [mdata removeObject:_seachStr];
      
        }else{
            if (mdata.count==10) {
                
                [mdata removeObjectAtIndex:0];
            }else
                [mdata addObject:_seachStr];
            
        }
        [USERDEFAULTS setObject:mdata forKey:@"AdressData"];
        
    }else{
        
        NSMutableArray *mdata=[NSMutableArray array];
        
        [mdata addObject:_seachStr];
    
        [USERDEFAULTS setObject:mdata forKey:@"AdressData"];

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
