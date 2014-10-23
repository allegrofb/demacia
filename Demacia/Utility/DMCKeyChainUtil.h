//
//  DMCKeyChainUtil.h
//  Demacia
//
//  Created by Hongyong Jiang on 28/08/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCKeyChainUtil : NSObject

@property (nonatomic) BOOL loginFlag;

- (void)dummy;
- (id)getPassword;
- (id)getUserName;
- (void)setPassword:(NSString*)password;
- (void)setUserName:(NSString*)userName;
- (void)reset;

+ (DMCKeyChainUtil *)sharedObject;

@end
