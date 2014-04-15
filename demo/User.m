//
//  User.m
//  demo
//
//  Created by Xu Deng on 4/12/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "User.h"

@implementation User
+ (id) initWithUser:(User *)u {
	User *user = [User new];
	user.userID = u.userID;
	user.userName = u.userName;
	user.gender = u.gender;
	user.subject = u.subject;
	user.age = u.age;
	user.userRating = u.userRating;
	user.photo = u.photo;
	return user;
}
@end
