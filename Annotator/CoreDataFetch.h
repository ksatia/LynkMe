//
//  CoreData.h
//  Annotator
//
//  Created by Aditya Narayan on 9/3/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"



@interface CoreDataFetch : NSObject <NSFetchedResultsControllerDelegate>



@property (nonatomic, strong) NSMutableArray *fetchedObjects;
@property (nonatomic, strong) NSMutableArray *groupNames;
@property (nonatomic, strong) NSMutableArray *groupID;
+ (id)sharedManager;
-(void)loadGroups;
-(void)deleteGroup :(NSInteger)index;

@end
