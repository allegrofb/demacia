//
//  DMCStrokeRectTableViewCell.m
//  Demacia
//
//  Created by Hongyong Jiang on 23/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCStrokeRectTableViewCell.h"

@implementation DMCStrokeRectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
        [self.contentView addSubview:_bottomLineView];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    _bottomLineView = [[UIView alloc] init];
//    _bottomLineView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
    _bottomLineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_bottomLineView];
    
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.imageView.frame = CGRectMake(10, 8, 34, 34);
    
//    CGRect rect = self.textLabel.frame;
//    rect.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
//    self.textLabel.frame = rect;
    
    _bottomLineView.frame = CGRectMake(0, 0, 320, 1);
}


//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
//}

@end
