//
//  DMCUserHelper.h
//  Demacia
//
//  Created by Hongyong Jiang on 05/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface DMCUserHelper : NSObject

@property (nonatomic, strong) BmobObject* userInfo;
@property (nonatomic, strong) BmobObject* userDetail;
@property (nonatomic, strong) BmobObject* userPortrait;

+ (DMCUserHelper *)sharedInstance;

@end
