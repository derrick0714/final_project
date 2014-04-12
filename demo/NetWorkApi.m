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
static NSString * const BaseURLString = @"http://ios.dengxu.me/ios_api_v1/";
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

+ (NSDate*)stringToDatetime:(NSString*) date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [dateFormat dateFromString: date];
}

+ (Event*) dictToEvent:(NSDictionary*) dict{
    Event * new = [[Event alloc] init];
    new.eventID = [(NSNumber*)[dict objectForKey:@"eventID"] intValue];
    new.status = [(NSNumber*)[dict objectForKey:@"status"] intValue];
    new.canidateID = [(NSNumber*)[dict objectForKey:@"canidateID"] intValue];
    new.title = (NSString*)[dict objectForKey:@"title"];
    new.subject = (NSString*)[dict objectForKey:@"subject"];
    new.notes = (NSString*)[dict objectForKey:@"notes"];
    new.location = (NSString*)[dict objectForKey:@"location"];
    
    new.createTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"createTime"]];
    new.startTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"startTime"]];
    new.endTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"endTime"]];
    
    new.latitude = [(NSNumber*)[dict objectForKey:@"latitude"] intValue];
    new.longitude = [(NSNumber*)[dict objectForKey:@"longitude"] intValue];
    return new;
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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{ @"status": [NSNumber numberWithInt: sortBy],
                              @"subject": subject};
    
    NSString *string = [NSString stringWithFormat:@"%@allEvent/", BaseURLString];
    [manager POST:string parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         NSMutableArray *events = [NSMutableArray new];
         NSDictionary *response = (NSDictionary *)responseObject;
         for (NSDictionary* value in response) {
             [events addObject: [self dictToEvent:value ]];
         }
         completionBlock(events);
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [self showNetWorkAlertWindow:error];
     }];

    
}

+ (void)EventByStatus:(EventsSelector)status
           completion:(void (^)(NSMutableArray *events))completionBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{ @"status": [NSNumber numberWithInt: status]};
    
    
    NSString *string = [NSString stringWithFormat:@"%@eventByStatus/", BaseURLString];
    [manager POST:string parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         NSMutableArray *events = [NSMutableArray new];
         NSDictionary *response = (NSDictionary *)responseObject;
         for (NSDictionary* value in response) {
             [events addObject: [self dictToEvent:value ]];
         }
         completionBlock(events);
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [self showNetWorkAlertWindow:error];
     }];

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
