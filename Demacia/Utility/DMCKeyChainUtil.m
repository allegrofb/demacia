//
//  DMCKeyChainUtil.m
//  Demacia
//
//  Created by Hongyong Jiang on 28/08/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Security/Security.h>
#import "DMCKeyChainUtil.h"
#import "KeychainItemWrapper.h"

static NSString * const kKeyChainItemIdentifierString = @"Password";

enum {
	kUsernameSection = 0,
	kPasswordSection,
	kAccountNumberSection,
};


@interface DMCKeyChainUtil()
{
@private
    __strong KeychainItemWrapper* _keyChainItem;
}

@end


@implementation DMCKeyChainUtil
@synthesize loginFlag;

+ (DMCKeyChainUtil *)sharedObject
{
    static DMCKeyChainUtil *_sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DMCKeyChainUtil alloc] init];
    });
    
    return _sharedObject;
}

- (id)secAttrForSection:(NSInteger)section
{
    switch (section)
    {
        case kUsernameSection: return (__bridge id)kSecAttrAccount;
        case kPasswordSection: return (__bridge id)kSecValueData;
        case kAccountNumberSection: return (__bridge id)kSecValueData;
    }
    return nil;
}

- (id)init
{
    _keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainItemIdentifierString accessGroup:nil];

    loginFlag = false;
    
    return self;
}

- (void)dummy
{
    return;
}

- (id)getPassword
{
    return [_keyChainItem objectForKey:[self secAttrForSection: kPasswordSection]];
}

- (id)getUserName
{
    return [_keyChainItem objectForKey:[self secAttrForSection:kUsernameSection]];
}

- (void)setPassword:(NSString*)password
{
   // NSString* tmp = [password stringByReplacingOccurrencesOfString:@" " withString:@""];        
    
   // if([tmp isEqualToString:@""] == NO)
    {        
        [_keyChainItem setObject:password forKey:[self secAttrForSection:kPasswordSection]];
        loginFlag = true;
    }
}

- (void)setUserName:(NSString*)userName
{
  //  NSString* tmp = [userName stringByReplacingOccurrencesOfString:@" " withString:@""];        
    
  //  if([tmp isEqualToString:@""] == NO)
    {
        [_keyChainItem setObject:userName forKey:[self secAttrForSection:kUsernameSection]];    
    }
}

- (void)reset
{
    loginFlag = false;
    [_keyChainItem resetKeychainItem];
}


@end
