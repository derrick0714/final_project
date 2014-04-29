//
//  SignUpViewController.m
//  demo
//
//  Created by Xu Deng on 4/11/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "SignUpViewController.h"
#import "NetWorkApi.h"
#import <CommonCrypto/CommonDigest.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
- (IBAction)clickSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;

@end

@implementation SignUpViewController

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) showAlert:(NSString *)title message:(NSString*) message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *myColor = [[UIColor alloc]initWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1];
    
    self.view.backgroundColor = myColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];


 
}

- (void)keyboardWillHide:(NSNotification *)n
{
    [self animateTextField:_userName up:NO];

}

- (void)keyboardWillShow:(NSNotification *)n
{
    [self animateTextField:_userName up:YES];

}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


-(void)dismissKeyboard {
    [self.view endEditing:YES]; //make the view end editing!
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickSignUp:(id)sender {

    if([_userName.text isEqual:@""] || [_password1.text isEqual:@""] || [_password2.text isEqual:@""] ){
        [self showAlert:@"Error" message:@"All fields need to be filled!"];
    }else if(![_password1.text isEqualToString: _password2.text] ){
       [self showAlert:@"Error" message: @"Password dissmatch!"];
    }else if(_password1.text.length < 6){
       [self showAlert:@"Error" message:  @"Password needs at least 6 characters!"];
    }else{
        NSLog(@"sing up a new user: @%@, password:@%@, gender:@%d",_userName.text,[self md5:_password1.text], _gender.selectedSegmentIndex);
        [NetWorkApi signUpAccountWithUserName:_userName.text
                                     password:_password1.text
                                       gender:_gender.selectedSegmentIndex
                                   completion:^(BOOL success, NSString* desc) {
            if (success) {
                [self showAlert:@"Cangraulations!" message: @"sing up success! Tap to log in"];
                [self performSegueWithIdentifier:@"segul_home" sender:self];

            } else {
                [self showAlert:@"Error!" message: desc];
            }
        }];
    }
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}
@end
