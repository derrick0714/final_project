//
//  MapViewController.h
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


//@class AddMeetingMapViewController;
@protocol AddMeetingMapViewControllerDelegate <NSObject>
- (void) addItemViewController: (double) latitude longitudePass: (double) longitude;
@end


@interface AddMeetingMapViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *mapSearchBar;
@property (nonatomic, weak)id addEventMapDelegate;

@property double latitudeToPass;
@property double longitudeToPass;

@end
