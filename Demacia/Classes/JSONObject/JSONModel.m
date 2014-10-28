//
//  JSONModel.m
//  Demacia
//
//  Created by Hongyong Jiang on 28/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel

- (id)initWithDictionary:(NSMutableDictionary *)jsonObject
{
    self = [super init];
    
    if(self != nil)
    {
        [self setValuesForKeysWithDictionary:jsonObject];
        
    }
    return self;
}

@end
