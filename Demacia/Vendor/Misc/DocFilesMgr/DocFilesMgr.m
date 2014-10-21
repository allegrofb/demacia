//
//  DocFilesMgr.m
//  QuCube
//
//  Created by Hongyong Jiang on 02/04/13.
//  Copyright (c) 2013年 Hongyong Jiang. All rights reserved.
//

#import "DocFilesMgr.h"
#import "Utility.h"

@implementation DocFilesMgr


+ (DocFilesMgr *)sharedInstance
{
    static DocFilesMgr *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DocFilesMgr alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if(!(self=[super init])) return nil;
    
    return self;
}

- (NSArray*) getFileList:(NSString*)folder
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
    if(folder != nil)
    {
        path = [path stringByAppendingPathComponent:folder];
    }
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
}

- (BOOL) deleteFile:(NSString*)name folder:(NSString *)folder
{
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths objectAtIndex:0];
    if(folder != nil)
    {
        path = [path stringByAppendingPathComponent:folder];
    }
	path = [path stringByAppendingPathComponent:name];
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

- (void) saveFile:(NSString*)name folder:(NSString *)folder data:(NSData *)data
{
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths objectAtIndex:0];
    if(folder != nil)
    {
        path = [path stringByAppendingPathComponent:folder];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
	path = [path stringByAppendingPathComponent:name];

	[[NSFileManager defaultManager] createFileAtPath:path
											contents:data
										attributes:nil];
	return;
}

- (NSData*) loadFile:(NSString*)name folder:(NSString *)folder func:(void (^)(NSData *))func
{
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths objectAtIndex:0];
    if(folder != nil)
    {
        path = [path stringByAppendingPathComponent:folder];
    }
	path = [path stringByAppendingPathComponent:name];

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

- (NSString*) getFullPath:(NSString*)folder name:(NSString*)name
{
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0];
    
    if(folder != nil)
    {
        path = [path stringByAppendingPathComponent:folder];
    }
    
    if(name != nil)
    {
        path = [path stringByAppendingPathComponent:name];
    }

    #ifdef DEBUG
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        DLog(@"File does not exist");
    }
    
    #endif
    
    return path;
}








//Show contents of Documents directory

//NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);


//Does File Exist
//
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectory"];
//path = [path stringByAppendingPathComponent:@"SomeFileName"];
//if ([[NSFileManager defaultManager] fileExistsAtPath:path])
//{



//Delete File
//
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectory"];
//path = [path stringByAppendingPathComponent:@"SomeFileName"];
//NSError *error;
//if ([[NSFileManager defaultManager] fileExistsAtPath:path])		//Does file exist?
//{
//    if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error])	//Delete it
//    {
//        NSLog(@"Delete file error: %@", error);
//    }
//}




//Delete DIrectory
//
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectoryName"];
//NSError *error;
//
//if ([[NSFileManager defaultManager] fileExistsAtPath:path])	//Does directory exist?
//{
//    if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error])	//Delete it
//    {
//        NSLog(@"Delete directory error: %@", error);
//    }
//}



//Create Directory
//
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectoryName"];
//NSError *error;
//if (![[NSFileManager defaultManager] fileExistsAtPath:path])	//Does directory already exist?
//{
//    if (![[NSFileManager defaultManager] createDirectoryAtPath:path
//                                   withIntermediateDirectories:NO
//                                                    attributes:nil
//                                                         error:&error])
//    {
//        NSLog(@"Create directory error: %@", error);
//    }
//}


//Save NSData File
//
//NSData *file;
//file = ...
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectoryName"];
//path = [path stringByAppendingPathComponent:@"SomeFileName"];
//
//[[NSFileManager defaultManager] createFileAtPath:path
//                                        contents:FileData
//                                      attributes:nil];




//Load File
//
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"My Directory"];
//path = [path stringByAppendingPathComponent:@"My Filename"];
//
//if ([[NSFileManager defaultManager] fileExistsAtPath:path])
//{
//    //File exists
//    NSData *file1 = [[NSData alloc] initWithContentsOfFile:path];
//    if (file1)
//    {
//        [self MyFunctionWantingAFile:file1];
//        [file1 release];
//        
//    }
//}
//else
//{
//    NSLog(@"File does not exist");
//}


//Move File

//[[NSFileManager defaultManager] moveItemAtPath:MySourcePath toPath:MyDestPath error:nil];

//Rename File
//Use same method as moving a file


//List Files

//----- LIST ALL FILES -----
//NSLog(@"LISTING ALL FILES FOUND");
//
//int Count;
//NSString *path;
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectoryName"];
//NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
//for (Count = 0; Count < (int)[directoryContent count]; Count++)
//{
//    NSLog(@"File %d: %@", (Count + 1), [directoryContent objectAtIndex:Count]);
//}


@end
