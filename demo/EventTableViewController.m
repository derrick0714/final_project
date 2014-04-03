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

@interface EventTableViewController ()

@property NSMutableArray* MeetingScheduleDataObjects;

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

    self.MeetingScheduleDataObjects = [[NSMutableArray alloc] init];
    
    [self loadInitialData];
    
}

//add initial data - this methods should be changed during after the sever is setted up and initial data is loaded from the sever.
- (void)loadInitialData {
        MeetingScheduleData *item1 = [[MeetingScheduleData alloc] init];
        item1.Title = @"Discussing iOS Programming";
        [self.MeetingScheduleDataObjects addObject:item1.Title];
    
        MeetingScheduleData *item2 = [[MeetingScheduleData alloc] init];
        item2.Title = @"Discussing Algorithms";
        [self.MeetingScheduleDataObjects addObject:item2.Title];
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

    return [self.MeetingScheduleDataObjects count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingScheduleData" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.MeetingScheduleDataObjects objectAtIndex:indexPath.row];
    
    return cell;
}

- (IBAction)unwindEventTableView:(UIStoryboardSegue *) segue
{
    AddEventTableViewController *scheduleDataSource = [segue sourceViewController];
    MeetingScheduleData *item = scheduleDataSource.scheduleData;
    
    
    
    if (item != nil) {
        [self.MeetingScheduleDataObjects addObject:item.Title];
        [self.tableView reloadData];
    }
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
