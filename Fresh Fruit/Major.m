//
//  Major.m
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Major.h"

@interface Major()

@end

@implementation Major

NSDictionary* majors;
                        
-(id)initWithName:(NSString*)newName
{
    self = [super init];
    if (!majors)
    {
        [Major initMajors];
    }
    self.name = newName;
    self.fullName = majors[newName];
    return self;
}

-(id)initWithFullName:(NSString*)fullName
{
    self = [super init];
    if (!majors)
    {
        [Major initMajors];
    }
    self.fullName = fullName;
    self.name = [[majors allKeysForObject:fullName] objectAtIndex:0];
    return self;
}

+(void)initMajors
{
    majors = [NSDictionary dictionaryWithObjectsAndKeys:
              @"Aerospace Engineering", @"AE",
              @"Architecture", @"ARCH",
              @"Biomedical Engineering", @"BME",
              @"Chemical Engineering", @"ChemE",
              @"Chemistry", @"Chem",
              @"Computational Media", @"CM",
              @"Computer Science", @"CS",
              @"Electrical Engineering", @"EE",
              @"Industrial and Systems Engineering", @"ISYE",
              @"Mathematics", @"Math",
              @"Management", @"MGT",
              @"Mechanical Engineering", @"ME",
              @"Physics", @"Phys",
              @"Undecided", @"Un", nil];
}

+(NSArray*)getAllMajors
{
    if (!majors)
    {
        [Major initMajors];
    }
    return [[majors allValues] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

@end
