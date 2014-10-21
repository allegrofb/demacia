//
//  CheckBox.m
//  Checkbox
//
//  Created by Jeruel Fernandes on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckBox.h"

@interface CheckBox()
- (void)defaultInit;
- (void)handleTap;
@end

@implementation CheckBox

@synthesize nID;
@synthesize btn_CheckBox;
@synthesize lbl_CheckBox;
@synthesize delegate;

#define kImageHeight    30
#define kImageWidth     30

- (void)defaultInit
{    
    btn_CheckBox            = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_CheckBox.frame      = CGRectMake(0, 0, kImageWidth, kImageHeight);
    btn_CheckBox.adjustsImageWhenHighlighted = NO;
    [btn_CheckBox setImage:[UIImage imageNamed:@"CheckBox_Deselected.png"] forState:UIControlStateNormal];
    [btn_CheckBox setImage:[UIImage imageNamed:@"CheckBox_Selected.png"] forState:UIControlStateSelected];
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)]; 
    tapped.numberOfTapsRequired = 1; 
    [btn_CheckBox addGestureRecognizer:tapped];
    
    //[btn_CheckBox addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_CheckBox];
    
    lbl_CheckBox            = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.bounds.size.width-35, 30)];
    lbl_CheckBox.backgroundColor    = [UIColor clearColor];
    lbl_CheckBox.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)]; 
    tapped2.numberOfTapsRequired = 1; 
    [lbl_CheckBox addGestureRecognizer:tapped2];
    [self addSubview:lbl_CheckBox];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self defaultInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndID:(NSUInteger)index AndSelected:(BOOL)state AndTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
        [self setID:index AndSelected:state AndTitle:title];
    }
    return self;
}

- (void)setID:(NSUInteger)index AndSelected:(BOOL)state AndTitle:(NSString *)title
{
    nID = index;
    [btn_CheckBox setSelected:state];
    lbl_CheckBox.text = title;
}

- (void)handleTap
{
    if(btn_CheckBox.selected)
    {
        [btn_CheckBox setSelected:NO];
    }
    else
    {
        [btn_CheckBox setSelected:YES];
    }
    
    [delegate stateChangedForID:nID WithCurrentState:btn_CheckBox.selected];
}

- (BOOL)currentState
{
    return btn_CheckBox.selected;
}

@end
