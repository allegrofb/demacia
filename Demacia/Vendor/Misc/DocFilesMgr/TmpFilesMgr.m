//
//  TmpFilesMgr.m
//  QuCube
//
//  Created by Hongyong Jiang on 02/04/13.
//  Copyright (c) 2013年 Hongyong Jiang. All rights reserved.
//

#import "TmpFilesMgr.h"
#import "Utility.h"

@implementation TmpFilesMgr


+ (TmpFilesMgr *)sharedInstance
{
    static TmpFilesMgr *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TmpFilesMgr alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if(!(self=[super init])) return nil;
    
    return self;
}

- (BOOL) deleteFile:(NSString*)name
{
	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:name];	
	NSError *error;
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])		//Does file exist?
	{
		if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error])	//Delete it
		{
			DLog(@"Delete file error: %@", error);
			return NO;
		}
	}
	
	return YES;
}

- (void) saveFile:(NSString*)name data:(NSData*)data
{
	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:name];	

	[[NSFileManager defaultManager] createFileAtPath:path
											contents:data
										attributes:nil];
	return;
}

- (NSString*)getFullName:(NSString*)name
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		//File exists
		return path;
	}
	else
	{
		DLog(@"File does not exist");
		return nil;
	}
}

- (NSData*) loadFile:(NSString*)name func:(void(^)(NSData* data))func
{
	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:name];	

	if ([[NSFileManager defaultManager] fileExistsAtPath:path])
	{
		//File exists
		NSData *file = [[NSData alloc] initWithContentsOfFile:path];
		if (file && func)
		{
			func(file);
		}
		return file;
	}
	else
	{
		DLog(@"File does not exist");
		return nil;
	}
}

@end
