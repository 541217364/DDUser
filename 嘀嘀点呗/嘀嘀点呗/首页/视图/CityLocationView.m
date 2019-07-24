//
//  CityLocationView.m
//  送小宝
//
//  Created by xgy on 2017/4/7.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "CityLocationView.h"
#import "CityLocationCell.h"
#import "CityListModel.h"
#import "BATableView.h"

@interface CityLocationView ()<BATableViewDelegate>

@property (nonatomic, strong) BATableView *mytableView;

@property (nonatomic, strong) NSArray *cityListArry;

@property (nonatomic, strong) UILabel *citylabel;

@property (nonatomic, strong) NSArray *letterNsArray;

@property (nonatomic, strong) NSMutableDictionary *dataDict;

@end


@implementation CityLocationView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        _letterNsArray=[NSMutableArray array];
        
        UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,50)];

        whiteView.backgroundColor=[UIColor whiteColor];
        
       // [self addSubview:whiteView];
        
        UIImage *img=[UIImage imageNamed:@"location_pic"];
        
        UIImageView *locationimgview=[[UIImageView alloc]initWithFrame:CGRectMake(10,12,img.size.width,img.size.height)];
      
        locationimgview.image=img;
        
      //  [whiteView addSubview:locationimgview];
        
        _citylabel=[[UILabel alloc]initWithFrame:CGRectMake(locationimgview.frame.origin.x+locationimgview.frame.size.width+5,8,60,30)];
        _citylabel.adjustsFontSizeToFitWidth=YES;
        [whiteView addSubview:_citylabel];
        
        UILabel *currentlocationlabel=[[UILabel alloc]initWithFrame:CGRectMake(_citylabel.frame.origin.x+_citylabel.frame.size.width,8,130,30)];
        currentlocationlabel.text=@"当前定位城市";
        currentlocationlabel.textColor=TR_COLOR_RGBACOLOR_A(149,150,151,1);
        [whiteView addSubview:currentlocationlabel];
        
        
        _mytableView=[[BATableView alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(frame),CGRectGetHeight(frame))];
        _mytableView.delegate = self;
        _mytableView.tableView.showsVerticalScrollIndicator = NO;
        _mytableView.tableView.showsHorizontalScrollIndicator = NO;
        _mytableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_mytableView];
        
        [self loadCity];
    }
    
    return self;
    
}

- (void)loadCity {
    
    NSString* cityPlistPath = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"];
    
    //按照拼写排序,spell是英文拼写
    NSArray *cities=[NSArray arrayWithContentsOfFile:cityPlistPath];
    _cityListArry=[CityListModel arrayOfModelsFromDictionaries:cities];
    
    [self loadSettitleLetter];
    
    [_mytableView reloadData];
}


- (void)setCitystr:(NSString *)citystr {

    _citystr=citystr;
    
    _citylabel.text=citystr;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return _letterNsArray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerV.backgroundColor = GRAYCLOLOR;
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH - 20, 20)];
    [headerV addSubview:titleLable];
    NSString *letterStr=_letterNsArray[section];
    titleLable.text=letterStr;
    return headerV;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_letterNsArray&&_letterNsArray.count!=0) {
        
        NSString *letterStr=_letterNsArray[section];
        
        NSArray *arr=[_dataDict  objectForKey:letterStr];
        
        return arr.count;
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * cellName = @"UITableViewCell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CityLocationCell *city_cell=[[CityLocationCell alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,40)];
            [city_cell addTarget:self action:@selector(cityNameButton:) forControlEvents:UIControlEventTouchUpInside];

            city_cell.letterlabel.hidden=YES;
            city_cell.tag=2000;
            [cell addSubview:city_cell];
            
        }
    
    CityLocationCell *city_cell=(CityLocationCell *)[cell viewWithTag:2000];
    
    if (_letterNsArray&&_letterNsArray.count!=0) {
        
        NSString *letterStr=_letterNsArray[indexPath.section];
        
        NSArray *arr=[_dataDict  objectForKey:letterStr];
        
        CityListModel *model=arr[indexPath.row];
        
        city_cell.citylabel.text=model.city;

    }

    return cell;
}



#pragma mark - BATableViewDelegate

- (NSArray *)sectionIndexTitlesForABELTableView:(BATableView *)tableView
{
    
    return  _letterNsArray;
}



- (void) loadSettitleLetter {
    
    
    _dataDict=[NSMutableDictionary dictionary];

    for (int i=0;i<_cityListArry.count; i++) {
        
        CityListModel *model=_cityListArry[i];
        
        NSString *str=[self firstCharactor:model.city];
        
        NSMutableArray *arr=[_dataDict objectForKey:str];
        
        if (arr) {
            
            [arr  addObject:model];
            
        }else {
            
            arr=[NSMutableArray array];
            
            [arr addObject:model];
            
        }
        [_dataDict setObject:arr forKey:str];

    }
    
    _letterNsArray=[[_dataDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    

}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)firstCharactor:(NSString *)aString
{
    if (!aString) {
        return @"";
    }
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}



- (void)cityNameButton:(CityLocationCell *)button {

    _citylabel.text= [NSString stringWithFormat:@"%@",button.citylabel.text] ;
    
    _addcityNameBlock(_citylabel.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
