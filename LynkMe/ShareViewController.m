//
//  ShareViewController.m
//  LynkMe
//
//  Created by Karan Satia on 9/24/16.
//  Copyright © 2016 Karan Satia. All rights reserved.
//

#import "ShareViewController.h"


@interface ShareViewController ()
{
    NSString *test;
}


@end

@implementation ShareViewController

-(void)viewDidLoad {
    NSExtensionItem *item = self.extensionContext.inputItems.firstObject;
    NSItemProvider *itemProvider = item.attachments.firstObject;
    if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url, NSError *error) {
            NSLog(@"%@", url.absoluteString);
            self.linkText = url.absoluteString;
        }];
    }
//    self.groupText.enabled = NO;
    self.groupPicker.hidden = YES;
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.ShareExtensionShareDefaults"];
    NSLog(@"%@", [defaults objectForKey:@"SessionToken"]);
    test = [defaults objectForKey:@"SessionToken"];
}


-(void)viewWillAppear:(BOOL)animated {
    [self.MessageText becomeFirstResponder];
    animated = NO;
}


- (IBAction)shareButton:(id)sender {
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

- (IBAction)cancelButton:(id)sender {
    
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"Clicked");
    [self.view endEditing:YES];
    [self.groupPicker setHidden:NO];
    return NO;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 3;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return test;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    
    NSLog(@"Row selected");
}

-(void)parseGroupFetch {
    
    
    
}

@end
