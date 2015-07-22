//
//  StudentUser.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_StudentUser_h
#define Fresh_Fruit_StudentUser_h

#import "User.h"

@class Major;

@interface StudentUser : User

@property(nonatomic, retain) Major *major;
@property(nonatomic, copy) NSString *preferences;
@property(nonatomic, copy) NSString *interest;

-(id)initWithName:(NSString*)newUsername :(NSString*)newPassword;

-(void)editProfile:(NSString*)user :(NSString*)pass :(NSString*)newEmail :(Major*)newMajor :(NSString*)newPreferences :(NSString*)newInterest;

@end

#endif
