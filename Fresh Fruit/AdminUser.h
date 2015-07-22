//
//  AdminUser.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_AdminUser_h
#define Fresh_Fruit_AdminUser_h

#import "User.h"

@interface AdminUser : User

-(void)editProfile:(NSString*)user :(NSString*)pass :(NSString*)newEmail;

@end

#endif
