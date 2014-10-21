//
//  UIImage+ColouredButton.h
//  QuCube
//
//  Created by Hongyong Jiang on 31/03/13.
//  Copyright (c) 2013年 Hongyong Jiang. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage*)setBackgroundImageByColor:(UIColor *)backgroundColor withFrame:(CGRect )rect;


+ (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance;

+(UIImage *)changeWhiteColorTransparent: (UIImage *)image;

+(UIImage *)changeColorTo:(NSMutableArray*) array Transparent: (UIImage *)image;

//resizing Stuff...
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
