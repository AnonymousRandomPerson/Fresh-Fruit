//
//  ReviewCell.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/22/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_ReviewCell_h
#define Fresh_Fruit_ReviewCell_h

#import "ViewController.h"

@class Review;

@interface ReviewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier :(Review*)review;

@end

#endif
