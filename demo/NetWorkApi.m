//
//  NetWorkApi.m
//  demo
//
//  Created by Xu Deng on 4/8/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "NetWorkApi.h"

@interface NetWorkApi ()
@end

@implementation NetWorkApi
static NSString * const BaseURLString = @"http://dengxu.me/ios_api_v1/";
static NSNumber* uid;

+ (void)showNetWorkAlertWindow:(NSError*) error{
    NSLog(@"Error: %@", error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}
+ (NSString*)datetimeToString:(NSDate*) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormat stringFromDate:date];
}

//log in
+ (void)signInAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                       completion:(void (^)(BOOL success,NSString* desc))completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @ {@"user" :userName,
                               @"pwd" :password };
    
    NSString *string = [NSString stringWithFormat:@"%@login/", BaseURLString];
    [manager POST:string parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        uid = [NSNumber numberWithInt: [[response objectForKey:@"uid"] intValue]];
        completionBlock([[response objectForKey:@"result"] boolValue] , [response objectForKey:@"desc"]);
    }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [self showNetWorkAlertWindow:error];
     }];
    
}




+ (void)discoverEventBySubject:(NSString *)subject
                        sortBy:(SortBy)sortBy
                    completion:(void (^)(NSMutableArray *events))completionBlock{
    NSLog(@"call discoverEventBySubject: subject: %@, sortBy:%d", subject,sortBy);
    NSString *string = [NSString stringWithFormat:@"%@allEvent/%@/%d", BaseURLString, subject , sortBy];
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
        
       
    }];
    
    [operation start];
    
}

+ (void)EventByStatus:(EventsSelector)status
           completion:(void (^)(NSMutableArray *events))completionBlock{
    
    NSString *string = [NSString stringWithFormat:@"%@eventByStatus/%d/", BaseURLString, status];
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
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{   @"creatorID":uid,
                                @"title":event.title,
                                @"subject":event.subject,
                                @"notes":event.notes,
                                @"location":event.location,
                                @"startTime":[self datetimeToString:event.startTime],
                                @"endTime":[self datetimeToString:event.endTime],
                                @"latitude":[NSNumber numberWithFloat:event.latitude],
                                @"longitude":[NSNumber numberWithFloat:event.longitude]
                                };

    
    NSString *string = [NSString stringWithFormat:@"%@createEvent/", BaseURLString];
    [manager POST:string parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *response = (NSDictionary *)responseObject;
         completionBlock([[response objectForKey:@"result"] boolValue]);
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [self showNetWorkAlertWindow:error];
     }];
}



@end
