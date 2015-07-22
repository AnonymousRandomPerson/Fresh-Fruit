//
//  UserManager.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/19/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserManager.h"
#import "AdminUser.h"
#import "Major.h"
#import "StudentUser.h"

@implementation UserManager

const NSInteger LIMITTRIES = 3;
sqlite3 *data;

UserManager *instance;

-(id)init
{
    self = [super init];
    sqlite3_stmt* stmt = [UserManager querySQL:@"SELECT USERNAME,PASSWORD,EMAIL,MAJOR,PREFERENCES,INTEREST,STATUS FROM USERS"];
    self.userList = [NSMutableDictionary dictionary];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        [self.userList setObject:[UserManager recreateUser:stmt]
                          forKey:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)]];
    }
    [UserManager closeSQL:stmt];
    return self;
}

+(UserManager*)getInstance
{
    if (!instance)
    {
        instance = [[UserManager alloc] init];
    }
    return instance;
}

-(User*)makeUser:(NSString*)user :(NSString*)pass
{
    User *newUser = [[StudentUser alloc] initWithName:user :pass];
    [newUser setUserManager:self];
    [self.userList setObject:newUser
                      forKey:user];
    [UserManager updateSQL:[NSString stringWithFormat:@"INSERT INTO USERS (USERNAME, PASSWORD) VALUES (\'%@\',\'%@\')", user, pass]];
    return newUser;
}

-(void)changeUsername:(NSString*)oldName :(NSString*)newName
{
    User *user = [self find:oldName];
    [self.userList setObject:user
                 forKey:newName];
    [self.userList removeObjectForKey:oldName];
    [UserManager updateSQL:[NSString stringWithFormat:@"UPDATE USERS SET USERNAME=\'%@\' WHERE USERNAME=\'%@\'", newName, oldName]];
}

-(User*)find:(NSString*)username
{
    return self.userList[username];
}

-(StudentUser*)getStudentUser
{
    if ([self.currentUser isKindOfClass:[StudentUser class]])
    {
        return (StudentUser*)self.currentUser;
    }
    else
    {
        return nil;
    }
}

+(User*)findByID:(NSInteger)userID
{
    sqlite3_stmt* stmt = [UserManager querySQL:[NSString stringWithFormat:@"SELECT USERNAME,PASSWORD,EMAIL,MAJOR,PREFERENCES,INTEREST,STATUS FROM USERS WHERE USERID=%ld", (long)userID]];
    User* user = nil;
    if (sqlite3_step(stmt) == SQLITE_ROW)
    {
        user = [UserManager recreateUser:stmt];
    }
    [UserManager closeSQL:stmt];
    return user;
}

+(User*)recreateUser:(sqlite3_stmt*)stmt
{
    NSString* status = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 6)];
    if ([status isEqualToString:@"Admin"])
    {
        AdminUser *newUser = [[AdminUser alloc] initWithName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)] :[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)]];
        [newUser setEmail:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 2)]];
        [newUser setStatus:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 6)]];
        return newUser;
    }
    else
    {
        StudentUser *newUser = [[StudentUser alloc] initWithName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)] :[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)]];
        [newUser setEmail:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 2)]];
        [newUser setStatus:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 6)]];
        [newUser setMajor:[[Major alloc] initWithName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 3)]]];
        [newUser setPreferences:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 4)]];
        [newUser setInterest:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 5)]];
        return newUser;
    }
}

+(sqlite3_stmt*)querySQL:(NSString*)query
{
    NSInteger result = sqlite3_open([[[NSString alloc] initWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent: @"fruit.db"]] UTF8String], &data);
    if (result)
    {
        NSLog(@"Database open errored (%ld): %s.", (long)result, sqlite3_errmsg(data));
        return nil;
    }
    sqlite3_stmt *statement;
    result = sqlite3_prepare_v2(data, [query UTF8String], -1, &statement, NULL);
    if (!statement)
    {
        NSLog(@"Database query %@ errored (%ld): %s.", query, (long)result, sqlite3_errmsg(data));
    }
    return statement;
}

+(void)closeSQL:(sqlite3_stmt*)statement
{
    sqlite3_finalize(statement);
    sqlite3_close(data);
}

+(void)updateSQL:(NSString*)query
{
    sqlite3_open([[[NSString alloc] initWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent: @"fruit.db"]] UTF8String], &data);
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(data, [query UTF8String], -1, &statement, NULL);
    NSInteger result = sqlite3_step(statement);
    if (result != 101)
    {
        NSLog(@"Database query %@ errored (%ld).", query, (long)result);
    }
    [self closeSQL:statement];
}

@end