//
//  AddEventTableViewController.h
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventTableViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveScheduleButton;
    

@end
