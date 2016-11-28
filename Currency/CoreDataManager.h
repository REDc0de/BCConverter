//
//  DBManager.h
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency+CoreDataClass.h"

@interface CoreDataManager : NSObject

+ (void)saveContext;
+ (void)deleteAllEnteties;
+ (NSArray*)currencyArray;
+ (void)addUSDtoEmptyDataBase;
+ (unsigned long)countOfEnteties;
+ (Currency*)entetieWithCurrencyCode:(NSString*)code;
+ (void)addOrUpdateCurrencyWithCode:(NSString*)code name:(NSString*)name rate:(double)rate date:(NSDate*)date;

@end
