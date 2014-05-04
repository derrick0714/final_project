//
//  mapViewController.m
//  demo
//
//  Created by Xu Deng on 4/29/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "mapViewController.h"
#import "REFrostedViewController.h"
#import "FilterTableViewController.h"
#import "discoverMapAnnotation.h"
#import "NetWorkApi.h"
#import "Event.h"
#import "FilterStaticClass.h"

@interface mapViewController ()
- (IBAction)onFilterClick:(id)sender;
@property discoverMapAnnotation *mapAnnotation;
@property NSMutableArray *annotationArray;
@property MKPointAnnotation* annotation;
@property NSMutableArray* events;
@property CLLocationManager *locationManager;

@end

@implementation mapViewController

@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.mapView setDelegate: self];
    [self.mapView setShowsUserLocation:YES];
    //self.events = [[NSMutableArray alloc] init];
    self.annotationArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    
    [self refresh:nil];
    [super viewDidLoad];
}


- (void)refresh:(id)sender {
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    // get user's current location:
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    
//    NSLog(@"the latitude is %f", tempLatitude);
//    NSLog(@"the longitude is %f", tempLongitude);
    
    
    NSString* selfKeyWord = [FilterStaticClass getKeyWord];
    NSString* selfSubject = [FilterStaticClass getSubject];
    SortBy selfSortBy = [FilterStaticClass getSortBy];
    
    //get current location:
    double selfLatitude = self.locationManager.location.coordinate.latitude;
    double selfLongitude = self.locationManager.location.coordinate.longitude;
    
    [NetWorkApi discoverEventByKeyworkd:selfKeyWord subject:selfSubject sortBy:selfSortBy latitude:selfLatitude longitude:selfLongitude completion:^(NSMutableArray *events) {
        for (Event *event in events) {
            discoverMapAnnotation *toAdd = [[discoverMapAnnotation alloc] init];
            toAdd.coordinate = CLLocationCoordinate2DMake(event.latitude, event.longitude);
            toAdd.title = event.title;
            toAdd.subtitle = event.subject;
            [self.mapView addAnnotation:toAdd];
        }
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//update user location when users change their location
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    //zoom to location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)onFilterClick:(id)sender {
    [FilterStaticClass setMapView:self];
    [FilterStaticClass setIsDiscoverList:false];
    [self.frostedViewController presentMenuViewController];
    
}
@end
