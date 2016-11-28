//
//  rootViewController.m
//  Currency
//
//  Created by Богдан Чайковский on 24.11.16.
//  Copyright © 2016 Богдан Чайковский. All rights reserved.
//

#import "rootViewController.h"
#import "CoreDataManager.h"
#import "InfiniteScrollView.h"
#import "KeyBoard.h"
#import "Currency+CoreDataClass.h"
#import "Converter.h"
#import "CG.h"
#import "RequestCenter.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Constants.h"
#import "InfiniteScrollView.h"
#import "Reachability.h"

@interface rootViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *updateStackView;


@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIStackView *currencyBlocksStackView;


@property (weak, nonatomic) IBOutlet UIView *topBaseViewForScrollView;
@property (weak, nonatomic) IBOutlet UIStackView *topBlockContainerStackView;
@property (weak, nonatomic) IBOutlet UILabel *topCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *topTextField;
@property (weak, nonatomic) IBOutlet UILabel *topNameLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;

@property (weak, nonatomic) IBOutlet UIView *bottomBaseViewForScrollView;
@property (weak, nonatomic) IBOutlet UIStackView *bottomBlockContainerStackView;
@property (weak, nonatomic) IBOutlet UILabel *bottomCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottomTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;

@property (weak, nonatomic) UITextField *activeTextField;
@property (weak, nonatomic) UITextField *notActiveTextField;

@property (strong, nonatomic) UIView *animationView;

@property (weak, nonatomic) Currency *topCurrency;
@property (weak, nonatomic) Currency *bottomCurrency;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageView2;


@end

@implementation rootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"currencyListHaveBeenUpdated" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"currencyListHaveBeenUpdated" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"centerButtonChangedAtTopScrollView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test2:) name:@"centerButtonChangedAtTopScrollView" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"centerButtonChangedAtBottomScrollView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test3:) name:@"centerButtonChangedAtBottomScrollView" object:nil];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeActiveCurrencyBlock:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.topTextField.text = @"0";
    self.bottomTextField.text = @"0";
    
    self.activeTextField = self.bottomTextField;
    self.notActiveTextField = self.topTextField;
    
    
    self.bottomCodeLabel.textColor = [UIColor whiteColor];
    self.bottomNameLabel.textColor = [UIColor whiteColor];
    self.bottomTextField.textColor = [UIColor whiteColor];
    self.bottomTextField.font = [UIFont systemFontOfSize:32 weight:UIFontWeightLight];
    self.topTextField.font = [UIFont systemFontOfSize:40 weight:UIFontWeightLight];
    
    self.topCodeLabel.textColor = [UIColor blackColor];
    self.topNameLabel.textColor = [UIColor redColor];
    self.topTextField.textColor = [UIColor blackColor];
    self.bottomTextField.font = [UIFont systemFontOfSize:40 weight:UIFontWeightLight];
    self.topTextField.font = [UIFont systemFontOfSize:32 weight:UIFontWeightLight];
 
    
    UIImage *image = [CG scrollViewBackgroundWithWidth:self.view.frame.size.width height:self.topScrollView.frame.size.height];
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    
    UIImage *image2 = [CG scrollViewBackgroundWithWidth:self.view.frame.size.width height:self.bottomScrollView.frame.size.height];
    
    self.imageView2 = [[UIImageView alloc] initWithImage:image2];
    
    
    [self.bottomBaseViewForScrollView insertSubview:self.imageView2 belowSubview:self.bottomScrollView];
     self.topScrollView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1];
    
    self.topBaseViewForScrollView.hidden = YES;
    [self.view layoutIfNeeded];  // prevent problems with no UIupdate on device but on simulator

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkForInternetConnection];
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 40+self.updateStackView.frame.size.height+self.topBlockContainerStackView.frame.size.height, self.view.frame.size.width, self.bottomBlockContainerStackView.frame.size.height)];
    self.animationView.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(66/255.0) blue:(66/255.0) alpha:1];;
    
    [self.view insertSubview:self.animationView atIndex:0.0];
    

   // [RequestCenter updateCurrencyList];
    [self updateAction:self];
}


- (void)checkForInternetConnection{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
    } else {
        NSLog(@"There IS internet connection");
    }

}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)test{
    NSLog(@"GOT IT!!!");
    [self.updateButton.layer removeAnimationForKey:@"SpinAnimation"];
    [self UIUpdate];
}

- (void)test2:(NSNotification*)notification{
    
    self.topCurrency = [Currency MR_findFirstByAttribute:@"code" withValue:[notification object] inContext:[NSManagedObjectContext MR_defaultContext]];
    
    self.topCodeLabel.text = self.topCurrency.code;
    self.topNameLabel.text = self.topCurrency.name;

    [self textFieldUpdater];
}

- (void)test3:(NSNotification*)notification{
    
    self.bottomCurrency = [Currency MR_findFirstByAttribute:@"code" withValue:[notification object] inContext:[NSManagedObjectContext MR_defaultContext]];
    
    self.bottomCodeLabel.text = self.bottomCurrency.code;
    self.bottomNameLabel.text = self.bottomCurrency.name;

    [self textFieldUpdater];
    
}

- (void)UIUpdate{
  

}


- (CGRect)statusBarFrameViewRect:(UIView*)view {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect statusBarWindowRect = [view.window convertRect:statusBarFrame fromWindow: nil];
    
    CGRect statusBarViewRect = [view convertRect:statusBarWindowRect fromView: nil];
    
    return statusBarViewRect;
}

- (void)changeActiveCurrencyBlock:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint tapedPoint = [gestureRecognizer locationInView:self.currencyBlocksStackView];
//    double duration = 4.5;
    if (CGRectContainsPoint(CGRectMake(0, self.currencyBlocksStackView.frame.size.height/2, self.currencyBlocksStackView.frame.size.width, self.currencyBlocksStackView.frame.size.height/2), tapedPoint)) {
        // bottom currency block contains tapedPoint
        if(self.topBaseViewForScrollView.hidden == NO) {
            [self.imageView removeFromSuperview];
            self.topScrollView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1];


            
            
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
                
                self.topBaseViewForScrollView.hidden = YES;
                //self.bottomScrollView.hidden = NO;
                
                
                self.bottomBaseViewForScrollView.hidden = NO;
 
//                [self.bottomBaseViewForScrollView  insertSubview:self.imageView2 belowSubview:self.bottomScrollView];

                
                
                [self.view layoutIfNeeded];
                
                
                self.activeTextField = self.bottomTextField;
                self.notActiveTextField = self.topTextField;
                
                self.animationView.frame = CGRectMake(0.0, 40+self.updateStackView.frame.size.height+self.topBlockContainerStackView.frame.size.height, self.view.frame.size.width, self.bottomBlockContainerStackView.frame.size.height);
                self.animationView.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(66/255.0) blue:(66/255.0) alpha:1];;
                [self.view layoutIfNeeded];
                
                

                self.bottomCodeLabel.textColor = [UIColor whiteColor];
                self.bottomNameLabel.textColor = [UIColor whiteColor];
                self.bottomTextField.textColor = [UIColor whiteColor];
                
                self.topCodeLabel.textColor = [UIColor blackColor];
                self.topNameLabel.textColor = [UIColor redColor];
                self.topTextField.textColor = [UIColor blackColor];
                
                self.bottomTextField.font = [UIFont systemFontOfSize:40 weight:UIFontWeightLight];
                self.topTextField.font = [UIFont systemFontOfSize:32 weight:UIFontWeightLight];
                
                [self.updateButton setBackgroundImage:[UIImage imageNamed:@"refreshImage4"] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                //code for completion
                self.bottomScrollView.backgroundColor = [UIColor clearColor];
                [self.bottomBaseViewForScrollView  insertSubview:self.imageView2 belowSubview:self.bottomScrollView];
                
            }];
        }
    } else if(CGRectContainsPoint(CGRectMake(0, 0, self.currencyBlocksStackView.frame.size.width, self.currencyBlocksStackView.frame.size.height/2), tapedPoint)) {
        // top currency block contains tapedPoint
        if(self.topBaseViewForScrollView.hidden == YES) {
            [self.imageView2 removeFromSuperview];
            self.bottomScrollView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1];
           
            
            
            [UIView animateWithDuration:AnimationDuration delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{

                self.bottomBaseViewForScrollView.hidden = YES;
                self.topBaseViewForScrollView.hidden = NO;
                [self.view layoutIfNeeded];
                
                self.activeTextField = self.topTextField;
                self.notActiveTextField = self.bottomTextField;
                
                
                self.bottomCodeLabel.textColor = [UIColor redColor];
                self.bottomNameLabel.textColor = [UIColor blackColor];
                self.bottomTextField.textColor = [UIColor blackColor];
                
                self.topCodeLabel.textColor =[UIColor whiteColor];
                self.topNameLabel.textColor =[UIColor whiteColor];
                self.topTextField.textColor = [UIColor whiteColor];
                
                self.bottomTextField.font = [UIFont systemFontOfSize:32 weight:UIFontWeightLight];
                self.topTextField.font = [UIFont systemFontOfSize:40 weight:UIFontWeightLight];
         
                self.animationView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 40+self.updateStackView.frame.size.height+self.topBlockContainerStackView.frame.size.height);
                self.animationView.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(207/255.0) blue:(65/255.0) alpha:1];
                [self.view layoutIfNeeded];
                
                  [self.updateButton setBackgroundImage:[UIImage imageNamed:@"refreshImageWhite"] forState:UIControlStateNormal];
                
            } completion:^(BOOL finished) {
                //code for completion
                self.topScrollView.backgroundColor = [UIColor clearColor];
                [self.topBaseViewForScrollView  insertSubview:self.imageView belowSubview:self.topScrollView];
                
                
                
            }];
        }
    }
}

- (IBAction)updateAction:(id)sender {
    [self checkForInternetConnection];
    if ([self.updateButton.layer animationForKey:@"SpinAnimation"] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
        animation.duration = 0.6f;
        animation.repeatCount = INFINITY;
        [self.updateButton.layer addAnimation:animation forKey:@"SpinAnimation"];
    }
   [RequestCenter updateCurrencyList];
}


- (void)textFieldUpdater{
    double amountOfMoneyToConvert = [self.activeTextField.text doubleValue];
    
    if(self.activeTextField == self.bottomTextField){
        [self.notActiveTextField setText:[NSString stringWithFormat:@"%.f",[Converter convertAmountOf:amountOfMoneyToConvert from:self.bottomCurrency to:self.topCurrency]]];
        
    } else{
        [self.notActiveTextField setText:[NSString stringWithFormat:@"%.f",[Converter convertAmountOf:amountOfMoneyToConvert from:self.topCurrency to:self.bottomCurrency]]];
        
    }
}


- (IBAction)button1Action:(id)sender {
    [KeyBoard add:@"1" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button2Action:(id)sender {
    [KeyBoard add:@"2" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button3Action:(id)sender {
    [KeyBoard add:@"3" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button4Action:(id)sender {
    [KeyBoard add:@"4" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button5Action:(id)sender {
    [KeyBoard add:@"5" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button6Action:(id)sender {
    [KeyBoard add:@"6" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button7Action:(id)sender {
    [KeyBoard add:@"7" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button8Action:(id)sender {
    [KeyBoard add:@"8" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button9Action:(id)sender {
    [KeyBoard add:@"9" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)buttonDotAction:(id)sender {
    [KeyBoard add:@"." intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)button0Action:(id)sender {
    [KeyBoard add:@"0" intoTextField:self.activeTextField];
    [self textFieldUpdater];
}

- (IBAction)buttonDeleteAction:(id)sender {
    [KeyBoard deleteLastCharacterFrom:self.activeTextField];
    [self textFieldUpdater];

}


@end
