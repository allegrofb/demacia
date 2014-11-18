//
//  DMCUploadHelper.h
//  Demacia
//
//  Created by Hongyong Jiang on 11/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface DMCUploadHelper : NSObject

- (void)setupUpload:(NSArray*)images urls:(NSArray*)urls;
- (void)blockHUD;
- (void)clearTmpFolder;
- (NSArray*)getUploadPhotos;
- (BmobObject*)getUploadAlbum;
- (NSString*)getUploadError;

+ (DMCUploadHelper *)sharedInstance;

@end
