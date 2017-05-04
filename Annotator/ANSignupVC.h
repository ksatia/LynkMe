//
//  ANSignupVC.h
//  Annotator
//
//  Created by Karan Satia on 9/4/16.
//  Copyright © 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import "ParseData.h"


@interface ANSignupVC : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (nonatomic, strong) ParseData *parseData;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)signUp:(id)sender;
- (IBAction)signupWithFB:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *backButton;

@end
