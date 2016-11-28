//
//  Currency+CoreDataProperties.h
//  Currency
//
//  Created by Bogdan Chaikovsky on 05.11.16.
//  Copyright © 2016 Bogdan Chaikovsky. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Currency+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *code;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double rate;
@property (nullable, nonatomic, copy) NSDate *date;

@end

NS_ASSUME_NONNULL_END
