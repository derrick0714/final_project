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
    NSString *string = [NSString stringWithFormat:@"%@login/%@/%@", BaseURLString, userName, password];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    NSString *string = [NSString stringWithFormat:@"%@allEvent/%@/%@", BaseURLString, @"0", sortBy];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSMutableArray *events = [NSMutableArray new];
        NSDictionary *response = (NSDictionary *)responseObject;
        for (NSDictionary* value in response) {
            Event * new = [[Event alloc] init];
            new.eventID = [(NSNumber*)[value objectForKey:@"eventID"] intValue];
            new.status = [(NSNumber*)[value objectForKey:@"status"] intValue];
            new.canidateID = [(NSNumber*)[value objectForKey:@"canidateID"] intValue];
            new.title = (NSString*)[value objectForKey:@"title"];
            new.subject = (NSString*)[value objectForKey:@"subject"];
            new.notes = (NSString*)[value objectForKey:@"notes"];
            new.location = (NSString*)[value objectForKey:@"location"];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

            new.createTime = [dateFormat dateFromString:(NSString*)[value objectForKey:@"createTime"]];
            new.startTime = [dateFormat dateFromString:(NSString*)[value objectForKey:@"startTime"]];
            new.endTime = [dateFormat dateFromString:(NSString*)[value objectForKey:@"endTime"]];

            
            new.latitude = [(NSNumber*)[value objectForKey:@"latitude"] intValue];
            new.longitude = [(NSNumber*)[value objectForKey:@"longitude"] intValue];
            [events addObject:new];

        }
        
        completionBlock(events);
        
        
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

+ (void)EventByStatus:(NSString *)status
           completion:(void (^)(NSMutableArray *events))completionBlock{
    
    NSString *string = [NSString stringWithFormat:@"%@eventByStatus/%@/", BaseURLString, status];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *events = [NSMutableArray new];
        NSDictionary *response = (NSDictionary *)responseObject;
        for (NSDictionary* value in response) {
            Event * new = [[Event alloc] init];
            new.eventID = [(NSNumber*)[value objectForKey:@"eventID"] intValue];
            new.status = [(NSNumber*)[value objectForKey:@"status"] intValue];
            new.canidateID = [(NSNumber*)[value objectForKey:@"canidateID"] intValue];
            new.title = (NSString*)[value objectForKey:@"title"];
            new.subject = (NSString*)[value objectForKey:@"subject"];
            new.notes = (NSString*)[value objectForKey:@"notes"];
            new.location = (NSString*)[value objectForKey:@"location"];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            new.createTime = [dateFormat dateFromString:(NSString*)[value objectForKey:@"createTime"]];
            new.startTime = [dateFormat dateFromString:(NSString*)[value objectForKey:@"startTime"]];
            new.endTime = [dateFormat dateFromString:(NSString*)[value objectForKey:@"endTime"]];
            
            
            new.latitude = [(NSNumber*)[value objectForKey:@"latitude"] intValue];
            new.longitude = [(NSNumber*)[value objectForKey:@"longitude"] intValue];
            [events addObject:new];
            
        }
        
        completionBlock(events);
        
        
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

+ (void)CreateEvent:(Event *)event
           completion:(void (^)(BOOL result))completionBlock{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *startTime  = [dateFormat stringFromDate:event.startTime];
    NSString *endTime  = [dateFormat stringFromDate:event.endTime];
    NSDictionary *parameter = @{@"title":event.title,
                                @"subject":event.subject,
                                @"subject":event.subject,
                                @"notes":event.notes,
                                @"location":event.location,
                                @"startTime":startTime,
                                @"endTime":endTime,
                                @"latitude":[NSNumber numberWithFloat:event.latitude],
                                @"longitude":[NSNumber numberWithFloat:event.longitude]
                                };


}



@end
