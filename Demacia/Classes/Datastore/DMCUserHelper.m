//
//  DMCUserHelper.m
//  Demacia
//
//  Created by Hongyong Jiang on 05/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCUserHelper.h"

@implementation DMCUserHelper
@synthesize userInfo;

+ (DMCUserHelper *)sharedInstance
{
    static DMCUserHelper *_sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DMCUserHelper alloc] init];
    });
    
    return _sharedObject;
}

@end
