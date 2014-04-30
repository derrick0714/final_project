//
//  EventMapViewController.m
//  demo
//
//  Created by 聂 路明 on 14-4-9.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import "EventMapViewController.h"

@interface EventMapViewController ()

@end

@implementation EventMapViewController
@synthesize eventOnMap;
@synthesize eventAnnotation;

@synthesize latitude;
@synthesize longitude;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.eventOnMap setDelegate: self];
    
    eventAnnotation = [[MKPointAnnotation alloc]init];
    
    CLLocationCoordinate2D pinCoordinate;
    
    //this location coordinates shuold be replaced by the parameters sent from server
    pinCoordinate.latitude = latitude; //should be data from server / double float type
    pinCoordinate.longitude = longitude; //should be data from server / double float type
    eventAnnotation.coordinate = pinCoordinate;
    
    eventAnnotation.title = @"Need help with Computer Mathematics";
    eventAnnotation.subtitle = @"Albert";
    
    //zoom to the event location
    [self.eventOnMap addAnnotation:eventAnnotation];
    CLLocationCoordinate2D loc = eventAnnotation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.eventOnMap setRegion:region animated:YES];
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

@end
