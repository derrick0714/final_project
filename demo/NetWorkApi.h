//
//  NetWorkApi.h
//  demo
//
//  Created by Xu Deng on 4/8/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
@interface NetWorkApi : NSObject
+ (void)signInAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                       completion:(void (^)(BOOL success, NSString* desc))completionBlock;

+ (void)discoverEventBySubject:(NSString *)subject
                        sortBy:(NSString *)sortBy
                       completion:(void (^)(NSMutableArray *events))completionBlock;

@end
