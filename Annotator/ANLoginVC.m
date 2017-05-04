//
//  ANLoginVC.m
//  Annotator
//
//  Created by Aditya Narayan on 9/1/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANLoginVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import <ParseUI/ParseUI.h>


@interface ANLoginVC ()

@end

@implementation ANLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:nil];
    [self drawBorders];
//    self.usernameField.delegate = self;
//    self.passwordField.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


-(void)drawBorders {
    
//    
//    CALayer *bottomBorder = [CALayer layer];
//    CGRect frm = self.usernameField.bounds;
//    frm.origin.y = frm.size.height-1;
//    bottomBorder.frame = frm;
//    
//    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
//    [self.usernameField.layer addSublayer:bottomBorder];
//    
//    
//    CALayer *passwordBorder = [CALayer layer];
//    CGRect btm = self.passwordField.bounds;
//    btm.origin.y = btm.size.height-1;
//    passwordBorder.frame = btm;
//    
//    passwordBorder.backgroundColor = [UIColor grayColor].CGColor;
//    [self.passwordField.layer addSublayer:passwordBorder];
    
    
    [self.logoBlock.layer setCornerRadius:5.0f];
    self.logoBlock.layer.masksToBounds = YES;
    
//    [self.signInButton.layer setCornerRadius:5.0f];
//    self.signInButton.layer.masksToBounds = YES;
    
    [self.facebookButton.layer setCornerRadius:5.0f];
    self.facebookButton.layer.masksToBounds = YES;
    
}



//- (IBAction)logIn:(id)sender {
//    NSString *username = self.usernameField.text;
//    NSString *password = self.passwordField.text;
//    
//    self.PFUser = [PFUser currentUser];
//    self.PFUser.username = username;
//    self.PFUser.password = password;
//    
//    
//    if (username.length == 0 || password.length == 0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to log you in"
//                                                       message:@"Please fill in all fields"
//                                                      delegate:self
//                                             cancelButtonTitle:@"OK"
//                                             otherButtonTitles:nil];
//        [alert show];
//    }
//
//    else {
//        
//    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError * error) {
//            
//            if (user) {
//                [self performSegueWithIdentifier:@"loginsuccessful" sender:self];
//            }
//            
//            else {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User not found."
//                                                               message:@"Would you like to sign up?"
//                                                              delegate:self
//                                                     cancelButtonTitle:@"Cancel"
//                                                     otherButtonTitles:@"OK", nil];
//                alert.tag = 50;
//                
//                [alert show];
//            }
//        }];
//    }
//}


- (IBAction)facebookLogIn:(id)sender {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[@"public_profile", @"email", @"user_friends"];
    
        // Login PFUser using Facebook
        [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
    
            if (!user) {
            //    NSLog(@"Uh oh. The user cancelled the Facebook login.");
            }
            else if (user.isNew) {
            //    NSLog(@"User signed up and logged in through Facebook!");
                [self _loadData];
                [self performSegueWithIdentifier:@"login" sender:self];
            }
            else {
           //     NSLog(@"user email: %@", user.email);
            //    NSLog(@"User logged in through Facebook!");
                [self _loadData];
                [self performSegueWithIdentifier:@"login" sender:self];
            }
        }];
}


//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (alertView.tag == 50) {
//        
//        if (buttonIndex != [alertView cancelButtonIndex]){
//            
//                    [self performSegueWithIdentifier:@"signup" sender:self];
//                    
//                }
//        }
//}


- (void)_loadData {
   
    self.parseData = [ParseData sharedManager];
    [self.parseData loadData];
    [self performSegueWithIdentifier:@"login" sender:self];
}


@end
