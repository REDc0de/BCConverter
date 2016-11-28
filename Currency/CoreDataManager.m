//
//  DBManager.m
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//


#import <MagicalRecord/MagicalRecord.h>
#import "CoreDataManager.h"


@interface CoreDataManager()

@end

@implementation CoreDataManager


+ (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if(contextDidSave) {
            NSLog(@"You successfully saved your context.");
        }else if(error) {
            NSLog(@"Error saving context: %@", error.description);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"currencyListHaveBeenUpdated" object:nil];
    }];
}

+ (void)deleteAllEnteties {
    if([Currency MR_countOfEntitiesWithContext:[NSManagedObjectContext MR_defaultContext]]) {
        [Currency MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    }
    [self saveContext];
}

+ (NSArray*)currencyArray {
    NSArray *currencyArray = [Currency MR_findAllSortedBy:@"code" ascending:YES inContext:[NSManagedObjectContext MR_defaultContext]];
    
    return currencyArray;
}

+ (unsigned long)countOfEnteties {
    unsigned long countOfEnteties = [Currency MR_countOfEntitiesWithContext:[NSManagedObjectContext MR_defaultContext]];
    
    return countOfEnteties;
}

+ (Currency*)entetieWithCurrencyCode:(NSString*)code {
    Currency *currency = [Currency MR_findFirstByAttribute:@"code" withValue:code inContext:[NSManagedObjectContext MR_defaultContext]];
    
    return currency;
}

+ (void)addOrUpdateCurrencyWithCode:(NSString*)code name:(NSString*)name rate:(double)rate date:(NSDate*)date {
    Currency *newCurrency = [Currency MR_findFirstByAttribute:@"code" withValue:code inContext:[NSManagedObjectContext MR_defaultContext]];
    if(!newCurrency) {
        newCurrency = [Currency MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
        newCurrency.name = name;
        newCurrency.code = code;
    }
        newCurrency.rate = rate;
        newCurrency.date = date;
}

+ (void)addUSDtoEmptyDataBase{
    [self addOrUpdateCurrencyWithCode:@"USD" name:@"United States Dollar" rate:1.0 date:[NSDate date]];
}


@end

