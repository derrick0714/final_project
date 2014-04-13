//
//  AddEventTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingScheduleData.h"
#import "Event.h"

@interface AddEventTableViewController : UITableViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>

@property MeetingScheduleData *scheduleData;
@property Event *event;

//coordinate information
@property double latitude;
@property double longitude;

//the location tabel cell is the view controller sender button for "AddMeetingMapViewController"


@end
