//
//  Event.h
//  demo
//
//  Created by Tom on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property NSString *title;
@property NSString *notes;
@property NSDate *startTime;
@property NSDate *endTime;
+ (id) initWithTitle:(NSString *) title
			   notes:(NSString *) notes
		   startTime:(NSDate *) startTime
			 endTime:(NSDate *) endTime;
@end
