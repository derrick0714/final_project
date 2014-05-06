//
//  EditProfileTableViewController.m
//  demo
//
//  Created by Xu Deng on 4/1/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "EditProfileTableViewController.h"
#import "GKImagePicker.h"
#import "MeTableViewController.h"
#import "NetWorkApi.h"
#import "User.h"

@interface EditProfileTableViewController()<GKImagePickerDelegate>{
  GKImagePicker *picker;
}
@property (nonatomic, retain) GKImagePicker *picker;
@property (weak, nonatomic) IBOutlet UIView *myPhoto;
@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *genderTextField;
@property (weak, nonatomic) IBOutlet UILabel *majorTextField;


@property (weak, nonatomic) IBOutlet UIPickerView *genderPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *majorPickerView;

@property (strong, nonatomic) NSArray *genderArray;
@property (strong, nonatomic) NSArray *majorArray;

@property (weak, nonatomic) IBOutlet UITableViewCell *genderPickerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *majorPickerCell;

@property BOOL genderPickerIsShowing;
@property BOOL majorPickerIsShowing;

@property BOOL genderFromPicker;
@property NSString* majorFromPicker;
@property NSString* nameToBeUpdated;

@end

@implementation EditProfileTableViewController
@synthesize picker = _picker;

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
    
    [self.genderPickerView setDelegate:self];
    [self.majorPickerView setDelegate:self];
    self.genderArray = [[NSArray alloc] initWithObjects:@"Male",@"Female", nil];
    
    self.majorArray  = [[NSArray alloc]         initWithObjects:@"Math",@"Physics",@"ComputerScience",@"Biology",@"Economics",@"E.E." , nil];
    
    self.genderPickerView.hidden = YES;
    self.majorPickerView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    tap.cancelsTouchesInView = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	if(self.userid != [NetWorkApi getSelfId]) {
		// disable buttons, etc.
	}
	__block User *u;
	[NetWorkApi getUserInfo:self.userid completion:^(User *user) {
		u = user;
		self.photo.image = user.photo;
        self.nameTextField.placeholder = user.userName;
        self.genderTextField.text = user.gender ? @"Male" : @"Female";
        self.majorTextField.text = user.subject;
    }];
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
    if (pickerView == self.genderPickerView) {
        return 2;
    }
    return 6;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.genderPickerView) {
        return [self.genderArray objectAtIndex:row];
    }
    return [self.majorArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if (pickerView == self.genderPickerView) {
        self.genderTextField.text = [self.genderArray objectAtIndex: row];
        if ([self.genderTextField.text  isEqual: @"Male"]) {
            self.genderFromPicker = 0;
        }
        else{
            self.genderFromPicker = 1;
        }
    }
    else if (pickerView == self.majorPickerView){
        self.majorTextField.text = [self.majorArray objectAtIndex: row];
        self.majorFromPicker = [self.majorArray objectAtIndex: row];
    }
}


-(void)dismissKeyboard {
    [self.view endEditing:YES]; //make the view end editing!
}

//below code is used to hide the date pciker cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = self.tableView.rowHeight;
    
    if (indexPath.section==0) {
        return 80;
    }
    
    if (indexPath.section==1 && indexPath.row==2){
        height = self.genderPickerIsShowing ? 185 : 0.0f;
    }
    if (indexPath.section==1 && indexPath.row==4){
        height = self.majorPickerIsShowing ? 185 : 0.0f;
    }
    
    return height;
}


//methods for showing and hiding date picker cells
- (void)showGenderPickerCell {
    
    self.genderPickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.genderPickerView.hidden = NO;
    self.genderPickerView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.genderPickerView.alpha = 1.0f;
    }];
}

- (void)hideGenderPickerCell {
    
    self.genderPickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.genderPickerView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.genderPickerView.hidden = YES;
                     }];
}

- (void)showMajorPickerCell {
    
    self.majorPickerIsShowing = YES;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    self.majorPickerView.hidden = NO;
    self.majorPickerView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.majorPickerView.alpha = 1.0f;
    }];
}

- (void)hideMajorPickerCell {
    
    self.majorPickerIsShowing = NO;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.majorPickerView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         self.majorPickerView.hidden = YES;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
	
    if(indexPath.section == 0 && indexPath.row ==0) {
        self.picker = [[GKImagePicker alloc] init];
        self.picker.delegate = self;
        self.picker.cropper.cropSize = CGSizeMake(320,320);   // (Optional) Default: CGSizeMake(320., 320.)
        self.picker.cropper.rescaleImage = YES;                // (Optional) Default: YES
        self.picker.cropper.rescaleFactor = 2.0;               // (Optional) Default: 1.0
        self.picker.cropper.dismissAnimated = YES;              // (Optional) Default: YES
        self.picker.cropper.overlayColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];  // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
        self.picker.cropper.innerBorderColor = [UIColor colorWithRed:255./255. green:255./255. blue:255./255. alpha:0.7];   // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
        [self.picker presentPicker];
    } else if (indexPath.section==1 && indexPath.row==1) {
        if (self.genderPickerIsShowing){
            [self hideGenderPickerCell];
        }else {
            [self showGenderPickerCell];
        }
    } else if (indexPath.section==1 && indexPath.row==3) {
        if (self.majorPickerIsShowing){
            [self hideMajorPickerCell];
        }else {
            [self showMajorPickerCell];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	switch(section) {
		case 0: return 1;
		case 1: return 5;
        case 2: return 1;
		default: return 0;
	}
}

- (void)imagePickerDidFinish:(GKImagePicker *)imagePicker withImage:(UIImage *)image {
   // myImageView.contentMode = UIViewContentModeCenter;
    //myImageView.image = image;
    NSIndexPath *a = [NSIndexPath indexPathForRow:0 inSection:0]; // I wanted to update this cell specifically
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:a];
    cell.imageView.image =image;

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
        NSLog(@"1");
    }
    else if([[segue identifier] isEqualToString:@"segueToLogin"]) {
        
    }
    else {
        NSIndexPath *a = [NSIndexPath indexPathForRow:0 inSection:0]; // I wanted to update this cell specifically
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:a];
        
        MeTableViewController * detailViewController = [segue destinationViewController];
        detailViewController.myphoto =  cell.imageView.image;
        
        CGDataProviderRef provider = CGImageGetDataProvider(cell.imageView.image.CGImage);
        NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
        

        
        //update name, gender and Major
        
        //name: "self.nameTextField.text"  NSString type,
        //gender: "self.genderFromPicker"  BOOL type,
        //major: "self.majorFromPicker"  NSString type.
        
        
        
        
        [NetWorkApi updateImage:data completion:^(BOOL result) {
            NSLog(@"upload image success");
        }];


    }
}
 

@end
