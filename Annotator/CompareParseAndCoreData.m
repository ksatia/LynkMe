//
//  CompareParseAndCoreData.m
//  Annotator
//
//  Created by Karan Satia on 9/3/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "CompareParseAndCoreData.h"
#import <Parse/Parse.h>

@implementation CompareParseAndCoreData {
    BOOL matchFound;
}

+ (id)sharedManager {
    static CompareParseAndCoreData *sharedCompareData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCompareData = [[self alloc] init];
    });
    
    return sharedCompareData;
}



-(void)compareParseAndCoreData :(NSString *)facebookID {
//    self.parseData = [ParseData sharedManager];
    matchFound = NO;
    self.user = self.parseData.user;
    self.coreData = [CoreDataFetch sharedManager];
    self.parseGroupNames = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Groups"];
    [query whereKey:@"facebookID" equalTo:facebookID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
 //           NSLog(@"Successfully retrieved %lu groups.", (unsigned long)objects.count);
            
            for (PFObject *object in objects) {
             //   NSLog(@"%@", object[@"groupId"]);
             //   NSLog(@"%lu", (unsigned long)[objects count]);
                [self.parseGroupNames addObject:object[@"groupName"]];
      
                if (self.coreData.groupNames.count != 0) {
    for (int i = 0; i < self.coreData.groupNames.count; i++) {
    
        if ([object[@"groupId"] isEqualToString:self.coreData.groupID[i]]) {
            matchFound = YES;
            break;
        }
    }
        if (matchFound == NO) {
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
            NSManagedObject *groupName = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:managedObjectContext];
            [groupName setValue:object[@"groupName"] forKey:@"name"];
            [groupName setValue:object[@"groupId"] forKey:@"groupID"];
            NSError *saveError = nil;
            BOOL saveResult = [managedObjectContext save:&saveError];
            if (saveError || !saveResult)
            {
             //   NSLog(@"Save not successful..");
            }
                    }
                }
        else if (self.coreData.groupNames.count == 0) {
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
            NSManagedObject *groupName = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:managedObjectContext];
//            NSLog(@"%@", object[@"groupId"]);
            [groupName setValue:object[@"groupName"] forKey:@"name"];
            [groupName setValue:object[@"groupId"] forKey:@"groupID"];
            NSError *saveError = nil;
            BOOL saveResult = [managedObjectContext save:&saveError];
            if (saveError || !saveResult)
            {
//                NSLog(@"Save not successful..");
            }
            
  //      }
    }
                matchFound = NO;
     }
            if (matchFound == NO) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CompareFinished" object:nil];
               
            }
      
        } else {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}


@end
