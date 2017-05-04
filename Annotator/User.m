//
//  User.m
//  Annotator
//
//  Created by Aditya Narayan on 9/2/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User


-(id)initWithFriends :(NSDictionary *)friends :(NSString *)url name:(NSString *)name {
    
    self = [super init];
    if (self) {
        self.friends = [[NSMutableDictionary alloc] init];
        self.friendsID = [friends valueForKey:@"data"];
        self.profileURL = url;
        self.name = name;
        
        for (NSDictionary *dictionary in self.friendsID) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"facebookID" equalTo:dictionary[@"id"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
//                    NSLog(@"Successfully retrieved %lu objects.", (unsigned long)objects.count);
                    // Do something with the found objects
                    for (PFObject *object in objects) {
 //                       NSLog(@"%@", [object valueForKey:@"pictureURL"]);
                        [self.friends setObject:[object valueForKey:@"pictureURL"] forKey:[object valueForKey:@"facebookID"]];
                    }
                } else {
                    // Log details of the failure
 //                   NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        
        
    }
    return self;
}


@end
