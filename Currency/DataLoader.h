//
//  DataLoader.h
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoader : NSObject

+ (void)loadDataFromURLWithString:(NSString*)urlString;

@end
