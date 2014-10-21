//
//  DMCAssets.m
//  Demacia
//
//  Created by Hongyong Jiang on 29/03/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DMCAssets.h"

@implementation DMCAsserts
@synthesize colorPrimary,colorPrimaryDark,colorPrimaryLight,colorPrimaryLessLight,
            colorPrimaryMoreDark,colorSecondary,colorSecondaryDark,
            colorSecondaryLight,colorSecondaryMoreDark,colorSecondaryLessLight,
			colorTertiary,colorTertiaryDark,colorTertiaryLight,colorTertiaryLessLight,
            colorTertiaryMoreDark;
@synthesize colorTextureBg,colorNavigationBar,colorLinkedText,
            colorOptionPanel,colorPanel,
            colorButtonBg,colorButtonTitle,            
            colorButtonBg2,colorButtonTitle2;
@synthesize imageButtonBg,imageButtonBg2;
@synthesize colorTextureHatched;
@synthesize imageButtonAlbum, imageButtonPhoto;
@synthesize imageBarButtonItemBrightness,
            imageBarButtonItemContrast, imageBarButtonItemSave,
            imageBarButtonItemEmail, imageBarButtonItemDelete,
            imageBarButtonItemPrint, imageBarButtonItemTrash,
            imageBarButtonItemFavorities;
@synthesize colorNavigationBar1, colorNavigationBar2, colorNavigationBar3;
@synthesize imageLogo;

+ (DMCAsserts *)sharedInstance
{
    static DMCAsserts *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DMCAsserts alloc] init];
    });
    
    return _sharedClient;
}

-(id)init
{
    colorPrimary = [UIColor colorWithRed:0xF5/255.0 
                                   green:0x00/255.0 
                                    blue:0x1D/255.0 alpha:1];
    colorPrimaryLight = [UIColor colorWithRed:0xFA/255.0 
                                   green:0x3E/255.0 
                                    blue:0x54/255.0 alpha:1];
    colorPrimaryLessLight = [UIColor colorWithRed:0xFA/255.0 
                                        green:0x70/255.0 
                                         blue:0x80/255.0 alpha:1];
    colorPrimaryDark = [UIColor colorWithRed:0xB7/255.0 
                                        green:0x2E/255.0 
                                         blue:0x3E/255.0 alpha:1];
    colorPrimaryMoreDark = [UIColor colorWithRed:0x9F/255.0 
                                        green:0x00/255.0 
                                         blue:0x13/255.0 alpha:1];
    colorSecondary = [UIColor colorWithRed:0x04/255.0 
                                        green:0x81/255.0 
                                         blue:0x9E/255.0 alpha:1];
    colorSecondaryLight = [UIColor colorWithRed:0x38/255.0 
                                        green:0x82/255.0 
                                         blue:0xce/255.0 alpha:1];
    colorSecondaryLessLight = [UIColor colorWithRed:0x60/255.0 
                                          green:0xb9/255.0 
                                           blue:0xce/255.0 alpha:1];
    colorSecondaryDark = [UIColor colorWithRed:0x20/255.0 
                                          green:0x66/255.0 
                                           blue:0x67/255.0 alpha:1];
    colorSecondaryMoreDark = [UIColor colorWithRed:0x01/255.0 
                                          green:0x53/255.0 
                                           blue:0x67/255.0 alpha:1];
    colorTertiary = [UIColor colorWithRed:0xcc/255.0 
                                   green:0xf6/255.0 
                                    blue:0x00/255.0 alpha:1];
    colorTertiaryLight = [UIColor colorWithRed:0xda/255.0 
                                   green:0xfb/255.0 
                                    blue:0x3f/255.0 alpha:1];
    colorTertiaryLessLight = [UIColor colorWithRed:0xe3/255.0 
                                        green:0xfb/255.0 
                                         blue:0x71/255.0 alpha:1];
    colorTertiaryDark = [UIColor colorWithRed:0xa1/255.0 
                                        green:0xb9/255.0 
                                         blue:0x2e/255.0 alpha:1];
    colorTertiaryMoreDark = [UIColor colorWithRed:0x86/255.0 
                                        green:0xa0/255.0 
                                         blue:0x00/255.0 alpha:1];
	
    
    colorTextureBg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture_background.png"]];
    colorNavigationBar = colorPrimaryLight;
    colorLinkedText = colorPrimary;
    colorPanel = colorPrimaryLessLight;
    colorOptionPanel = colorPrimaryLessLight;
    colorButtonBg = colorSecondary;
    colorButtonTitle = [UIColor whiteColor];
    colorButtonBg2 = colorPrimaryDark;        
    colorButtonTitle2 = [UIColor blackColor];    
    
    imageButtonBg = [self from:colorButtonBg];
    imageButtonBg2 = [self from:colorButtonBg2];

    imageButtonPhoto = [UIImage imageNamed:@"button_photo"];
    imageButtonAlbum = [UIImage imageNamed:@"button_album"];
       
    imageBarButtonItemBrightness = [UIImage imageNamed:@"icon_brightness"];
    imageBarButtonItemContrast = [UIImage imageNamed:@"icon_contrast"];
    imageBarButtonItemSave = [UIImage imageNamed:@"icon_save"];
    imageBarButtonItemEmail = [UIImage imageNamed:@"icon_mail"];
    imageBarButtonItemDelete = [UIImage imageNamed:@"icon_delete"];
    imageBarButtonItemPrint = [UIImage imageNamed:@"icon_delete"];
    imageBarButtonItemTrash = [UIImage imageNamed:@"icon_trash"];
    imageBarButtonItemFavorities = [UIImage imageNamed:@"icon_favorities"];
	[self createColorTextureHatched];
    
	colorNavigationBar1 = colorPrimaryLight;
	colorNavigationBar2 = colorSecondaryLight;
	colorNavigationBar3 = colorTertiaryLight;
	
	imageLogo = [UIImage imageNamed:@"logo"];
	
    return self;
}

-(void)createColorTextureHatched
{
    CGRect rect = CGRectMake(0, 0, 3, 4);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    
    rect = CGRectMake(2, 0, 1, 1);
    CGContextSetFillColorWithColor(context,
                                   [colorPrimary CGColor]);
    CGContextFillRect(context, rect);
    rect = CGRectMake(0, 2, 1, 1);
    CGContextSetFillColorWithColor(context,
                                   [colorPrimary CGColor]);
    CGContextFillRect(context, rect);
        
    rect = CGRectMake(2, 1, 1, 1);
    CGContextSetFillColorWithColor(context,
                                   [colorPrimaryLessLight CGColor]);
    CGContextFillRect(context, rect);
    rect = CGRectMake(0, 3, 1, 1);
    CGContextSetFillColorWithColor(context,
                                   [colorPrimaryLessLight CGColor]);
    CGContextFillRect(context, rect);

    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    colorTextureHatched = [UIColor colorWithPatternImage:img];
}

-(UIImage*)from:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end
