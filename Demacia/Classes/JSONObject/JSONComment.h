//
//  JSONComment.h
//  Demacia
//
//  Created by Hongyong Jiang on 28/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface JSONComment : JSONModel

@property(nonatomic,strong) NSString * files;
@property(nonatomic,strong) NSString * gmtCreate;
@property(nonatomic,strong) NSString * up_mid;
@property(nonatomic,strong) NSString * msgId;
@property(nonatomic,strong) NSString * replyId;
@property(nonatomic,strong) NSString * content;
@property(nonatomic,strong) NSString * upReplyId;
@property(nonatomic,strong) NSString * atmans;
@property(nonatomic,strong) NSString * title;

@end
