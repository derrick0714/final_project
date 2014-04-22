//
//  EventDetailTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailTableViewController : UITableViewController

@property Event *event;
@property BOOL isSelfEvent;
@property BOOL isComingEvent;
@property BOOL isPendingEvent;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applyButton;

@end
