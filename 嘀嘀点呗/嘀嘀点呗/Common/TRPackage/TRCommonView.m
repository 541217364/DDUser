

#import "TRCommonView.h"
#import "TouchTableView.h"
#import "MJRefresh.h"
#import "TRExtendsClass.h"
//#import "EZT_db.h"

@interface TRCommonView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) TouchTableView *tableView;

@property(nonatomic,strong) TouchTableView *tableView1;

@property(nonatomic,strong) NSArray   *ParamData;

@property(nonatomic,assign) int tr_type;

@property(nonatomic,strong) NSMutableArray   *tableViewArray;

@property(nonatomic,strong) NSMutableArray   *tableView1Array;

@property(nonatomic,strong) TRButton *okBtn;

// 起始页 默认1
@property (nonatomic,strong) NSNumber * page;

// 起始行 默认10
@property (nonatomic,strong) NSNumber * rowsPerPage;

@property (nonatomic,assign) CGRect hRect;

@property (nonatomic,assign) CGRect sRect;

@property (nonatomic,strong) UIView *tr_viewa;

/*智能筛选*/
@property(nonatomic,strong) NSArray   *znDataArray;

@end

@implementation TRCommonView
/*paramData
 
 */
- (id)initWithFrame:(CGRect)frame withData:(NSArray *)paramData{
    _hRect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    _sRect = frame;
    _ParamData = paramData;
    _tr_type = [paramData[1]intValue];
    self = [super initWithFrame:_hRect];
    
    _tableView = [[TouchTableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle=UITableViewCellAccessoryDisclosureIndicator;
    [self addSubview:_tableView];
    
    

    if (_tr_type==1) {
        _znDataArray = @[@"预约有号",@"预约效率高",@"评价较高",@"级别高到低"];
        _okBtn = [TRButton buttonWithType:UIButtonTypeCustom];
        _okBtn.hidden = YES;
        _okBtn.frame  =CGRectMake(0, _sRect.size.height-30, _sRect.size.width, 30);
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _okBtn.backgroundColor = TR_MainColor;
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_okBtn];
    }else if(_tr_type==2){
        [_tableView setWidth:140];
        
        _tr_viewa = [[UIView alloc]initWithFrame:CGRectMake(140, 0, 1, 0)];
        _tr_viewa.backgroundColor = TR_MainColor;
        [self addSubview:_tr_viewa];
        
        _tableView1 = [[TouchTableView alloc]initWithFrame:CGRectMake(141, 0, SCREEN_WIDTH-141, 0) style:UITableViewStylePlain];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.separatorStyle=UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:_tableView1];
        
    }else if (_tr_type==3){
        _znDataArray = @[@"全国",@"天津",@"北京",@"沈阳",@"深圳"];
        _tableViewArray =[ @[@0,@2,@1,@37,@199]mutableCopy];
        [_tableView1 reloadData];
    }
    
    self.tr_show = NO;
    
    [self addMaskViewWithColor:ClearColor];
    [self loadAndRefreshData];
    return self;
}

- (void)loadAndRefreshData{
//    if (_tr_type==1) {
//        _tableViewArray = [[_ParamData[2] firstObject]mutableCopy];
//        [_tableView reloadData];
//    }else if(_tr_type==2){
//        [self getBigDept];
//    }else if(_tr_type==3){
//        
//    }else
//        [self getDeptList2];
}

- (void)BtnClick:(TRButton *)btn{
    self.callbackParams(_tableViewArray);
    self.tr_show= YES;
}


-(void)setTr_show:(BOOL)tr_show{
    if (tr_show) {
        [UIView animateWithDuration:0.2 animations:^{
            [self setHeight:0];
            [_tableView setHeight:0];
            [_tableView1 setHeight:0];
            if (_tr_type==1)
                _okBtn.hidden = YES;
            else
                [_tr_viewa setHeight:0];
            
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self removeMaskView];
        }];
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [self setHeight:_sRect.size.height];
            if (_tr_type==1)
                [_tableView setHeight:_sRect.size.height-30];
            else{
                [_tableView setHeight:_sRect.size.height];
                [_tableView1 setHeight:_sRect.size.height];
                [_tr_viewa setHeight:_sRect.size.height];
            }

            
        }completion:^(BOOL finished) {
           if (_tr_type==1)
               _okBtn.hidden = NO;
        }];
    }
}

#pragma mark - 屏幕点击移除self
- (void)trView{
    self.callbackChangeState();
    self.tr_show = YES;
    
}

#pragma mark - 添加遮罩view
- (void)addMaskViewWithColor:(ColorType)color{
    UIView * view = [[UIView alloc]initWithFrame:TR_Frame];
    view.tag = 22222;
    switch (color) {
        case ClearColor:
            view.backgroundColor = [UIColor clearColor];
            break;
        case GrayColor:
            view.backgroundColor = TR_COLOR_RGBACOLOR_A(102, 102, 102, 1.0);
            break;
        case WhithColor:
            view.backgroundColor = [UIColor clearColor];
            break;
            
        default:
            break;
    }
    view.alpha = 0.5;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trView)];
    [view addGestureRecognizer:tap];
    [ROOTVIEW addSubview:view];
}

#pragma mark - 移除遮罩view
- (void)removeMaskView{
    UIView *view = (UIView *)[ROOTVIEW viewWithTag:22222];
    [view removeFromSuperview];
}

//#pragma mark - EZTData— 获取二级科室列表
//- (void)getDeptList:(BigOfficeInfo *)info{
//    /*
//     pid=大分类ID
//     */
//    [HBHttpTool post:URL_GET_DEPT_LIST params:@{@"pid":info.mid} success:^(id responseDic) {
//        NSDictionary *dic = responseDic;
//        if (TR_isNotEmpty(dic[@"data"])) {
//            if ([dic[@"flag"]intValue]) {
//                _tableView1Array =  [BigOfficeInfo arrayOfModelsFromDictionaries:dic[@"data"]];
//                [_tableView1 reloadData];
//                
//            }
//        }else{
//            [_tableView1Array removeAllObjects];
//            [_tableView1 reloadData];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//#pragma mark - EZTData— 获取大科室分类
//- (void)getBigDept{
//    /*
//     level=分类级别（1大分类2小分类） 或者hospitalId=医院ID
//     */
//    [HBHttpTool post:URL_GET_BIG_DEPT params:@{@"level":@"1"} success:^(id responseDic) {
//        NSDictionary *dic = responseDic;
//        
//        if ([dic[@"flag"]intValue]) {
//            if (TR_isNotEmpty(dic[@"data"])) {
//                _tableViewArray =  [BigOfficeInfo arrayOfModelsFromDictionaries:dic[@"data"]];
//                [_tableView reloadData];
//                
//                [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]animated:YES scrollPosition:UITableViewScrollPositionTop];
//            }else{
//                [_tableViewArray removeAllObjects];
//                [_tableView reloadData];
//            }
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}
//
//#pragma mark - EZTData— 获取小科室列表
//- (void)getDeptList2{
//    EZTHospitalInfo *info = [_ParamData[2] firstObject];
//    
//    /*
//     dptCateId=科室分类ID或者hospitalId=医院ID
//     */
//    [HBHttpTool post:URL_GET_DEPT_LIST2 params:@{@"hospitalId":info.mid} success:^(id responseDic) {
//        NSDictionary *dic = responseDic;
//        if (TR_isNotEmpty(dic[@"data"])) {
//            _tableViewArray =  [OfficeInfo arrayOfModelsFromDictionaries:dic[@"data"]];
//            [_tableView reloadData];
//
//        }else{
//            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"暂无可预约科室!"];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}



#pragma mark - UITableViw delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//    if (_tr_type==0) {
//         [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [[EZT_db shareInstance] addOfficeInfo:_tableViewArray[indexPath.row]];
//        if (_trp_type==0)
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"AMRegisterViewDataChange" object:nil];
//        
//        self.callbackParams(@[_tableViewArray[indexPath.row]]);
//        self.tr_show = YES;
//        
//    }else if(_tr_type==1){
//         [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        int row = (int)indexPath.row;
//        if([_tableViewArray[row] intValue])
//            [_tableViewArray replaceObjectAtIndex:row withObject:@0];
//        else
//            [_tableViewArray replaceObjectAtIndex:row withObject:@1];
//        [_tableView reloadData];
//    }else if(_tr_type==2){
//        if (tableView==_tableView) {
//            BigOfficeInfo *info =  _tableViewArray[indexPath.row];
//            [self getDeptList:info];
//        }else{
//            self.callbackParams(@[_tableView1Array[indexPath.row]]);
//            self.tr_show = YES;
//        }
//    }else if(_tr_type==3){
//        self.callbackParams(@[_tableViewArray[indexPath.row],_znDataArray[indexPath.row]]);
//        self.tr_show = YES;
//    }
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==_tableView)
        return _tableViewArray.count;
    else
        return _tableView1Array.count;
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
            
            TRLabel *labelR = [[TRLabel alloc]initWithFrame:CGRectMake(_sRect.size.width-20, 5, 15, 20)];
            labelR.font = [UIFont systemFontOfSize:13];
            labelR.textColor = [UIColor grayColor];
            labelR.textAlignment = NSTextAlignmentLeft;
            labelR.tag = 8888;
            [cell addSubview:labelR];
        }
        if (_tr_type==0) {
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
//            OfficeInfo *info = _tableViewArray[indexPath.row];
//            cell.textLabel.text = info.dptName;
        }else if(_tr_type==1){
            TRLabel *labelR = (TRLabel *)[cell viewWithTag:8888];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.textLabel.text = _znDataArray[indexPath.row];
            if([_tableViewArray[indexPath.row] intValue])
                labelR.text = @"是";
            else
                labelR.text = @"否";
        }else if(_tr_type==2){
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
//            BigOfficeInfo *info = _tableViewArray[indexPath.row];
//            cell.textLabel.text = info.dcName;
        }else if(_tr_type==3){
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = _znDataArray[indexPath.row];
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier2 = @"cellIdentifier5";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
//        BigOfficeInfo *info = _tableView1Array[indexPath.row];
//        cell.textLabel.text = info.dcName;
        
        return cell;
    }
    return nil;
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
@end

@implementation TRCommonView(UITableViewCell)
@end
