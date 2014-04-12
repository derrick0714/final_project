//
//  FilterTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface FilterTableViewController : UITableViewController
@property SortBy sortBy;
@property NSString *subject;
@end
