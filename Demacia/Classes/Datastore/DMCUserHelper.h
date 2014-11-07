//
//  DMCUserHelper.h
//  Demacia
//
//  Created by Hongyong Jiang on 05/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface BmobTmpFile : NSObject

@property (nonatomic, strong) NSString* picFileKey;
@property (nonatomic, strong) NSString* picThumbKey;
@property (nonatomic) BOOL finishedFlag;

@end


@interface DMCUserHelper : NSObject

@property (nonatomic, strong) BmobObject* userInfo;
@property (nonatomic, strong) NSMutableArray* photoUploadStatus;

+ (DMCUserHelper *)sharedInstance;

@end
