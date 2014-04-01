//
//  MeTableViewController.h
//  demo
//
//  Created by Xu Deng on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeTableViewController : UITableViewController
- (IBAction)unwindToMe:(UIStoryboardSegue*)sender;
@property UIImage *myphoto;
@end
