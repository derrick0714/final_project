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
			 endTime:(NSDate *) endTime
			location:(NSString *) location {
	Event *e = [[Event alloc] init];
	if(e) {
		e.title = title;
		e.notes = notes;
		e.startTime = startTime;
		e.endTime = endTime;
		e.location = location;
	}
	return e;
}

+ (id) initWithEvent:(Event *)event {
	Event *e = [Event new];
	if(e) {
		e.eventID = event.eventID;
		e.status = event.status;
		e.numOfCandidates = event.numOfCandidates;
		e.canidateID = event.canidateID;
		e.creatorID = event.creatorID;
		
		e.title = event.title;
		e.subject = event.subject;
		e.notes = event.notes;
		e.location = event.location;
		
		e.startTime = event.startTime;
		e.endTime = event.endTime;
		e.createTime = event.createTime;
		e.latitude = event.latitude;
		e.longitude = event.longitude;
	}
	return e;
}

@end
