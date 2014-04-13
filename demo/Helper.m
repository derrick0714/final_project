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
    new.status = [(NSNumber*)[dict objectForKey:@"status"] intValue];
    new.canidateID = [(NSNumber*)[dict objectForKey:@"canidateID"] intValue];
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
@end
