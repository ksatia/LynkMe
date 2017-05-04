//
//  GroupFetch.h
//  Annotator
//
//  Created by Karan Satia on 9/4/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GroupFetch : NSObject <UIWebViewDelegate>

@property (strong, nonatomic) NSMutableArray *groupMemberIds;
@property (strong, nonatomic) NSMutableArray *groupLinks;
@property (strong, nonatomic) NSMutableArray *linkIds;
@property (strong, nonatomic) NSMutableArray *groupMessages;
@property (strong, nonatomic) NSMutableArray *posterName;

+ (id)sharedManager;
-(void)getGroupMembers :(NSString *)groupId;
-(void)getLinks :(NSString *)groupId;
-(void)notificationLink :(NSString *)groupName;
-(void)deleteLink :(NSString *)linkId;
@end
