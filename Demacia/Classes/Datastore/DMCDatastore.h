//
//  DMCDatastore.h
//  Demacia
//
//  Created by Hongyong Jiang on 04/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

typedef void (^DMCRemoteLoginResultBlock) (BmobObject* userInfo, BOOL isSuccessful, NSError *error);
typedef void (^DMCRemoteBoolResultBlock) (BOOL isSuccessful, NSError *error);
typedef void (^DMCRemoteDictResultBlock) (NSDictionary* result, BOOL isSuccessful, NSError *error);
typedef void (^DMCRemoteListResultBlock) (NSArray* result, BmobQuery* query, BOOL isSuccessful, NSError *error);


@interface DMCDatastore : NSObject

- (void)signUp:(NSString*)username password:(NSString*)password block:(DMCRemoteLoginResultBlock)block;
- (void)resetPassword:(NSString*)username block:(DMCRemoteBoolResultBlock)block;
- (void)signIn:(NSString*)username password:(NSString*)password block:(DMCRemoteLoginResultBlock)block;
- (void)signOut:(DMCRemoteBoolResultBlock)block;

- (void)getUserInfo:(NSString*)userName block:(DMCRemoteDictResultBlock)block;
- (void)setUserInfo:(NSString*)userName info:(NSDictionary*)info block:(DMCRemoteBoolResultBlock)block;

- (void)getUserDetail:(NSString*)userInfoId block:(DMCRemoteDictResultBlock)block;
- (void)setUserDetail:(NSString*)userInfoId info:(NSDictionary*)info block:(DMCRemoteBoolResultBlock)block;

- (void)getFriendsList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getFunsList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getFollowingsList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getNearbyUserList:(NSString*)userInfoId longitude:(double)longitude latitude:(double)latitude block:(DMCRemoteListResultBlock)block;

- (void)getMyPostList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getFriendsPostList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getFunsPostList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getFollowingsPostList:(NSString*)userInfoId block:(DMCRemoteListResultBlock)block;
- (void)getPostDetail:(NSString*)postId block:(DMCRemoteDictResultBlock)block;
- (void)addPost:(NSString*)userInfoId info:(NSDictionary*)info block:(DMCRemoteBoolResultBlock)block;
- (void)modifyPost:(NSString*)postId info:(NSDictionary*)info block:(DMCRemoteBoolResultBlock)block;

- (void)getNextList:(BmobQuery*)query block:(DMCRemoteListResultBlock)block;




+ (DMCDatastore *)sharedInstance;

@end
