//
//  MeTableViewController.h
//  demo
//
//  Created by Xu Deng on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Comment.h"

@interface MeTableViewController : UITableViewController<UITextFieldDelegate,UITextViewDelegate>
@property UIImage *myphoto;


@property int userid;
@property int eventID;

@property BOOL isNotSelf;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *acceptButton;
@property BOOL isApplicantToMe;

@property (weak, nonatomic) IBOutlet UINavigationItem *meTableViewTitle;

@end
