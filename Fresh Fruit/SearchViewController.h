//
//  SearchViewController.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/21/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_SearchViewController_h
#define Fresh_Fruit_SearchViewController_h

#import "ViewController.h"

@interface SearchViewController : ViewController

@property(nonatomic, copy) NSString *toSearch;
@property(nonatomic, retain) NSMutableArray *movies;
@property(nonatomic) NSInteger similar;

@end

#endif
