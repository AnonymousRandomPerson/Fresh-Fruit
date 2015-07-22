//
//  AdminProfileViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/22/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdminProfileViewController.h"

#import "AdminUser.h"
#import "UserManager.h"

@implementation AdminProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.username.text = self.userManager.currentUser.username;
    self.password.text = self.userManager.currentUser.password;
    self.email.text = self.userManager.currentUser.email;
}

-(IBAction)editProfile:(id)sender
{
    if (![self.username.text isEqualToString:self.userManager.currentUser.username])
    {
        if (![self validateUsername:self.username.text])
        {
            return;
        }
    }
    [(AdminUser*)self.userManager.currentUser editProfile:self.username.text
                                                         :self.password.text
                                                         :self.email.text];
    [self performSegueWithIdentifier:@"saveProfileAdmin" sender:nil];
}

@end
