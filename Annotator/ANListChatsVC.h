//
//  ANListChatsVC.h
//  Annotator
//
//  Created by Karan Satia on 8/27/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANListChatsCell.h"
#import "ANNewsChatVC.h"
#import "ParseData.h"
#import <Parse/Parse.h>
#import "User.h"
#import "CoreDataFetch.h"
#import "CompareParseAndCoreData.h"
#import "SWTableViewCell.h"
#import "GroupFetch.h"
#import "ANShareLinkVC.h"

@interface ANListChatsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ANListChatsCell *chatCell;
@property (strong, nonatomic) ANNewsChatVC *newsChatVC;
@property (strong, nonatomic) ParseData *parseData;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) CoreDataFetch *coreData;
@property (strong, nonatomic) CompareParseAndCoreData *compareData;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) GroupFetch *groupFetch;
@property (strong, nonatomic) ANShareLinkVC *shareLink;

@end
