//
//  FilterStaticClass.m
//  demo
//
//  Created by 聂 路明 on 14-5-4.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import "FilterStaticClass.h"

@implementation FilterStaticClass

static NSString* keyWord=@"";
static NSString* subject=@"All";
static SortBy sortBy=BESTMATCH;
static float latitude;
static float longitude;

+(NSString*) getKeyWord{
    return keyWord;
}
+(NSString*) getSubject{
    return subject;
}
+(SortBy) getSortBy{
    return sortBy;
}
+(float) getLatitude{
    return latitude;
}
+(float) getLongitude{
    return longitude;
}

+(void) setKeyWord:(NSString *)keyWordValue{
    keyWord = keyWordValue;
}
+(void) setSubject:(NSString *)subjectValue{
    subject = subjectValue;
}
+(void) setSortBy:(SortBy)sortByValue{
    sortBy = sortByValue;
}
+(void) setCoordinate:(float)latitudeValue
            longitude:(float)longitudeValue{
    latitude = latitudeValue;
    longitude = longitudeValue;
}


@end
