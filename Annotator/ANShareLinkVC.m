//
//  ANShareLinkVC.m
//  Annotator
//
//  Created by Aditya Narayan on 9/4/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANShareLinkVC.h"
#import <Parse/Parse.h>

@interface ANShareLinkVC ()

@end

@implementation ANShareLinkVC 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coreData = [CoreDataFetch sharedManager];
    UIPasteboard *thePasteboard = [UIPasteboard generalPasteboard];
    NSString *pasteboardString = thePasteboard.string;
    self.linkText.text = pasteboardString;
    [self.messageText setDelegate:self];
    [self.linkText setDelegate:self];
    self.groupUpdate = [GroupFetch sharedManager];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)shareButton:(id)sender {
    int randomID = arc4random() % 9000 + 1000;
    NSString *randomId = [NSString stringWithFormat:@"%i", randomID];
    
    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray *name = [self.userName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString *words in name) {
        NSString *initials = [words substringToIndex:1];
        [firstCharacters appendString:initials];
    }
    
   // NSLog(@"%ld", (long)self.indexPath);
    PFObject *link = [PFObject objectWithClassName:@"Links"];
    [link setObject:self.linkText.text  forKey:@"URL"];
    [link setObject:self.coreData.groupID[self.indexPath] forKey:@"groupId"];
    [link setObject:self.messageText.text forKey:@"Message"];
    [link setObject:randomId forKey:@"linkId"];
    [link setObject:firstCharacters forKey:@"SubmittedBy"];
    [link saveInBackground];
   
   
    [self.groupUpdate notificationLink:self.coreData.groupNames[self.indexPath]];
    [self.groupUpdate getLinks:self.coreData.groupID[self.indexPath]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddedLink" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
