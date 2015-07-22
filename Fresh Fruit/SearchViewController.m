//
//  SearchViewController.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/21/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"

#import "RatingViewController.h"

#import "Major.h"
#import "Movie.h"
#import "MovieLogic.h"
#import "StudentUser.h"

@interface SearchViewController()

@end

@implementation SearchViewController
{
    NSInteger selectedRow;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.searchDisplayController.searchBar.text = self.toSearch;
    if (!self.movies)
    {
        [self updateSearch:self.toSearch];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MovieList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Movie *movie = (Movie*)[self.movies objectAtIndex:indexPath.row];
    cell.imageView.image = movie.image;
    cell.textLabel.text = movie.title;
    return cell;
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self updateSearch:searchText];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"selectMovie" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selectMovie"]) {
        RatingViewController *destViewController = segue.destinationViewController;
        destViewController.movie = [self.movies objectAtIndex:selectedRow];
        destViewController.query = self.searchDisplayController.searchBar.text;
        destViewController.savedMovies = self.movies;
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self updateSearch:aSearchBar.text];
    [aSearchBar resignFirstResponder];
}

-(void)updateSearch:(NSString*)query
{
    if (self.similar)
    {
        self.movies = [MovieLogic getSimilarMovies:self.similar];
        self.similar = 0;
    }
    else if ([query isEqualToString:@"New Releases"])
    {
        self.movies = [MovieLogic getNewMovies];
    }
    else if ([query isEqualToString:@"New DVDs"])
    {
        self.movies = [MovieLogic getNewDvd];
    }
    else if ([query isEqualToString:@"Top Rated"])
    {
        self.movies = [MovieLogic getTopMovies];
    }
    else if ([query isEqualToString:@"Recommended Movies"])
    {
        self.movies = [MovieLogic recommendMovies:[self.userManager getStudentUser].major];
    }
    else
    {
        self.movies = [MovieLogic searchMovies:query];
    }
    [self.searchDisplayController.searchResultsTableView reloadData];
}

@end
