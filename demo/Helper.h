//
//  Helper.h
//  demo
//
//  Created by Xu Deng on 4/12/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "FilterTableViewController.h"
#import "EventTableViewController.h"

@interface Helper : NSObject
+ (NSString *) md5:(NSString *) input;
+ (void)showNetWorkAlertWindow:(NSError*) error;
+ (Event*) dictToEvent:(NSDictionary*) dict;
+ (NSString*)datetimeToString:(NSDate*) date;
+ (NSDate*)stringToDatetime:(NSString*) date;

@end
