//
//  FlipSegue.m
//  demo
//
//  Created by Tom on 4/22/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "FlipSegue.h"

@implementation FlipSegue
- (void)perform {
	UIViewController *srcVC = self.sourceViewController;
	UIViewController *destVC = self.destinationViewController;
	[UIView animateWithDuration:0.5
						  delay:0
						options:UIViewAnimationOptionTransitionNone
					 animations:^{
						 srcVC.view.transform = CGAffineTransformMakeScale(0, 1);
					 }                                                                                                                                                                                                                                                                                                                                                                                                         
					 completion:^(BOOL finished) {
						 [srcVC presentViewController:destVC
											 animated:NO
										   completion:^{
											   destVC.view.transform = CGAffineTransformMakeScale(0, 1);
											   [UIView animateWithDuration:0.5
																	 delay:0
																   options:UIViewAnimationOptionTransitionNone
																animations:^{
																	destVC.view.transform = CGAffineTransformMakeScale(1, 1);
																}
																completion:^(BOOL finished) {}];
										   
										   }];
					 }];
}
@end
