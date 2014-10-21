//
//  AppDelegate.h
//  Demacia
//
//  Created by Hongyong Jiang on 21/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, IChatManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;

@end

