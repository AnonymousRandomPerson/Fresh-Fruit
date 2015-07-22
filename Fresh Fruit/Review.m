//
//  Review.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"
#import "StudentUser.h"

@implementation Review

-(id)initWithName:(NSInteger)newStarRating :(NSString*)newTextReview :(StudentUser*)newReviewer
{
    self = [super init];
    self.starRating = newStarRating;
    self.textReview = newTextReview;
    self.reviewer = newReviewer;
    return self;
}

-(NSString*)starImage:(NSInteger)position
{
    return self.starRating < position ? @"StarEmpty.png" : @"StarFilled.png";
}

@end