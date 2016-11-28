//
//  KeyboardButton.m
//  Currency
//
//  Created by Богдан Чайковский on 24.11.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "KeyboardButton.h"

@implementation KeyboardButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    UIColor *borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.05];
    [[self layer] setBorderWidth:0.5f];
    [[self layer] setBorderColor:[borderColor CGColor]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
