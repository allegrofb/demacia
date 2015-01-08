//
//  JSONPhoto.h
//  Demacia
//
//  Created by Hongyong Jiang on 20/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "JSONModel.h"

@interface JSONPhoto : JSONModel

@property(nonatomic,strong) NSString* content;
@property(nonatomic,strong) NSString* picture;
@property(nonatomic,strong) NSString* thumb;

@end
