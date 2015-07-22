//
//  LoginViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import "LoginViewController.h"
#import "StudentUser.h"

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)login:(id)sender
{
    if ([self.username.text isEqualToString:@""])
    {
        [self displayError:@"No username entered."];
        return;
    }
    User *user = [self.userManager find:self.username.text];
    if (!user)
    {
        [self displayError:@"Username or password incorrect."];
    }
    else if ([user isLocked])
    {
        [self displayError:@"You have exceeded your number of attempts to log in."];
    }
    else if ([user isBanned])
    {
        [self displayError:@"You have been banned from this application."];
    }
    else if ([user checkLogin:self.password.text])
    {
        self.userManager.currentUser = user;
        if ([user isKindOfClass:[StudentUser class]])
        {
            [self performSegueWithIdentifier:@"loginSuccess" sender:nil];
        }
        else
        {
            [self performSegueWithIdentifier:@"adminLoginSuccess" sender:nil];
        }
    }
    else
    {
        [self displayError:@"Username or password incorrect"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
