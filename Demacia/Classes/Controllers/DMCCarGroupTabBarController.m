//
//  DMCCarGroupTabBarController.m
//  Demacia
//
//  Created by Hongyong Jiang on 22/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCCarGroupTabBarController.h"
#import "DMCFirstViewController.h"

@interface DMCCarGroupTabBarController ()
{
    UIView* _titleView;
}
@end

@implementation DMCCarGroupTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,0, 400, 20);
    label.text = @"车队";
    label.textAlignment = NSTextAlignmentCenter;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIPageControl* pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake(0, 20, 400, 10);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 1;
    pageControl.defersCurrentPageDisplay = YES;
    [pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    
    UIView* titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0,0,400,30);
    [titleView addSubview:label];
    [titleView addSubview:pageControl];
    _titleView = titleView;
    
    self.navigationItem.titleView = titleView;
    
    UISwipeGestureRecognizer *gestureRight;
    UISwipeGestureRecognizer *gestureLeft;
    gestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    gestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [gestureLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    UIViewController* vc = (UIViewController*)[self.viewControllers objectAtIndex:0];
    [[vc view] addGestureRecognizer:gestureRight];
    [[vc view] addGestureRecognizer:gestureLeft];
    
    int i = 0;
    for(id item in self.tabBar.items)
    {
        ((UITabBarItem*)item).tag = i++;
    }
    
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


#pragma mark - swipe right, left

- (void)swipeLeft:(UISwipeGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded))
    {
        //do something for a right swipe gesture.
        
        UINavigationController* nav = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        DMCFirstViewController* vc = (DMCFirstViewController*)[nav.viewControllers objectAtIndex:0];
        ;
        [nav pushViewController:vc.modelGroupTabBarController animated:YES];
        
    }
}


- (void)swipeRight:(UISwipeGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        
        //do something for a right swipe gesture.
        UINavigationController* nav = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [nav popViewControllerAnimated:YES];        
    }
}


- (void)pageAction:(id)sender
{
    UIPageControl* pageControl = sender;
    
    if(pageControl.currentPage > 1)
    {
        pageControl.currentPage = 1;
        
        UINavigationController* nav = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        DMCFirstViewController* vc = (DMCFirstViewController*)[nav.viewControllers objectAtIndex:0];
        [nav pushViewController:vc.modelGroupTabBarController animated:YES];
    }
    else if(pageControl.currentPage < 1)
    {
        pageControl.currentPage = 1;
        
        UINavigationController* nav = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [nav popViewControllerAnimated:YES];
    }
}


#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0)
    {
        self.title = @"会话";
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.titleView = _titleView;
    }
    else
    {
        self.navigationItem.titleView = nil;
    }
    
    if (item.tag == 1)
    {
        self.title = @"车队";
    }
    else if(item.tag == 2)
    {
        self.title = @"顺风";
        self.navigationItem.rightBarButtonItem = nil;
    }
    else if(item.tag == 3)
    {
        self.title = @"服务";
        self.navigationItem.rightBarButtonItem = nil;
    }
}


@end
