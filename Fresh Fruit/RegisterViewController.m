//
//  RegisterViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterViewController.h"

@implementation RegisterViewController

-(IBAction)register:(id)sender
{
    if (![self validateUsername:self.username.text])
    {
        return;
    }
    self.userManager.currentUser = [self.userManager makeUser:self.username.text :self.password.text];
    [self.password resignFirstResponder];
    [self.username resignFirstResponder];
    [self displaySuccess:@"Registration successful." :@"registerSuccess"];
}

@end