//
//  EventMapViewController.h
//  demo
//
//  Created by 聂 路明 on 14-4-9.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface EventMapViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *eventOnMap;
@property MKPointAnnotation *eventAnnotation;

@property double latitude;
@property double longitude;

@end
