//
//  ANLogOutVC.m
//  Annotator
//
//  Created by Karan Satia on 9/14/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANLogOutVC.h"

@interface ANLogOutVC ()

@end

@implementation ANLogOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)logOutButton:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"returnToLogin" sender:self];
}
@end
