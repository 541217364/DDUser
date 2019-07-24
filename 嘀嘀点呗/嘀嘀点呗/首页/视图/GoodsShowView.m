//
//  GoodsShowView.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/2.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "GoodsShowView.h"
#import "StoreGoodsCell.h"
#import "StoreInfo.h"

@interface GoodsShowView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@end


@implementation GoodsShowView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        
       // [self loadGoodsPics:@[@"xx",@"xx",@"xx"] withData:nil];
    }
    
    return self;
}


- (void) loadGoodsPics:(NSArray *)pics  withData:(NSArray *)dataArray{
    
    _dataArr=dataArray;
    
    CGFloat pic_width= (SCREEN_WIDTH -40)/3;
    
    NSInteger intnum=pics.count<=3?pics.count:3;
    
    for (int i=0; i<intnum; i++) {
        
        UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(10*(i+1)+pic_width*i,10,pic_width,pic_width)];
        
        [imgview sd_setImageWithURL:[NSURL URLWithString:pics[i]]];
        
        [self addSubview:imgview];
    }

    if (!_mytableView) {
        
        _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0,pic_width+20,self.frame.size.width,self.frame.size.height-50)];
        
        _mytableView.delegate=self;
       
        _mytableView.bounces=NO;
        
        _mytableView.dataSource=self;
    
        [self addSubview:_mytableView];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return  120;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backgView=[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,30)];
    
    backgView.backgroundColor=[UIColor whiteColor];
    
    UIView *colorview=[[UIView alloc]initWithFrame:CGRectMake(10,0,5,30)];
    colorview.layer.cornerRadius=3;
    colorview.layer.masksToBounds=YES;
    colorview.backgroundColor=TR_COLOR_RGBACOLOR_A(221,93,43,1);
    
    [backgView addSubview:colorview];
    
    UILabel *textlabel=[[UILabel alloc]initWithFrame:CGRectMake(20,0,SCREEN_WIDTH-15,30)];
    
    textlabel.backgroundColor=[UIColor whiteColor];
    
    textlabel.textAlignment=NSTextAlignmentLeft;
    textlabel.text=@"推荐";
    [backgView addSubview:textlabel];
    
    if (_dataArr&&_dataArr.count!=0) {
        
        StoreProductItem *item=_dataArr[section];
        
        textlabel.text=item.cat_name;
    }
    
    return backgView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArr&&_dataArr.count!=0) {
        
        StoreProductItem *item=_dataArr[section];
        
        return item.product_list.count;
        
    }else{
        
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    StoreGoodsCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell=[[StoreGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
      
        cell.backgroundColor=[UIColor whiteColor];
        
    }
    
    
    if (_dataArr&&_dataArr.count!=0) {
        
        StoreProductItem *sitem=_dataArr[indexPath.section];
        
        ProductItem *item=sitem.product_list[indexPath.row];
        
        [cell.goodPic sd_setImageWithURL:[NSURL URLWithString:item.product_image]];
        
        cell.goodnamelabel.text=item.product_name;
        
        cell.salelabel.text=[NSString stringWithFormat:@"销售%@%@",item.product_sale,item.unit];
        
        cell.pricelabel.text=[NSString stringWithFormat:@"¥%@",item.o_price];
        
        
        
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y==0) {
        
        scrollView.scrollEnabled=NO;
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
