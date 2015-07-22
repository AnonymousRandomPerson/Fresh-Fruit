//
//  ProfileViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/21/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_ProfileViewController_h
#define Fresh_Fruit_ProfileViewController_h

#import "ViewController.h"

@interface ProfileViewController : ViewController

@property(nonatomic, retain) IBOutlet UITextField *username;
@property(nonatomic, retain) IBOutlet UITextField *password;
@property(nonatomic, retain) IBOutlet UITextField *email;
@property(nonatomic, retain) IBOutlet UITextField *preferences;
@property(nonatomic, retain) IBOutlet UITextField *interest;
@property(nonatomic, retain) IBOutlet UIPickerView *major;

-(IBAction)editProfile:(id)sender;

@end

#endif
