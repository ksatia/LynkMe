//
//  AppDelegate.h
//  Annotator
//
//  Created by Karan Satia on 8/25/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseData.h"
#import "CoreDataFetch.h"
#import <CoreData/CoreData.h>
#import "ANAddUserVC.h"

@class CoreDataFetch;
@class ParseData;
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ParseData *parseData;
@property (strong, nonatomic) CoreDataFetch *coreData;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end

