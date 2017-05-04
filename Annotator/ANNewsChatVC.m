//
//  ViewController.m
//  Annotator
//
//  Created by Karan Satia on 8/25/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANNewsChatVC.h"
#import "UIImageView+AFNetworking.h"
#import "ANWebViewVC.h"
#import <AFNetworking.h>
#import "Constants.h"
//#import "HTMLData.h"

@interface ANNewsChatVC ()
{
    NSInteger row;
}

@end

@implementation ANNewsChatVC

    BOOL expandedShow = NO;
    int  rowCount;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(70.0, 70.0);
    flowLayout.minimumLineSpacing = 20;
    //flowLayout.sectionInset = UIEdgeInsetsMake(-68, 10, 0, 0);
  //  [self.scrollContacts setShowsHorizontalScrollIndicator:NO];
    [self.scrollContacts setCollectionViewLayout:flowLayout];
   

    [self.newsTableView registerNib:[UINib nibWithNibName:@"ANNewsChatCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    self.newsCell = [[UINib nibWithNibName:@"ANNewsChatCell" bundle:nil] instantiateWithOwner:nil options:nil][0];
    
    UINib *cellNib = [UINib nibWithNibName:@"ANFriendsProfileCell" bundle:nil];
    [self.scrollContacts registerNib:cellNib forCellWithReuseIdentifier:@"profileCell"];
    [self.scrollContacts setContentInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    /*
    self.expandedCellView.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    self.expandedCellView.layer.borderWidth = 1;
    self.expandedCellView.layer.cornerRadius = 10;
    [self.expandedCellView setHidden:YES];
    */
    self.coreData = [CoreDataFetch sharedManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCollectionView)
                                                 name:@"GroupsLoaded"
                                               object:nil];

    self.navigationItem.title = self.coreData.groupNames[self.superIndexPath];
    
    [self.groupFetch getGroupMembers:self.groupId];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.groupFetch = [GroupFetch sharedManager];
    self.parseData = [ParseData sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTableView)
                                                 name:@"AddedLink"
                                               object:nil];
    
    rowCount = 0;
}

-(void)setGroupIdTest:(NSString *)groupId {
    self.groupId = groupId;
    
}

-(void)updateTableView {
    [self.newsTableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)updateCollectionView {
    [self.scrollContacts reloadData];
//    [self.newsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.groupFetch.groupMemberIds.count != 0) {
        return [self.groupFetch.groupMemberIds count];
    }
    
    return 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ANFriendsProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"profileCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 35;
    cell.layer.borderColor = [UIColor colorWithRed:0.592 green:0.592 blue:0.592 alpha:1].CGColor;
    cell.layer.borderWidth = 1;
    if (self.groupFetch.groupMemberIds.count != 0) {
     //   cell.collectionLabel.text = self.groupFetch.groupMemberIds[indexPath.row];
    }
    
    
    NSURL *profileURL;
    NSString *friendsID;
    if (self.groupFetch.groupMemberIds.count != 0) {
    friendsID = self.groupFetch.groupMemberIds[indexPath.row];
    }
    /*
    if (indexPath.row == 0) {
        profileURL = [NSURL URLWithString:self.parseData.user.profileURL];
    }
    else {
        profileURL = [NSURL URLWithString:[self.parseData.user.friends valueForKey:friendsID]];
    }
     */
 //   friendsID = self.groupFetch.groupMemberIds[indexPath.row];
    profileURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", friendsID]];
    __weak UIImageView *friendImage = cell.profilePic;
    friendImage.layer.masksToBounds = YES;
    [friendImage setImageWithURLRequest:[NSURLRequest requestWithURL:profileURL] placeholderImage:nil success:^ (NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        friendImage.image = image;
        friendImage.alpha = 1.0;
        friendImage.layer.cornerRadius = 35;
        
    } failure:nil];
    [cell addSubview:friendImage];
    
    return cell;
}

#pragma mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.groupFetch.groupLinks.count != 0) {
        return self.groupFetch.groupLinks.count;
    }
    return 0;
}

//For custom spacing between cells
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18;
}

//Sets section to clear to show background for spacing
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
//    [self getArticleTitleWithURL:self.groupFetch.groupLinks[indexPath.row]];
    
    ANNewsChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (self.groupFetch.groupLinks.count != 0) {
    cell.linkMessage.text = self.groupFetch.groupMessages[indexPath.row];
    cell.linkTitle.text = self.groupFetch.groupLinks[indexPath.row];
    cell.initials.text = self.groupFetch.posterName[indexPath.row];
        /*
        NSString *facebookId = self.groupFetch.posterId[indexPath.row];
        NSURL *profileURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookId]];
        __weak UIImageView *friendImage = cell.initials;
        friendImage.layer.masksToBounds = YES;
        [friendImage setImageWithURLRequest:[NSURLRequest requestWithURL:profileURL] placeholderImage:nil success:^ (NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            friendImage.image = image;
            friendImage.alpha = 1.0;
            friendImage.layer.cornerRadius = 21;
            
        } failure:nil];
        [cell addSubview:friendImage];
         */
    }
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    return cell;
}


//-(void)getArticleTitleWithURL:(NSString *)url {
//    NSString *urlarticlepassed = url;
//    self.htmlParser = [[DataParser alloc]loadHTMLByURL:url];
//    self.articleTitle = [self.htmlParser.elementArray objectAtIndex:0];
//
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
 //   ANWebViewVC * vc = [storyboard instantiateViewControllerWithIdentifier:@"webView"];
 //   vc.url = self.groupFetch.groupLinks[indexPath.row];
 //   [self presentViewController:vc animated:YES completion:nil];
    row = indexPath.row;
    [self performSegueWithIdentifier:@"webView" sender:self];
    /*
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
     CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    CGPoint centerPoint = CGPointMake(rect.origin.x + (rect.size.width / 2), rect.origin.y + (rect.size.height / 2));
    [self.newsTableView cellForRowAtIndexPath:indexPath].selectionStyle = UITableViewCellSelectionStyleNone;
    self.expandedCellView.center = centerPoint;
    [self showExpandedCell];
    */
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            // Delete button is pressed
            NSIndexPath *cellIndexPath = [self.newsTableView indexPathForCell:cell];
            [self.groupFetch.groupLinks removeObjectAtIndex:cellIndexPath.row];
            [self.groupFetch.groupMessages removeObjectAtIndex:cellIndexPath.row];
            [self.newsTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.groupFetch deleteLink:self.groupFetch.linkIds[cellIndexPath.row]];
            break;
            
        }
        default:
            break;
    }
}

/*
-(void)showExpandedCell {
    
    if (expandedShow == NO) {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [self.expandedCellView.layer addAnimation:animation forKey:nil];
    
    [self.expandedCellView setHidden:NO];
        expandedShow = YES;
    self.tapViewRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissExpandedCell)];
    [self.view addGestureRecognizer:self.tapViewRecognizer];
    }

    
}
*/
/*
-(void)dismissExpandedCell {

    if (expandedShow == YES) {
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.3;
        [self.expandedCellView.layer addAnimation:animation forKey:nil];
        
        [self.expandedCellView setHidden:YES];
        expandedShow = NO;
        [self.view removeGestureRecognizer:self.tapViewRecognizer];
    }
}
*/


- (IBAction)shareLink:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    self.shareVC = [storyboard instantiateViewControllerWithIdentifier:@"Share"];
    
    self.shareVC.indexPath = self.superIndexPath;
    
    self.shareVC.userName = self.parseData.user.name;
    
    [self presentViewController:self.shareVC animated:YES completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ANWebViewVC *vc = [segue destinationViewController];
    vc.url = self.groupFetch.groupLinks[row];
    
}
@end
