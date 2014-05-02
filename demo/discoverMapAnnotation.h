//
//  discoverMapAnnotation.h
//  demo
//
//  Created by 聂 路明 on 14-4-29.
//  Copyright (c) 2014年 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface discoverMapAnnotation : NSObject<MKAnnotation>
{
    NSString *title;
    NSString *subtitle;
    NSString *note;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

@end
