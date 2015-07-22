//
//  Movie.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewController.h"

#import "Movie.h"
#import "MovieLogic.h"
#import "Review.h"
#import "StudentUser.h"
#import "UserManager.h"

@implementation Movie

-(id)initWithName:(NSString*)newTitle :(NSString*)newImagePath :(NSInteger)newId
{
    self = [super init];
    self.title = newTitle;
    NSURL *imageURL = [NSURL URLWithString:newImagePath];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    self.image = [UIImage imageWithData:imageData];
    self.reviews = [NSMutableArray arrayWithCapacity:0];
    self.releaseDate = @"2000-01-01";
    self.synopsis = @"Synopsis";
    self.movieID = newId;
    return self;
}

-(id)initWithDetails:(NSString*)newTitle :(NSString*)newImagePath :(NSString*)newReleaseDate :(NSString*)newSynopsis :(NSInteger)newId
{
    self = [super init];
    self.title = newTitle;
    NSURL *imageURL = [NSURL URLWithString:newImagePath];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    self.image = [UIImage imageWithData:imageData];
    self.reviews = [NSMutableArray arrayWithCapacity:10];
    self.releaseDate = newReleaseDate;
    self.synopsis = newSynopsis;
    self.movieID = newId;
    
    sqlite3_stmt* stmt = [UserManager querySQL:[NSString stringWithFormat:@"SELECT STARRATING, TEXTREVIEW, USERID FROM REVIEWS WHERE MOVIEID='%ld'", (long)newId]];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        User *tempUser = [UserManager findByID:sqlite3_column_int(stmt, 2)];
        if ([tempUser isKindOfClass:[StudentUser class]])
        {
            [self.reviews addObject:[[Review alloc] initWithName: sqlite3_column_int(stmt, 0)
                                                                : [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)]
                                                                : (StudentUser*)tempUser]];
        }
    }
    [UserManager closeSQL:stmt];
    return self;
}

-(NSArray*)reviews
{
    if ([_reviews count] < LIMIT)
    {
        return _reviews;
    }
    else
    {
        NSRange range;
        range.location = 0;
        range.length = LIMIT;
        return [_reviews subarrayWithRange:range];
    }
}

-(NSInteger)avgScore
{
    NSInteger total = 0;
    for (Review *review in self.reviews)
    {
        total += review.starRating;
    }
    total /= [self.reviews count];
    return total;
}

-(void)addReview:(Review*)review
{
    [self.reviews addObject:review];
}

@end