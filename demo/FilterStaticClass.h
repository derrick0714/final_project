//
//  FilterStaticClass.h
//  demo
//
//  Created by 聂 路明 on 14-5-4.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"
#import "mapViewController.h"
#import "DiscoverTableViewController.h"

@interface FilterStaticClass : NSObject


+(BOOL) isDiscoverList;

+(NSString*) keyWord;
+(NSString*) subject;
+(SortBy) sortBy;
+(float) latitude;
+(float) longitude;

+(NSString*) getKeyWord;
+(NSString*) getSubject;
+(SortBy) getSortBy;
+(float) getLatitude;
+(float) getLongitude;
+(BOOL) getIsDiscoverList;
+(mapViewController*) getMapViewController;
+(DiscoverTableViewController*) getDiscoverTableViewController;

+(void) setKeyWord:(NSString*) keyWordValue;
+(void) setSubject:(NSString*) subjectValue;
+(void) setSortBy: (SortBy) sortByValue;
+(void) setCoordinate: (float)latitudeValue
            longitude: (float)longitudeValue;
+(void) setIsDiscoverList: (BOOL) isDiscoverListValue;
+(void) setDiscoverList: (DiscoverTableViewController*) discoverController;
+(void) setMapView: (mapViewController*) mapViewControllerSet;

@end
