//
//  EntryViewController.m
//  Life's Good
//
//  Created by Daniel on 4/11/14.
//  Copyright (c) 2014 Worthless Apps. All rights reserved.
//

#import "EntryViewController.h"
#import "Entry.h"
#import "AddEntryViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

#define ENTRY_HEIGHT    50

@interface EntryViewController ()
@property (nonatomic, strong) NSArray* entries;
@property CGFloat height;
@end

@implementation EntryViewController

- (id)initWithEntries:(NSArray*)entries height:(CGFloat)height
{
    self = [self initWithNibName:nil bundle:nil];
    if (self)
    {
        self.entries = entries;
        self.height = height;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat screenWidth = APP_FRAME.size.width;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, _height)];
    [self.view addSubview:scrollView];
    
    CGFloat y = 0;
    for (Entry* entry in _entries)
    {
        y += ENTRY_HEIGHT;
    }
    
    UIView* addCell = [[UIView alloc] initWithFrame:CGRectMake(0, y, screenWidth, ENTRY_HEIGHT)];
    [addCell setBackgroundColor:[UIColor grayColor]];
    UITapGestureRecognizer* addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAddTap:)];
    [addCell addGestureRecognizer:addTap];
    [scrollView addSubview:addCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onAddTap:(UITapGestureRecognizer*)tapGesture
{
    UIView* view = tapGesture.view;
    CGPoint toPoint = [view convertPoint:view.frame.origin toView:nil];
    AddEntryViewController* addVC = [[AddEntryViewController alloc] initWithEntryViewVC:self atYPosition:toPoint.y];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.viewController addChildViewController:addVC];
    [appDelegate.viewController.view addSubview:addVC.view];
    
    //[ViewController addViewController:addVC];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
