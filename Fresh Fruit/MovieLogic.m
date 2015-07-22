//
//  MovieLogic.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Major.h"
#import "MovieLogic.h"
#import "UserManager.h"

const NSInteger LIMIT = 50;
const NSString* HOST = @"jdbc:derby://localhost:1527/fruit";
const NSString* UNAME = @"fruit";
const NSString* UPASS = @"team11";

@implementation MovieLogic

+(NSMutableArray*)searchMovies:(NSString*)search
{
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString* link = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=yedukp76ffytfuy24zsqk7f5&q=%@&page_limit=%ld", [search stringByReplacingOccurrencesOfString:@"\\s" withString:@"+"], (long)LIMIT];
    return [MovieLogic findMovies:link];
}

+(NSMutableArray*)getNewDvd
{
    NSString* link = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?page_limit=%ld&page=1&country=us&apikey=yedukp76ffytfuy24zsqk7f5", (long)LIMIT];
    return [MovieLogic findMovies:link];
}

typedef struct {
    NSInteger average;
    NSInteger movieID;
} entry;

int compar(const void* p1, const void* p2)
{
    entry* p1entry = (entry*)p1;
    entry* p2entry = (entry*)p2;
    if (p1entry->average < p2entry->average)
    {
        return -1;
    }
    else if (p1entry->average > p2entry->average)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

+(NSMutableArray*)recommendMovies:(Major*)major
{
    NSMutableArray* ids = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray* totals = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray* reviewCount = [NSMutableArray arrayWithCapacity:10];
    sqlite3_stmt* stmt = [UserManager querySQL:[NSString stringWithFormat:@"SELECT MOVIEID,STARRATING FROM REVIEWS WHERE REVIEWMAJOR=\'%@\'", major.name]];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        NSInteger testID = sqlite3_column_int(stmt, 0);
        if ([ids containsObject:[NSNumber numberWithInteger:testID]])
        {
            [totals replaceObjectAtIndex:[ids indexOfObject:[NSNumber numberWithInteger:testID]]
                              withObject:[NSNumber numberWithInteger:sqlite3_column_int(stmt, 1) + [[totals objectAtIndex: [ids indexOfObject:[NSNumber numberWithInteger:testID]]] integerValue]]];
            [reviewCount replaceObjectAtIndex:[ids indexOfObject:[NSNumber numberWithInteger:testID]]
                                   withObject:[NSNumber numberWithInteger:1 + [[reviewCount objectAtIndex:[ids indexOfObject:[NSNumber numberWithInteger:testID]]] integerValue]]];
        }
        else
        {
            [ids addObject:[NSNumber numberWithInteger:testID]];
            [totals addObject:[NSNumber numberWithInt:sqlite3_column_int(stmt, 1)]];
            [reviewCount addObject:[NSNumber numberWithInteger:1]];
        }
    }
    [UserManager closeSQL:stmt];
    entry averages[[ids count]];
    for (int i = 0; i < [ids count]; i++)
    {
        averages[i].average = [[totals objectAtIndex:i] integerValue] / [[reviewCount objectAtIndex:i] integerValue];
        averages[i].movieID = [[ids objectAtIndex:i] integerValue];
    }
    qsort(averages, [ids count], sizeof(entry), compar);
    
    NSMutableArray *movies = [NSMutableArray arrayWithCapacity:[ids count]];
    for (int i = 0; i < [ids count]; i++)
    {
        Movie *movie = [MovieLogic getMovieById:averages[i].movieID];
        if (movie)
        {
            [movies addObject:movie];
        }
    }
    return movies;
}

+(Movie*)getMovieById:(NSInteger)movieID
{
    NSString *link = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%ld.json?apikey=yedukp76ffytfuy24zsqk7f5", (long)movieID];
    NSString *callResult = [MovieLogic getJsonData:link];
    NSDictionary *movieJson = [MovieLogic fromJson:callResult];
    return [MovieLogic parseMovie:movieJson :movieID];
}

+(NSDictionary*)fromJson:(NSString*)json
{
    return [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
}

+(NSMutableArray*)getNewMovies
{
    NSString* link = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit%ld&page=1&country=us&apikey=yedukp76ffytfuy24zsqk7f5", (long) LIMIT];
    return [MovieLogic findMovies:link];
}

+(NSMutableArray*)getTopMovies
{
    NSString* link = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?page_limit=%ld&page=1&country=us&apikey=yedukp76ffytfuy24zsqk7f5", (long)LIMIT];
    return [MovieLogic findMovies:link];
}

+(NSMutableArray*)getSimilarMovies:(NSInteger)movieID
{
    NSString* link = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%ld/similar.json?limit=5&apikey=yedukp76ffytfuy24zsqk7f5", (long)movieID];
    return [MovieLogic findMovies:link];
}

+(NSMutableArray*)findMovies:(NSString*)query
{
    NSString *callResult = [MovieLogic getJsonData:query];
    if (!callResult)
    {
        return [NSMutableArray arrayWithCapacity:0];
    }
    NSDictionary *jo = [MovieLogic fromJson:callResult];
    NSArray *movieArray = jo[@"movies"];
    NSInteger numMovies = MIN(LIMIT, [movieArray count]);
    NSMutableArray* movies = [NSMutableArray arrayWithCapacity:numMovies];
    for (int i = 0; i < numMovies; i++)
    {
        NSDictionary *movieJson = [movieArray objectAtIndex:i];
        NSInteger movieID = [movieJson[@"id"] integerValue];
        [movies addObject:[MovieLogic parseMovie:movieJson :movieID]];
    }
    return movies;
}

+(Movie*)parseMovie:(NSDictionary*)movieJson :(NSInteger)movieID
{
    NSString *title = movieJson[@"title"];
    NSString *thumbnail = movieJson[@"posters"][@"thumbnail"];
    NSString *synopsis = @"None";
    NSString *release = @"Unknown";
    if (movieJson[@"synopsis"])
    {
        synopsis = movieJson[@"synopsis"];
    }
    NSString* releaseJson = movieJson[@"release_dates"][@"theater"];
    if (releaseJson)
    {
        release = releaseJson;
    }
    return [[Movie alloc] initWithDetails:title :thumbnail :release :synopsis :movieID];
}

+(NSString*)getJsonData:(NSString*)link
{
    NSURL *url = [NSURL URLWithString:link];
    NSError *error;
    NSString *jsonData = [[NSString alloc] initWithContentsOfURL:url
                                                        encoding:NSUTF8StringEncoding
                                                           error:&error];
    if (!jsonData)
    {
        NSLog(@"Failed:%@", [error localizedFailureReason]);
    }
    return jsonData;
}

@end