//
//  XMLParser.m
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "XMLParser.h"
#import "CoreDataManager.h"


@interface XMLParser() <NSXMLParserDelegate>

@property (strong, nonatomic) NSString *currentElement;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSMutableString *name;
@property (strong, nonatomic) NSDate *date;
@property double rate;

@end


@implementation XMLParser

@synthesize currentElement, code, name, date, rate;

- (void)parse:(NSData *)data {
    [CoreDataManager addUSDtoEmptyDataBase]; // we add USD coz it's initial currency for our xml file

    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    xmlParser.delegate = self;
    [xmlParser parse];
    [CoreDataManager saveContext];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",parseError);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if([currentElement isEqualToString:@"targetCurrency"]) {
        code = string;
    }else if([currentElement isEqualToString:@"targetName"]) {
        // prevent string separartion while parsing
        if (!name) {
            name = [[NSMutableString alloc] init];
        }
        NSString  *encodSctring = [NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        [name appendString:encodSctring];
    }else if([currentElement isEqualToString:@"exchangeRate"]) {
        rate = [string doubleValue];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"item"]) {
        [CoreDataManager addOrUpdateCurrencyWithCode:code name:name rate:rate date:[NSDate date]];
        name = nil; // clear NSMutableString before next element will start (not next part of the word)
    }
    currentElement = nil;
}


@end
