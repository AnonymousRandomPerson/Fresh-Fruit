//
//  LoginViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface LoginViewController : ViewController

@property(nonatomic, retain) IBOutlet UITextField *username;
@property(nonatomic, retain) IBOutlet UITextField *password;

-(IBAction)login:(id)sender;

@end


