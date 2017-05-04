//
//  ShareViewController.h
//  LynkMe
//
//  Created by Karan Satia on 9/24/16.
//  Copyright © 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>




@interface ShareViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) NSString *linkText;
@property (weak, nonatomic) IBOutlet UITextField *MessageText;
@property (weak, nonatomic) IBOutlet UITextField *groupText;
@property (weak, nonatomic) IBOutlet UIPickerView *groupPicker;

- (IBAction)shareButton:(id)sender;
- (IBAction)cancelButton:(id)sender;


@end
