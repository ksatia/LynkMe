//
//  DataParser.h
//  Annotator
//
//  Created by Karan Satia on 9/14/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLData.h"

@interface DataParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableString *currentNodeContent;
@property (strong, nonatomic) NSMutableArray *elementArray;
@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) HTMLData *currentHTMLData;

-(id)loadHTMLByURL:(NSString *)urlString;

@end
