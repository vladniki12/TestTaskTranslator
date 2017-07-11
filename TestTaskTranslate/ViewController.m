//
//  ViewController.m
//  TestTaskTranslate
//
//  Created by Vladislav Novoseltsev on 10.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

#import "ViewController.h"
#import <RealReachability.h>

#import "Translate+CoreDataClass.h"
#import <MagicalRecord/MagicalRecord.h>
#import "CoreDataController.h"

@interface ViewController ()

@property (nonatomic) float mainHeight;
@property (nonatomic) BOOL isShowKeyboard;

@end

NSString * const WB_SORT_KEY     = @"WB_SORT_KEY";

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainHeight = self.view.frame.size.height;
    _isShowKeyboard = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    NSLog(@"Initial reachability status:%@",@(status));
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    
    _isShowKeyboard = YES;
    
     CGSize kbSize = [[aNotification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    float secs = [[aNotification.userInfo valueForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:secs delay:0.0 options:0
                     animations:^{
                         self.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height - kbSize.height);
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDTAE_TABLE" object:nil];
                     }
                     completion:nil];
}

- (IBAction)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    if(_isShowKeyboard) {
        [self.view endEditing:YES];
        _isShowKeyboard = NO;
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    
    float secs = [[aNotification.userInfo valueForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:secs delay:0.0 options:0
                     animations:^{
                         self.view.frame = CGRectMake(0,0, self.view.frame.size.width, _mainHeight);
                     }
                     completion:nil];
}
- (IBAction)addTextForTranslate:(id)sender {
    [self.view endEditing:YES];
    
    NSString* textForTranslate = _textField.text;
    if(textForTranslate && ![textForTranslate isEqualToString:@""]) {
        [[CoreDataController sharedInstance] addTextForTranslate:textForTranslate];
        _textField.text = @"";
    }
}

- (IBAction)clearTable:(id)sender {
    [[CoreDataController sharedInstance] clearDB];
}

- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
    NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
    if(status != RealStatusNotReachable) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UPDTAE_TABLE" object:nil];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *myRegex = @"[A-Za-zА-Яа-я]*";
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", myRegex];
    NSString *stringValidation = [NSString stringWithString:string];
    BOOL valid = [myTest evaluateWithObject:stringValidation];
    
   
    if ( [string isEqualToString:@" "] || !valid ){
        return NO;
    }
    else {
        return YES;
    }
}
@end
