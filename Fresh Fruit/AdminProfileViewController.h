//
//  AdminProfileViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/22/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_AdminProfileViewController_h
#define Fresh_Fruit_AdminProfileViewController_h

#import "ViewController.h"

@interface AdminProfileViewController : ViewController

@property(nonatomic, retain) IBOutlet UITextField *username;
@property(nonatomic, retain) IBOutlet UITextField *password;
@property(nonatomic, retain) IBOutlet UITextField *email;

-(IBAction)editProfile:(id)sender;

@end

#endif
