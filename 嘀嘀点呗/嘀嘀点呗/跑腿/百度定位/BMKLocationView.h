//
//  BMKLocationView.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/22.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
@interface BMKLocationView : UIView<BMKMapViewDelegate,BMKLocationServiceDelegate>{
     BMKMapView* _mapView;
     UIButton* startBtn;
     UIButton* stopBtn;
     UIButton* followingBtn;
     UIButton* followHeadBtn;
     BMKLocationService* _locService;
}
//-(IBAction)startLocation:(id)sender;
//-(IBAction)stopLocation:(id)sender;
//-(IBAction)startFollowing:(id)sender;
//-(IBAction)startFollowHeading:(id)sender;

@end
