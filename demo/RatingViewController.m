//
//  RatingViewController.m
//  demo
//
//  Created by Tom on 4/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "RatingViewController.h"
#import "TPFloatRatingView.h"
#import "NetWorkApi.h"

@interface RatingViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;
- (IBAction)submit:(id)sender;
@property (strong, nonatomic) IBOutlet TPFloatRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UITextView *content;

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
	//self.ratingView.delegate = self;
    self.ratingView.emptySelectedImage = [UIImage imageNamed:@"star_empty"];
    self.ratingView.fullSelectedImage = [UIImage imageNamed:@"star"];
    self.ratingView.contentMode = UIViewContentModeScaleAspectFill;
    self.ratingView.maxRating = 5;
    self.ratingView.minRating = 1;
    self.ratingView.rating = 0;
    self.ratingView.editable = YES;
    self.ratingView.halfRatings = YES;
    self.ratingView.floatRatings = NO;
    
    _content.delegate = self;
    _content.text = @"Say something to him/her";
    _content.textColor = [UIColor lightGrayColor]; //optional
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Say something to him/her"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Say something to him/her";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if(sender == self.submitButton){
        NSLog(@"from id:%d",_fromUserId);
        NSLog(@"to id:%d",_toUserId);
        NSLog(@"eventId:%d",_eventID);
        NSLog(@"rating:%f",self.ratingView.rating);
        NSLog(@":%@",_content.text);
        [NetWorkApi addComment:_toUserId content:_content.text rating:self.ratingView.rating eventId:_eventID completion:^(BOOL result, NSString *desc) {
            NSLog(@"%d",result);
        }];

    }
}


- (IBAction)submit:(id)sender {
    
}
@end
