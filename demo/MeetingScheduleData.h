//
//  MeetingScheduleData.h
//  demo
//
//  Created by 聂 路明 on 14-4-2.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetingScheduleData : NSObject

@property NSString *Title;

@property NSString *Notes;

@property NSDate *startTime;

@property NSDate *endTime;

@property NSString *Location;

@property BOOL *Complete;

@end
