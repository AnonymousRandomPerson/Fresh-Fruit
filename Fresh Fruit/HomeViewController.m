//
//  HomeViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/21/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"

#import "SearchViewController.h"

#import "Major.h"
#import "StudentUser.h"

@implementation HomeViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchViewController *destViewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"searchMovies"])
    {
        destViewController.toSearch = self.search.text;
    }
    else if ([segue.identifier isEqualToString:@"newReleases"])
    {
        destViewController.toSearch = @"New Releases";
    }
    else if ([segue.identifier isEqualToString:@"newDVDs"])
    {
        destViewController.toSearch = @"New DVDs";
    }
    else if ([segue.identifier isEqualToString:@"topRated"])
    {
        destViewController.toSearch = @"Top Rated";
    }
    else if ([segue.identifier isEqualToString:@"recommendedMovies"])
    {
        destViewController.toSearch = @"Recommended Movies";
    }
}

-(bool)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"recommendedMovies"])
    {
        if ([[self.userManager getStudentUser].major.name isEqualToString:@"Un"])
        {
            [self displayError:@"You need to have decided a major to be recommended movies."];
            return NO;
        }
    }
    return YES;
}

@end