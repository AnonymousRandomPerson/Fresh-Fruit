//
//  RatingViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/22/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "RatingViewController.h"

#import "ReviewCell.h"
#import "SearchViewController.h"

#import "Major.h"
#import "Movie.h"
#import "Review.h"
#import "StudentUser.h"
#import "UserManager.h"

@interface RatingViewController()
{
    NSArray *stars;
}

@end

@implementation RatingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.review.layer.borderWidth = 1.0f;
    self.review.layer.borderColor = [[UIColor grayColor] CGColor];
    self.image.image = self.movie.image;
    self.movieTitle.text = self.movie.title;
    self.releaseDate.text = self.movie.releaseDate;
    self.synopsis.text = self.movie.synopsis;
    self.starRating = 5;
    stars = @[self.star1, self.star2, self.star3, self.star4, self.star5];
}

-(IBAction)rate:(id)sender
{
    self.image.image = self.movie.image;
    if ([self.review.text isEqualToString:@""])
    {
        [self displayError:@"You need to enter a review before it can be submitted."];
        return;
    }
    StudentUser *user = [self.userManager getStudentUser];
    sqlite3_stmt *stmt = [UserManager querySQL:[NSString stringWithFormat:@"SELECT USERID FROM USERS WHERE USERNAME = '%@'", user.username]];
    NSInteger userID = -1;
    if (sqlite3_step(stmt) == SQLITE_ROW)
    {
        userID = sqlite3_column_int(stmt, 0);
    }
    [UserManager closeSQL:stmt];
    [UserManager updateSQL:[NSString stringWithFormat:@"INSERT INTO REVIEWS (MOVIEID, STARRATING, TEXTREVIEW, REVIEWMAJOR, USERID) VALUES ('%ld', %ld,'%@','%@',%ld)", (long)self.movie.movieID, (long)self.starRating, self.review.text, user.major.name, (long)userID]];
    [self displaySuccess:@"Your review has been submitted." :@"rateMovie"];
}

-(IBAction)rate1:(id)sender
{
    [self changeStars:1];
}

-(IBAction)rate2:(id)sender
{
    [self changeStars:2];
}

-(IBAction)rate3:(id)sender
{
    [self changeStars:3];
}

-(IBAction)rate4:(id)sender
{
    [self changeStars:4];
}

-(IBAction)rate5:(id)sender
{
    [self changeStars:5];
}

-(void)changeStars:(NSInteger)rating
{
    if (self.starRating != rating)
    {
        self.starRating = rating;
        for (int i = 0; i < 5; i++)
        {
            UIButton *star = (UIButton*)[stars objectAtIndex:i];
            if (i < rating)
            {
                [star setImage:[UIImage imageNamed:@"StarEmpty.png"] forState:UIControlStateNormal];
            }
            else
            {
                [star setImage:[UIImage imageNamed:@"StarFilled.png"] forState:UIControlStateNormal];
            }
            [star.imageView setNeedsDisplay];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Review *review = (Review*)[self.movie.reviews objectAtIndex:indexPath.row];
    NSDictionary *attributes = [self reviewCellAttributes];
    CGRect rect = [review.textReview boundingRectWithSize:CGSizeMake(290, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    if (rect.size.height < 50)
    {
        return 50;
    }
    return rect.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movie.reviews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewCell *cell = (ReviewCell*)[tableView dequeueReusableCellWithIdentifier:@"Review"];
    Review *review = (Review*)[self.movie.reviews objectAtIndex:indexPath.row];
    
    if (!cell)
    {
        cell = [[ReviewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                 reuseIdentifier:@"Review"
                                                :review];
    }
    NSDictionary *attributes = [self reviewCellAttributes];
    cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, 50);
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:review.textReview attributes:attributes];
    cell.textLabel.numberOfLines = 5;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"\nBy %@ ", review.reviewer.username];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    return cell;
}

-(NSDictionary*)reviewCellAttributes
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [style setLineHeightMultiple:1.05];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14],
                                 NSParagraphStyleAttributeName: style};
    return attributes;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.review resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"backSearch"])
    {
        SearchViewController *destViewController = segue.destinationViewController;
        destViewController.toSearch = self.query;
        destViewController.movies = self.savedMovies;
    }
    else if ([segue.identifier isEqualToString:@"similarMovies"])
    {
        SearchViewController *destViewController = segue.destinationViewController;
        destViewController.toSearch = @"Similar Movies";
        destViewController.similar = self.movie.movieID;
    }
}

@end