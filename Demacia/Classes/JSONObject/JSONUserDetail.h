//
//  JSONUserDetail.h
//  Demacia
//
//  Created by Hongyong Jiang on 04/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "JSONModel.h"

@interface JSONUserDetail : JSONModel

@property(nonatomic) NSUInteger birthday_y;
@property(nonatomic) NSUInteger birthday_m;
@property(nonatomic) NSUInteger birthday_d;
@property(nonatomic) BOOL maleOrFemale;

@end
