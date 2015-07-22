//
//  Movie.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_Movie_h
#define Fresh_Fruit_Movie_h

@class UIImage;

@class Review;
@class StudentUser;
@class UserManager;

@interface Movie : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, retain) NSMutableArray *reviews;
@property(nonatomic, copy) NSString *releaseDate;
@property(nonatomic, copy) NSString *synopsis;
@property(nonatomic, retain) UIImage *image;
@property(nonatomic) NSInteger movieID;

-(id)initWithName:(NSString*)newTitle :(NSString*)newImagePath :(NSInteger)newId;
-(id)initWithDetails:(NSString*)newTitle :(NSString*)newImagePath :(NSString*)newReleaseDate :(NSString*)newSynopsis :(NSInteger)newId;

-(NSInteger)avgScore;
-(void)addReview:(Review*)review;

@end

#endif
