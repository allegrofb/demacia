//
//  JSONUserDetail.m
//  Demacia
//
//  Created by Hongyong Jiang on 04/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "JSONUserDetail.h"

@implementation JSONUserDetail
@synthesize birthday_d, birthday_m, birthday_y, maleOrFemale;

- (id)init
{
    self = [super init];
    
    if(self != nil)
    {
        self.birthday_y = 2000;
        self.birthday_m = 1;
        self.birthday_d = 1;
        self.maleOrFemale = YES;
        
    }
    
    return self;
}

@end
