//
//  MeTableViewController.m
//  demo
//
//  Created by Xu Deng on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "MeTableViewController.h"
#import "EditProfileTableViewController.h"
#import "NetWorkApi.h"
#import "EventCandidatesCollectionViewController.h"
#import "AllCommentsTableViewController.h"
#import "TPFloatRatingView.h"
#import "Comment.h"

@interface MeTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *userCell;

@property int firstCommentUserId;
@property (weak, nonatomic) IBOutlet UIImageView *firstCommentImage;
@property (nonatomic, retain) IBOutlet UITextView *firstCommentText;
@property int secondCommentUserId;
@property (weak, nonatomic) IBOutlet UIImageView *secondCommentImage;
@property (nonatomic, retain) IBOutlet UITextView *secondCommentText;

@property NSMutableArray *commentsList;
@property (strong, nonatomic) IBOutlet TPFloatRatingView *rating;

@property UIAlertView *alert;
@end



@implementation MeTableViewController

@synthesize acceptButton;
@synthesize eventID;
@synthesize meTableViewTitle;
@synthesize isApplicantToMe;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"Me: viewDidLoad");
    
	
    if (!self.isNotSelf) {
        self.userid = [NetWorkApi getSelfId];
    }
    
//    meTableViewTitle.title = @"Applicant";
    if (!self.isApplicantToMe) {
        acceptButton.customView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [acceptButton setEnabled:NO];
        acceptButton.customView.alpha = 0.0f;
//        meTableViewTitle.title = @"My Profile";
    } else if(self.isCandidate) {
//		meTableViewTitle.title = @"Candidate";
	}
    
	[NetWorkApi getUserInfo:self.userid
				 completion:^(User *user) {
					 self.userCell.textLabel.text = user.userName;
					 self.userCell.imageView.image = user.photo;
					 NSLog(@"Photo: %@", user.photo);
				 }];
    
//	self.rating.delegate = self;
    self.rating.emptySelectedImage = [UIImage imageNamed:@"star_empty"];
    self.rating.fullSelectedImage = [UIImage imageNamed:@"star"];
    self.rating.contentMode = UIViewContentModeScaleAspectFill;
    self.rating.maxRating = 5;
    self.rating.minRating = 0;
    
    self.rating.editable = NO;
    self.rating.halfRatings = YES;
    self.rating.floatRatings = YES;
	
    // API for getting comments photo and text
    [NetWorkApi getComments:self.userid completion:^(NSMutableArray *commentList) {
        self.commentsList = commentList;
        float all_rating = 0;
            for (int i=0; i<[self.commentsList count]; i++) {
                Comment *comment = [commentList objectAtIndex:i];
                if(i ==0){
                self.firstCommentUserId = comment.userID;
                self.firstCommentText.text = comment.content;
                [NetWorkApi getUserInfo:self.firstCommentUserId
                                 completion:^(User *user) {
                                     self.firstCommentImage.image = user.photo;
                                     // self.rating.rating = user.userRating;
                                 }];
                }
                if(i ==1){
                    self.secondCommentUserId = comment.userID;
                    self.secondCommentText.text = comment.content;
                    [NetWorkApi getUserInfo:self.secondCommentUserId
                                 completion:^(User *user) {
                                     self.secondCommentImage.image = user.photo;
                                     // self.rating.rating = user.userRating;
                                 }];
                }
                all_rating += comment.rating;
                
//                self.secondCommentUserId = (int)[[commentList objectAtIndex:2] userID];
//                self.firstCommentText.text = [[commentList objectAtIndex:2] content];
            }
        
        self.rating.rating = all_rating/[commentList count];
    }];
    
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (IBAction)acceptButton:(id)sender {
    [NetWorkApi confirmCandidate:eventID candidateId:self.userid completion:^(BOOL result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Successfully Accept" message: @"This applicant is successfully added." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"segueEditProfile"]) {
        NSIndexPath *a = [NSIndexPath indexPathForRow:0 inSection:0]; // I wanted to update this cell specifically
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:a];
        EditProfileTableViewController * detailViewController = [segue destinationViewController];
        
        detailViewController.myphoto =  cell.imageView.image;
        NSIndexPath *b = [NSIndexPath indexPathForRow:0 inSection:0]; // I wanted to update this cell specifically
        UITableViewCell *cell2 = [detailViewController.tableView cellForRowAtIndexPath:b];
        cell2.imageView.image = cell.imageView.image;
    } else if ([[segue identifier] isEqualToString:@"SeeAllComments"]) {
        AllCommentsTableViewController *destVC = [segue destinationViewController];
        
        destVC.userIdComment = self.userid;
    } else if ([[segue identifier] isEqualToString:@"segue_edit_profile"]) {
		EditProfileTableViewController *destVC = [segue destinationViewController];
		destVC.userid = self.userid;
	}
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
	if([identifier isEqualToString:@"segue_edit_profile"])
		return NO;
	else
		return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(self.userid == [NetWorkApi getSelfId] && indexPath.section == 0) {
		[self performSegueWithIdentifier:@"segue_edit_profile" sender:self];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)unwindToMe:(UIStoryboardSegue*)sender
{
    NSIndexPath *a = [NSIndexPath indexPathForRow:0 inSection:0]; // I wanted to update this cell specifically
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:a];
    cell.imageView.image =self.myphoto;
}

@end
