//
//  CG.m
//  Currency
//
//  Created by Богдан Чайковский on 19.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "CG.h"

@implementation CG


+ (UIImage *)drawBackgroundImageForButton{
    // was made manual static 2X scale for retina!!!
    UIGraphicsBeginImageContext(CGSizeMake(160, 100));
    
    CGRect frame = CGRectMake(33.0, 30.0, 94.0, 40.0);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:30.0];
    [[UIColor colorWithRed:(0/255.0)
                     green:(0/255.0)
                      blue:(0/255.0)
                     alpha:0.3] setFill];
    [path fill];
    // make image out of bitmap context.
    UIImage *backgroundButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    // free the context.
    UIGraphicsEndImageContext();
    
    return backgroundButtonImage;
}

+ (UIImage*)scrollViewBackgroundWithWidth:(double)width height:(double)height {

    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    UIBezierPath *scrollPath = [UIBezierPath bezierPath];
    [scrollPath moveToPoint:CGPointMake(0.0, 0.0)];
    [scrollPath addLineToPoint:CGPointMake(width/2.0-5.0, 0.0)];
    [scrollPath addLineToPoint:CGPointMake(width/2.0, 4.0)];
    [scrollPath addLineToPoint:CGPointMake(width/2.0+5.0, 0.0)];
    [scrollPath addLineToPoint:CGPointMake(width, 0.0)];
    [scrollPath addLineToPoint:CGPointMake(width, height)];
    [scrollPath addLineToPoint:CGPointMake(0.0, height)];
    [scrollPath addLineToPoint:CGPointMake(0.0, 0.0)];
    
    [[UIColor colorWithRed:(0/255.0)
                     green:(0/255.0)
                      blue:(0/255.0)
                     alpha:0.1] setFill];
    
    [scrollPath fill];
    
    UIImage *backgroundButtonImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return backgroundButtonImage;
}


@end
