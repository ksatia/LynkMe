//
//  CompareParseAndCoreData.h
//  Annotator
//
//  Created by Karan Satia on 9/3/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseData.h"
#import "CoreDataFetch.h"
#import "User.h"
#import <CoreData/CoreData.h>

@class CoreDataFetch;
@interface CompareParseAndCoreData : NSObject

@property (nonatomic, strong) User *user;
@property (strong, nonatomic) ParseData *parseData;
@property (strong, nonatomic) CoreDataFetch *coreData;
@property (strong, nonatomic) NSMutableArray *parseGroupNames;

+ (id)sharedManager;
-(void)compareParseAndCoreData :(NSString *)facebookID;

@end
