//
//  DataLoader.m
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "DataLoader.h"

@implementation DataLoader

+ (void)loadDataFromURLWithString:(NSString*)urlString{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"currencyListDataHaveBeenLoad" object:data];
        });
        
    });
}

@end
