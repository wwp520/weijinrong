//
//  HomeLocation.m
//  weijinrong
//
//  Created by RY on 17/3/30.
//  Copyright © 2017年 oudapay. All rights reserved.
//

#import "HomeLocation.h"
#import "IntegralController.h"


#pragma mark - 声明
@interface HomeLocation()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKOfflineMapDelegate>
{
    BMKMapView * _mapView;

}
@property (nonatomic, copy  ) KKLocationBlock city;
@property (nonatomic, copy  ) KKBlock error;
@property (nonatomic, strong) BMKLocationService *location;
@property (nonatomic, strong) BMKGeoCodeSearch *geo;
@end

#pragma mark - 实现
@implementation HomeLocation
singleton_implementation(HomeLocation)

+ (instancetype)sharedHomeLocation:(KKLocationBlock)city error:(KKBlock)error {
    HomeLocation *view = [HomeLocation sharedHomeLocation];
    [view setError:error];
    [view setCity:city];
    [view location];
    return view;
}

#pragma mark - 初始化
- (BMKLocationService *)location {
    if (!_location) {
        _location = [[BMKLocationService alloc] init];
        _location.delegate = self;
    }
    [_location startUserLocationService];
    return _location;
}
- (void)setCoor:(CLLocationCoordinate2D)coor {
    if (!_geo) {
        _geo = [[BMKGeoCodeSearch alloc] init];
        _geo.delegate = self;
    }
    BOOL flag = [_geo reverseGeoCode:({
        BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
        option.reverseGeoPoint = coor;
        option;
    })];
    if(flag) {
        NSLog(@"反geo检索发送成功");
    }else {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    CLLocation *location = userLocation.location;
    if (location != nil && location.coordinate.latitude != 0) {
        [self setCoor:location.coordinate];
        NSLog(@"##########################################%f  %f",location.coordinate.latitude,location.coordinate.longitude);
        //获取到经纬度先以单例形式保存,方便在其他地方调取
        [KKStaticParams sharedKKStaticParams].lat = location.coordinate.latitude;
        [KKStaticParams sharedKKStaticParams].lot = location.coordinate.longitude;
    }
    // 停止定位
    [_location stopUserLocationService];
}
- (void)didFailToLocateUserWithError:(NSError *)error {
    if (_error) {
        _error();
    }
    // 停止定位
    [_location stopUserLocationService];
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!error) {
        //山东省济南市历下区舜华路359
        NSMutableString * str = [[NSMutableString alloc]initWithString:result.address];
         NSLog(@"********************%@************************",str);
        
        NSMutableString *strm = [[NSMutableString alloc] initWithString:result.addressDetail.city];
        NSString *city = [strm stringByReplacingOccurrencesOfString:@"市" withString:@""];
        if (_city) {
            _city(city,str);
            
            /************************获取当前城市编码cityId***********************/
            
            _mapView = [[BMKMapView alloc] initWithFrame:CGRectZero];
            
            BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
            _offlineMap.delegate = self;//可以不要
            NSArray* records = [_offlineMap searchCity:city];
            if (records.count > 0) {
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //城市编码如:北京为131
                _cityId = oneRecord.cityID;
            }
            //单例类存储
            [KKStaticParams sharedKKStaticParams].cityId = _cityId;
            
            NSLog(@"当前城市编号-------->%zd",_cityId);
            
//            IntegralController * integralVC = [[IntegralController  alloc]init];
//            integralVC.cityId = _cityId;
            
            //找到了当前位置城市后就关闭服务
            [_location stopUserLocationService];
            
        }
    }else {
        if (_error) {
            _error();
        }
    }
}


@end
