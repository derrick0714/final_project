//
//  ViewController.m
//  GKImagePicker
//
//  Created by Xu Deng on 3/30/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//


#import "EditProfileViewController.h"
#import "GKImagePicker.h"

@interface EditProfileViewController () <GKImagePickerDelegate> {
    IBOutlet UIImageView *myImageView;
    GKImagePicker *picker;
}
@property (nonatomic, retain) GKImagePicker *picker;
- (IBAction)handleImageButton:(id)sender;
@end

@implementation EditProfileViewController

@synthesize picker = _picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - User interaction methods

- (IBAction)handleImageButton:(id)sender {
    self.picker = [[GKImagePicker alloc] init];
    self.picker.delegate = self;
    self.picker.cropper.cropSize = CGSizeMake(320.,320.);   // (Optional) Default: CGSizeMake(320., 320.)
    self.picker.cropper.rescaleImage = YES;                // (Optional) Default: YES
    self.picker.cropper.rescaleFactor = 2.0;               // (Optional) Default: 1.0
    self.picker.cropper.dismissAnimated = YES;              // (Optional) Default: YES
    self.picker.cropper.overlayColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];  // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
    self.picker.cropper.innerBorderColor = [UIColor colorWithRed:255./255. green:255./255. blue:255./255. alpha:0.7];   // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
    [self.picker presentPicker];
}

#pragma mark - GKImagePicker delegate methods

- (void)imagePickerDidFinish:(GKImagePicker *)imagePicker withImage:(UIImage *)image {
    myImageView.contentMode = UIViewContentModeCenter;
    myImageView.image = image;
}

@end
