//
//  GroupFetch.m
//  Annotator
//
//  Created by Karan Satia on 9/4/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "GroupFetch.h"
#import <Parse/Parse.h>

@implementation GroupFetch


+ (id)sharedManager {
    static GroupFetch *sharedGroupData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupData = [[self alloc] init];
    });
    
    return sharedGroupData;
}

-(void)getGroupMembers :(NSString *)groupId {
    self.groupMemberIds = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Groups"];
    [query whereKey:@"groupId" equalTo:groupId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //           NSLog(@"Successfully retrieved %lu groups.", (unsigned long)objects.count);
            
            for (PFObject *object in objects) {
//                NSLog(@"%@", object[@"facebookID"]);
                [self.groupMemberIds addObject:object[@"facebookID"]];
                }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupsLoaded" object:nil];
            
        }
        else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self getLinks:groupId];

}

-(void)getLinks :(NSString *)groupId {
    self.groupLinks = [[NSMutableArray alloc] init];
    self.linkIds = [[NSMutableArray alloc] init];
    self.groupMessages = [[NSMutableArray alloc] init];
    self.posterName = [[NSMutableArray alloc] init];
    PFQuery *linkQuery = [PFQuery queryWithClassName:@"Links"];
    [linkQuery whereKey:@"groupId" equalTo:groupId];
    [linkQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //           NSLog(@"Successfully retrieved %lu groups.", (unsigned long)objects.count);
            
            for (PFObject *object in objects) {
 //               NSLog(@"%@", object[@"URL"]);
                [self.groupLinks addObject:object[@"URL"]];
                [self.groupMessages addObject:object[@"Message"]];
                [self.linkIds addObject:object[@"linkId"]];
                [self.posterName addObject:object[@"SubmittedBy"]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddedLink" object:nil];
        
        }
        else {
 //           NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

-(void)notificationLink :(NSString *)groupName {
    
    for (NSString *facebookId in self.groupMemberIds) {
    
    PFQuery *query = [PFInstallation query];
    [query whereKey:@"FacebookId" equalTo:facebookId];
    
    PFPush *push = [[PFPush alloc] init];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"A new link has been posted to %@", groupName], @"alert", @"Increment",@"badge", nil];
    [push setQuery:query];
    [push setData:data];
    [push sendPushInBackground];
    
    }
    
}

-(void)deleteLink :(NSString *)linkId {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Links"];
    [query whereKey:@"linkId" equalTo:linkId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            [PFObject deleteAllInBackground:objects];
        } else {
            // Log details of the failure
 //           NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
     
     }

@end
