//
//  RatingViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/22/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_RatingViewController_h
#define Fresh_Fruit_RatingViewController_h

#import "ViewController.h"

@class Movie;

@interface RatingViewController : ViewController

@property(nonatomic, retain) IBOutlet Movie *movie;
@property(nonatomic, retain) IBOutlet UIImageView *image;
@property(nonatomic, retain) IBOutlet UILabel *movieTitle;
@property(nonatomic, retain) IBOutlet UILabel *releaseDate;
@property(nonatomic, retain) IBOutlet UILabel *synopsis;
@property(nonatomic, retain) IBOutlet UITextView *review;
@property(nonatomic, retain) IBOutlet UIButton *star1;
@property(nonatomic, retain) IBOutlet UIButton *star2;
@property(nonatomic, retain) IBOutlet UIButton *star3;
@property(nonatomic, retain) IBOutlet UIButton *star4;
@property(nonatomic, retain) IBOutlet UIButton *star5;
@property(nonatomic, retain) IBOutlet UITableView *reviews;

@property(nonatomic) NSInteger starRating;
@property(nonatomic, copy) NSString *query;
@property(nonatomic, retain) NSMutableArray *savedMovies;

-(IBAction)rate:(id)sender;
-(IBAction)rate1:(id)sender;
-(IBAction)rate2:(id)sender;
-(IBAction)rate3:(id)sender;
-(IBAction)rate4:(id)sender;
-(IBAction)rate5:(id)sender;

@end

#endif
