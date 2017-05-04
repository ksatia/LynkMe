//
//  ANShareLinkVC.h
//  Annotator
//
//  Created by Aditya Narayan on 9/4/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataFetch.h"
#import "GroupFetch.h"

@interface ANShareLinkVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *linkText;
@property (weak, nonatomic) IBOutlet UITextField *messageText;
@property (strong, nonatomic) CoreDataFetch *coreData;
@property (nonatomic) NSInteger indexPath;
@property (strong, nonatomic)  GroupFetch *groupUpdate;
@property (strong, nonatomic) NSString *userName;

- (IBAction)cancelButton:(id)sender;
- (IBAction)shareButton:(id)sender;


@end
