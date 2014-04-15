//
//  AddEntryViewController.m
//  Life's Good
//
//  Created by Daniel on 4/13/14.
//  Copyright (c) 2014 Worthless Apps. All rights reserved.
//

#import "AddEntryViewController.h"
#import "EntryViewController.h"
#import "Constants.h"

@interface AddEntryViewController ()
@property CGFloat startY;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) UITextField* textField;
@end

@implementation AddEntryViewController

- (id)initWithEntryViewVC:(EntryViewController*)entryVC atYPosition:(CGFloat)yPos
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.startY = yPos;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    CGSize screenSize = APP_FRAME.size;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, _startY, screenSize.width, 50)];
    [_textField setBackgroundColor:[UIColor whiteColor]];
    [self.view setAlpha:0];
    [self.view addSubview:_textField];
    
    CGSize buttonSize = CGSizeMake(30, 30);
    CGFloat buttonY = 30;
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(-buttonSize.width, buttonY, buttonSize.width, buttonSize.height)];
    [_cancelButton addTarget:self action:@selector(onCancelTap:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_cancelButton];
    
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width, buttonY, buttonSize.width, buttonSize.height)];
    [_confirmButton addTarget:self action:@selector(onConfirmTap:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmButton setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_confirmButton];
    
    [UIView animateWithDuration:.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         [self.view setAlpha:1];
                         [_cancelButton setFrame:CGRectMake(0, _cancelButton.frame.origin.y, _cancelButton.frame.size.width, _cancelButton.frame.size.height)];
                         [_confirmButton setFrame:CGRectMake(screenSize.width - buttonSize.width, _confirmButton.frame.origin.y, _confirmButton.frame.size.width, _confirmButton.frame.size.height)];
                         [_textField setFrame:CGRectMake(0, 90, _textField.frame.size.width, _textField.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancelTap:(id)sender
{
    [self animateOut];
    
}

- (void)onConfirmTap:(id)sender
{
    [self animateOut];
}

- (void)animateOut
{
    CGSize screenSize = APP_FRAME.size;
    [UIView animateWithDuration:.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         [self.view setAlpha:0];
                         [_cancelButton setFrame:CGRectMake(-_cancelButton.frame.size.width, _cancelButton.frame.origin.y, _cancelButton.frame.size.width, _cancelButton.frame.size.height)];
                         [_confirmButton setFrame:CGRectMake(screenSize.width, _confirmButton.frame.origin.y, _confirmButton.frame.size.width, _confirmButton.frame.size.height)];
                         [_textField setFrame:CGRectMake(0, _startY, _textField.frame.size.width, _textField.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                         }
                     }];
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
