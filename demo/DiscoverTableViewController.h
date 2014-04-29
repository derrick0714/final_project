//
//  DiscoverTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <CoreLocation/CoreLocation.h>
#import "REFrostedViewController.h"

@interface DiscoverTableViewController : UITableViewController<UIScrollViewDelegate, CLLocationManagerDelegate>
-(void) reload_data;

@property SortBy sortBy;
@property NSString *subject;
@end
