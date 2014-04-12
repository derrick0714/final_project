//
//  EventTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@interface EventTableViewController : UITableViewController{
    //three-way segmented control
    IBOutlet UISegmentedControl *Segment;
}
//coming, pending, history
-(IBAction)threeEventSelector;

@property EventsSelector eventSelectID;
@property NSString* eventSelect;

@end


