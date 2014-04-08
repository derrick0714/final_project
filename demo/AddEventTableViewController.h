//
//  AddEventTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingScheduleData.h"
#import "../Event.h"
@interface AddEventTableViewController : UITableViewController<UITextFieldDelegate>
@property MeetingScheduleData *scheduleData;
@property Event *event;

@end
