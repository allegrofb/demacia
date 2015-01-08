//
//  DMCDatastore.m
//  Demacia
//
//  Created by Hongyong Jiang on 04/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCDatastore.h"
#import "Utility.h"
#import "TmpFilesMgr.h"

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
                    DLog(@"objectId==============>%@",obj.objectId);
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
        
        if(user)
        {
            BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCUserInfo"];
            [bquery whereKey:@"userPointer" equalTo:user];
            
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if(array.count <= 0)
                {
                    BmobObject* userInfo = [BmobObject objectWithClassName:@"DMCUserInfo"];
                    [userInfo setObject:user forKey:@"userPointer"];
                    [userInfo setObject:username forKey:@"userName"];
                    
                    [userInfo saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if(!isSuccessful)
                        {
                            DLog(@"signIn failed, %ld",(long)error.code);

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
            DLog(@"user nil, %ld",(long)error.code);
            block(nil,isSuccessful,error);
        }
        
    }];
}

- (void)signOut:(DMCRemoteBoolResultBlock)block
{
    BOOL isSuccessful = false;

    block(isSuccessful,nil);
    
}

- (void)setUserInfo:(BmobObject*)userInfo info:(NSDictionary*)info block:(DMCRemoteBoolResultBlock)block
{

    BmobObject* detail = [userInfo objectForKey:@"UserPointer"];
    
    
//    [userInfo setObject:userInfo forKey:@"userInfoPointer"];
    
    [userInfo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"addPost failed");
        }
        
        block(isSuccessful,error);
        
    }];
    
    
    
    
}

- (void)getUserInfo:(BmobObject*)userInfo json:(JSONUserInfo*)json
{
    json.userName = [userInfo objectForKey:@"userName"];
    json.usernameEasemob = userInfo.objectId;
    json.passwordEasemob = userInfo.objectId;
    json.shortDescription = [userInfo objectForKey:@"shortDescription"];
    
    return;
}

- (void)getUserDetail:(BmobObject*)userInfo block:(DMCRemoteIdResultBlock)block
{
    JSONUserDetail* json = [[JSONUserDetail alloc]init];

    BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCUserDetail"];
    [bquery whereKey:@"userInfoPointer" equalTo:userInfo];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(array.count <= 0)
        {
            block(nil,json,NO,error);
        }
        else
        {
            BmobObject* obj = array[0];
            
            NSNumber* n = nil;
            n = [obj objectForKey:@"birthday_d"];
            json.birthday_d = [n intValue];
            n = [obj objectForKey:@"birthday_m"];
            json.birthday_m = [n intValue];
            n = [obj objectForKey:@"birthday_y"];
            json.birthday_y = [n intValue];
            json.maleOrFemale = [obj objectForKey:@"maleOrFemale"];
            
            block(obj,json,YES,error);
        }
    }];
    
    return;
}

- (void)setUserInfo:(BmobObject*)userInfo json:(JSONUserInfo*)json block:(DMCRemoteBoolResultBlock)block
{
    [userInfo setObject:json.nickname forKey:@"nickname"];
    [userInfo setObject:json.shortDescription forKey:@"shortDescription"];
    
    [userInfo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"setUserInfo failed");
        }
        
        block(isSuccessful,error);
        
    }];
    
}

- (void)addUserDetail:(BmobObject*)userInfo json:(JSONUserDetail*)json block:(DMCRemoteBoolResultBlock)block
{
    BmobObject* detail = [BmobObject objectWithClassName:@"DMCUserDetail"];
    
    [detail setObject:userInfo forKey:@"userInfoPointer"];
    
    ;
    
    [detail setObject:[[NSNumber alloc] initWithUnsignedInteger:json.birthday_y] forKey:@"birthday_y"];
    [detail setObject:[[NSNumber alloc] initWithUnsignedInteger:json.birthday_m] forKey:@"birthday_m"];
    [detail setObject:[[NSNumber alloc] initWithUnsignedInteger:json.birthday_d] forKey:@"birthday_d"];
    [detail setObject:[NSNumber numberWithBool:json.maleOrFemale] forKey:@"maleOrFemale"];
    
    [detail saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if(!isSuccessful)
        {
            DLog(@"addUserDetail failed");
        }
        
        block(isSuccessful,error);
        
    }];
    
    return;
}

- (void)setUserDetail:(BmobObject*)userInfo userDetail:(BmobObject*)userDetail json:(JSONUserDetail*)json block:(DMCRemoteBoolResultBlock)block
{
    if(userDetail)
    {
        [userDetail setObject:[[NSNumber alloc] initWithUnsignedInteger:json.birthday_y] forKey:@"birthday_y"];
        [userDetail setObject:[[NSNumber alloc] initWithUnsignedInteger:json.birthday_m] forKey:@"birthday_m"];
        [userDetail setObject:[[NSNumber alloc] initWithUnsignedInteger:json.birthday_d] forKey:@"birthday_d"];
        [userDetail setObject:[NSNumber numberWithBool:json.maleOrFemale] forKey:@"maleOrFemale"];
        
        [userDetail updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if(isSuccessful)
            {
                DLog(@"setUserDetail failed");
            }

            block(isSuccessful,error);
            
        }];
    
    }
    else
    {
        [self addUserDetail:userInfo json:json block:block];
    }
    
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

- (void)updatePhoto:(BmobObject*)photo picture:(BmobFile*)picture thumbWidth:(NSInteger)thumbWidth block:(DMCRemoteBoolResultBlock)block
{
    
    [BmobImage thumbnailImageBySpecifiesTheWidth:thumbWidth quality:100 sourceImageUrl:picture.url outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {
        
        if(object)
        {
            [photo setObject:picture forKey:@"picture"];
            [photo setObject:object forKey:@"thumb"];
            
            [photo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                block(isSuccessful,error);
                
            }];
        }
        else
        {
            block(FALSE,error);
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

- (void)getNearbyUserList:(BmobObject*)geoInfo longitude:(double)longitude latitude:(double)latitude limit:(NSInteger)limit block:(DMCRemoteListResultBlock)block
{
    if(longitude > 180.0)
    {
        longitude = 179.99;
    }
    else if(longitude < -180.0)
    {
        longitude = -179.99;
    }
    
    if(latitude > 90.0)
    {
        longitude = 89.99;
    }
    else if(longitude < -90.0)
    {
        longitude = -89.99;
    }
    
    BmobGeoPoint  *point = [[BmobGeoPoint alloc] initWithLongitude:longitude WithLatitude:latitude];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCUserLocation"];
    [bquery whereKey:@"geo" nearGeoPoint:point];
    [bquery setLimit:limit];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {

        block(array, bquery, YES, error);
        
    }];
}

- (void)getNextList:(BmobQuery*)query skip:(NSInteger)skip block:(DMCRemoteListResultBlock)block
{
    [query setSkip:skip];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        block(array, query, YES, error);
        
    }];
}

- (void)updateGeo:(BmobObject*)geoInfo longitude:(double)longitude latitude:(double)latitude block:(DMCRemoteBoolResultBlock)block
{
    if(longitude > 180.0)
    {
        longitude = 179.99;
    }
    else if(longitude < -180.0)
    {
        longitude = -179.99;
    }
    
    if(latitude > 90.0)
    {
        longitude = 89.99;
    }
    else if(longitude < -90.0)
    {
        longitude = -89.99;
    }
    
    BmobGeoPoint* geo = [[BmobGeoPoint alloc] initWithLongitude:longitude WithLatitude:latitude];
    [geoInfo setObject:geo forKey:@"geo"];
    [geoInfo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        block(isSuccessful,error);
        
    }];
}

- (void)setUserPortrait:(BmobObject*)userInfo portrait:(BmobObject*)portrait image:(UIImage*)image thumbWidth:(NSInteger)thumbWidth block:(DMCRemoteObjectResultBlock)block progressBlock:(DMCRemoteWithProgressBlock)progressBlock
{
    
    if(!portrait)
    {
        return [self addUserPortrait:userInfo image:image thumbWidth:thumbWidth block:block progressBlock:progressBlock];
    }
    
    NSString* name = @"portrait";
    NSData* data = UIImageJPEGRepresentation(image,1.0);
    name = [[TmpFilesMgr sharedInstance] saveFile:name data:data];
    
    [self uploadFile:name key:nil resultBlock:^(NSURL *key, BmobFile *bmobFile, BOOL isSuccessful, NSError *error) {
        
        [self updatePhoto:portrait picture:bmobFile thumbWidth:thumbWidth block:^(BOOL isSuccessful, NSError *error) {


        }];
        
    } progressBlock:progressBlock];
}

- (void)addUserPortrait:(BmobObject*)userInfo image:(UIImage*)image thumbWidth:(NSInteger)thumbWidth block:(DMCRemoteObjectResultBlock)block progressBlock:(DMCRemoteWithProgressBlock)progressBlock
{
    NSString* name = @"portrait";
    NSData* data = UIImageJPEGRepresentation(image,1.0);
    name = [[TmpFilesMgr sharedInstance] saveFile:name data:data];
    
    [self uploadFile:name key:nil resultBlock:^(NSURL *key, BmobFile *bmobFile, BOOL isSuccessful, NSError *error) {
        
        NSString* userInfoId = userInfo.objectId;
        
        [self addPhoto:userInfoId content:@"" picture:bmobFile thumbWidth:thumbWidth block:^(BmobObject *object, BOOL isSuccessful, NSError *error) {
            
            BmobRelation *relation = [[BmobRelation alloc] init];
            [relation addObject:object];
            [userInfo addRelation:relation forKey:@"portraitRelation"];

            [userInfo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {

                block(object, isSuccessful, error);
            }];
            
        }];
        
        
    } progressBlock:progressBlock];
    
}

- (void)getUserPortrait:(BmobObject*)userInfo block:(DMCRemoteIdResultBlock)block
{
    JSONPhoto* json = [[JSONPhoto alloc]init];
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"DMCPhoto"];
    [bquery whereObjectKey:@"portraitRelation" relatedTo:userInfo];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if(array.count <= 0)
        {
            block(nil,json,NO,error);
        }
        else
        {
            BmobObject* obj = array[0];
            
            json.picture = [obj objectForKey:@"picture"];
            json.thumb = [obj objectForKey:@"thumb"];
            json.content = [obj objectForKey:@"content"];
            
            block(obj,json,YES,error);
        }
    }];
    
    return;
}

@end



