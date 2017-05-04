//
//  CoreData.m
//  Annotator
//
//  Created by Aditya Narayan on 9/3/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "CoreDataFetch.h"

@implementation CoreDataFetch

+ (id)sharedManager {
    static CoreDataFetch *sharedCoreData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoreData = [[self alloc] init];
    });
    return sharedCoreData;
}

-(void)loadGroups {
    self.groupNames = [[NSMutableArray alloc] init];
    self.groupID = [[NSMutableArray alloc] init];
    self.fetchedObjects = [[NSMutableArray alloc] init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Group" inManagedObjectContext:managedObjectContext];
    NSError *error;
    [fetchRequest setEntity:entity];
    self.fetchedObjects = [[NSMutableArray alloc] initWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    
    if (error) {
        
//        NSLog(@"Unable to execute fetch request.");
//        NSLog(@"%@, %@", error, error.localizedDescription);
        
    }
    
    for (NSManagedObject *group in self.fetchedObjects) {
 //       NSLog(@"Group ID: %@", [group valueForKey:@"groupID"]);
        [self.groupNames addObject:[group valueForKey:@"name"]];
        [self.groupID addObject:[group valueForKey:@"groupID"]];
    }
    
    
    /*
    for (int i = 0; i < [self.fetchedObjects count]; i++) {
    
    NSManagedObject *person = (NSManagedObject *)[self.fetchedObjects objectAtIndex:i];
    
    [managedObjectContext deleteObject:person];
    
    NSError *deleteError = nil;
    
    if (![person.managedObjectContext save:&deleteError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
    }
    }
    */
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"CompareFinished" object:nil];

}

-(void)deleteGroup :(NSInteger)index {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
        NSManagedObject *group = (NSManagedObject *)[self.fetchedObjects objectAtIndex:index];
        
        [managedObjectContext deleteObject:group];
        [self.fetchedObjects removeObjectAtIndex:index];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Couldn't save: %@", error);
    }
    }


@end
