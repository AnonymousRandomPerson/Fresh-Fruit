//
//  Review.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_Review_h
#define Fresh_Fruit_Review_h

@class StudentUser;

@interface Review : NSObject

@property(nonatomic) NSInteger starRating;
@property(nonatomic, copy) NSString *textReview;
@property(nonatomic, retain) StudentUser *reviewer;

-(id)initWithName:(NSInteger)newStarRating :(NSString*)newTextReview :(StudentUser*)newReviewer;

-(NSString*)starImage:(NSInteger)position;

@end

#endif
