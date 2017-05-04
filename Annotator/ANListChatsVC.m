//
//  ANListChatsVC.m
//  Annotator
//
//  Created by Karan Satia on 8/27/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ANListChatsVC.h"


@interface ANListChatsVC ()

@end

@implementation ANListChatsVC {
    int rowCounter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"ANListChatsCell" bundle:nil] forCellReuseIdentifier:@"chatCell"];
    self.chatCell = [[UINib nibWithNibName:@"ANListChatsCell" bundle:nil] instantiateWithOwner:nil options:nil][0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(compareParseandCore)
                                                 name:@"GroupsUpdated"
                                               object:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {

    self.navigationItem.hidesBackButton = YES;
    self.coreData = [CoreDataFetch sharedManager];
    //[self.coreData loadGroups];
    self.parseData = [ParseData sharedManager];
    
    rowCounter = 0;
    
    
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateCoreData)
                                                 name:@"CompareFinished"
                                               object:nil];
}

// Compare Parse and Core Data for any changes

-(void)compareParseandCore {
    self.user = self.parseData.user;
    self.compareData = [CompareParseAndCoreData sharedManager];
    [self.compareData compareParseAndCoreData:self.parseData.user.id];
}

// After comparison is done, if new groups, reload data from Core Data

-(void)updateCoreData {
    
    [self.coreData loadGroups];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
        return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return [self.coreData.groupNames count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ANListChatsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell"];

    cell.titleLabel.text = self.coreData.groupNames[indexPath.row];

    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"Share"];
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    rowCounter++;
    
    return cell;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
 [self.tableView cellForRowAtIndexPath:indexPath].selectionStyle = UITableViewCellSelectionStyleNone;
    self.indexPath = indexPath;
 [self performSegueWithIdentifier:@"chat" sender:self];

}


-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            // Delete button is pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            [self.coreData.groupNames removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.coreData deleteGroup:cellIndexPath
             .row];
            [self.parseData deleteGroup:self.coreData.groupID[cellIndexPath.row]];
            break;

        }
        case 1:
        {
         
            // More button is pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            ANShareLinkVC  *vc = [storyboard instantiateViewControllerWithIdentifier:@"Share"];
            vc.indexPath = cellIndexPath.row;
            vc.userName = self.parseData.user.name;
            [self presentViewController:vc animated:YES completion:nil];
            [cell hideUtilityButtonsAnimated:YES];
            break;
                    }
        default:
            break;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addMembers"]) {
        
    ANAddUserVC *vc = [segue destinationViewController];
    [vc setFriends:self.user];
        
    }
    
    else if ([segue.identifier isEqualToString:@"chat"]) {
        
    ANNewsChatVC *vc = [segue destinationViewController];
        vc.superIndexPath = self.indexPath.row;
        [vc setGroupIdTest:self.coreData.groupID[self.indexPath.row]];
        self.groupFetch = [GroupFetch sharedManager];
        [self.groupFetch getGroupMembers:self.coreData.groupID[self.indexPath.row]];
        
    }
    
}





@end
