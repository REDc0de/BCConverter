//
//  ViewController.m
//  Currency
//
//  Created by Богдан Чайковский on 16.09.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "ViewController.h"
#import "Converter.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Currency+CoreDataClass.h"
#import "DataLoader.h"
#import "XMLParser.h"
#import "CoreDataManager.h"
#import "KeyBoard.h"
#import "InfiniteScrollView.h"
#import "CG.h"

@interface ViewController () <UIScrollViewDelegate>

//@property (weak, nonatomic) IBOutlet UITextField *baseCurrencyTextField;
//@property (weak, nonatomic) IBOutlet UITextField *targetCurrencyTextField;
//@property (weak, nonatomic) UITextField *currentTextField;
//@property (weak, nonatomic) UITextField *currentTargetTextField;
//@property (weak, nonatomic) IBOutlet UILabel *baseCurrencyCharCode;
//@property (weak, nonatomic) IBOutlet UILabel *baseCurrencyName;
//@property (weak, nonatomic) IBOutlet UILabel *targetCurrencyCharcode;
//@property (weak, nonatomic) IBOutlet UILabel *targetCurrencyName;
//
//@property (strong, nonatomic) InfiniteScrollView *targetScrollView;
//@property (strong, nonatomic) InfiniteScrollView *baseScrollView;
//@property (strong, nonatomic) NSMutableArray *visibleButtons;
//@property (strong, nonatomic) UIImage *buttonBackgroundImage;
//@property (nonatomic) BOOL deceleratingOrDragingEnd;
//
//@property (weak, nonatomic) IBOutlet UIView *animatedBackground;
//@property (strong, nonatomic) CAShapeLayer *animatedBackgroundShapeLayer;
//@property (strong, nonatomic) CAShapeLayer *baseScrollViewBackgroundShapeLayer;
//@property (strong, nonatomic) CAShapeLayer *targetScrollViewBackgroundShapeLayer;
//@property (weak, nonatomic) NSString *currentPosition;
//@property (weak, nonatomic) NSString *positionTotransit;
//@property (strong, nonatomic) UIView *loadingView;
//
//@property (strong, nonatomic) Currency *currentTargetCurrency;
//@property (strong, nonatomic) Currency *currentBaseCurrency;
//@property (strong, nonatomic) UIButton *currentCenterButton;
//
//@property (strong, nonatomic) NSManagedObjectContext *localContext;
//@property (strong, nonatomic) KeyBoard *keyBoard;
//@property (strong, nonatomic) Converter *converter;
//@property (strong, nonatomic) DataLoader *dataLoader;
//@property (strong, nonatomic) XMLParser *xmlParser;
//@property (strong, nonatomic) CoreDataManager *coreDataManager;
//@property (weak, nonatomic) IBOutlet UIButton *updateCircle;
//
//- (void)viewControllerLoadSetup;
//- (void)scrollViewSetup:(UIScrollView*)scrollView;
//- (void)labelsUpdate;
//- (void)textFieldsResultUpdater;
//- (void)updtaeCurrencyList;
//- (void)createShapeLayer;
//- (void)transitionAnimationTo:(NSString*)target;

@end


@implementation ViewController

//@synthesize keyBoard, converter, dataLoader, xmlParser, coreDataManager, localContext;
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    keyBoard = [[KeyBoard alloc] init];
//    converter = [[Converter alloc] init];
//    dataLoader = [[DataLoader alloc] init];
//    xmlParser = [[XMLParser alloc] init];
//    localContext = [NSManagedObjectContext MR_defaultContext];
//    
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    [self.view addGestureRecognizer:gestureRecognizer];
//    
//    [self.baseCurrencyTextField setText:@"0"];
//    [self.targetCurrencyTextField setText:@"0"];
//    
//    // Loading view.
//    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 568.0)];
//    self.loadingView.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(66/255.0) blue:(66/255.0) alpha:1];
//    
//    [self.view addSubview:self.loadingView];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0, 250.0, 200, 50)];
//    label.text = @"Loading....";
//    label.textColor= [UIColor whiteColor];
//    [self.loadingView addSubview:label];
//    //
//    
//}
//
//
//- (void)viewWillAppear:(BOOL)animated{
//    if ([coreDataManager countOfEnteties] !=0){
//        [self viewControllerLoadSetup];
//        self.baseScrollView.contentOffset = CGPointMake(self.baseScrollView.contentOffset.x-40, 0.0);
//        
//        self.targetScrollView.contentOffset = CGPointMake(self.targetScrollView.contentOffset.x-40, 0.0);
//        //    self.baseScrollView.contentOffset = CGPointMake(self.baseScrollView.contentOffset.x-920, 0.0);
//        //    self.targetScrollView.contentOffset = CGPointMake(self.targetScrollView.contentOffset.x+1960, 0.0);
//        [self scrollViewSetup:self.baseScrollView];
//        [self scrollViewSetup:self.targetScrollView];
//        
//    }
//
//}
//
//
//- (void)viewDidAppear:(BOOL)animated{
//    if ([coreDataManager countOfEnteties] ==0){
//        [self updtaeCurrencyList];
//        [self viewControllerLoadSetup];
//
//    }
//    [self.targetCurrencyTextField becomeFirstResponder];
//    
//    self.baseScrollView.contentOffset = CGPointMake(self.baseScrollView.contentOffset.x-40, 0.0);
//    
//    self.targetScrollView.contentOffset = CGPointMake(self.targetScrollView.contentOffset.x-40, 0.0);
//    //    self.baseScrollView.contentOffset = CGPointMake(self.baseScrollView.contentOffset.x-920, 0.0);
//    //    self.targetScrollView.contentOffset = CGPointMake(self.targetScrollView.contentOffset.x+1960, 0.0);
//    [self scrollViewSetup:self.baseScrollView];
//    [self scrollViewSetup:self.targetScrollView];
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//- (void)viewControllerLoadSetup{
//
//    [self.loadingView removeFromSuperview];
//    
//    self.targetScrollView = [[InfiniteScrollView alloc] initWithFrame:CGRectMake(0.0, 241, 320, 50.0)];
//    self.baseScrollView = [[InfiniteScrollView alloc] initWithFrame:CGRectMake(0.0, 156, 320, 50.0)];
//    [self.view addSubview:self.targetScrollView];
//    [self.view addSubview:self.baseScrollView];
//    
//    self.visibleButtons = [[NSMutableArray alloc] init];
//    CG *cg = [[CG alloc] init];
//    self.buttonBackgroundImage = [cg drawBackgroundImageForButton];
//    
//    self.targetCurrencyTextField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.baseCurrencyTextField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.currentTextField = self.baseCurrencyTextField;
//    self.currentTargetTextField = self.targetCurrencyTextField;
//    [self.currentTextField becomeFirstResponder];
//    
//    [self labelsUpdate];
//    
//    self.currentPosition = @"targetCurrency";
//    [self transitionAnimationTo:@"staticTargetCurrencyField"];
//    
//    self.baseScrollView.delegate = self;
//    self.targetScrollView.delegate = self;
//    self.baseScrollView.hidden = YES;
//
//}
//
//
//- (void)labelsUpdate{
//    
//    [self.baseCurrencyCharCode setText:[NSString stringWithFormat:@"%@",self.currentBaseCurrency.code]];
//    self.baseCurrencyCharCode.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
//    
//    [self.baseCurrencyName setText:[NSString stringWithFormat:@"%@",self.currentBaseCurrency.name]];
//    self.baseCurrencyName.font = [UIFont systemFontOfSize:11 weight:UIFontWeightLight];
//    
//    [self.targetCurrencyCharcode setText:[NSString stringWithFormat:@"%@",self.currentTargetCurrency.code]];
//    self.targetCurrencyCharcode.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
//    
//    [self.targetCurrencyName setText:[NSString stringWithFormat:@"%@",self.currentTargetCurrency.name]];
//    self.targetCurrencyName.font = [UIFont systemFontOfSize:11 weight:UIFontWeightLight];
//    
//    
//}
//
//// Gesture recognizer.
//
//
//- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
//    CGPoint tapedPoint = [gestureRecognizer locationInView:self.view];
//    if (CGRectContainsPoint(CGRectMake(0, 0, 320, 178), tapedPoint)) {
//        // Got a tap on base currency region.
//        self.currentTextField = self.baseCurrencyTextField;
//        self.currentTargetTextField = self.targetCurrencyTextField;
//        self.positionTotransit = @"baseCurrency";
//        [self transitionAnimationTo:@"moveToCurrencyField"];
//        self.currentPosition = self.positionTotransit;
//        self.baseScrollView.hidden = NO;
//        self.targetScrollView.hidden = YES;
//        
//        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//            // Do your animations here.
//            self.targetCurrencyCharcode.frame  = CGRectMake(8, 182+50, 40, 20);
//            self.targetCurrencyName.frame = CGRectMake(8, 198+50, 135, 14);
//            self.targetCurrencyTextField.frame = CGRectMake(155, 181+50, 150, 30);
//            
//        } completion:nil];
//        
//    } else if (CGRectContainsPoint(CGRectMake(0, 179, 320, 111), tapedPoint)){
//        // Got a tap on target currency region.
//        self.currentTextField = self.targetCurrencyTextField;
//        self.currentTargetTextField = self.baseCurrencyTextField;
//        self.positionTotransit = @"targetCurrency";
//        [self transitionAnimationTo:@"moveToTargetCurrencyField"];
//        self.currentPosition = self.positionTotransit;
//        self.baseScrollView.hidden = YES;
//        self.targetScrollView.hidden = NO;
//        
//        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//            // Do your animations here.
//            self.targetCurrencyCharcode.frame  = CGRectMake(8, 182, 40, 20);
//            self.targetCurrencyName.frame = CGRectMake(8, 198, 135, 14);
//            self.targetCurrencyTextField.frame = CGRectMake(155, 181, 150, 30);
//            
//        } completion:nil];
//        
//    }
//    [self.currentTextField becomeFirstResponder];
//    [self textFieldsResultUpdater];
//    
//}
//
//
//- (void)createShapeLayer{
//    if (!self.animatedBackgroundShapeLayer){
//        self.animatedBackgroundShapeLayer = [[CAShapeLayer alloc] init];
//        self.baseScrollViewBackgroundShapeLayer = [[CAShapeLayer alloc] init];
//        self.targetScrollViewBackgroundShapeLayer = [[CAShapeLayer alloc] init];
//
//    }
//    
//}
//
//
//- (void)transitionAnimationTo:(NSString*)target{
//    
//    [self createShapeLayer];
//    
//    if(self.currentPosition == self.positionTotransit){
//        // Your target position is equal to current position. Thats why no transition animation.
//        
//    } else{
//    
//    [self.animatedBackground.layer addSublayer:self.animatedBackgroundShapeLayer];
//    [self.animatedBackground.layer insertSublayer:self.targetScrollViewBackgroundShapeLayer above:self.animatedBackgroundShapeLayer];
//    [self.animatedBackground.layer insertSublayer:self.baseScrollViewBackgroundShapeLayer above:self.animatedBackgroundShapeLayer];
//    
//    UIColor *transitionColor = [UIColor colorWithRed:(243/255.0) green:(66/255.0) blue:(66/255.0) alpha:1];
//    UIColor *scrollBgColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.10];
//        
//    if([target isEqualToString:@"moveToCurrencyField"]){
//        transitionColor = [UIColor colorWithRed:(243/255.0) green:(207/255.0) blue:(65/255.0) alpha:1];
//    }
//    
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.duration = 0.25f;
//    
//    CG *cg = [[CG alloc] init];
//    
//    if([target isEqualToString:@"moveToCurrencyField"]){
//        
//        self.targetScrollViewBackgroundShapeLayer.fillColor = [scrollBgColor CGColor];
//        animation.values = [cg bezierPathForAnimation:@"scrollTargetBackgroundMoveToCurrencyField"];
//        [self.targetScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        self.animatedBackgroundShapeLayer.fillColor = [transitionColor CGColor];
//        animation.values = [cg bezierPathForAnimation:target];
//        [self.animatedBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        self.baseScrollViewBackgroundShapeLayer.fillColor = [scrollBgColor CGColor];
//        animation.values = [cg bezierPathForAnimation:@"scrollBaseBackgroundMoveToBaseField"];
//       [self.baseScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        animation.values = [cg bezierPathForAnimation:@"baseScrollViewBackground"];
//        [self.baseScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        
//        self.baseCurrencyCharCode.textColor = [UIColor whiteColor];
//        self.baseCurrencyName.textColor = [UIColor whiteColor];
//        self.baseCurrencyTextField.textColor = [UIColor whiteColor];
//        
//        self.targetCurrencyCharcode.textColor = [UIColor blackColor];
//        self.targetCurrencyName.textColor = [ UIColor redColor];
//        self.targetCurrencyTextField.textColor = [UIColor blackColor];
//        
//        
//    } else if([target isEqualToString:@"moveToTargetCurrencyField"]){
//        
//        self.baseScrollViewBackgroundShapeLayer.fillColor = [scrollBgColor CGColor];
//        animation.values = [cg bezierPathForAnimation:@"scrollBaseBackgroundMoveToTargetField"];
//        [self.baseScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        self.animatedBackgroundShapeLayer.fillColor = [transitionColor CGColor];
//        animation.values = [cg bezierPathForAnimation:target];
//        [self.animatedBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        self.targetScrollViewBackgroundShapeLayer.fillColor = [scrollBgColor CGColor];
//        animation.values = [cg bezierPathForAnimation:@"scrollTargetBackgroundMoveToTargetField"];
//        [self.targetScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//
//        self.targetScrollViewBackgroundShapeLayer.fillColor = [scrollBgColor CGColor];
//        animation.values = [cg bezierPathForAnimation:@"targetScrollViewBackground"];
//        [self.targetScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        self.targetCurrencyCharcode.textColor = [UIColor whiteColor];
//        self.targetCurrencyName.textColor = [UIColor whiteColor];
//        self.targetCurrencyTextField.textColor = [UIColor whiteColor];
//
//        self.baseCurrencyCharCode.textColor = [UIColor blackColor];
//        self.baseCurrencyName.textColor = [ UIColor redColor];
//        self.baseCurrencyTextField.textColor = [UIColor blackColor];
//        
//        
//    } else if([target isEqualToString:@"staticTargetCurrencyField"]){
//        
//        self.animatedBackgroundShapeLayer.fillColor = [transitionColor CGColor];
//        animation.values = [cg bezierPathForAnimation:target];
//        [self.animatedBackgroundShapeLayer addAnimation:animation forKey:nil];
//        
//        self.targetScrollViewBackgroundShapeLayer.fillColor = [scrollBgColor CGColor];
//        animation.values = [cg bezierPathForAnimation:@"targetScrollViewBackground"];
//        [self.targetScrollViewBackgroundShapeLayer addAnimation:animation forKey:nil];
//    
//    }
//    
//  }
//    
//}
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // Use this method for online update instead of scrollViewDidEndDecelerating and scrollViewDidEndDragging.
//    [self scrollViewSetup:scrollView];
//    
//}
//
//
//// Use folowing code for upadting after every Decelerating or Draging.
////- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
////
////}
////- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
////    if (decelerate == NO){
////        [self scrollViewSetup:scrollView];
////    } else{
////        // ScrollView will decelerate.
////    }
////}
////- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
////
////}
////- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
////    [self scrollViewSetup:scrollView];
////}
//
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat rightMargin = 4*screenWidth/8;
//    CGFloat leftMargin = 2*screenWidth/8;
//    UIButton *newCenterButton;
//    
//    [self.visibleButtons removeAllObjects];
//    for (UIView *subview in scrollView.subviews) {
//        if ([subview isKindOfClass:[UIView class]]) {
//            for (UIView *buttonView in subview.subviews){
//                if([buttonView isKindOfClass:[UIButton class]]){
//                    UIButton *newButton = (UIButton*)buttonView;
//                    [self.visibleButtons addObject:newButton];
//                    
//                    CGPoint originInSuperview = [self.animatedBackground convertPoint:newButton.frame.origin fromView:subview];
//                    if(originInSuperview.x >= leftMargin && originInSuperview.x <=rightMargin){
//                        newCenterButton = newButton;
//
//           
//                       
//                        CGPoint buttonPositionAtVisibleScreenArea = [self.animatedBackground convertPoint:newCenterButton.frame.origin fromView:subview];
//                        
//                        int positionDifference = 120-buttonPositionAtVisibleScreenArea.x;
//                        
//                        targetContentOffset->x = targetContentOffset->x-positionDifference;
//                        
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//
////    NSLog(@"will begind dercelerating at %f", scrollView.contentOffset.x);
////  
////    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
////    CGFloat rightMargin = 4*screenWidth/8;
////    CGFloat leftMargin = 2*screenWidth/8;
////    UIButton *newCenterButton;
////    
////    [self.visibleButtons removeAllObjects];
////    for (UIView *subview in scrollView.subviews) {
////        if ([subview isKindOfClass:[UIView class]]) {
////            for (UIView *buttonView in subview.subviews){
////                if([buttonView isKindOfClass:[UIButton class]]){
////                    UIButton *newButton = (UIButton*)buttonView;
////                    [self.visibleButtons addObject:newButton];
////                    
////                    CGPoint originInSuperview = [self.animatedBackground convertPoint:newButton.frame.origin fromView:subview];
////                    if(originInSuperview.x >= leftMargin && originInSuperview.x <=rightMargin){
////                        newCenterButton = newButton;
////                        
////                        
////                        // CGPoint buttonPositionAtScrollView = [subview convertPoint:newCenterButton.frame.origin toView:scrollView];
////                        CGPoint buttonPositionAtVisibleScreenArea = [self.animatedBackground convertPoint:newCenterButton.frame.origin fromView:subview];
////                        
////                        int positionDifference = 120-buttonPositionAtVisibleScreenArea.x;
////                        
////                        //  NSLog(@"first target content offset = %f\n position difference = %d", targetContentOffset->x, positionDifference);
////                        // scrollView.contentOffset.x = scrollView.contentOffset.x-positionDifference;
////                        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x-positionDifference, scrollView.contentOffset.y) animated:YES];
////                        //
////                        //                        NSLog(@"target content offset %f\nnewCenterButton.frame.origin.x = %f\nbuttonPositionAtScrollView = %f\nbuttonPositionAtVisibleScreenArea = %f", targetContentOffset->x, newCenterButton.frame.origin.x, buttonPositionAtScrollView.x, buttonPositionAtVisibleScreenArea.x);
////                        
////                    }
////                }
////            }
////        }
////    }
//}
//
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    NSLog(@"did end dercelerating at %f", scrollView.contentOffset.x);
//    
//    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat rightMargin = 4*screenWidth/8;
//    CGFloat leftMargin = 2*screenWidth/8;
//    UIButton *newCenterButton;
//    
//    [self.visibleButtons removeAllObjects];
//    for (UIView *subview in scrollView.subviews) {
//        if ([subview isKindOfClass:[UIView class]]) {
//            for (UIView *buttonView in subview.subviews){
//                if([buttonView isKindOfClass:[UIButton class]]){
//                    UIButton *newButton = (UIButton*)buttonView;
//                    [self.visibleButtons addObject:newButton];
//                    
//                    CGPoint originInSuperview = [self.animatedBackground convertPoint:newButton.frame.origin fromView:subview];
//                    if(originInSuperview.x >= leftMargin && originInSuperview.x <=rightMargin){
//                        newCenterButton = newButton;
//
//                        CGPoint buttonPositionAtVisibleScreenArea = [self.animatedBackground convertPoint:newCenterButton.frame.origin fromView:subview];
//                        int positionDifference = 120-buttonPositionAtVisibleScreenArea.x;
//
//                        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x-positionDifference, scrollView.contentOffset.y) animated:YES];
//
//                    }
//                }
//            }
//        }
//    }
//}
//
//
//
//- (void)scrollViewSetup:(UIScrollView*)scrollView{
//    
//    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat rightMargin = 4*screenWidth/8;
//    CGFloat leftMargin = 2*screenWidth/8;
//   // UIButton *newCenterButton;
//    
//    [self.visibleButtons removeAllObjects];
//    for (UIView *subview in scrollView.subviews) {
//        if ([subview isKindOfClass:[UIView class]]) {
//            for (UIView *buttonView in subview.subviews){
//                if([buttonView isKindOfClass:[UIButton class]]){
//                    UIButton *newButton = (UIButton*)buttonView;
//                    [self.visibleButtons addObject:newButton];
//                    
//                    CGPoint originInSuperview = [self.animatedBackground convertPoint:newButton.frame.origin fromView:subview];
//                    if(originInSuperview.x >= leftMargin && originInSuperview.x <=rightMargin){
//                        self.currentCenterButton = newButton;
//                        
//                    }
//                }
//            }
//        }
//    }
//    
//    unsigned long count = [self.visibleButtons count];
//    if (count == 0){
//        // There is no button on subview.
//        
//    } else{
//
//        Currency *newCenterCurrency = [Currency MR_findFirstByAttribute:@"code" withValue:self.currentCenterButton.titleLabel.text];
//        if(scrollView == self.baseScrollView){
//            // Active ScrollView is base scroll view.
//            if(self.currentBaseCurrency == newCenterCurrency){
//                //  No update, coz new centerBaseCurreny is equal to previous one.
//                
//            }else {
//                // Updat.
//                for(UIButton *button in self.visibleButtons){
//                    [button setBackgroundImage:nil forState:UIControlStateNormal];
//                }
//                [self.currentCenterButton setBackgroundImage:self.buttonBackgroundImage forState:UIControlStateNormal];
//                self.currentBaseCurrency = newCenterCurrency;
//                [self labelsUpdate];
//                [self textFieldsResultUpdater];
//                
//            }
//            
//        } else{
//            // Active ScrollView is target scroll view.
//            if(self.currentTargetCurrency == newCenterCurrency){
//                //  No update, coz new centerTargetCurreny is equal to previous one.
//                
//            }else {
//                // Update.
//                for(UIButton *button in self.visibleButtons){
//                    [button setBackgroundImage:nil forState:UIControlStateNormal];
//                    
//                }
//                [self.currentCenterButton setBackgroundImage:self.buttonBackgroundImage forState:UIControlStateNormal];
//                self.currentTargetCurrency = newCenterCurrency;
//                [self labelsUpdate];
//                [self textFieldsResultUpdater];
//                
//            }
//            
//        }
//        
//    }
//    
//}
//
//
//-(void)updtaeCurrencyList{
//    
//    if([coreDataManager countOfEnteties] == 0){
//        [coreDataManager addOrUpdateCurrencyWithCode:@"USD" name:@"United States Dollar" rate:1.0 date:[NSDate date]];
//        
//    }
//    NSURL *url = [[NSURL alloc] initWithString:@"http://www.floatrates.com/daily/USD.xml"];
//    NSData *dataForParsing = [dataLoader LoadDataFrom:url];
//    [xmlParser parse:dataForParsing];
//    NSLog(@"Count of all loaded Currency = %lu.",(unsigned long)[Currency MR_countOfEntities]);
//    
//}
//
//
//- (IBAction)updateCurrency:(id)sender {
//    
//    CABasicAnimation *rotate =
//    [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotate.byValue = @(M_PI*2); // Change to - angle for counter clockwise rotation
//    rotate.duration = 0.6;
//    
//    [self.updateCircle.layer addAnimation:rotate
//                                   forKey:@"myRotationAnimation"];
//    
//    [self updtaeCurrencyList];
//    [self.updateCircle.layer addAnimation:rotate
//                                   forKey:@"myRotationAnimation"];
//    
//}
//
//
//#pragma mark - TextField
//
//
//- (void)textFieldsResultUpdater{
//    double amountOfMoneyToConvert = [self.currentTextField.text doubleValue];
//    Currency *initialCurrency, *targetCurrency;
//    
//    if(self.currentTargetTextField == self.targetCurrencyTextField){
//        initialCurrency = self.currentBaseCurrency;
//        targetCurrency = self.currentTargetCurrency;
//        
//    } else{
//        initialCurrency = self.currentTargetCurrency;
//        targetCurrency = self.currentBaseCurrency;
//        
//    }
//    [self.currentTargetTextField setText:[NSString stringWithFormat:@"%.f",[converter convertAmountOf:amountOfMoneyToConvert
//                                                                                                 from:initialCurrency
//                                                                                                   to:targetCurrency]]];
//    
//}
//
//
//#pragma mark - KeyBoard
//
//
//- (IBAction)button1Touch:(id)sender {
//    [keyBoard add:@"1" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button2Touch:(id)sender {
//    [keyBoard add:@"2" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button3Touch:(id)sender {
//    [keyBoard add:@"3" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button4Touch:(id)sender {
//    [keyBoard add:@"4" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//}
//
//- (IBAction)button5Touch:(id)sender {
//
//    [keyBoard add:@"5" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button6Touch:(id)sender {
//    [keyBoard add:@"6" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button7Touch:(id)sender {
//    [keyBoard add:@"7" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button8Touch:(id)sender {
//    [keyBoard add:@"8" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button9Touch:(id)sender {
//    [keyBoard add:@"9" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)button0Touch:(id)sender {
//    [keyBoard add:@"0" intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)buttonDotTouch:(id)sender {
//    [keyBoard add:@"." intoTextField:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}
//
//- (IBAction)buttonDeleteTouch:(id)sender {
//    [keyBoard deleteLastCharacterFrom:self.currentTextField];
//    [self textFieldsResultUpdater];
//    
//}


@end
