//
//  ViewController.m
//  Life's Good
//
//  Created by Daniel on 4/11/14.
//  Copyright (c) 2014 Worthless Apps. All rights reserved.
//

#import "ViewController.h"
#import "EntryViewController.h"
#import "AppDelegate.h"

#define OPTIONS_BUTTON_SIZE     CGSizeMake(50, 30)

@interface ViewController ()
@property (nonatomic, strong) UIView* titleView;
@property (nonatomic, strong) UIScrollView* mainScrollView;
@property (nonatomic, strong) UIView* optionsContainer;
@property (nonatomic, strong) UIView* optionsView;
@end

@implementation ViewController

+ (id)sharedInstance
{
    static ViewController *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
    });
    return sharedMyInstance;
}

+ (void)addViewController:(UIViewController*)viewController
{
    ViewController* mainVC = [ViewController sharedInstance];
    [mainVC addChildViewController:viewController];
    [mainVC.view addSubview:viewController.view];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;
    
	// Do any additional setup after loading the view, typically from a nib.
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    BOOL ios7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
    CGFloat statusBar = ios7 ? 20 : 0;
    
    CGFloat titleHeight = 50 + statusBar;
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, titleHeight)];
    [_titleView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_titleView];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleHeight, screenSize.width, screenSize.height - titleHeight)];
    [_mainScrollView setBackgroundColor:[UIColor purpleColor]];
    [_mainScrollView setPagingEnabled:YES];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_mainScrollView];
    [_mainScrollView setContentSize:CGSizeMake(screenSize.width * 3, _mainScrollView.frame.size.height)];
    
    CGFloat offset = 0;
    for (int i = 0; i < 3; i++)
    {
        if (i == 1)
        {
            EntryViewController* entryViewVC = [[EntryViewController alloc] initWithEntries:nil height:_mainScrollView.frame.size.height];
            [_mainScrollView addSubview:entryViewVC.view];
            [self addChildViewController:entryViewVC];
            [entryViewVC.view setFrame:CGRectMake(offset, 0, entryViewVC.view.frame.size.width, entryViewVC.view.frame.size.height)];
        }
        else
        {
            UIView* temp = [[UIView alloc] initWithFrame:CGRectMake(offset + 10, 0, screenSize.width - 20, _mainScrollView.frame.size.height)];
            [temp setBackgroundColor:[UIColor yellowColor]];
            [_mainScrollView addSubview:temp];
        }
        
        offset += screenSize.width;
    }
    [_mainScrollView setContentOffset:CGPointMake(screenSize.width, 0)];
    
    CGSize optionsButtonSize = OPTIONS_BUTTON_SIZE;
    self.optionsContainer = [[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height - optionsButtonSize.height, screenSize.width, _mainScrollView.frame.size.height + optionsButtonSize.height)];
    
    UIView* optionsButton = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - optionsButtonSize.width) / 2, 0, optionsButtonSize.width, optionsButtonSize.height)];
    [optionsButton setBackgroundColor:[UIColor blueColor]];
    UITapGestureRecognizer* optionsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onOptionsTap)];
    [optionsButton addGestureRecognizer:optionsTap];
    [_optionsContainer addSubview:optionsButton];
    
    self.optionsView = [[UIView alloc] initWithFrame:CGRectMake(0, optionsButtonSize.height, screenSize.width, _mainScrollView.frame.size.height)];
    [_optionsView setBackgroundColor:[UIColor blueColor]];
    [_optionsView setHidden:YES];
    [_optionsContainer addSubview:_optionsView];
    [self.view addSubview:_optionsContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onOptionsTap
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat toY = screenSize.height - OPTIONS_BUTTON_SIZE.height;
    BOOL isOpening = NO;
    if (_optionsView.hidden)
    {
        isOpening = YES;
        toY = screenSize.height - _optionsContainer.frame.size.height;
    }
    if (isOpening)
    {
        [_optionsView setHidden:NO];
    }
    [UIView animateWithDuration:.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         [_optionsContainer setFrame:CGRectMake(0, toY, _optionsContainer.frame.size.width, _optionsContainer.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             if (!isOpening)
                             {
                                 [_optionsView setHidden:YES];
                             }
                         }
                     }];
    
}

@end
