//
//  AdminUser.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdminUser.h"
#import "UserManager.h"

@implementation AdminUser

-(void)editProfile:(NSString*)user :(NSString*)pass :(NSString*)newEmail
{
    NSString* oldUsername = self.username;
    if (![self.username isEqualToString:user])
    {
        [self.userManager changeUsername:self.username :user];
    }
    self.username = user;
    self.password = pass;
    self.email = newEmail;
    [UserManager updateSQL:[NSString stringWithFormat:@"UPDATE USERS SET USERNAME=\'%@\', PASSWORD=\'%@\', EMAIL=\'%@\' WHERE USERNAME=\'%@\'", user, pass, newEmail, oldUsername]];
}

@end