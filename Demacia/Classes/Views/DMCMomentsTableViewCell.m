//
//  DMCMomentsTableViewCell.m
//  Demacia
//
//  Created by Hongyong Jiang on 29/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCMomentsTableViewCell.h"
#import "UIImageView+HBHttpCache.h"
#import "TimeUtil.h"
#import <QuartzCore/QuartzCore.h>
#import "NSStrUtil.h"
//#import "ObjUrlData.h"



@implementation DMCMomentsCommentTableViewCell
@synthesize label;
-(void)prepareForReuse
{
//    self.label.match=nil;
    
}

@end


@implementation DMCMomentsTableViewCell
@synthesize controller;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma -mark 私有方法

-(void) prepare
{
    [super prepareForReuse];
    //    _time.text=@"";
    //    _title.text=@"";
    for(UIView * view in _imageContent.subviews)
        [view removeFromSuperview];
    UIView * view=[self.contentView viewWithTag:191];
    if(view){
        [view removeFromSuperview];
    }
    view=[self.contentView viewWithTag:192];
    if(view){
        [view removeFromSuperview];
    }
    linesLimit=NO;
}

+(float) heightForReply:(NSArray*)replys
{
    float height=6;
//    for(WeiboReplyData * data in replys){
//        height+=data.height+4;
//    }
    return height;
}

-(void)addImagesWithFiles:(float)offset
{
//    if(_weibo.imageHeight==0){
//        self.imageContent.hidden=YES;
//        CGRect  frame=self.imageContent.frame;
//        frame.origin.y=self.content.frame.origin.y+self.content.frame.size.height+offset+5;
//        frame.size.height=0;
//        self.imageContent.frame=frame;
//        return;
//    }else{
//        self.imageContent.hidden=NO;
//        CGRect  frame=self.imageContent.frame;
//        frame.origin.y=self.content.frame.origin.y+self.content.frame.size.height+offset+5;
//        frame.size.height=_weibo.imageHeight;
//        self.imageContent.frame=frame;
//    }
//    __weak WeiboCell * wself=self;
//    __weak WeiboData * wweibo=_weibo;
//    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        if (wself&&wweibo.willDisplay&&wweibo) {
//            __strong WeiboCell * sself=wself;
//            __strong WeiboData * sweibo=wweibo;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                HBShowImageControl * control=[[HBShowImageControl alloc]initWithFrame: sself.imageContent.bounds];
//                control.controller=sself.controller;
//                control.smallTag=THUMB_WEIBO_SMALL_1;
//                control.bigTag=THUMB_WEIBO_BIG;
//                [control setImagesFileStr:sweibo.files];
//                [sself.imageContent addSubview:control];
//                control.delegate=sself;
//            });
//        }
//    });
}


#pragma -mark 接口方法
-(void)loadReply
{
    _replys=_weibo.replys;
    [self.tableReply reloadData];
}

-(void)setCellContent:(DMCPost *)weibo
{
//    weibo.willDisplay=YES;
//    if(weibo.msgId.intValue==_weibo.msgId.intValue&&weibo.local==_weibo.local&&linesLimit==weibo.linesLimit&&[_weibo.replys count]==[weibo.replys count])
//        return;
//    [self prepare];
//    replyCount=[weibo.replys count];
//    linesLimit=weibo.linesLimit;
//    
//    self.mLogo.layer.cornerRadius=3;
//    self.mLogo.clipsToBounds=YES;
//    [self.content registerCopyAction];
//    _weibo=weibo;
//    self.content.linesLimit=_weibo.linesLimit;
//    __weak HBCoreLabel * wcontent=self.content;
//    MatchParser* match=[_weibo getMatch:^(MatchParser *parser,id data) {
//        if (wcontent) {
//            WeiboData * weibo=(WeiboData*)data;
//            if (weibo.willDisplay) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    wcontent.match=parser;
//                });
//            }
//        }
//    } data:weibo];
//    self.content.match=match;
//    //    ContactData *contact = [[WeqiaAppDelegate App].dbUtil searchSingle:[ContactData class]where:[NSString stringWithFormat:@"mid='%@'",weibo.mid] orderBy:nil];
//    //    if (contact != nil) {
//    //        self.title.text=contact.mName;
//    //        if([NSStrUtil notEmptyOrNull:contact.mLogo]){
//    //            [self.mLogo setImageWithURL:[NSURL URLWithString:contact.mLogo] placeholderImage:[UIImage imageNamed:@"people.png"]];
//    //        }else{
//    //            self.mLogo.image=[UIImage imageNamed:@"people.png"];
//    //        }
//    //    }else{
//    //        self.mLogo.image=[UIImage imageNamed:@"people.png"];
//    //    }
//    NSMutableString * timeStr=[[NSMutableString alloc]init];
//    if ([NSStrUtil notEmptyOrNull:weibo.gmtCreate]) {
//        long long time=[weibo.gmtCreate longLongValue];
//        [timeStr appendString:[TimeUtil getTimeStrStyle1:time/1000]];
//    }
//    self.time.text=timeStr;
//    CGRect frame=self.time.frame;
//    frame.size.width=[timeStr sizeWithFont:self.time.font].width+10;
//    self.time.frame=frame;
//    self.tableReply.scrollEnabled=NO;
//    float offset=0.0f;
//    if(weibo.numberOfLineLimit<weibo.numberOfLinesTotal){
//        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitleColor:self.title.textColor forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        [self.contentView addSubview:button];
//        [button addTarget:self action:@selector(limitAction) forControlEvents:UIControlEventTouchUpInside];
//        if(weibo.linesLimit){
//            [button setTitle:@"全文" forState:UIControlStateNormal];
//            _content.frame=CGRectMake(57, 32, _weibo.miniWidth,_weibo.heightOflimit);
//            offset=25;
//        }else{
//            [button setTitle:@"收起" forState:UIControlStateNormal];
//            _content.frame=CGRectMake(57, 32, _weibo.miniWidth,_weibo.height);
//            offset=25;
//        }
//        button.frame=CGRectMake(57, self.content.frame.origin.y+self.content.frame.size.height+6, 50, 20);
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
//        button.tag=191;
//    }else{
//        _content.frame=CGRectMake(57, 32, _weibo.miniWidth,_weibo.height);
//    }
//    [self addImagesWithFiles:offset];
//    //    if(!weibo.local){
//    //        if(weibo.isGetReply){
//    //            if ([weibo.replys isKindOfClass:[NSArray class]]&&[weibo.replys count]>0) {
//    //                [self.tableReply reloadData];
//    //                [self.back setHidden:NO];
//    //            } else {
//    //                [self.back setHidden:YES];
//    //            }
//    //        }else{
//    //            [self.back setHidden:YES];
//    //            [weibo getWeiboReplysByType:1];
//    //        }
//    //    }else{
//    //        [self.back setHidden:YES];
//    //    }
//    [self.back setHidden:NO];
//    float height=_weibo.replyHeight;
//    
//    frame=self.replyContent.frame;
//    frame.origin.y=self.imageContent.frame.origin.y+self.imageContent.frame.size.height+5;
//    frame.size.height=_weibo.replyHeight+30;
//    self.replyContent.frame=frame;
//    
//    frame=_back.frame;
//    frame.size.height=height;
//    frame.origin.y=28;
//    _back.frame=frame;
//    
//    frame=_tableReply.frame;
//    frame.size.height=height-6;
//    frame.origin.y=35;
//    _tableReply.frame=frame;
//    if(weibo.local){
//        [self.btnReply setEnabled:NO];
//    }else{
//        [self.btnReply setEnabled:YES];
//    }
}

+(float)getHeightByContent:(JSONPost*)data
{
//    float height;
//    if(data.shouldExtend){
//        if(data.linesLimit){
//            height=data.heightOflimit+25;
//        }else{
//            height=data.height+25;
//        }
//    }else{
//        height=data.height;
//    }
    
//    if ([data.replys isKindOfClass:[NSArray class]]&&[data.replys count]>0&&!data.local)
//    {
//        return 70.0+data.imageHeight+height+6+data.replyHeight;
//    }
//    else
//    {
//        return 70.0+data.imageHeight+height;
//    }
    
    return 170;
}

#pragma -mark 委托方法
-(void)showImageControlFinishLoad:(HBShowImageControl*)control
{
    CGRect frame=self.imageContent.frame;
    frame.size.height=control.frame.size.height;
    self.imageContent.frame=frame;
}


#pragma -mark 事件响应方法

-(void)limitAction
{
//    if(_weibo.linesLimit){
//        _weibo.linesLimit=NO;
//        [controller.tableView reloadData];
//    }else{
//        _weibo.linesLimit=YES;
//        [controller.tableView reloadData];
//        [controller.tableView scrollRectToVisible:CGRectMake(0, self.frame.origin.y, 320, controller.tableView.frame.size.height) animated:NO];
//    }
    
}

-(IBAction)deleteAction:(id)sender
{
    
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"删除分享"
                                                  message:nil
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"确认", nil];
    alert.tag=222;
    [alert show];
}

-(IBAction)btnReplyAction:(id)sender
{
    
}

-(void)delAndReplyAction
{
    
}


#pragma -mark 回调方法

-(void)lookImageAction:(HBShowImageControl*)control
{
}

#pragma -mark  tableReply delegate

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WeiboReplyData * data=[_weibo.replys objectAtIndex:indexPath.row];
//    return data.height+4;
    return 10.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_weibo.replys count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuse=@"DMCMomentsCommentTableViewCell";
    DMCMomentsCommentTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    if(indexPath.row>=_weibo.replys.count)
        return cell;
    
    //TODO
//    WeiboReplyData * data=[_weibo.replys objectAtIndex:indexPath.row];
//    __weak HBCoreLabel * wlabel=cell.label;
//    MatchParser * match=[data getMatch:^(MatchParser *parser, id data) {
//        if (wlabel) {
//            WeiboData * weibo=(WeiboData*)data;
//            if (weibo.willDisplay) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    wlabel.match=parser;
//                });
//            }
//        }
//    } data:_weibo];
//    cell.label.match=match;
//    cell.label.userInteractionEnabled=YES;
//    CGRect frame=cell.label.frame;
//    cell.backgroundColor=[UIColor clearColor];
//    frame.size.height=data.height;
//    cell.label.frame=frame;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath=indexPath;
    _reply=[_weibo.replys objectAtIndex:indexPath.row];
    [self delAndReplyAction];
}


@end
