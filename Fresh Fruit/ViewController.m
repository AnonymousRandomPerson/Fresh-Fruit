//
//  ViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userManager = [UserManager getInstance];
}

-(void)displayError:(NSString*)message
{
    UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Okay", @"OK action")
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    [error addAction:defaultAction];
    [self presentViewController:error animated:YES completion:nil];
}

-(void)displaySuccess:(NSString*)message :(NSString*)segueID
{
    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Success"
                                                                     message:message
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Okay", @"OK action")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   [self performSegueWithIdentifier:segueID sender:nil];
                               }];
    [success addAction:okAction];
    [self presentViewController:success animated:YES completion:nil];
}

-(IBAction)logout:(id)sender
{
    self.userManager.currentUser = nil;
}

-(bool)validateUsername:(NSString*)username
{
    if ([username isEqualToString:@""])
    {
        [self displayError:@"No username entered."];
        return false;
    }
    else if ([self.userManager find:username])
    {
        [self displayError:@"Username already exists."];
        return false;
    }
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
