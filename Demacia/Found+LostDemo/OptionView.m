//
//  OptionView.m
//  Found+Lost
//
//  Created by Bmob on 14-5-21.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "OptionView.h"

@implementation OptionView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithOptionArray:(NSArray*)array{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:60.0f/255 green:60.0f/255 blue:60.0f/255 alpha:0.5f];
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [array count]*50)];
        backgroundImageView.image        = [[UIImage imageNamed:@"pull_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        [self addSubview:backgroundImageView];
        
        for (int i = 0; i < [array count];i ++) {
            UIButton *btn              = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame                  = CGRectMake(0, 50*i, 320, 50);
            btn.tag                    = 100+i;
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [[btn titleLabel] setFont:[UIFont boldSystemFontOfSize:18]];
            [btn addTarget:self action:@selector(chose:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:btn];

            UIImageView *lineImageView = [[UIImageView alloc] init];
            lineImageView.frame        = CGRectMake(0, 50*i+49, 320, 1);
            lineImageView.image        = [UIImage imageNamed:@"line"];
            [self addSubview:lineImageView];
        }
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    [self removeView];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    
}


-(void)chose:(UIButton*)sender{
    

    if (self.delegate && [self.delegate respondsToSelector:@selector(optionDidDismiss: optionView:)]) {
        [self.delegate  optionDidDismiss:(sender.tag-100) optionView:self];
        [self removeView];
    }
}



-(void)removeView{

//    [UIView animateWithDuration:0.7f animations:^{
//        self.frame = CGRectMake(0, 0, 320, 0);
//    }];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.0f];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
