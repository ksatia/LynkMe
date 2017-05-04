//
//  addUserFirstUseViewController.h
//  Annotator
//
//  Created by Karan Satia on 8/27/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addUserAnimation.h"
#import "addUserFirstUseCell.h"
#import "User.h"
//#import "ANLoginVC.h"
#import "ParseData.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"


@interface ANAddUserVC : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate, NSURLConnectionDataDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}



@property (weak, nonatomic) IBOutlet UITableView *friendsTable;
@property (strong, nonatomic) addUserFirstUseCell *cell;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) User *user;
//@property (strong, nonatomic) ANLoginVC *loginVC;
@property (strong, nonatomic) ParseData *parseData;
@property (weak, nonatomic) IBOutlet UITextField *groupName;
@property (strong, nonatomic) NSMutableArray *groupMembers;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


- (IBAction)saveGroup:(id)sender;
-(void)setFriends :(User *)user;


@end
