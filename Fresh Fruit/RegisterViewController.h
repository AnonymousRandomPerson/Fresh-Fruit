//
//  RegisterViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_RegisterViewController_h
#define Fresh_Fruit_RegisterViewController_h

#import "ViewController.h"

@interface RegisterViewController : ViewController

@property(nonatomic, retain) IBOutlet UITextField *username;
@property(nonatomic, retain) IBOutlet UITextField *password;

-(IBAction)register:(id)sender;

@end

#endif
