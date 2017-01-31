//
//  BaiduMapViewController.h
//  enuo4
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface BaiduMapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKMapView *_mapView;
    UIButton * starBtn;
    UIButton * stopBtn;
    BMKLocationService* _locService;
    BMKGeoCodeSearch* _geocodesearch;
}

@end
