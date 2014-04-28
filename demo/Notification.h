//
//  Notification.h
//  demo
//
//  Created by Xu Deng on 4/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property int userID;
@property NSString* content;
@property NSDate* fireDate;
@end
