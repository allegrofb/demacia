//
//  OptionView.h
//  Found+Lost
//
//  Created by Bmob on 14-5-21.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import <UIKit/UIKit.h>


@class OptionView;
@protocol OptionViewDelegate <NSObject>

@optional

-(void)optionDidDismiss:(NSInteger)row optionView:(OptionView*)view;
@end



@interface OptionView : UIView

@property(nonatomic,weak)id<OptionViewDelegate>delegate;


-(id)initWithOptionArray:(NSArray*)array;
@end



