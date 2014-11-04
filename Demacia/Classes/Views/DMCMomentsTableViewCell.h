//
//  DMCMomentsTableViewCell.h
//  Demacia
//
//  Created by Hongyong Jiang on 29/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBShowImageControl.h"
#import "DMCPost.h"
#import "DMCComment.h"
#import "DMCMomentsViewController.h"
#import <QuickLook/QuickLook.h>

#define REPLY_BACK_COLOR 0xd5d5d5


@interface DMCMomentsCommentTableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel * label;

@end

@class DMCMomentsViewController;

@interface DMCMomentsTableViewCell : UITableViewCell<HBShowImageControlDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    DMCPost * _weibo;
    DMCComment * _reply;
    
    //    HBCellOperation * _operation;
    
    NSArray * _replys;
    
    NSIndexPath * _indexPath;
    
    BOOL linesLimit;
    
    int replyCount;
}
@property(nonatomic,weak) IBOutlet UILabel *  title;
@property(nonatomic,weak) IBOutlet UILabel * content;
@property(nonatomic,weak) IBOutlet UIView * imageContent;
@property(nonatomic,weak) IBOutlet UILabel * time;
//@property(nonatomic,weak) IBOutlet UILabel * replyCount;
@property(nonatomic,weak) IBOutlet UIImageView * mLogo;
@property(nonatomic,weak) IBOutlet UIView * replyContent;
@property(nonatomic,weak) IBOutlet UIButton * btnReply;
@property(nonatomic,weak) IBOutlet UIImageView * back;
@property(nonatomic,weak) IBOutlet UITableView * tableReply;
@property(nonatomic,weak) IBOutlet UIView * lockView;
@property(nonatomic,weak) IBOutlet UIButton *btnDelete;
@property(nonatomic,weak) IBOutlet UIButton * btnShare;
@property(nonatomic,strong) DMCMomentsViewController * controller;

-(void)loadReply;
-(void)setCellContent:(DMCPost *)data;

+(float)getHeightByContent:(DMCPost*)data;
+(float) heightForReply:(NSArray*)replys;

@end
