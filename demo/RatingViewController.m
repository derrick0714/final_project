//
//  RatingViewController.m
//  demo
//
//  Created by Tom on 4/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "RatingViewController.h"
#import "TPFloatRatingView.h"

@interface RatingViewController ()
@property (strong, nonatomic) IBOutlet TPFloatRatingView *ratingView;
@end

@implementation RatingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.ratingView.delegate = self;
    self.ratingView.emptySelectedImage = [UIImage imageNamed:@"star_empty"];
    self.ratingView.fullSelectedImage = [UIImage imageNamed:@"star"];
    self.ratingView.contentMode = UIViewContentModeScaleAspectFill;
    self.ratingView.maxRating = 5;
    self.ratingView.minRating = 1;
    self.ratingView.rating = 5;
    self.ratingView.editable = YES;
    self.ratingView.halfRatings = NO;
    self.ratingView.floatRatings = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
