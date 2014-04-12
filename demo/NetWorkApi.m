//
//  NetWorkApi.m
//  demo
//
//  Created by Xu Deng on 4/8/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "NetWorkApi.h"
#import "Helper.h"

@interface NetWorkApi ()
@end

@implementation NetWorkApi
static NSString * const BaseURLString = @"http://ios.dengxu.me/ios_api_v1/";
static NSNumber* uid;


//sign up
+ (void)signUpAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                           gender:(bool)gender
                       completion:(void (^)(BOOL success, NSString* desc))completionBlock{
    
    NSString *apiName = @"signup";
    NSDictionary *params = @ {@"user" :userName,
        @"pwd" :[Helper md5:password],
        @"gender":[NSNumber numberWithBool:gender]};
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 completionBlock([[response objectForKey:@"result"] boolValue] , [response objectForKey:@"desc"]);
             }];
    
}
//sign in
+ (void)signInAccountWithUserName:(NSString *)userName
                         password:(NSString *)password
                       completion:(void (^)(BOOL success,NSString* desc))completionBlock
{
    NSString *apiName = @"login";
    NSDictionary *params = @ {@"user" :userName,
        @"pwd" :[Helper md5:password] };
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 uid = [NSNumber numberWithInt: [[response objectForKey:@"uid"] intValue]];
                 completionBlock([[response objectForKey:@"result"] boolValue] , [response objectForKey:@"desc"]);
             }];
}


//search event by keywords
+ (void)discoverEventByKeyworkd:(NSString *)keyword
                        subject:(NSString *)subject
                         sortBy:(SortBy)sortBy
                       latitude:(float)latitude
                      longitude:(float)longitude
                     completion:(void (^)(NSMutableArray *events))completionBlock{
    
    NSString *apiName = @"allEvent";
    NSDictionary *params = @{@"keyword": keyword,
                             @"status": [NSNumber numberWithInt: sortBy],
                             @"subject": subject,
                             @"latitude": [NSNumber numberWithFloat: latitude],
                             @"longitude":[NSNumber numberWithFloat: longitude]
                             };
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 NSMutableArray *events = [NSMutableArray new];
                 for (NSDictionary* value in response) {
                     [events addObject: [Helper dictToEvent:value ]];
                 }
                 completionBlock(events);
             }];
    
}

//get events list by status
+ (void)EventByStatus:(EventsSelector)status
           completion:(void (^)(NSMutableArray *events))completionBlock{
    
    NSString *apiName = @"eventByStatus";
    NSDictionary *params = @{ @"status": [NSNumber numberWithInt: status]};
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 NSMutableArray *events = [NSMutableArray new];
                 for (NSDictionary* value in response) {
                     [events addObject: [Helper dictToEvent:value ]];
                 }
                 completionBlock(events);
             }];
}

//create a event
+ (void)CreateEvent:(Event *)event
         completion:(void (^)(BOOL result))completionBlock{
    NSString *apiName = @"createEvent";
    NSDictionary *params = @{   @"creatorID":uid,
                                @"title":event.title,
                                @"subject":event.subject,
                                @"notes":event.notes,
                                @"location":event.location,
                                @"startTime":[Helper datetimeToString:event.startTime],
                                @"endTime":[Helper datetimeToString:event.endTime],
                                @"latitude":[NSNumber numberWithFloat:event.latitude],
                                @"longitude":[NSNumber numberWithFloat:event.longitude]
                                };
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                  completionBlock([[response objectForKey:@"result"] boolValue]);
             }];
}

//apply a event
+ (void)applyEvent:(int) eventId
        completion:(void (^)(BOOL result))completionBlock{

    NSString *apiName = @"applyEvent";
    NSDictionary *params = @{ @"eventId":[NSNumber numberWithInt:eventId] };

    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 completionBlock([[response objectForKey:@"result"] boolValue]);
             }];
}

//network core function
+(void) networkDealer:(NSString*) apiName
               params:(NSDictionary*) params
           completion:(void (^)(NSDictionary * response))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [BaseURLString stringByAppendingString: apiName];
    
    NSLog(@"Call api url: %@", url);
    [manager POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Api response: %@", responseObject);
         completionBlock((NSDictionary*)responseObject);
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"network error: %@", error);
         [Helper showNetWorkAlertWindow:error];
     }];
}

@end
