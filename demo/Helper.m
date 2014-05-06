//
//  Helper.m
//  demo
//
//  Created by Xu Deng on 4/12/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Helper
+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

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
    new.creatorID= [(NSNumber*)[dict objectForKey:@"creatorID"] intValue];
    new.status = [(NSNumber*)[dict objectForKey:@"status"] intValue];
    new.canidateID = [(NSNumber*)[dict objectForKey:@"canidateID"] intValue];
    new.numOfCandidates =[(NSNumber*)[dict objectForKey:@"numOfCandidates"] intValue];
    new.title = (NSString*)[dict objectForKey:@"title"];
    new.subject = (NSString*)[dict objectForKey:@"subject"];
    new.notes = (NSString*)[dict objectForKey:@"notes"];
    new.location = (NSString*)[dict objectForKey:@"location"];
    
    new.createTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"createTime"]];
    new.startTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"startTime"]];
    new.endTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"endTime"]];
    
    new.latitude = [(NSNumber*)[dict objectForKey:@"latitude"] doubleValue];
    new.longitude = [(NSNumber*)[dict objectForKey:@"longitude"] doubleValue];
    return new;
}
+ (User*) dictToUser:(NSDictionary*) dict{
   
    User * new = [[User alloc] init];
    if(dict.count == 0)
         return new;
    new.userID = [(NSNumber*)[dict objectForKey:@"userID"] intValue];
    new.userName = [dict objectForKey:@"userName"];
    new.subject = [dict objectForKey:@"subject"];
    new.userRating = [(NSNumber*)[dict objectForKey:@"userRating"] floatValue];
    new.gender = [(NSNumber*)[dict objectForKey:@"gender"] boolValue];
    NSString* photo_name = @"face1.png";
    if([new.userName isEqual:@"derrick"])
        photo_name = @"xu.png";
    else if([new.userName isEqual:@"luming"])
        photo_name = @"luming.png";
    else if([new.userName isEqual:@"tom"])
        photo_name = @"tom.png";
    UIImage *img = [[UIImage alloc] init];
    img = [UIImage imageNamed:photo_name];
    new.photo = img;
    return new;
}

+ (Comment*) dictToComment:(NSDictionary*) dict{
    Comment * new = [[Comment alloc] init];
    if(dict.count == 0)
        return new;
    new.userID = [(NSNumber*)[dict objectForKey:@"userID"] intValue];
    new.content = [dict objectForKey:@"content"];
    new.createTime = [self stringToDatetime :(NSString*)[dict objectForKey:@"createTime"]];
    new.rating = [(NSNumber*)[dict objectForKey:@"rating"] floatValue];
    return new;
}

+ (Notification*) dictToNotification:(NSDictionary*) dict{
    Notification * new = [[Notification alloc] init];
    if(dict.count == 0)
        return new;
    new.userID = [(NSNumber*)[dict objectForKey:@"userID"] intValue];
    new.content = [dict objectForKey:@"content"];
    new.fireDate = [self stringToDatetime :(NSString*)[dict objectForKey:@"fireTime"]];
    return new;
}


+ (void) setNotification:(NSMutableArray*) notificationList{
    
    for (Notification* key in notificationList) {
       
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [key.fireDate dateByAddingTimeInterval:-30*60];
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = key.content;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"add a new notifaction %@", localNotification);
    }
}

+ (BOOL) findNotification:(NSNumber*) eventId{
    NSArray* notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

    for (UILocalNotification* key in notifications){
        if((NSNumber*)[key.userInfo valueForKey:@"eventId"] == eventId){
            return true;
        }
    }
    return false;
}

@end
