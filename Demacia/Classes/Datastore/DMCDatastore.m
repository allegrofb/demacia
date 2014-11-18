//
//  DMCDatastore.m
//  Demacia
//
//  Created by Hongyong Jiang on 04/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCDatastore.h"
#import "Utility.h"

@implementation DMCDatastore


+ (DMCDatastore *)sharedInstance
{
    static DMCDatastore *_sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DMCDatastore alloc] init];
    });
    
    return _sharedObject;
}

#pragma mark - private methods



#pragma mark - api functions

- (void)signUp:(NSString*)username password:(NSString*)password block:(DMCRemoteLoginResultBlock)block
{
    //signup Bmob
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUserName:username];
    [bUser setPassword:password];

    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"signUp failed");
        }
        
        if(isSuccessful)
        {
            BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCUserInfo"];
            [bquery whereKey:@"userPointer" equalTo:bUser];
            
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                for(BmobObject *obj in array){
                    NSLog(@"objectId==============>%@",obj.objectId);
                }
                
                if(array.count <= 0)
                {
                    BmobObject* userInfo = [BmobObject objectWithClassName:@"DMCUserInfo"];
                    [userInfo setObject:bUser forKey:@"userPointer"];
                    [userInfo setObject:username forKey:@"userName"];
                    
                    [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if(isSuccessful)
                        {
                            block(userInfo,isSuccessful,error);
                        }
                        else
                        {
                            block(nil,YES,error);
                        }
                    }];

                }
                else
                {
                    block(array[0],isSuccessful,error);
                }
                
            }];
        }
        else
        {
            block(nil,isSuccessful,error);
        }
        
    }];

}

- (void)resetPassword:(NSString*)username block:(DMCRemoteBoolResultBlock)block
{
    BOOL isSuccessful = false;
    
    block(isSuccessful,nil);
    
}

- (void)signIn:(NSString*)username password:(NSString*)password block:(DMCRemoteLoginResultBlock)block
{
    BOOL isSuccessful = false;
    
    [BmobUser logInWithUsernameInBackground:username password:password block:^(BmobUser *user, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"signIn failed");
        }
        
        if(user)
        {
            BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCUserInfo"];
            [bquery whereKey:@"userPointer" equalTo:user];
            
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                for(BmobObject *obj in array){
                    NSLog(@"objectId==============>%@",obj.objectId);
                }
                
                if(array.count <= 0)
                {
                    BmobObject* userInfo = [BmobObject objectWithClassName:@"DMCUserInfo"];
                    [userInfo setObject:user forKey:@"userPointer"];
                    [userInfo setObject:username forKey:@"userName"];
                    
                    [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if(!isSuccessful)
                        {
                            DLog(@"signIn failed");
                        }
                        if(isSuccessful)
                        {
 
                            block(userInfo,isSuccessful,error);
                        }
                        else
                        {
                            block(nil,isSuccessful,error);
                        }
                    }];
                    
                }
                else
                {
                    block(array[0],YES,error);
                }
                
            }];
        }
        else
        {
            block(nil,isSuccessful,error);
        }
        
    }];
}

- (void)signOut:(DMCRemoteBoolResultBlock)block
{
    BOOL isSuccessful = false;

    block(isSuccessful,nil);
    
}

- (void)getUserInfo:(NSString*)userName block:(DMCRemoteDictResultBlock)block
{
    BOOL isSuccessful = false;
    NSDictionary* result = [[NSDictionary alloc] init];
    
    block(result, isSuccessful,nil);
    
}

- (void)getFriendsList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block
{
    BOOL isSuccessful = false;

    

}

- (void)getFunsList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block
{
    BOOL isSuccessful = false;
    

    
}

- (void)getFollowingsList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block
{
    BOOL isSuccessful = false;
    

    
}

- (void)getUserDetail:(NSString*)userInfoId block:(DMCRemoteDictResultBlock)block
{
    BOOL isSuccessful = false;
    NSDictionary* result = [[NSDictionary alloc] init];
    
    block(result, isSuccessful,nil);
    
}

- (void)addPost:(BmobObject*)userInfo content:(NSString*)content album:(BmobObject*)album block:(DMCRemoteBoolResultBlock)block
{
    BmobObject  *bObject = [BmobObject objectWithClassName:@"DMCPost"];
    [bObject setObject:content forKey:@"content"];
    [bObject setObject:userInfo forKey:@"userInfoPointer"];
    
    if(album)
    {
        BmobRelation *relation = [[BmobRelation alloc] init];
        [relation addObject:album];
        [bObject addRelation:relation forKey:@"albumsRelation"];
    }
    
    [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"addPost failed");
        }
        
        block(isSuccessful,error);
        
    }];
    
}

- (void)addPhoto:(NSString*)userInfoId content:(NSString*)content picture:(BmobFile*)picture thumbWidth:(NSInteger)thumbWidth block:(DMCRemoteObjectResultBlock)block
{
    
    [BmobImage thumbnailImageBySpecifiesTheWidth:thumbWidth quality:100 sourceImageUrl:picture.url outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {

        if(object)
        {
            BmobObject  *bObject = [BmobObject objectWithClassName:@"DMCPhoto"];
            [bObject setObject:content forKey:@"content"];
            [bObject setObject:[BmobObject objectWithoutDatatWithClassName:@"DMCUserInfo" objectId:userInfoId] forKey:@"userInfoPointer"];

            [bObject setObject:picture forKey:@"picture"];
            [bObject setObject:object forKey:@"thumb"];
            
            [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                block(bObject, isSuccessful,error);
                
            }];
        }
        else
        {
            block(nil,FALSE,error);
        }
    
    }];
    
}

- (void)uploadFile:(NSString*)filePath key:(NSURL*)key resultBlock:(DMCRemoteUploadResultBlock)resultBlock progressBlock:(DMCRemoteWithProgressBlock)progressBlock
{
    __block NSURL* tmp = key;
    
    BmobFile *file = [[BmobFile alloc] initWithClassName:@"DMCFiles" withFilePath:filePath];
    
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"uploadFile failed, %ld",(long)error.code);
        }
        
        resultBlock(tmp, file, isSuccessful,error);
        
    } withProgressBlock:^(float progress) {
        
        progressBlock(progress);
        
    }];
}

- (void)getBmobUserName:(NSString*)easeMobId block:(DMCRemoteStringResultBlock)block
{
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCUserInfo"];
    [bquery whereKey:@"objectId" equalTo:easeMobId];
    [bquery selectKeys:@[@"userName"]];

    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for(NSString *obj in array){
            NSLog(@"userName==============>%@",obj);
        }
        
        if(array.count <= 0)
        {
            block(nil,NO,error);
        }
        else
        {
            block(array[0],YES,error);
        }
    }];

}

- (void)addAlbum:(BmobObject*)userInfo content:(NSString*)content block:(DMCRemoteObjectResultBlock)block
{
    BmobObject  *bObject = [BmobObject objectWithClassName:@"DMCAlbum"];
    [bObject setObject:content forKey:@"content"];
    [bObject setObject:userInfo forKey:@"userInfoPointer"];
    
    [bObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        block(bObject, isSuccessful,error);
        
    }];
    
}

- (void)addPhotoToAlbum:(BmobObject*)album photo:(BmobObject*)photo block:(DMCRemoteBoolResultBlock)block
{
    BmobRelation *relation = [[BmobRelation alloc] init];
    [relation addObject:photo];
    [album addRelation:relation forKey:@"photosRelation"];
    
    [album updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        block(isSuccessful,error);
        
    }];
}

@end
