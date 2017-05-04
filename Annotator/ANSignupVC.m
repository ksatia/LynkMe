//
//  ANSignupVC.m
//  Annotator
//
//  Created by Karan Satia on 9/4/16.
//  Copyright © 2016 Karan Satia. All rights reserved.
//

#import "ANSignupVC.h"
#import "ANLoginVC.h"

@interface ANSignupVC ()

@end

@implementation ANSignupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBorders];
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.phoneNumberField.delegate = self;
    /*
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.scrollView.subviews)
        scrollViewHeight += view.frame.size.height;
    }
    self.scrollView.contentSize = CGSizeMake(519, scrollViewHeight);
*/
}

-(void)viewDidLayoutSubviews {
    self.scrollView.contentSize = CGSizeMake(200, 550);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


-(void)addBorders {
    
    CALayer *bottomBorder = [CALayer layer];
    CGRect frm = self.usernameField.bounds;
    frm.origin.y = frm.size.height-1;
    bottomBorder.frame = frm;
    
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.usernameField.layer addSublayer:bottomBorder];
    
    
    CALayer *passwordBorder = [CALayer layer];
    CGRect btm = self.passwordField.bounds;
    btm.origin.y = btm.size.height-1;
    passwordBorder.frame = btm;
    
    passwordBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.passwordField.layer addSublayer:passwordBorder];

    
    CALayer *phoneBorder = [CALayer layer];
    CGRect phone = self.phoneNumberField.bounds;
    phone.origin.y = phone.size.height-1;
    phoneBorder.frame = phone;
    
    phoneBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.phoneNumberField.layer addSublayer:phoneBorder];

    CALayer *firstName = [CALayer layer];
    CGRect firstNameCG = self.firstName.bounds;
    firstNameCG.origin.y = firstNameCG.size.height-1;
    firstName.frame = firstNameCG;
    
    firstName.backgroundColor = [UIColor grayColor].CGColor;
    [self.firstName.layer addSublayer:firstName];
    
    CALayer *lastName = [CALayer layer];
    CGRect lastNameCG = self.lastName.bounds;
    lastNameCG.origin.y = lastNameCG.size.height-1;
    lastName.frame = lastNameCG;
    
    lastName.backgroundColor = [UIColor grayColor].CGColor;
    [self.lastName.layer addSublayer:lastName];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)signUp:(id)sender {
    
    NSString *firstName = self.firstName.text;
    NSString *lastName = self.lastName.text;
    NSString *combinedName = [firstName stringByAppendingString:@" "];
    NSString *fullname = [combinedName stringByAppendingString:lastName];
    NSString *userName = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *phoneNumber = [self.phoneNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    
    PFUser *user = [PFUser user];
    user.username = userName;
    user.password = password;
    user[@"Name"] = fullname;
    user[@"phoneNumber"] = phoneNumber;
    
    if (userName.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to sign you up"
                                                       message:@"Please fill in all fields"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];

    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
         //   NSLog(@"successful sign up");
            [self performSegueWithIdentifier:@"signupsuccessful" sender:self];
        }
        
        else {
       //     NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)signupWithFB:(id)sender {
    
    NSArray *permissionsArray = @[@"public_profile", @"email", @"user_friends"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
         //   NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
         //   NSLog(@"User signed up and logged in through Facebook!");
            self.parseData = [ParseData sharedManager];
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }
        
        else {
            
          //  NSLog(@"user email: %@", user.email);
          //  NSLog(@"User logged in through Facebook!");
            self.parseData = [ParseData sharedManager];
        }
    }];

    
}
@end
