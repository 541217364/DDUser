//
//  AdressHistoryView.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@class AdressHistoryView;

@protocol AdressHistorydelegate<NSObject>

- (void) adressHistory:(AdressHistoryView *) historyView  andPoint:(BMKPoiInfo *)pointinfo;

- (void) adressHistory:(AdressHistoryView *) historyView  andSeachstr:(NSString *)seachStr;

@end

@interface AdressHistoryView : UIView

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSString *seachStr;

@property (nonatomic, assign) id<AdressHistorydelegate> delegate;

@end
