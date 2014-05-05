//
//  User.h
//  demo
//
//  Created by Xu Deng on 4/12/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSInteger userID;
@property NSString* userName;
@property NSString* gender;
//subject is "Major" in user profile selection
@property NSString* subject;
@property NSInteger age;

@property float userRating;
@property UIImage* photo;

+ (id) initWithUser:(User *)u;

@end
