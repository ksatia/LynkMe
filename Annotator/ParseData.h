//
//  ParseData.h
//  Annotator
//
//  Created by Aditya Narayan on 9/2/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ParseData : NSObject 

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *parseGroupNames;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *name;

+ (id)sharedManager;
-(void)saveGroup :(NSString *)groupName :(NSArray *)groupMembers :(NSString *)groupId;
-(void)loadData;
-(void)deleteGroup :(NSString *)groupId;

@end
