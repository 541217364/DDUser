//
//  EZTSelectView.m
//  EZTUser
//
//  Created by eztios on 15/5/26.
//  Copyright (c) 2015年 huanghongbo. All rights reserved.
//

#import "EZTSelectView.h"
//#import "TouchTableView.h"
#import "MJRefresh.h"
//#import "EZT_db.h"

@interface EZTSelectView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UITableView *tableView1;

@property(nonatomic,strong) NSMutableArray * mArray;

@property(nonatomic,strong) NSMutableArray * mArray1;

@property(nonatomic,strong) NSMutableArray * spareArray;

//@property(nonatomic,strong) DoctorPoolInfo *doctorPoolInfo;

@end

@implementation EZTSelectView
- (id)initWithFrame:(CGRect)frame withData:(NSArray *)data{
    self =[super initWithFrame:frame withData:data];
    self.isBackBtn = YES;
    
    if (self.superData.count) {
        _mArray = self.superData[0];
        if (self.superData.count>1)
            _spareArray = self.superData[1];
    }
    
    if (self.superType<10) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.superY, SCREEN_WIDTH, SCREEN_HEIGHT-self.superY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:_tableView];
        
        if (self.superType==5){
            self.titleName = @"离我最近的医院";
            [self getNearHosList];
        }else
            self.titleName = @"请选择";
    }else{
        self.titleName = @"请选择";
        _mArray =  [[self.superData firstObject] mutableCopy];
        
//        DoctorPoolInfo *info = [_mArray firstObject];
//         _doctorPoolInfo = info;
//        
//        _mArray1 = [info.doctorPools mutableCopy];
        
        [TRClassMethod AddLineWithFrame:CGRectMake(SCREEN_WIDTH/2, self.superY, 1, SCREEN_HEIGHT-self.superY) SuperView:self];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.superY, SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT-self.superY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:_tableView];
        
        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, self.superY, SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT-self.superY) style:UITableViewStylePlain];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.separatorStyle=UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:_tableView1];
        
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    return self;
}

-(void)loadAndRefreshData{
    
}


#pragma mark - UITableViw delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.superType<10) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        if (self.superType==2) {
//            self.callback(@[_mArray[indexPath.row],_spareArray[indexPath.row]]);
//        }else if(self.superType==5){
//            EZTHospitalInfo *info = [[EZTHospitalInfo alloc]init];
//            NearHospitalInfo *infon = _mArray[indexPath.row];
//            info.mid = infon.mid;
//            info.ehName = infon.ehName;
//            [[EZT_db shareInstance] addHospitallInfo:info];
//            [[EZT_db shareInstance] addOfficeInfo:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"AMRegisterViewDataChange" object:nil];
//        }else
//            self.callback(@[_mArray[indexPath.row]]);
//            
//        [super back];
//    }else{
//        if (tableView==_tableView) {
//            _doctorPoolInfo = _mArray[indexPath.row];
//            _mArray1 = [_doctorPoolInfo.doctorPools mutableCopy];
//            [_tableView1 reloadData];
//        }else{
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            self.callback(@[_doctorPoolInfo,[NSNumber numberWithInt:(int)indexPath.row]]);
//            [super back];
//        }
//    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableView)
        return _mArray.count ;
    else
        return _mArray1.count ;
    
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        static NSString *cellIdentifier2 = @"cellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            TRLabel *label = [[TRLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 5, 145, 20)];
            label.tag = 12000;
            label.hidden = YES;
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:12];
            [cell addSubview:label];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        TRLabel *label = (TRLabel *)[cell viewWithTag:12000];
        
//        if (self.superType==1){
//            ShipsubInfo * info = _mArray[indexPath.row];
//            cell.textLabel.text =info.label;
//        }else if(self.superType==4){
//            BigOfficeInfo * info = _mArray[indexPath.row];
//            cell.textLabel.text =info.dcName;
//        }else if(self.superType==5){
//            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            NearHospitalInfo * info = _mArray[indexPath.row];
//            cell.textLabel.text =info.ehName;
//            label.hidden = NO;
//            label.text = [NSString stringWithFormat:@"%.2fkm",[info.distance doubleValue]/1000.0];
//        }else if(self.superType==10){
//            DoctorPoolInfo * info = _mArray[indexPath.row];
//            cell.textLabel.text =info.doctorPoolDate;
//        }else
//            cell.textLabel.text = _mArray[indexPath.row];
        
        return cell;
    }else{
        static NSString *cellIdentifier2 = @"cellIdentifier1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        if (self.superType==10) {
//            DoctorPoolsInfo * info = _mArray1[indexPath.row];
//            cell.textLabel.text =[NSString stringWithFormat:@"%@-%@",[info.startDate trmSubstringWithRange:11 Length:5],[info.endDate trmSubstringWithRange:11 Length:5]];
//        }
    
        
        return cell;
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}

#pragma mark - EZTData— 获取离我最近的医院
- (void)getNearHosList{
//    NSDictionary *pram = [NSDictionary dictionaryWithObjectsAndKeys:
//                          @"22.524378",@"lat",//
//                          @"113.940767",@"lng",//
//                          self.rowsPerPage,@"rowsPerPage",
//                          self.page,@"page",
//                          nil];
//    
//    //发起post请求
//    [HBHttpTool get:URL_NEAR_HOS_LIST params:pram success:^(id responseDic) {
//        NSDictionary *dic = responseDic;
//        if ([dic[@"flag"] intValue]) {
//            if (TR_isNotEmpty(dic[@"data"][@"rows"])) {
//                _mArray = [NearHospitalInfo arrayOfModelsFromDictionaries:dic[@"data"][@"rows"]];
//                [_tableView reloadData];
//            }
//        }
//    } failure:^(NSError *error) {
//        
//    }];
}
@end
