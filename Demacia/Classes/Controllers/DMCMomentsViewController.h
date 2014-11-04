//
//  DMCMomentsViewController.h
//  Demacia
//
//  Created by Hongyong Jiang on 29/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageLoadFootView.h"
#import "DMCPost.h"
#import "DMCComment.h"


@interface DMCMomentsViewController : UIViewController<PageLoadFootViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _artArr;
    NSMutableDictionary * _artDic;
    void(^_block)(NSString*string);
    DMCPost * _deleteWeibo;
    NSIndexPath *_deletePath;
    BOOL  animationEnd;
}

@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)DMCPost * weiboData;
@property(nonatomic,strong)DMCComment * replyData;
@property(nonatomic,strong)DMCPost * deleteWeibo;
@property(nonatomic,strong) UIView * superView;
@property(nonatomic,strong) IBOutlet UITableView * tableView;

@end
