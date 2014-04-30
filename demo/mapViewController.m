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

@interface mapViewController ()
- (IBAction)onFilterClick:(id)sender;
@property discoverMapAnnotation *mapAnnotation;
@property NSMutableArray *annotationArray;
@property NSMutableArray* events;
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
    self.events = [[NSMutableArray alloc] init];
    self.annotationArray = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add multiple map Annotations to the mapview
    self.sortBy = BESTMATCH;
	self.subject = @"All";
    
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
    [self.frostedViewController presentMenuViewController];

}
@end
