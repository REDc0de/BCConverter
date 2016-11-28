//
//  InfinityScrollView.m
//  Currency
//
//  Created by MacBook  on 18.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "InfiniteScrollView.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Currency+CoreDataClass.h"
#import "CG.h"
#import "CoreDataManager.h"

@interface InfiniteScrollView ()

@property (nonatomic, strong) NSMutableArray *visibleButtons;
@property (nonatomic, strong) UIView *buttonContainerView;
@property (nonatomic, weak) Currency *currency;
@property (nonatomic, strong) NSArray *currencyArray;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat rightMargin;
@property (nonatomic) CGFloat leftMargin;
@property (nonatomic, weak) NSString *currentCenterButtonString;

@end

@implementation InfiniteScrollView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {

        self.contentSize = CGSizeMake(5000, self.frame.size.height);
        self.visibleButtons = [[NSMutableArray alloc] init];
        self.buttonContainerView = [[UIView alloc] init];
        self.buttonContainerView.frame = CGRectMake(0, 0, 80, 50);
        [self addSubview:self.buttonContainerView];
        
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];

        self.screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.rightMargin = self.screenWidth/2;
        self.leftMargin = self.screenWidth/2-80;
        
        self.currencyArray = [CoreDataManager currencyArray];

    }
    return self;
}


#pragma mark - Layout


// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterIfNecessary {
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentWidth = [self contentSize].width;
    CGFloat centerOffsetX = (contentWidth - [self bounds].size.width) / 2.0;
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
    
    if (distanceFromCenter > (contentWidth / 4.0)) {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
        // move content by the same amount so it appears to stay still
        for (UIButton *button in self.visibleButtons) {
            CGPoint center = [self.buttonContainerView convertPoint:button.center toView:self];
            center.x += (centerOffsetX - currentOffset.x);
            button.center = [self convertPoint:center toView:self.buttonContainerView];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self recenterIfNecessary];
    
    // tile content in visible bounds
    CGRect visibleBounds = [self convertRect:[self bounds] toView:self.buttonContainerView];
    CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
    CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
    
    [self tileLabelsFromMinX:minimumVisibleX toMaxX:maximumVisibleX];
}


#pragma mark - Button Tiling


- (UIButton *)insertButton:(BOOL)nextButton {
    
    unsigned long currencyCount = [self.currencyArray count]-1;
    unsigned long newTag;
    UIButton *button;
 
        
    if (nextButton == YES){
        if ([self.visibleButtons count] == 0){
            newTag = 0;
        } else {
            UIButton *lastButton = [self.visibleButtons objectAtIndex:([self.visibleButtons count]-1)];
            if (lastButton.tag == currencyCount){
                newTag = 0;
            } else {
                newTag = lastButton.tag+1;
            }
        }
    } else if (nextButton == NO) {
        UIButton *lastButton = [self.visibleButtons objectAtIndex:0];
        if (lastButton.tag == 0){
            newTag = currencyCount;
        } else {
            newTag = lastButton.tag-1;
        }
        
    }
    Currency *currency = [self.currencyArray objectAtIndex:newTag];
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    [button setBackgroundColor:[UIColor clearColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    button.center = [button.superview convertPoint:button.superview.center fromView:button.superview.superview];
    [button setTag:newTag];
    [button setTitle:[NSString stringWithFormat:@"%@", currency.code] forState:UIControlStateNormal];
    
    [self.buttonContainerView addSubview:button];
    return button;
    
}

- (CGFloat)placeNewLabelOnRight:(CGFloat)rightEdge {
    UIButton *button = [self insertButton:YES];
    [self.visibleButtons addObject:button]; // add rightmost label at the end of the array
    
    CGRect frame = [button frame];
    frame.origin.x = rightEdge;
    frame.origin.y = [self.buttonContainerView bounds].size.height - frame.size.height;
    [button setFrame:frame];

    return CGRectGetMaxX(frame);
}

- (CGFloat)placeNewLabelOnLeft:(CGFloat)leftEdge {
    UIButton *button = [self insertButton:NO];
    [self.visibleButtons insertObject:button atIndex:0]; // add leftmost label at the beginning of the array
    
    CGRect frame = [button frame];
    frame.origin.x = leftEdge - frame.size.width;
    frame.origin.y = [self.buttonContainerView bounds].size.height - frame.size.height;
    [button setFrame:frame];
    
    return CGRectGetMinX(frame);
}

- (void)tileLabelsFromMinX:(CGFloat)minimumVisibleX toMaxX:(CGFloat)maximumVisibleX {
    [self currentCenterElement];

    
    if ([self.currencyArray count] == 0){
    self.currencyArray = [CoreDataManager currencyArray];
    
    } else{
    /* The upcoming tiling logic depends on there already being at least one label in the visibleLabels array, so to kick off the tiling we need to make sure there's at least one label.*/
    if ([self.visibleButtons count] == 0) {
        [self placeNewLabelOnRight:minimumVisibleX];
    }
    
    // Add labels that are missing on right side.
    UIButton *lastButton = [self.visibleButtons lastObject];
    CGFloat rightEdge = CGRectGetMaxX([lastButton frame]);
    while (rightEdge < maximumVisibleX) {
        rightEdge = [self placeNewLabelOnRight:rightEdge];
        [self currentCenterElement];
    }
    
    // Add labels that are missing on left side.
    UILabel *firstLabel = self.visibleButtons[0];
    CGFloat leftEdge = CGRectGetMinX([firstLabel frame]);
    while (leftEdge > minimumVisibleX){
        leftEdge = [self placeNewLabelOnLeft:leftEdge];
        [self currentCenterElement];
    }
    
    // Remove labels that have fallen off right edge.
    lastButton = [self.visibleButtons lastObject];
    while ([lastButton frame].origin.x > maximumVisibleX) {
        [lastButton removeFromSuperview];
        [self.visibleButtons removeLastObject];
        lastButton = [self.visibleButtons lastObject];
         [self currentCenterElement];
    }
    
    // Remove labels that have fallen off left edge.
    firstLabel = self.visibleButtons[0];
    while (CGRectGetMaxX([firstLabel frame]) < minimumVisibleX) {
        [firstLabel removeFromSuperview];
        [self.visibleButtons removeObjectAtIndex:0];
        firstLabel = self.visibleButtons[0];
         [self currentCenterElement];
    }
        
    }
    
}

- (void)currentCenterElement {
    for (UIButton *button in self.visibleButtons) {
        CGPoint originInSuperview = [self.superview convertPoint:button.frame.origin fromView:self];

        if(originInSuperview.x >= self.leftMargin && originInSuperview.x <=self.rightMargin){

            if ([self.currentCenterButtonString isEqualToString:button.titleLabel.text]){
                // center button did not change
                
            } else{
                unsigned long tag = self.tag;
                
                NSString *notificationName = @"centerButtonChangedAtTopScrollView";
                if (tag == 2) {
                    notificationName = @"centerButtonChangedAtBottomScrollView";
                }
                self.currentCenterButtonString = button.titleLabel.text;
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:button.titleLabel.text];
                for(UIButton *button in self.visibleButtons){
                    [button setBackgroundImage:nil forState:UIControlStateNormal];
                }
                [button setBackgroundImage:[CG drawBackgroundImageForButton] forState:UIControlStateNormal];
            }
        }
    }
}


@end
