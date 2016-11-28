//
//  RequestCenter.m
//  Currency
//
//  Created by Bogdan Chaikovsky on 26.11.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "RequestCenter.h"
#import "XMLParser.h"
#import "DataLoader.h"
#import "Constants.h"

@implementation RequestCenter

+ (void)updateCurrencyList {
    [self loadDataForParsing];
}

+ (void)loadDataForParsing {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"currencyListDataHaveBeenLoad" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseAndSaveToCoreData:) name:@"currencyListDataHaveBeenLoad" object:nil];
   
    [DataLoader loadDataFromURLWithString: BCCurrencyDataURL];
}

+ (void)parseAndSaveToCoreData:(NSNotification*)notification {
    XMLParser *xmlParser = [[XMLParser alloc] init];
    [xmlParser parse:[notification object]];
}

@end
