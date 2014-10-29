//
//  JSONPost.h
//  Demacia
//
//  Created by Hongyong Jiang on 28/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface JSONPost : JSONModel

@property(nonatomic,strong) NSString * weiboId;
@property(nonatomic,strong) NSString * content;
@property(nonatomic,strong) NSString * gmtCreate;
@property(nonatomic,strong) NSString * msgId;
@property(nonatomic,strong) NSString * tMans;
@property(nonatomic,strong) NSArray * files;
@property(nonatomic,strong) NSArray * replys;

@property(nonatomic) float imageHeight;
@property(nonatomic) float replyHeight;

@end
