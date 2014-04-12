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
+ (void)signUpAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                           gender:(bool)gender
                       completion:(void (^)(BOOL success, NSString* desc))completionBlock;
+ (void)signInAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                       completion:(void (^)(BOOL success, NSString* desc))completionBlock;

+ (void)discoverEventByKeyworkd:(NSString *)keyword
                        subject:(NSString *)subject
                         sortBy:(SortBy)sortBy
                       latitude:(float)latitude
                      longitude:(float)longitude
                     completion:(void (^)(NSMutableArray *events))completionBlock;

+ (void)EventByStatus:(EventsSelector)status
           completion:(void (^)(NSMutableArray *events))completionBlock;

+ (void)CreateEvent:(Event *)event
         completion:(void (^)(BOOL result))completionBlock;

+ (void)applyToCandidate:(int) eventId
         completion:(void (^)(BOOL result))completionBlock;

+ (void)comfirmCandidate:(int) candidateId
        completion:(void (^)(BOOL result))completionBlock;

@end
