//
//  DMCFirstViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 22/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCFirstViewController.h"
#import "DMCBuddyTabBarController.h"
#import "LoginViewController.h"
#import "ApplyViewController.h"
#import "DMCLoginViewController.h"

@interface DMCFirstViewController ()

@end

@implementation DMCFirstViewController
@synthesize buddyTabBarController;
@synthesize carGroupTabBarController;
@synthesize modelGroupTabBarController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    [self loginStateChange:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - private

-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = self.navigationController;
    
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess)
    {
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        if (buddyTabBarController == nil)
        {
//            buddyTabBarController = [[DMCBuddyTabBarController alloc] init];
            buddyTabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DMCBuddyTabBarController"];
            [nav pushViewController:buddyTabBarController animated:NO];
        }
        
        if(carGroupTabBarController == nil)
        {
            carGroupTabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DMCCarGroupTabBarController"];
        }

        if(modelGroupTabBarController == nil)
        {
            modelGroupTabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DMCModelGroupTabBarController"];
        }
        
    }
    else
    {
        buddyTabBarController = nil;
        carGroupTabBarController = nil;
//        LoginViewController *loginController = [[LoginViewController alloc] init];
//        [nav pushViewController:loginController animated:NO];
//        loginController.title = @"CarChat";
        DMCLoginViewController *loginController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DMCLoginViewController"];
        [nav pushViewController:loginController animated:NO];
        loginController.title = @"CarChat";
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0)
    {
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    
    [nav setNavigationBarHidden:YES];
    [nav setNavigationBarHidden:NO];
}


@end
