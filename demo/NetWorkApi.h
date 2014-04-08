//
//  NetWorkApi.h
//  demo
//
//  Created by Xu Deng on 4/8/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "FilterTableViewController.h"
#import "EventTableViewController.h"
@interface NetWorkApi : NSObject
+ (void)signInAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                       completion:(void (^)(BOOL success, NSString* desc))completionBlock;

+ (void)discoverEventBySubject:(NSString *)subject
                        sortBy:(SortBy)sortBy
                       completion:(void (^)(NSMutableArray *events))completionBlock;

+ (void)EventByStatus:(EventsSelector)status
             completion:(void (^)(NSMutableArray *events))completionBlock;

+ (void)CreateEvent:(Event *)event
         completion:(void (^)(BOOL result))completionBlock;
@end
