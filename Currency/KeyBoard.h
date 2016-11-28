//
//  KeyBoard.h
//  Currency
//
//  Created by MacBook  on 17.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeyBoard : NSObject

+ (void)add:(NSString *)symbol intoTextField:(UITextField *)textField;
+ (void)deleteLastCharacterFrom:(UITextField *)textField;

@end
