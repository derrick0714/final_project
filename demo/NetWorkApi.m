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

+ (int)getSelfId{
    return [uid intValue];
}

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
                             @"sortBy": [NSNumber numberWithInt: sortBy],
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
    NSDictionary *params = @{ @"status": [NSNumber numberWithInt: status],
                              @"uid":uid};
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

//apply to candidate
+ (void)applyToCandidate:(int) eventId
        completion:(void (^)(BOOL result, NSString* desc))completionBlock{

    NSString *apiName = @"applyEvent";
    NSDictionary *params = @{ @"eventId":[NSNumber numberWithInt:eventId],
                              @"uid": uid
                              };

    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 completionBlock([[response objectForKey:@"result"] boolValue], [response objectForKey:@"desc"]);
             }];


    
}

//get candidates list
+ (void)candidatesList:(int) eventId
              completion:(void (^)(NSMutableArray *candidates))completionBlock{
    
    NSString *apiName = @"candidateList";
    NSDictionary *params = @{ @"eventId":[NSNumber numberWithInt:eventId]
                              };
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 NSMutableArray *candidates = [NSMutableArray new];
                 for (NSDictionary* value in response) {
                     [candidates addObject: [Helper dictToUser:value ]];
                 }
                 completionBlock(candidates);
             }];
}

//comfirm a candidate
+ (void)confirmCandidate:(int) eventId
             candidateId:(int) candidateId
              completion:(void (^)(BOOL result))completionBlock{
    
    NSString *apiName = @"applyCandidate";
    NSDictionary *params = @{@"eventId": [NSNumber numberWithInt: eventId],
                             @"candidateId":[NSNumber numberWithInt:candidateId] };
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 completionBlock([[response objectForKey:@"result"] boolValue]);
             }];
    
    //set notification
    NSString *words= @"Your have a coming event in 30 min";
    [self setNotification:uid.intValue content:words eventId:eventId completion:^(BOOL result) {
    }];
    [self setNotification:candidateId content:words eventId:eventId completion:^(BOOL result) {
    }];
}
//get user info
+ (void)getUserInfo:(int) uid
         completion:(void (^)(User* user))completionBlock{
    NSString *apiName = @"getUserInfo";
    NSDictionary *params = @{ @"uid":[NSNumber numberWithInt:uid] };
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 for (NSDictionary* value in response) {
                     completionBlock([Helper dictToUser:value]);
                 }
                 
             }];

}


//upload image
+ (void)updateImage:(NSData*) data
         completion:(void (^)(BOOL result))completionBlock{
    NSString *apiName = @"updatePhoto";
    NSDictionary *params = @{ @"uid":uid,
                              @"photo":data
                              };
    
//    [self networkDealer:apiName
//                 params:params
//             completion:^(NSDictionary *response) {
//                     completionBlock([[response objectForKey:@"result"] boolValue]);
//                 
//             }];
//
}

+ (void)addComment:(int) commenterId
           content:(NSString*) content
            rating:(float)rating
           eventId:(int)eventId
        completion:(void (^)(BOOL result, NSString* desc))completionBlock{
    
    NSString *apiName = @"addComment";
    NSDictionary *params = @{@"uid":uid,
                             @"commenterId":[NSNumber numberWithInt:commenterId],
                             @"content":content,
                             @"rating":[NSNumber numberWithFloat:rating],
                             @"eventId":[NSNumber numberWithInt:eventId]
                             };
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                     completionBlock([[response objectForKey:@"result"] boolValue] , [response objectForKey:@"desc"]);
             }];

    
}

+ (void)getComments:(int) userId
         completion:(void (^)(NSMutableArray* commentList))completionBlock{
    NSString *apiName = @"getComments";
    NSDictionary *params = @{@"uid":uid};
    
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                     NSMutableArray *commentList = [NSMutableArray new];
                     for (NSDictionary* value in response) {
                         [commentList addObject: [Helper dictToComment:value ]];
                     }
                     completionBlock(commentList);
             }];
    
}

+ (void)getNotification:(int) userId
             completion:(void (^)(NSMutableArray* notificationList))completionBlock{
    NSString *apiName = @"getNotification";
    NSDictionary *params = @{@"uid":uid};
    
    [self networkDealer:apiName
                 params:params
             completion:^(NSDictionary *response) {
                 NSMutableArray *notificationList = [NSMutableArray new];
                 for (NSDictionary* value in response) {
                     [notificationList addObject: [Helper dictToNotification:value ]];
                 }
                 completionBlock(notificationList);
             }];
}

+ (void)setNotification:(int) userId
                content:(NSString*) content
               eventId:(int)eventId
             completion:(void (^)(BOOL result))completionBlock{
    
    NSString *apiName = @"setNotification";
    NSDictionary *params = @{@"userId": [NSNumber numberWithInt: userId],
                             @"content":content,
                             @"eventId":[NSNumber numberWithInt:eventId]};
    
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
