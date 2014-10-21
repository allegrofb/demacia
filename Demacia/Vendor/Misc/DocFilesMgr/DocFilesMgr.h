//
//  DocFilesMgr.h
//  QuCube
//
//  Created by Hongyong Jiang on 02/04/13.
//  Copyright (c) 2013年 Hongyong Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocFilesMgr : NSObject

+ (DocFilesMgr *)sharedInstance;

- (NSArray*) getFileList:(NSString*)folder;
- (BOOL) deleteFile:(NSString*)name folder:(NSString*)folder;
- (void) saveFile:(NSString*)name folder:(NSString*)folder data:(NSData*)data;
- (NSData*) loadFile:(NSString*)name folder:(NSString*)folder func:(void(^)(NSData* data))func;
- (NSString*) getFullPath:(NSString*)folder name:(NSString*)name;

@end
