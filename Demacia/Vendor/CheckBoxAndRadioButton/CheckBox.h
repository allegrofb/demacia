//
//  CheckBox.h
//  Checkbox
//
//  Created by Jeruel Fernandes on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckBoxDelegate <NSObject>
- (void)stateChangedForID:(NSUInteger)index WithCurrentState:(BOOL)currentState;
@end

@interface CheckBox : UIView
{
    NSUInteger  nID;
    UIButton    *btn_CheckBox;
    UILabel     *lbl_CheckBox;
    
    id <CheckBoxDelegate> delegate;
}

@property (readwrite, nonatomic) NSUInteger nID;
@property (strong, nonatomic) UIButton *btn_CheckBox;
@property (strong, nonatomic) UILabel *lbl_CheckBox;
@property (strong, nonatomic) id <CheckBoxDelegate> delegate;

- (id)initWithFrame:(CGRect)frame AndID:(NSUInteger)index AndSelected:(BOOL)state AndTitle:(NSString*)title;
- (void)setID:(NSUInteger)index AndSelected:(BOOL)state AndTitle:(NSString*)title;
- (BOOL)currentState;

@end
