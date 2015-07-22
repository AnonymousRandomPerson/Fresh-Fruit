//
//  User.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_User_h
#define Fresh_Fruit_User_h

#import "UserManager.h"

@interface User : NSObject

@property(nonatomic, retain) UserManager *userManager;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSString *status;
@property(nonatomic) NSInteger numTries;

-(id)initWithName:(NSString*)newUsername :(NSString*)newPassword;

-(void)setAndUpdateStatus:(NSString*)s;
-(bool)checkLogin:(NSString*)p;
-(bool)isLocked;
-(bool)isBanned;

@end

#endif
