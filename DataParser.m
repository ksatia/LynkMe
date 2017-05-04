//
//  DataParser.m
//  Annotator
//
//  Created by Karan Satia on 9/14/16.
//  Copyright (c) 2016 Karan Satia. All rights reserved.
//

#import "DataParser.h"

@implementation DataParser

-(id)loadHTMLByURL:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *nsData = [[NSData alloc]initWithContentsOfURL:url];
    self.elementArray = [NSMutableArray new];
    self.parser = [[NSXMLParser alloc]initWithData:nsData];
    self.parser.delegate = self;
    [self.parser parse];
    self.currentHTMLData = [HTMLData alloc];
    
    return self;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"title"]) {
        self.currentHTMLData.tag = elementName;
        self.currentHTMLData.value = self.currentNodeContent;
        [self.elementArray addObject:self.currentHTMLData];
    }
//    else if ([elementName isEqualToString:@"h1"]) {
//        self.currentHTMLData.tag = elementName;
//        self.currentHTMLData.value = self.currentNodeContent;
//        [self.elementArray addObject:self.currentHTMLData];
//        self.currentHTMLData = nil;
//        self.currentNodeContent = nil;
//    }
//    else if ([elementName isEqualToString:@"p"]) {
//        self.currentHTMLData.tag = elementName;
//        self.currentHTMLData.value = self.currentNodeContent;
//        [self.elementArray addObject:self.currentHTMLData];
//        self.currentHTMLData = nil;
//        self.currentNodeContent = nil;
//    }
//    else if ([elementName isEqualToString:@"div"]) {
//        self.currentHTMLData.tag = elementName;
//        self.currentHTMLData.value = self.currentNodeContent;
//        [self.elementArray addObject:self.currentHTMLData];
//        self.currentHTMLData = nil;
//        self.currentNodeContent = nil;
//    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.currentNodeContent = (NSMutableString *)[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
