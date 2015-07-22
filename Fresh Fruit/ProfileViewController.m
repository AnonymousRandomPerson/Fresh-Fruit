//
//  ProfileViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/21/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileViewController.h"
#import "Major.h"
#import "StudentUser.h"

@interface ProfileViewController()
{
    NSArray *majors;
    StudentUser *currentUser;
}

@end

@implementation ProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    currentUser = [self.userManager getStudentUser];
    self.username.text = currentUser.username;
    self.password.text = currentUser.password;
    self.email.text = currentUser.email;
    self.preferences.text = currentUser.preferences;
    self.interest.text = currentUser.interest;
    majors = [Major getAllMajors];
    [self.major selectRow:[majors indexOfObject:[currentUser.major fullName]]
                                    inComponent:0
                                       animated:NO];
}

-(IBAction)editProfile:(id)sender
{
    if (![self.username.text isEqualToString:currentUser.username])
    {
        if (![self validateUsername:self.username.text])
        {
            return;
        }
    }
    [currentUser editProfile:self.username.text
                            :self.password.text
                            :self.email.text
                            :[[Major alloc] initWithFullName:majors[[self.major selectedRowInComponent:0]]]
                            :self.preferences.text
                            :self.interest.text];
    [self performSegueWithIdentifier:@"saveProfile" sender:nil];
}

-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (int)majors.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return majors[row];
}

@end