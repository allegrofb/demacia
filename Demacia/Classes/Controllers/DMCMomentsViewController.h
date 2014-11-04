//
//  DMCMomentsViewController.h
//  Demacia
//
//  Created by Hongyong Jiang on 29/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageLoadFootView.h"
#import "JSONPost.h"
#import "JSONComment.h"


@interface DMCMomentsViewController : UIViewController<PageLoadFootViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _artArr;
    NSMutableDictionary * _artDic;
    void(^_block)(NSString*string);
    JSONPost * _deleteWeibo;
    NSIndexPath *_deletePath;
    BOOL  animationEnd;
}

@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)JSONPost * weiboData;
@property(nonatomic,strong)JSONComment * replyData;
@property(nonatomic,strong)JSONPost * deleteWeibo;
@property(nonatomic,strong) UIView * superView;
@property(nonatomic,strong) IBOutlet UITableView * tableView;

@end
