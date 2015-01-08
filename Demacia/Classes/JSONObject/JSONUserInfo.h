//
//  JSONUserInfo.h
//  Demacia
//
//  Created by Hongyong Jiang on 28/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface JSONUserInfo : JSONModel

@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong) NSString* nickname;
@property(nonatomic,strong) NSString* shortDescription;
@property(nonatomic,strong) NSString* usernameEasemob;
@property(nonatomic,strong) NSString* passwordEasemob;

@end
