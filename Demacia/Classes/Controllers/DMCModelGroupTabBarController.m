//
//  DMCModelGroupTabBarController.m
//  Demacia
//
//  Created by Hongyong Jiang on 28/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCModelGroupTabBarController.h"

@interface DMCModelGroupTabBarController ()

@end

@implementation DMCModelGroupTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.hidesBackButton = YES;
    
    
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,0, 400, 20);
    label.text = @"车模";
    label.textAlignment = NSTextAlignmentCenter;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIPageControl* pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake(0, 20, 400, 10);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 2;
    
    UIView* titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0,0,400,30);
    [titleView addSubview:label];
    [titleView addSubview:pageControl];
    
    self.navigationItem.titleView = titleView;
    
    
    
    UISwipeGestureRecognizer *gestureRight;
    UISwipeGestureRecognizer *gestureLeft;
    gestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];//direction is set by default.
    gestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];//need to set direction.
    [gestureLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    UIViewController* vc = (UIViewController*)[self.viewControllers objectAtIndex:0];
    
    [[vc view] addGestureRecognizer:gestureRight];//this gets things rolling.
    [[vc view] addGestureRecognizer:gestureLeft];//this gets things rolling.
    
    
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


@end
