//
//  TmpFilesMgr.h
//  QuCube
//
//  Created by Hongyong Jiang on 02/04/13.
//  Copyright (c) 2013年 Hongyong Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TmpFilesMgr : NSObject

+ (TmpFilesMgr *)sharedInstance;

- (BOOL) deleteFile:(NSString*)name;
- (void) saveFile:(NSString*)name data:(NSData*)data;
- (NSData*) loadFile:(NSString*)name func:(void(^)(NSData* data))func;
- (NSString*)getFullName:(NSString*)name;

@end
