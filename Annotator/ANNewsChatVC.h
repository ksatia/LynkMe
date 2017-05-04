//
//  ViewController.h
//  Annotator
//
//  Created by Karan Satia on 8/25/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANNewsChatCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ANShareLinkVC.h"
#import "GroupFetch.h"
#import "CoreDataFetch.h"
#import "ParseData.h"
#import "ANFriendsProfileCell.h"
#import "MBProgressHUD.h"
//#import "DataParser.h"


@interface ANNewsChatVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *scrollContacts;
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (strong, nonatomic) ANNewsChatCell *newsCell;
@property (strong, nonatomic) ANFriendsProfileCell *profileCell;
//@property (weak, nonatomic) IBOutlet UIView *expandedCellView;
@property (strong, nonatomic) UITapGestureRecognizer *tapViewRecognizer;
@property (strong, nonatomic) ANShareLinkVC *shareVC;
@property (strong, nonatomic) CoreDataFetch *coreData;
@property (strong, nonatomic) GroupFetch *groupFetch;
@property (strong, nonatomic) ParseData *parseData;
@property (strong, nonatomic) NSString *groupId;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (nonatomic) NSInteger superIndexPath;
@property (strong, nonatomic) NSString *articleTitle;
//@property (strong, nonatomic) DataParser *htmlParser;


- (IBAction)shareLink:(id)sender;
-(void)setGroupIdTest:(NSString *)groupId;
//-(void)getArticleTitleWithURL:(NSString *)url;
@end

