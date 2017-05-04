//
//  addUserFirstUseViewController.m
//  Annotator
//
//  Created by Karan Satia on 8/27/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANAddUserVC.h"
#import "addUserFirstUseCell.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>


@interface ANAddUserVC ()

@end

@implementation ANAddUserVC {
    BOOL cellChecked;
    int rowCounter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsTable.separatorColor = [UIColor clearColor];
    //[self drawFriendBox];
    UIColor *color2 = [UIColor colorWithRed: 0.83 green: 0.448 blue: 0.546 alpha: 1];

    self.welcomeLabel.textColor = color2;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.groupMembers = [[NSMutableArray alloc] init];
    self.parseData = [ParseData sharedManager];
    rowCounter = 0;
    [self.groupName setDelegate:self];
    
    if (self.user.id != nil) {
    [self.groupMembers addObject:self.user.id];
    }

}


-(void)drawFriendBox{
    [addUserAnimation drawShapeInView:self.view];
}

-(void)setFriends :(User *)user {
    
    self.user = user;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [self.user.friendsID count];
    
    return rows;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    
    addUserFirstUseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    if (cell == nil)
    {
        cell = (addUserFirstUseCell *) [[[NSBundle mainBundle] loadNibNamed:@"addUserFirstUseCell" owner:self options:nil] lastObject];
    }
    cell.friendsPicture.layer.masksToBounds = YES;
    NSDictionary *friend = self.user.friendsID[indexPath.row];
    cell.friendsName.text = friend [@"name"];
    NSString *friendsID = [self.user.friendsID[indexPath.row] valueForKey:@"id"];
    NSURL *profileURL = [NSURL URLWithString:[self.user.friends valueForKey:friendsID]];
    __weak UIImageView *friendImage = cell.friendsPicture;
   
    [friendImage setImageWithURLRequest:[NSURLRequest requestWithURL:profileURL] placeholderImage:nil success:^ (NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        friendImage.image = image;
        friendImage.alpha = 1.0;
        friendImage.layer.cornerRadius = 21;
    
    } failure:nil];
    
    return cell;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
    
}


//For custom spacing between cells
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *friend = self.user.friendsID[indexPath.row];
    if (!cellChecked) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.groupMembers addObject:friend[@"id"]];
    cellChecked = YES;
    }
    else {
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self.groupMembers removeObject:friend[@"id"]];
    cellChecked = NO;
        
    }

    

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)saveGroup:(id)sender {
    int randomID = arc4random() % 9000 + 1000;
    NSString *randomId = [NSString stringWithFormat:@"%i", randomID];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [appDelegate managedObjectContext];
    NSManagedObject *groupName = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:self.managedObjectContext];
    [groupName setValue:self.groupName.text forKey:@"name"];
    [groupName setValue:randomId forKey:@"groupID"];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
    //    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self.parseData saveGroup:self.groupName.text :self.groupMembers :randomId];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CompareFinished" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
