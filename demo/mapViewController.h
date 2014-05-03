//
//  mapViewController.h
//  demo
//
//  Created by Xu Deng on 4/29/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "discoverMapAnnotation.h"
#import "Event.h"

@interface mapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property SortBy sortBy;
@property NSString *subject;

@property NSMutableArray *events;

@end
