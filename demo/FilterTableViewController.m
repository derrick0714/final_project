//
//  FilterTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "FilterTableViewController.h"
#import "EventCustomCellTableViewCell.h"
#import "rootViewController.h"
#import "DiscoverTableViewController.h"
#import "FBShimmeringView.h"

@interface FilterTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *view;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIView *logo;

@end

@implementation FilterTableViewController
FBShimmeringView *_shimmeringView;
UILabel *_logoLabel;


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
    
	int section = 1;
	for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
		NSIndexPath *cellPath = [NSIndexPath indexPathForRow:row inSection:section];
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:cellPath];
        SortBy selfSortBy = [FilterStaticClass getSortBy];
		if (row == selfSortBy) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
	section = 2;
	for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
		NSIndexPath *cellPath = [NSIndexPath indexPathForRow:row inSection:section];
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:cellPath];
        
        NSString* selfSubject = [FilterStaticClass getSubject];
		if ([cell.textLabel.text isEqual:selfSubject]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    _shimmeringView = [[FBShimmeringView alloc] init];
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.3;
    _shimmeringView.shimmeringOpacity = 0.3;
    [self.view addSubview:_shimmeringView];
    
    _logoLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    _logoLabel.text = @"Tutor Me";
    _logoLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:40.0];
    _logoLabel.textColor = [UIColor whiteColor];
    _logoLabel.textAlignment = NSTextAlignmentCenter;
    _logoLabel.backgroundColor = [UIColor clearColor];
    _shimmeringView.contentView = _logoLabel;
    
    UIColor *myColor = [[UIColor alloc]initWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1];
    
    self.logo.backgroundColor = myColor;

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect shimmeringFrame = self.view.bounds;
    shimmeringFrame.origin.y = shimmeringFrame.size.height * 0.02;
    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.17;
    _shimmeringView.frame = shimmeringFrame;
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
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	switch(section) {
        case 0: return 1;
		case 1: return 3;
		case 2: return 6;
		case 3: return 1;
        case 4: return 1;
		default: return 0;
	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0)
//        return nil;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
//    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
//    
//    
//    return view;
//}
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
//	for (int section = 0; section < [tableView numberOfSections]; section++) {
	int section = indexPath.section;
    
	if(section == 1 || section == 2) {
        
	for (int row = 0; row < [tableView numberOfRowsInSection:section]; row++) {
		NSIndexPath *cellPath = [NSIndexPath indexPathForRow:row inSection:section];
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:cellPath];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
//	}
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	switch(section) {
		case 1: // sort by
            [FilterStaticClass setSortBy:(SortBy)indexPath.row];
          //  ((DiscoverTableViewCont*)self.frostedViewController.menuViewController).sortBy = DISTANCE;
			break;
		case 2: // subject
            [FilterStaticClass setSubject:(NSString *) cell.textLabel.text];
			break;
	}
    }
    if(section == 3){
        [self.frostedViewController hideMenuViewController];
        
        BOOL isList = [FilterStaticClass getIsDiscoverList];
        
        if (isList) {
            DiscoverTableViewController* discoverList = [FilterStaticClass getDiscoverTableViewController];
            [discoverList reload_data];
        } else {
            mapViewController* annotatedMap = [FilterStaticClass getMapViewController];
            [annotatedMap refresh:nil];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	if(sender == self.doneButton) {
		//NSLog(@"%d %@", self.sortBy, self.subject);
	}
}

@end
