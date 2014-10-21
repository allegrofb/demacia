//
//  SpinnerView.m
//  SgChinese
//
//  Created by Hongyong Jiang on 15/04/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SpinnerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SpinnerView

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 0, frame.size.width/3.0, frame.size.width/3.0);
    
    self = [super initWithFrame:rect];
    if (self) 
    {
        // Initialization code        
        self.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);        
        self.alpha = 0.8;
        self.backgroundColor = [UIColor grayColor];       
        self.layer.cornerRadius = self.frame.size.height/5.0;        
        
        UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];                
        indicatorView.hidesWhenStopped = YES;
        [indicatorView startAnimating];
        indicatorView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);        
        
        [self addSubview:indicatorView];                            
    }
    return self;
}

@end
