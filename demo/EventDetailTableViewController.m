//
//  EventDetailTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "EventDetailTableViewController.h"
#import "EventMapViewController.h"

@interface EventDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *subjectCell;
@property (weak, nonatomic) IBOutlet UITextView *questionDetail;
@property (weak, nonatomic) IBOutlet UITableViewCell *startTimeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *endTimeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *locationCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *candidatesCell;
@end

@implementation EventDetailTableViewController

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
    
    self.titleCell.detailTextLabel.text = self.event.title;
    NSLog(@"subject: %@", self.event.subject);
    self.subjectCell.detailTextLabel.text = self.event.subject;
	self.questionDetail.text = self.event.notes;
	self.startTimeCell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:self.event.startTime
																			 dateStyle:NSDateFormatterShortStyle
																			 timeStyle:NSDateFormatterShortStyle];
	self.endTimeCell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:self.event.endTime
																		   dateStyle:NSDateFormatterShortStyle
																		   timeStyle:NSDateFormatterShortStyle];
	self.locationCell.detailTextLabel.text = self.event.location;
	self.candidatesCell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.event.numOfCandidates];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch(section) {
        case 0: return 1;
        case 1: return 2;
        case 2: return 4;
		case 3: return 1;
        default: return 0;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showEventOnMap"]){
        EventMapViewController *controller = (EventMapViewController *)segue.destinationViewController;
        controller.latitude = self.event.latitude;
        controller.longitude = self.event.longitude;
    }
}



- (IBAction)unwindEventDetailTableView:(UIStoryboardSegue *) segue
{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark Candidates
//
//- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
//{
//	return [self.candidates count];
//}

@end
