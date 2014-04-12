//
//  LoginViewController.m
//  demo
//
//  Created by Xu Deng on 3/28/14.
//  Copyright (c) 2014 Xu Deng. All rights reserved.
//

#import "LoginViewController.h"
#import "NetWorkApi.h"
@interface LoginViewController ()
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *uname;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *myColor = [[UIColor alloc]initWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1];
    
    self.view.backgroundColor = myColor;
    
    self.password.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction) clickedBackground
{
    NSLog(@"123");
    [self.view endEditing:YES]; //make the view end editing!
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


-(void)dismissKeyboard {
    NSLog(@"222");
    [self.view endEditing:YES]; //make the view end editing!

}
- (IBAction)login:(id)sender {
    
    
    [NetWorkApi signInAccountWithUserName:self.uname.text
                           password:self.password.text
                         completion:^(BOOL success, NSString* desc) {
                             if (success) {
                                [self performSegueWithIdentifier:@"segue_login" sender:self];
                             } else {
                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"user name or password dismatch"
                                                                                 message:@"You need to type your user name or password again."
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK"
                                                                       otherButtonTitles:nil];
                                 [alert show];
                             }
                         }];
    

   // [alert release];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  //  NSLog(@"12");
  //  return [textField resignFirstResponder];
    [self login:self];
    [textField resignFirstResponder];
    return true;
}

@end
