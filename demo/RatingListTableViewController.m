//
//  RatingListTableViewController.m
//  demo
//
//  Created by Tom on 4/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "RatingListTableViewController.h"
#import "EventCustomCellTableViewCell.h"
#import "Event.h"
#import "NetWorkApi.h"

@interface RatingListTableViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segCtrl;
@property NSMutableArray *unratedEvents;
@property NSMutableArray *ratedEvents;
@end

@implementation RatingListTableViewController

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
	[NetWorkApi EventByStatus:3
				   completion:^(NSMutableArray* events) {
					   self.unratedEvents = events;
					   [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.unratedEvents count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomEventTableCell"];
    
    // Configure the cell...
	Event *e = [self.unratedEvents objectAtIndex: indexPath.row];
    
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomEventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
	NSLog(@"EventID: %d", e.eventID);
	
    cell.numberOfApplicant.layer.cornerRadius = 15.0;
    cell.numberOfApplicant.layer.masksToBounds = YES;
    
    // Configure the cell...
	[NetWorkApi getUserInfo:e.creatorID completion:^(User *user) {
		cell.personalImage.image = user.photo;
	}];
    cell.title.text = e.title;
	NSLog(@"%@", e.title);
	cell.location.text = e.location;
    cell.time.text = [NSDateFormatter localizedStringFromDate:e.startTime
													dateStyle:NSDateFormatterShortStyle
													timeStyle:NSDateFormatterShortStyle];
    //this should be modified, and the type from sever should be string
    cell.numberOfApplicant.text = [NSString stringWithFormat:@"%d", e.numOfCandidates];
    return cell;
}

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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"segue_rating"
							  sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

@end
