//
//  EventTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

//three selectors for coming|pending|history
typedef enum {
	COMING = 0,
	PENDING,
	HISTORY
} EventsSelector;


@interface EventTableViewController : UITableViewController{
    //three-way segmented control
    IBOutlet UISegmentedControl *Segment;
}
//coming, pending, history
-(IBAction)threeEventSelector;

@property EventsSelector eventSelectID;
@property NSString* eventSelect;

@end


