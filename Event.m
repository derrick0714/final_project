//
//  Event.m
//  demo
//
//  Created by Tom on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "Event.h"

@implementation Event
+ (id) initWithTitle:(NSString *) title
			   notes:(NSString *) notes
		   startTime:(NSDate *) startTime
			 endTime:(NSDate *) endTime {
	Event *e = [[Event alloc] init];
	e.title = title;
	e.notes = notes;
	e.startTime = startTime;
	e.endTime = endTime;
	return e;
}

@end
