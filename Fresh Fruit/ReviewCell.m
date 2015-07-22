//
//  ReviewCell.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/22/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewCell.h"

#import "Review.h"

@implementation ReviewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier :(Review*)review
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i < 5; i++)
        {
            UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(250 + i * 10, 0, 10, 10)];
            if (i < review.starRating)
            {
                star.image = [UIImage imageNamed:@"StarFilled.png"];
            }
            else
            {
                star.image = [UIImage imageNamed:@"StarEmpty.png"];
            }
            [self addSubview:star];
        }
    }
    return self;
}

@end