//
//  User.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentUser.h"

@implementation User

-(id)initWithName:(NSString*)newUsername :(NSString*)newPassword
{
    self = [super init];
    self.username = newUsername;
    self.password = newPassword;
    self.numTries = 0;
    self.email = @"";
    self.status = @"Normal";
    return self;
}

-(void)setAndUpdateStatus:(NSString*)s
{
    _status = s;
    [UserManager updateSQL:[NSString stringWithFormat:@"UPDATE USERS SET STATUS = \'%@\' WHERE USERNAME = \'%@\'", self.status, self.username]];
}

-(bool)checkLogin:(NSString*)p
{
    if ([p isEqualToString:self.password])
    {
        return true;
    }
    else
    {
        self.numTries++;
        if (self.numTries >= LIMITTRIES && [self isKindOfClass:[StudentUser class]])
        {
            [self setStatus:@"Locked"];
        }
        return false;
    }
}

-(bool)isLocked
{
    return [self.status isEqualToString:@"Locked"];
}

-(bool)isBanned
{
    return [self.status isEqualToString:@"Banned"];
}

@end