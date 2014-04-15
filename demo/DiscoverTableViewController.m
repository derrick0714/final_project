//
//  DiscoverTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "Event.h"
#import "EventDetailTableViewController.h"
#import "FilterTableViewController.h"
#import "EventCustomCellTableViewCell.h"
#import "NetWorkApi.h"

@interface DiscoverTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSMutableArray* events;
@property CLLocationManager *locationManager;

- (IBAction)refresh:(id)sender;
@end

@implementation DiscoverTableViewController

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
    
    //key board dismiss with a tap on the screen
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    //this enables the editing of picker views after touching
    tap.cancelsTouchesInView = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
	[self.tableView registerNib:[UINib nibWithNibName:@"CustomEventCell"
											   bundle:nil]
		 forCellReuseIdentifier:@"CustomEventTableCell"];
	
	self.sortBy = BESTMATCH;
	self.subject = @"All";
	
    self.events = [[NSMutableArray alloc] init];
    [self refresh:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//dismiss the keyboard when scrolling the tabel view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
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
    return [self.events count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Event *e = [self.events objectAtIndex: indexPath.row];
	
	// Default cell
	//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discover_item_cell" forIndexPath:indexPath];
	//    // Configure the cell...
	//    cell.textLabel.text = e.title;
	//	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
	//								 e.location,
	//								 [NSDateFormatter localizedStringFromDate:e.startTime
	//																dateStyle:NSDateFormatterShortStyle
	//																timeStyle:NSDateFormatterShortStyle]];
	//	return cell;
	
	// Custom cell
	EventCustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomEventTableCell"
																		 forIndexPath:indexPath];
	if(!cell) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomEventTableCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
	NSLog(@"%@ %d", e.title, [self.events count]);
    
    
    // Initialization cell style code
    cell.numberOfApplicant.layer.cornerRadius = 15.0;
    cell.numberOfApplicant.layer.masksToBounds = YES;
    
	cell.title.text = e.title;
	cell.location.text = e.location;
	cell.time.text = [NSDateFormatter localizedStringFromDate:e.startTime
													dateStyle:NSDateFormatterShortStyle
													timeStyle:NSDateFormatterShortStyle];
    //this cell should be filled with data from the server
    cell.numberOfApplicant.text = @"5";
    
	return cell;
}

-(void)dismissKeyboard {
    [self.view endEditing:YES]; //make the view end editing!
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"segue_eventdetail"
							  sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqual:@"segue_eventdetail"]) {
        EventDetailTableViewController *destVC = [segue destinationViewController];
		NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
		Event *e = [self.events objectAtIndex:ip.row];
		destVC.event = [Event initWithEvent:e];
    } else if([segue.identifier isEqual:@"segue_filter"]) {
        FilterTableViewController *destVC = [segue destinationViewController];
		destVC.sortBy = self.sortBy;
		destVC.subject = self.subject;
	}
}

- (IBAction)refresh:(id)sender {
	// Placeholder: add a placeholder event
	// should use self.sortBy and self.subject as parameters to get data remotely
    //	Event *e = [Event initWithTitle:[NSString stringWithFormat:@"A %@ Event",
    //									 self.subject]
    //							  notes:[NSString stringWithFormat:@"Sort by %@",
    //									 self.sortBy]
    //						  startTime:[NSDate dateWithTimeIntervalSinceNow:0]
    //							endTime:[NSDate dateWithTimeIntervalSinceNow:3600]
    //						   location:@"Somewhere"];
    //	[self.section addObject:e];
    
    
    // get user's current location:
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    double tempLatitude = self.locationManager.location.coordinate.latitude;
    double tempLongitude = self.locationManager.location.coordinate.longitude;

    NSLog(@"the latitude is %f", tempLatitude);
    NSLog(@"the longitude is %f", tempLongitude);
    
    
    //this is temporary code, need to be changed
//    float temp_latitude = 0.1;
//    float temp_longitude = 0.1;
    NSString* temp_keyword = self.searchBar.text;
    //
    
    [NetWorkApi discoverEventByKeyworkd:temp_keyword
                                subject:self.subject
                                 sortBy:self.sortBy
                               latitude:tempLatitude
                              longitude:tempLongitude
                             completion:^( NSMutableArray* events) {
                                 
                                 self.events = [[NSMutableArray alloc] initWithArray:events];
                                 [self.tableView reloadData];
                             }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self refresh:nil];
    [searchBar resignFirstResponder];
}

- (IBAction)refresh {
	[self refresh:nil];
}

- (IBAction)unwindToDiscover	:(UIStoryboardSegue *)segue {
	if([[segue sourceViewController] isKindOfClass:[FilterTableViewController class]]) {
		FilterTableViewController *filterVC = [segue sourceViewController];
		self.sortBy = filterVC.sortBy;
		self.subject = filterVC.subject;
		[self refresh];
	} else if([[segue sourceViewController] isKindOfClass:[EventDetailTableViewController class]]) {
		EventDetailTableViewController *detailVC = [segue sourceViewController];
		[NetWorkApi applyToCandidate:detailVC.event.eventID
						  completion:^(BOOL result, NSString *desc) {
			if(result) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Applied"
																message:desc
															   delegate:nil
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
				[alert show];
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
																message:desc
															   delegate:nil
													  cancelButtonTitle:@"OK"
													  otherButtonTitles:nil];
				[alert show];
			}
		}];
	}
}

@end
