//
//  Comment.h
//  demo
//
//  Created by Xu Deng on 4/22/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property NSInteger userID;
@property NSString* content;
@property NSDate* createTime;
@property float rating;
@end
