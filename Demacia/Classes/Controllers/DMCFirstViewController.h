//
//  DMCFirstViewController.h
//  Demacia
//
//  Created by Hongyong Jiang on 22/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCBuddyTabBarController.h"
#import "DMCCarGroupTabBarController.h"
#import "DMCModelGroupTabBarController.h"

@interface DMCFirstViewController : UIViewController

@property (strong, nonatomic) DMCBuddyTabBarController *buddyTabBarController;
@property (strong, nonatomic) DMCCarGroupTabBarController *carGroupTabBarController;
@property (strong, nonatomic) DMCModelGroupTabBarController *modelGroupTabBarController;

@end
