//
//  DiscoverTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "EventDetailTableViewController.h"
#import "Event.h"

@interface DiscoverTableViewController ()
@property NSMutableArray* section;
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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //init data in section
    self.section = [[NSMutableArray alloc] init];
//    [self.section addObject:@"SSS"];
//    [self.section addObject:@"BBB"];
	[self.section addObject:[Event initWithTitle:@"Guitar"
										   notes:@"How to play scales"
									   startTime:[NSDate dateWithTimeIntervalSinceNow:0]
										 endTime:[NSDate dateWithTimeIntervalSinceNow:3600]
										location:@"5 MetroTech Center, Brooklyn, NY 11201"]];
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
    return [self.section count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discover_item_cell" forIndexPath:indexPath];
    
    // Configure the cell...
	Event *e = [self.section objectAtIndex: indexPath.row];
    cell.textLabel.text = e.title;
	cell.detailTextLabel.text = e.notes;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqual: @"segue_eventdetail"]) {
		NSLog(@"%@", @"prepareForSegue");
        EventDetailTableViewController *destVC = [segue destinationViewController];
        UITableViewCell *cell = (UITableViewCell *) sender;
        destVC.eventTitle = cell.textLabel.text;
		NSIndexPath *ip = [self.tableView indexPathForSelectedRow];

		Event *e = [self.section objectAtIndex:ip.row];
		NSLog(@"%@", e.title);
		destVC.event = [Event initWithEvent:e];
    } else if([segue.identifier isEqual:@"segue_filter"]) {
		
	}
}

- (IBAction)refresh:(id)sender {
	Event *e = [Event initWithTitle:@"Place holder"
							  notes:@"Description"
						  startTime:[NSDate dateWithTimeIntervalSinceNow:0]
							endTime:[NSDate dateWithTimeIntervalSinceNow:3600]
						   location:@"Somewhere"];
	[self.section addObject:e];
	[self.tableView reloadData];
}
@end
