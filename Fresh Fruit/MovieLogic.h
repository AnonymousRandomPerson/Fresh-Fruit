//
//  MovieLogic.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_MovieLogic_h
#define Fresh_Fruit_MovieLogic_h

#import "Movie.h"

@class Major;

extern const NSInteger LIMIT;
extern const NSString* HOST;
extern const NSString* UNAME;
extern const NSString* UPASS;

@interface MovieLogic : NSObject

+(NSMutableArray*)searchMovies:(NSString*)search;
+(NSMutableArray*)getNewDvd;
+(NSMutableArray*)recommendMovies:(Major*)major;
+(Movie*)getMovieById:(NSInteger)movieID;
+(NSDictionary*)fromJson:(NSString*)json;
+(NSMutableArray*)getNewMovies;
+(NSMutableArray*)getTopMovies;
+(NSMutableArray*)getSimilarMovies:(NSInteger)movieID;
+(NSMutableArray*)findMovies:(NSString*)query;
+(Movie*)parseMovie:(NSDictionary*)movieJson :(NSInteger)movieID;
+(NSString*)getJsonData:(NSString*)link;

@end

#endif
