//
//  ParseData.m
//  Annotator
//
//  Created by Aditya Narayan on 9/2/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "ParseData.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import <ParseUI/ParseUI.h>

@implementation ParseData {
    NSString *facebookID;
}

+ (id)sharedManager {
    static ParseData *sharedParseData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParseData = [[self alloc] init];
    });
    return sharedParseData;
}

-(void)loadData {
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:nil];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id, name"}];
    FBSDKGraphRequest *requestFriends = [[FBSDKGraphRequest alloc]
                                         initWithGraphPath:@"me/friends" parameters:@{@"fields":@"id, name"}];
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    [connection addRequest:request
         completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             NSDictionary *userData = (NSDictionary *)result;
        
             facebookID = userData[@"id"];
             self.url = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
             //NSURL *pictureURL = [NSURL URLWithString:url];
             self.user.profileURL = self.url;
             self.name = userData[@"name"];
             [[PFUser currentUser] setObject:userData[@"name"] forKey:@"Name"];
             [[PFUser currentUser] setObject:self.url forKey:@"pictureURL"];
             [[PFUser currentUser] setObject:userData[@"id"] forKey:@"facebookID"];
             [[PFUser currentUser] saveInBackground];
             
             PFInstallation *installation = [PFInstallation currentInstallation];
             [installation setObject:userData[@"id"] forKey:@"FacebookId"];
             [installation saveInBackground];
            
             
         }];
    [connection addRequest:requestFriends
         completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             //TODO: process like information
             NSArray* friends = [result objectForKey:@"data"];
//             NSLog(@"Found: %lu friends", (unsigned long)friends.count);
             NSDictionary *userData = (NSDictionary *)result;
             self.user = [[User alloc] initWithFriends:userData :self.url name:self.name];
             self.user.id = facebookID;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupsUpdated" object:nil];
         }];
    
    [connection start];
}


-(void)saveGroup :(NSString *)groupName :(NSArray *)groupMembers :(NSString *)groupId {
   
    for (NSString *id in groupMembers) {
        
        PFObject *group = [PFObject objectWithClassName:@"Groups"];
        [group setObject:id  forKey:@"facebookID"];
        [group setObject:groupName forKey:@"groupName"];
        [group setObject:groupId forKey:@"groupId"];
        [group saveInBackground];
        
     
        
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"FacebookId" equalTo:id];
        
        if (id != self.user.id) {
        
        PFPush *push = [[PFPush alloc] init];
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"You have just been added to the group: %@", groupName], @"alert", @"Increment",@"badge", nil];
        [push setQuery:pushQuery];
        [push setData:data];
        [push sendPushInBackground];
        
        }
    }
}

-(void)deleteGroup :(NSString *)groupId {
//    PFObject *object = [PFObject objectWithoutDataWithClassName:@"Groups"
//                                                       objectId:groupId];
//    [object deleteInBackground];
    PFQuery *query = [PFQuery queryWithClassName:@"Groups"];
    [query whereKey:@"groupId" equalTo:groupId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
//            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
         [PFObject deleteAllInBackground:objects];
        } else {
            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}




@end
