//
//  AddEventTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "AddEventTableViewController.h"
#import "NetWorkApi.h"
#import "../Event.h"

@interface AddEventTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *titleText;

//locationText will not be presented on the events table view, but will bu stored in database

@property (weak, nonatomic) IBOutlet UITextField *locationText;
@property (weak, nonatomic) IBOutlet UITextField *questionDetail;
@property float latitude;
@property float longitude;

//start and end time
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

//date and time values to be passed to the events table
//add properties here:
@property NSDate *startTimeFromPicker;
@property NSDate *endTimeFromPicker;
@property NSDate *createTime;

//date picker
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
//date picker cell outlets used for hiding date picker cells
@property (weak, nonatomic) IBOutlet UITableViewCell *startDatePickerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *endDatePickerCell;
//flags for controlling the showing and hiding of datepickercell
@property BOOL startDatePickerIsShowing;
@property BOOL endDatePickerIsShowing;

//date formatter for converting datepicker's time to formatted string
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end


@implementation AddEventTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//because the table view cells are static, so there is no need to use the following two methods:

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 7;
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


//initialize and create the date formatter
- (void)createDateFormatter {
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}


//below two functions are used to handle the change of date pickers

- (IBAction)startDatePickerChanged:(UIDatePicker *)sender {
    
    [self createDateFormatter];
    self.startTime.text =  [self.dateFormatter stringFromDate:sender.date];
    
    //storing the user picker's data
    self.startTimeFromPicker = sender.date;
}

- (IBAction)endDatePickerChanged:(UIDatePicker *)sender {
    
    [self createDateFormatter];
    
    self.endTime.text =  [self.dateFormatter stringFromDate:sender.date];

    //storing the user picker's data
    self.endTimeFromPicker = sender.date;
}


//below code is used to hide the date pciker cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.tableView.rowHeight;
    
    if (indexPath.row == 2){
        height = self.startDatePickerIsShowing ? 164 : 0.0f;
    }
    
    if (indexPath.row == 4){
        height = self.endDatePickerIsShowing ? 164 : 0.0f;
    }
    
    return height;
}



//when datecell is selected show the datepicker cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1){
        
        if (self.startDatePickerIsShowing){
            [self hideStartDatePickerCell];
        }else {
            [self showStartDatePickerCell];
        }
    }
    
    if (indexPath.row == 3){
        
        if (self.endDatePickerIsShowing){
            [self hideEndDatePickerCell];
        }else {
            [self showEndDatePickerCell];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//methods for showing and hiding date picker cells
- (void)showStartDatePickerCell {
    
    self.startDatePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.startDatePicker.hidden = NO;
    self.startDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.startDatePicker.alpha = 1.0f;
    }];
}

- (void)hideStartDatePickerCell {
    
    self.startDatePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.startDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.startDatePicker.hidden = YES;
                     }];
}


- (void)showEndDatePickerCell {
    
    self.endDatePickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.endDatePicker.hidden = NO;
    self.endDatePicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.endDatePicker.alpha = 1.0f;
    }];
}

- (void)hideEndDatePickerCell {
    
    self.endDatePickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.endDatePicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.endDatePicker.hidden = YES;
                     }];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender != self.saveButton) return;
    if (self.titleText.text.length > 0) {
		//get create current time
		self.createTime = [NSDate date];
		
        //initialize the event object
		self.event = [[Event alloc] init];
		self.event.title = self.titleText.text;

        if (self.startTimeFromPicker) {
            self.event.startTime = self.startTimeFromPicker;
        }
        else
            self.event.startTime = [NSDate date];
        
        if (self.endTimeFromPicker) {
            self.event.endTime = self.endTimeFromPicker;
        }
        else
            self.event.endTime = [NSDate date];

		self.event.location = self.locationText.text;
		self.event.notes = self.questionDetail.text;
        
        [NetWorkApi CreateEvent:self.event
                     completion:^(BOOL result){
                         if (!result) {
                             
                         }
                         
                     }];
    }
    

}

-(IBAction)unwindToEventlist: (UIStoryboardSegue *)segue {
    
}

@end
