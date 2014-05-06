//
//  AddEventTableViewController.m
//  demo
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "AddEventTableViewController.h"
#import "NetWorkApi.h"
#import "Event.h"
#import "AddMeetingMapViewController.h"

@interface AddEventTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (weak, nonatomic) IBOutlet UITextField *titleText;
//locationText will not be presented on the events table view, but will bu stored in database
@property (weak, nonatomic) IBOutlet UITextField *locationText;
@property (weak, nonatomic) IBOutlet UITextView *questionDetail;
//start and end time
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

//date and time values to be passed to the events table
//add properties here:
@property NSDate *startTimeFromPicker;
@property NSDate *endTimeFromPicker;
@property NSDate *createTime;

//subject picker
@property (weak, nonatomic) IBOutlet UIPickerView *subjectPicker;
@property (weak, nonatomic) IBOutlet UILabel *subjectFromPicker;
@property (strong, nonatomic) NSArray *subjectArray;

//date picker
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
//date picker cell outlets used for hiding date picker cells
@property (weak, nonatomic) IBOutlet UITableViewCell *startDatePickerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *endDatePickerCell;
//flags for controlling the showing and hiding of datepickercell
@property BOOL startDatePickerIsShowing;
@property BOOL endDatePickerIsShowing;
@property BOOL subjectPickerIsShowing;

//date formatter for converting datepicker's time to formatted string
@property (strong, nonatomic) NSDateFormatter *dateFormatter;


@end


@implementation AddEventTableViewController

//coordinate information
@synthesize latitude;
@synthesize longitude;

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
    
    [self.subjectPicker setDelegate: self];
    
    self.subjectArray  = [[NSArray alloc] initWithObjects:
                          @"Math",
                          @"Physics",
                          @"Computer Science",
                          @"Biology",
                          @"Economics",
                          @"E.E." , nil];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    //this enables the editing of picker views after touching
    tap.cancelsTouchesInView = NO;
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(titleKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(titleKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(detailKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(detailKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Implement the subject picker
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 6;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    //  NSLog(@"12");
//    //  return [textField resignFirstResponder];
//    [self titleText:self];
//    [textField resignFirstResponder];
//    return true;
//}

//--------------------- Key board dismiss---------------------------
- (void)titleKeyboardWillHide:(NSNotification *)n
{
    [self animateTextField:_titleText up:NO];
}
- (void)titleKeyboardWillShow:(NSNotification *)n
{
    [self animateTextField:_titleText up:NO];
}
- (void)locationKeyboardWillHide:(NSNotification *)n
{
    [self animateTextField:_locationText up:NO];
}
- (void)locationKeyboardWillShow:(NSNotification *)n
{
    [self animateTextField:_locationText up:YES];
}
- (void)detailKeyboardWillHide:(NSNotification *)n
{
    [self animateTextView:_questionDetail up:NO];
}
- (void)detailKeyboardWillShow:(NSNotification *)n
{
    [self animateTextView:_questionDetail up:YES];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -10; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)animateTextView:(UITextView*)textView up:(BOOL)up
{
    const int movementDistance = -10; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextView" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES]; //make the view end editing!
}

//dismiss the keyboard when scrolling the tabel view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.titleText resignFirstResponder];
    [self.locationText resignFirstResponder];
}
//----------------------    Key  board   ---------------------------


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.subjectArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    self.subjectFromPicker.text = [self.subjectArray objectAtIndex: row];
}



//initialize and create the date formatter
- (void)createDateFormatter {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}

//subject picker changed:



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
        height = self.subjectPickerIsShowing ? 185 : 0.0f;
    }
    if (indexPath.row == 4){
        height = self.startDatePickerIsShowing ? 165 : 0.0f;
    }
    if (indexPath.row == 6){
        height = self.endDatePickerIsShowing ? 165 : 0.0f;
    }
    if (indexPath.row == 9) {
        height = 162;
    }
    
    return height;
}



//when datecell is selected show the datepicker cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1){
        
        if (self.subjectPickerIsShowing){
            [self hideSubjectPickerCell];
        }else {
            [self showSubjectPickerCell];
        }
    }
    
    if (indexPath.row == 3){
        
        if (self.startDatePickerIsShowing){
            [self hideStartDatePickerCell];
        }else {
            [self showStartDatePickerCell];
        }
    }
    
    if (indexPath.row == 5){
        
        if (self.endDatePickerIsShowing){
            [self hideEndDatePickerCell];
        }else {
            [self showEndDatePickerCell];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
 
}

//methods for showing and hiding date picker cells
- (void)showSubjectPickerCell {
    
    self.subjectPickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.subjectPicker.hidden = NO;
    self.subjectPicker.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.subjectPicker.alpha = 1.0f;
    }];
}

- (void)hideSubjectPickerCell {
    
    self.subjectPickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.subjectPicker.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.subjectPicker.hidden = YES;
                     }];
}


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

//If there is not input to the title, segue will not be performed
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if (sender == self.saveButton) {
        if (self.titleText.text.length > 0) {
            return YES;
        }
        //alert information - this will be showed when adding event fails
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail To Add"
                                                        message:@"Please Input Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (void)addItemViewController:(AddMeetingMapViewController *)controller didFinishEnteringItem:(double) item
{
    self.latitude = item;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString: @"annotateOnMap"]) {
//        AddMeetingMapViewController *destVC = [segue destinationViewController];
//        destVC.annotateTitle = self.titleText.text;
//    }
    if (sender != self.saveButton) return;
    if (self.titleText.text.length > 0) {
		
        //initialize the event object
		self.event = [[Event alloc] init];
		self.event.title = self.titleText.text;
        
        self.event.subject = self.subjectFromPicker.text;
            
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
        
        self.event.latitude = self.latitude;
        self.event.longitude = self.longitude;
        
        //test to see if the values are successfully passed
        NSLog(@"latitude %f", self.event.latitude);
        NSLog(@"longitude %f", self.event.longitude);
        NSLog(@"subject %@", self.event.subject);
        
        [NetWorkApi CreateEvent:self.event
                     completion:^(BOOL result){
                         if (!result) {
                             //alert information - this will be showed when adding event fails
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail To Add"
                                                                             message:@"Please Input Again."
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"OK"
                                                                   otherButtonTitles:nil];
                             [alert show];
                         }
                         
                     }];
    }
    
    
}

-(IBAction)unwindToAddEventTable: (UIStoryboardSegue *)segue {
    AddMeetingMapViewController *source = [segue sourceViewController];
    self.latitude = source.latitudeToPass;
    self.longitude = source.longitudeToPass;
}

@end
