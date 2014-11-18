//
//  DMCUploadHelper.m
//  Demacia
//
//  Created by Hongyong Jiang on 11/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCUploadHelper.h"
#import "TmpFilesMgr.h"
#import "DMCDatastore.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface BmobTmpFile : NSObject

@property (nonatomic, strong) NSString* fileName;
@property (nonatomic) BOOL finishedFlag;
@property (nonatomic) BOOL uploadingFlag;
@property (nonatomic, strong) BmobFile* bmobFile;
@property (nonatomic) BOOL isSuccessful;
@property (nonatomic, strong) NSError* error;

@property (nonatomic, strong) NSString* thumbName;
@property (nonatomic) BOOL finishedThumbFlag;
@property (nonatomic) BOOL uploadingThumbFlag;
@property (nonatomic, strong) BmobFile* bmobThumb;
@property (nonatomic) BOOL isSuccessfulThumb;
@property (nonatomic, strong) NSError* errorThumb;

@end

@implementation BmobTmpFile
@synthesize fileName, finishedFlag, uploadingFlag, bmobFile, isSuccessful, error;
@synthesize thumbName, finishedThumbFlag, uploadingThumbFlag, bmobThumb, isSuccessfulThumb, errorThumb;

- (id)init
{
    self = [super init];
    
    self.finishedFlag = false;
    self.uploadingFlag = false;
    
    self.finishedThumbFlag = false;
    self.uploadingThumbFlag = false;
    
    return self;
}

@end

@interface DMCUploadHelper ()

@property (nonatomic, strong) NSCondition* uploadCondition;
@property (nonatomic, strong) NSMutableArray* currentArray;
@property (nonatomic, strong) NSMutableDictionary* uploadQueue;
@property (nonatomic) NSUInteger imageTmpNumber;

@end

@implementation DMCUploadHelper

- (id)init
{
    self = [super init];
    
    _uploadCondition = [[NSCondition alloc] init];
    _currentArray = [[NSMutableArray alloc] init];
    _uploadQueue = [[NSMutableDictionary alloc] init];
    
    return self;
}

+ (DMCUploadHelper *)sharedInstance
{
    static DMCUploadHelper *_sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DMCUploadHelper alloc] init];
    });
    
    return _sharedObject;
}

- (void)setupUpload:(NSArray*)images urls:(NSArray*)urls
{
    [_currentArray removeAllObjects];
    
    int i = 0;
    
    for(i = 0;i<images.count;i++)
    {
        NSURL* url = urls[i];
        UIImage* image = images[i];
        
        BmobTmpFile* obj = [_uploadQueue objectForKey:url];
        if(obj == nil)
        {
            NSString* name = [NSString stringWithFormat:@"%lu.jpg",(unsigned long)_imageTmpNumber];
            NSString* thumbName = [NSString stringWithFormat:@"%luThumb.jpg",(unsigned long)_imageTmpNumber];
            _imageTmpNumber++;
            
            NSData* data = UIImageJPEGRepresentation(image,1.0);
            name = [[TmpFilesMgr sharedInstance] saveFile:name data:data];
            
            thumbName = [[TmpFilesMgr sharedInstance] saveFile:thumbName data:data];
            
            BmobTmpFile* file = [[BmobTmpFile alloc] init];
            file.fileName = name;
            file.thumbName = thumbName;
            
            [_currentArray addObject:url];
            [_uploadQueue setObject:file forKey:url];
        }
        
    }
    
    [self startUpload];
}

- (void)startUpload
{
    for(NSURL* i in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:i];
        BOOL flag = false;
        
        [_uploadCondition lock];
        flag = file.uploadingFlag;
        if(!flag)
        {
            file.uploadingFlag = true;
        }
        [_uploadCondition unlock];

        if(!flag)
        {
        
            [[DMCDatastore sharedInstance]uploadFile:file.fileName key:i resultBlock:^(NSURL *key, BmobFile* bmobFile, BOOL isSuccessful, NSError *error) {
            
                BmobTmpFile* result = [_uploadQueue objectForKey:key];
                [self setFinishedFlag:result bmobFile:bmobFile isSuccessful:isSuccessful error:error];
            
            } progressBlock:^(float progress) {
            
            
            
            }];
        }
        
        flag = false;
        
        [_uploadCondition lock];
        flag = file.uploadingThumbFlag;
        if(!flag)
        {
            file.uploadingThumbFlag = true;
        }
        [_uploadCondition unlock];
        
        if(!flag)
        {
            
            [[DMCDatastore sharedInstance]uploadFile:file.thumbName key:i resultBlock:^(NSURL *key, BmobFile* bmobFile, BOOL isSuccessful, NSError *error) {
                
                BmobTmpFile* result = [_uploadQueue objectForKey:key];
                [self setFinishedThumbFlag:result bmobFile:bmobFile isSuccessful:isSuccessful error:error];
                
            } progressBlock:^(float progress) {
                
                
                
            }];
        }
        
    }
}

- (void)setFinishedFlag:(BmobTmpFile*)result bmobFile:(BmobFile*)bmobFile isSuccessful:(BOOL) isSuccessful error:(NSError*)error
{
    [_uploadCondition lock];
    
    result.uploadingFlag = false;
    result.finishedFlag = true;
    result.error = error;
    result.bmobFile = bmobFile;
    result.isSuccessful = isSuccessful;
    
    bool all = true;
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        all = all && file.finishedFlag && file.finishedThumbFlag;
    }
    
    if(all)
    {
        [_uploadCondition signal];
    }
    
    [_uploadCondition unlock];
}

- (void)setFinishedThumbFlag:(BmobTmpFile*)result bmobFile:(BmobFile*)bmobFile isSuccessful:(BOOL) isSuccessful error:(NSError*)error
{
    [_uploadCondition lock];
    
    result.uploadingThumbFlag = false;
    result.finishedThumbFlag = true;
    result.errorThumb = error;
    result.bmobThumb = bmobFile;
    result.isSuccessfulThumb = isSuccessful;
    
    bool all = true;
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        all = all && file.finishedFlag && file.finishedThumbFlag;
    }
    
    if(all)
    {
        [_uploadCondition signal];
    }
    
    [_uploadCondition unlock];
}

- (void)blockHUD
{
    [_uploadCondition lock];

    bool all = true;
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        all = all && file.finishedFlag;
    }
    
    if(!all)
    {
        [_uploadCondition wait];
    }
    
    [_uploadCondition unlock];
}

- (NSArray*)getUploadFiles
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        [array addObject:file.bmobFile];
    }
    
    return array;
}

- (NSArray*)getUploadThumbs
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        [array addObject:file.bmobThumb];
    }
    
    return array;
}

@end