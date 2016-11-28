//
//  Converter.h
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency+CoreDataClass.h"

@interface Converter : NSObject

+ (double)convertAmountOf:(double)money from:(Currency*)currency to:(Currency*)targetCurrency;

@end
