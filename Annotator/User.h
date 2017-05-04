//
//  User.h
//  Annotator
//
//  Created by Aditya Narayan on 9/2/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *profileURL;
@property (nonatomic, strong) NSArray *friendsID;
@property (nonatomic, strong) NSMutableDictionary *friends;


-(id)initWithFriends :(NSDictionary *)friends :(NSString *)url name:(NSString *)name ;

@end
