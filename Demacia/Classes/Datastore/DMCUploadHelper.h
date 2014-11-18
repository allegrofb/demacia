//
//  DMCUploadHelper.h
//  Demacia
//
//  Created by Hongyong Jiang on 11/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCUploadHelper : NSObject

- (void)setupUpload:(NSArray*)images urls:(NSArray*)urls;
- (void)blockHUD;
- (void)clearTmpFolder;
- (NSArray*)getUploadFiles;
- (NSArray*)getUploadThumbs;

+ (DMCUploadHelper *)sharedInstance;

@end
