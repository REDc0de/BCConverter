//
//  Converter.m
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "Converter.h"

@interface Converter()

@end


@implementation Converter

+ (double)convertAmountOf:(double)money from:(Currency*)currency to:(Currency*)targetCurrency{
    double result = 0.0;
    
    if(!targetCurrency.rate || !currency.rate) {
        
    } else{
    result = money * targetCurrency.rate/currency.rate;
    }
    return result;
}

@end
