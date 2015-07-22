//
//  UserManager.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_UserManager_h
#define Fresh_Fruit_UserManager_h

#import "sqlite3.h"

@class StudentUser;
@class User;

extern const NSInteger LIMITTRIES;

@interface UserManager : NSObject

@property(nonatomic, retain) NSMutableDictionary *userList;
@property(nonatomic, retain) User *currentUser;

+(UserManager*)getInstance;

-(User*)makeUser:(NSString*)user :(NSString*)pass;
-(void)changeUsername:(NSString*)oldName :(NSString*)newName;
-(User*)find:(NSString*)username;
-(StudentUser*)getStudentUser;

+(User*)findByID:(NSInteger)userID;
+(User*)recreateUser:(sqlite3_stmt*)stmt;
+(sqlite3_stmt*)querySQL:(NSString*)query;
+(void)closeSQL:(sqlite3_stmt*)statement;
+(void)updateSQL:(NSString*)query;

@end

#endif
