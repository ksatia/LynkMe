//
//  ANLoginVC.h
//  Annotator
//
//  Created by Aditya Narayan on 9/1/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ParseData.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import <ParseUI/ParseUI.h>


@interface ANLoginVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

//@property (weak, nonatomic) IBOutlet UITextField *usernameField;
//@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *logoBlock;
//@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

//- (IBAction)logIn:(id)sender;
- (IBAction)facebookLogIn:(id)sender;
- (void)_loadData;

//@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
//@property (weak, nonatomic) IBOutlet UIImageView *passwordIcon;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) ParseData *parseData;
@property (strong, nonatomic) PFUser *PFUser;


@end
