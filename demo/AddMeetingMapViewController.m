//
//  MapViewController.m
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "AddMeetingMapViewController.h"
#import "AddEventMapAnnotation.h"
#import "AddEventTableViewController.h"

#define METERS_PER_MILE 1609.344


@interface AddMeetingMapViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property float latitude;
@property float longitude;

@end

@implementation AddMeetingMapViewController

@synthesize mapView;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    
    //Set the delegate to self
    [self.mapView setDelegate: self];
    //annotate self location
    [self.mapView setShowsUserLocation:YES];
    [self addGestureRecogniserToMapView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addGestureRecogniserToMapView{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(addPinToMap:)];
    lpgr.minimumPressDuration = 0.5;
    [self.mapView addGestureRecognizer:lpgr];
    
}

- (void)addPinToMap:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    AddEventMapAnnotation *toAdd = [[AddEventMapAnnotation alloc]init];
    
    toAdd.coordinate = touchMapCoordinate;
    toAdd.subtitle= @"Subtitle";
    toAdd.title = @"Title";
    
    if(![self.mapView.annotations count] == 0) { [self.mapView removeAnnotation:self.mapView.annotations.lastObject];}
    
    self.latitude = toAdd.coordinate.latitude;
    self.longitude = toAdd.coordinate.longitude;
    
    [self.mapView addAnnotation:toAdd];
    
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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self.mapView setRegion:region animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    
    AddEventTableViewController *controller = (AddEventTableViewController *)segue.destinationViewController;
        
    controller.latitude = self.latitude;
    controller.longitude = self.longitude;
        
    
}




@end
