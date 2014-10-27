//
//  FoundTableViewCell.m
//  Found+Lost
//
//  Created by Bmob on 14-5-22.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "FoundTableViewCell.h"

@implementation FoundTableViewCell

@synthesize titleLabel   = _titleLabel;
@synthesize timeLabel    = _timeLabel;
@synthesize contentLabel = _contentLabel;
@synthesize phoneButton  = _phoneButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel                 = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font            = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor       = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel                 = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font            = [UIFont systemFontOfSize:12];
        _timeLabel.textColor       = RGB(159, 159, 159);
        _timeLabel.numberOfLines   = 0;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel                 = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font            = [UIFont systemFontOfSize:14];
        _contentLabel.textColor       = RGB(159, 159, 159);
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

-(UIButton*)phoneButton{
    if (!_phoneButton) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[_phoneButton titleLabel] setFont:[UIFont systemFontOfSize:11]];
        [_phoneButton setBackgroundImage:[[UIImage imageNamed:@"btn_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)] forState:UIControlStateNormal];
        [_phoneButton setImage:[UIImage imageNamed:@"btn_icon"] forState:UIControlStateNormal];
        [_phoneButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [_phoneButton setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
        [self.contentView addSubview:_phoneButton];
    }
    
    return _phoneButton;
}




-(void)dealloc{
    _titleLabel   = nil;
    _timeLabel    = nil;
    _contentLabel = nil;
    _phoneButton  = nil;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame   = CGRectMake(12, 10, 296, 16);
    self.contentLabel.frame = CGRectMake(12, 30, 296, 46);
    self.timeLabel.frame    = CGRectMake(12, 88, 120, 13);
    self.phoneButton.frame  = CGRectMake(200, 80, 105, 20);
    
}

@end
