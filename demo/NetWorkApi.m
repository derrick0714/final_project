//
//  NetWorkApi.m
//  demo
//
//  Created by Xu Deng on 4/8/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "NetWorkApi.h"
@interface NetWorkApi ()
@property(nonatomic, strong) NSDictionary *weather;   // current section being parsed
@end

@implementation NetWorkApi
static NSString * const BaseURLString = @"http://dengxu.me/ios_api_v1/";


+ (void)signInAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                       completion:(void (^)(BOOL success,NSString* desc))completionBlock
{
    // 1
    NSString *string = [NSString stringWithFormat:@"%@login/%@/%@", BaseURLString, userName, password];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    // 3
        NSDictionary *response = (NSDictionary *)responseObject;
        NSLog(@"%@",[response objectForKey:@"result"]);
        NSLog(@"%@",[response objectForKey:@"desc"]);
        if([[response objectForKey:@"result"]  isEqual: @"true"]){
            completionBlock(true, [response objectForKey:@"desc"]);
        }else{
            completionBlock(false, [response objectForKey:@"desc"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
    
}



+ (void)discoverEventBySubject:(NSString *)subject
                        sortBy:(NSString *)sortBy
                    completion:(void (^)(NSMutableArray *events))completionBlock{
    
    NSString* title = @"title1";
    NSString* notes = @"subject2";
    NSDate* startDate = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSDate* endDate = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSString* location = @"poly";
    
//    Event *e = [Event initWithTitle:title
//                notes:notes
//                startTime:startDate
//                endTime:endDate location:location];
//    Event *e1 = [Event initWithTitle:title
//                              notes:notes
//                          startTime:startDate
//                            endTime:endDate location:location];
    
    NSMutableArray *events = [NSMutableArray new];
//    [events addObject:e];
//    [events addObject:e1];
    
    
    completionBlock(events);
    
}

+ (void)EventByStatus:(NSString *)status
           completion:(void (^)(NSMutableArray *events))completionBlock{
    
    
    NSString* title = @"title1";
    NSString* notes = @"subject2";
    NSDate* startDate = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSDate* endDate = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSString* location = @"poly";
    
//    Event *e = [Event initWithTitle:title
//                              notes:notes
//                          startTime:startDate
//                            endTime:endDate location:location];
//    Event *e1 = [Event initWithTitle:title
//                               notes:notes
//                           startTime:startDate
//                             endTime:endDate location:location];
    
    NSMutableArray *events = [NSMutableArray new];
//    [events addObject:e];
//    [events addObject:e1];
    
    
    completionBlock(events);

    
}

@end
