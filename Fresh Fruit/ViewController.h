//
//  ViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface ViewController : UIViewController

@property(nonatomic, retain) UserManager *userManager;

-(void)displayError:(NSString*)message;
-(void)displaySuccess:(NSString*)message :(NSString*)segueID;
-(bool)validateUsername:(NSString*)username;

-(IBAction)logout:(id)sender;

@end

