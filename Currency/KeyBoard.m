//
//  KeyBoard.m
//  Currency
//
//  Created by MacBook  on 17.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "KeyBoard.h"

@implementation KeyBoard


+ (void)add:(NSString *)symbol intoTextField:(UITextField *)textField {
    
    NSString *currentText = [textField text];
    
    if([currentText length] == 9) {
        
    }else{
        if ([currentText isEqualToString:@"0"]){
            if([symbol  isEqual: @"."]){
                NSString *resultText = [NSString stringWithFormat:@"%@%@", @"0", symbol];
                [textField setText:resultText];}
            else {
                [textField setText:symbol];
            }
        } else{
            if ([symbol isEqual: @"."]){
                if([currentText rangeOfString:@"."].location == NSNotFound){
                    NSString *resultText = [NSString stringWithFormat:@"%@%@", currentText, symbol];
                    [textField setText:resultText];
                } else{
                    [textField setText:currentText];
                }
            } else{
                NSString *resultText = [NSString stringWithFormat:@"%@%@", currentText, symbol];
                [textField setText:resultText];
            }
        }
    }
}

+ (void)deleteLastCharacterFrom:(UITextField *)textField {
    NSString *currentText = [textField text];
    unsigned long currentTextLengt = [currentText length];
    
    if (currentTextLengt == 1){
        [textField setText:@"0"];
    } else {
        NSString *resultText = [currentText substringToIndex:[currentText length]-1];
        [textField setText:resultText];
    }
}


@end
