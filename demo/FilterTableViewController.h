//
//  FilterTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface FilterTableViewController : UITableViewController
@property SortBy sortBy;
@property NSString *subject;
@end
