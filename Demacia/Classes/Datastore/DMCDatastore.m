//
//  DMCDatastore.m
//  Demacia
//
//  Created by Hongyong Jiang on 04/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCDatastore.h"

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
    //signup Easemob
    
    
    //signup Bmob
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUserName:username];
    [bUser setPassword:password];

    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        
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
                    
                    [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
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





@end
