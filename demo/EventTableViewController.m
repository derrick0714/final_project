//
//  EventTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "EventTableViewController.h"
#import "AddEventTableViewController.h"
#import "MeetingScheduleData.h"
#import "EventCustomCellTableViewCell.h"

//import custom tableview cell
#import "EventCustomCellTableViewCell.h"
#import "NetWorkApi.h"

@interface EventTableViewController ()

@property NSMutableArray* events;
//properties for storing data and showing in customized table cell
@property NSMutableArray* cellTitle;
@property NSMutableArray* cellTime;
@property NSMutableArray* cellLocation;

//date formatter
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation EventTableViewController

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

    self.events = [[NSMutableArray alloc] init];
    self.cellTitle = [[NSMutableArray alloc] init];
    self.cellTime = [[NSMutableArray alloc] init];
    self.cellLocation = [[NSMutableArray alloc] init];
    
    [self loadInitialData];
    
}


//initialize and create the date formatter
- (void)createDateFormatter {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    //in the below form: "date, time"
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}

//add initial data - this methods should be changed during after the sever is setted up and initial data is loaded from the sever.
- (void)loadInitialData {
    Event *e1 = [Event initWithTitle:@"Discussing iOS Programming"
							   notes:@"LOLWTF"
						   startTime:[NSDate dateWithTimeIntervalSinceNow:0]
							 endTime:[NSDate dateWithTimeIntervalSinceNow:3600]
							location:@"RH 715"];
    
//        MeetingScheduleData *item2 = [[MeetingScheduleData alloc] init];
//        //[self createDateFormatter];
//        item2.Title = @"Discussing Algorithms";
//        item2.Location = @"JB 213";
//        //item2.startTime = @"2014/04/05, 3:00pm";
//        [self.cellTitle addObject:item2.Title];
//        [self.cellLocation addObject:item2.Location];
//        [self.cellTime addObject:@"2014/04/05, 4:00pm"];
	[self.events addObject:e1];
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
    
    return [self.events count];
    // return [self.MeetingScheduleDataObjects count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Event *e = [self.events objectAtIndex: indexPath.row];
    EventCustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomEventTableCell"];
    
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomEventCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
	
    // Configure the cell...
    cell.title.text = e.title;
	cell.location.text = e.location;
    cell.time.text = [NSDateFormatter localizedStringFromDate:e.startTime
													dateStyle:NSDateFormatterShortStyle
													timeStyle:NSDateFormatterShortStyle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (IBAction)unwindEventTableView:(UIStoryboardSegue *) segue
{
    AddEventTableViewController *srcVC = [segue sourceViewController];
//    MeetingScheduleData *item = srcVC.scheduleData;
	Event *e = [Event initWithEvent:srcVC.event];
    [self.events addObject:e];
//    if (item != nil) {
//        [self.events addObject:item.Title];
//        [self.cellTitle addObject: item.Title];
//        [self.cellLocation addObject: item.Location];
//        //use date formatter to convert NSDate value in item to string
//        [self createDateFormatter];
//        [self.cellTime addObject: [self.dateFormatter stringFromDate:item.startTime]];//@"Time"];
//
//        [self.tableView reloadData];
//    }
	[self.tableView reloadData];
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
