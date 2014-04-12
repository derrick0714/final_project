//
//  Event.h
//  demo
//
//  Created by Tom on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
	BESTMATCH = 0,
	DISTANCE,
	RATING
} SortBy;

typedef enum {
	all = 0,
	math,
	cs,
	history,
	english,
	sports
} Subject;

// #import user;
@interface Event : NSObject

//user and candidates
@property int eventID; // eid
@property int status; // enum: recruiting: 1; has canidate: 2; ended: 3;
@property int canidateID;
@property int creatorID;
//events information
@property NSString *title; // ename
@property NSString *subject;
@property NSString *notes;
@property NSString *location; // location_desc
//time
@property NSDate *startTime;
@property NSDate *endTime;
@property NSDate *createTime;
//location
@property double latitude;
@property double longitude;




+ (id) initWithTitle:(NSString *) title
			   notes:(NSString *) notes
			location:(NSString *) location
		   startTime:(NSDate *) startTime
			 endTime:(NSDate *) endTime
		  createTime:(NSDate *) createTime
			latitute:(float) latitude
		  longitude:(float) longitude;

+ (id) initWithEvent:(Event *)event;

@end
