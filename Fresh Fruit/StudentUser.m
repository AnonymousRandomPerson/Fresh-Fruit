//
//  StudentUser.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentUser.h"
#import "Major.h"
#import "UserManager.h"

@implementation StudentUser

-(id)initWithName:(NSString*)newUsername :(NSString*)newPassword
{
    self = [super initWithName:newUsername :newPassword];
    self.major = [[Major alloc] initWithName:@"Un"];
    self.preferences = @"";
    self.interest = @"";
    return self;
}

-(void)editProfile:(NSString*)user :(NSString*)pass :(NSString*)newEmail :(Major*)newMajor :(NSString*)newPreferences :(NSString*)newInterest
{
    NSString *oldUsername = self.username;
    if (![self.username isEqualToString:user])
    {
        [self.userManager changeUsername:self.username :user];
    }
    self.username = user;
    self.password = pass;
    self.email = newEmail;
    self.major = newMajor;
    self.preferences = newPreferences;
    self.interest = newInterest;
    [UserManager updateSQL:[NSString stringWithFormat:@"UPDATE USERS SET USERNAME=\'%@\', PASSWORD=\'%@\', EMAIL=\'%@\', MAJOR=\'%@\', PREFERENCES=\'%@\', INTEREST=\'%@\' WHERE USERNAME=\'%@\'", user, pass, newEmail, newMajor.name, newPreferences, newInterest, oldUsername]];
}

@end