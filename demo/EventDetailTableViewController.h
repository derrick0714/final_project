//
//  EventDetailTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Event.h"

@interface EventDetailTableViewController : UITableViewController
@property NSString *eventTitle;
@property Event *event;
@end
