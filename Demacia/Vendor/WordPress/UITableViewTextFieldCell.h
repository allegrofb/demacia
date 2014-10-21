//
//  UITableViewTextFieldCell.h
//  WordPress
//
//  Created by Jorge Bernal on 4/27/11.
//  Copyright 2011 WordPress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UITableViewTextFieldCell : UITableViewCell

@property (nonatomic, retain) UITextField *textField;
@property (nonatomic) CGFloat titleWidth;

@end