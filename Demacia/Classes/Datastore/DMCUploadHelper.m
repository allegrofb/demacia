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
#import "DMCUserHelper.h"
#import "Utility.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface BmobTmpFile : NSObject

@property (nonatomic, strong) NSString* fileName;
@property (nonatomic) BOOL finishedFlag;
@property (nonatomic) BOOL uploadingFlag;
@property (nonatomic, strong) BmobFile* bmobFile;
@property (nonatomic, strong) BmobObject* photoObject;
@property (nonatomic) BOOL isSuccessful;
@property (nonatomic, strong) NSError* error;

@end

@implementation BmobTmpFile
@synthesize fileName, finishedFlag, uploadingFlag, bmobFile, isSuccessful, error, photoObject;

- (id)init
{
    self = [super init];
    
    self.finishedFlag = false;
    self.uploadingFlag = false;
    
    return self;
}

@end

@interface DMCUploadHelper ()

@property (nonatomic, strong) NSCondition* uploadCondition;
@property (nonatomic, strong) NSMutableArray* currentArray;
@property (nonatomic, strong) NSMutableDictionary* uploadQueue;
@property (nonatomic) NSUInteger imageTmpNumber;
@property (nonatomic) BOOL albumErrorFlag;
@property (nonatomic, strong) BmobObject* currentAlbum;

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
    
    [[DMCDatastore sharedInstance] addAlbum:[DMCUserHelper sharedInstance].userInfo content:@"" block:^(BmobObject *object, BOOL isSuccessful, NSError *error) {

        _albumErrorFlag = isSuccessful;
        
        if(isSuccessful)
        {
            _currentAlbum = object;
            
            [_currentArray removeAllObjects];
            
            int i = 0;
            
            for(i = 0;i<images.count;i++)
            {
                NSURL* url = urls[i];
                UIImage* image = images[i];
                
                BmobTmpFile* obj = [_uploadQueue objectForKey:url];
                if(obj == nil)
                {
                    NSString* name = [NSString stringWithFormat:@"%lu",(unsigned long)_imageTmpNumber];
                    _imageTmpNumber++;
                    
                    NSData* data = UIImageJPEGRepresentation(image,1.0);
                    name = [[TmpFilesMgr sharedInstance] saveFile:name data:data];
                    
                    BmobTmpFile* file = [[BmobTmpFile alloc] init];
                    file.fileName = name;
                    
                    [_uploadQueue setObject:file forKey:url];
                }
                
                [_currentArray addObject:url];
                
            }
            
            [self startUpload];
            
        }
        else
        {
            DLog(@"addAlbum failed");
        }
        
    }];

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
                
                if(!isSuccessful)
                {
                    DLog(@"uploadFile failed, %ld",(long)error.code);
                }
                
                BmobTmpFile* result = [_uploadQueue objectForKey:key];
                result.bmobFile = bmobFile;
                
                if(isSuccessful)
                {
                    NSString* userInfo = [DMCUserHelper sharedInstance].userInfo.objectId;
                
                    [[DMCDatastore sharedInstance] addPhoto:userInfo content:@"" picture:result.bmobFile thumbWidth:100 block:^(BmobObject* object, BOOL isSuccessful, NSError *error) {
                    
                            if(!isSuccessful)
                            {
                                DLog(@"addPhoto failed, %ld",(long)error.code);
                            }
                            result.photoObject = object;
                        
                            [[DMCDatastore sharedInstance] addPhotoToAlbum:_currentAlbum photo:object block:^(BOOL isSuccessful, NSError *error) {
                        
                                if(!isSuccessful)
                                {
                                    DLog(@"addPhotoToAlbum failed,%ld ",(long)error.code);
                                }
                                else
                                {
                                    [self setFinishedFlag:result isSuccessful:isSuccessful error:error];
                                    
                                }
                                
                            }];
                        
                    }];
                }
                else
                {
                    [self setFinishedFlag:result isSuccessful:isSuccessful error:error];
                    
                }
                
            
            } progressBlock:^(float progress) {
            
            
            
            }];
        }
    }
}

- (void)setFinishedFlag:(BmobTmpFile*)result isSuccessful:(BOOL) isSuccessful error:(NSError*)error
{
    [_uploadCondition lock];
    
    result.uploadingFlag = false;
    result.finishedFlag = true;
    result.error = error;
    result.isSuccessful = isSuccessful;
    
    bool all = true;
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        all = all && file.finishedFlag;
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

- (NSArray*)getUploadPhotos
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        [array addObject:file.photoObject];
    }
    
    return array;
}

- (BmobObject*)getUploadAlbum
{
    return _currentAlbum;
}

- (NSString*)getUploadError
{
    if(!_albumErrorFlag)
    {
        return @"album failed";
    }
    
    for(NSURL* url in _currentArray)
    {
        BmobTmpFile* file = [_uploadQueue objectForKey:url];
        if(!file.isSuccessful)
        {
            return @"photo failed";
        }
    }
    
    return nil;
}



@end