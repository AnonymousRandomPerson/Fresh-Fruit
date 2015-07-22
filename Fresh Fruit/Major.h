//
//  Major.h
//  Fresh Fruit
//
//  Created by Cheng Hann Gan on 7/20/15.
//  Copyright (c) 2015 Fresh Fruit. All rights reserved.
//

#ifndef Fresh_Fruit_Major_h
#define Fresh_Fruit_Major_h

@interface Major : NSObject

@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSString* fullName;

-(id)initWithName:(NSString*)newName;
-(id)initWithFullName:(NSString*)fullName;

+(NSArray*)getAllMajors;

@end

#endif
