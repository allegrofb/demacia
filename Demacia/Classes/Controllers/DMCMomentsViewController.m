//
//  DMCMomentsViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 29/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCMomentsViewController.h"
#import "DMCMomentsTableViewCell.h"
#import "DMCCommentMessageToolBar.h"
#import "ObjUrlData.h"
#import "JSONKit.h"

@interface DMCMomentsViewController () <DMCCommentMessageToolBarDelegate>
{
    PageLoadFootView *_footView;
    BOOL _first;
    int _lastId;
    
    NSString * phoneNumber;
    UIWebView * webView;
    
    NSMutableArray * _images;  //测试用
    NSMutableArray * _contents;
}

@property (strong, nonatomic) DMCCommentMessageToolBar *chatToolBar;

@end

@implementation DMCMomentsViewController
@synthesize weiboData,replyData,superView,deleteWeibo=_deleteWeibo;
@synthesize datas;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupForDismissKeyboard];
    
    datas = [[NSMutableArray alloc] init];
    
    _footView=[[PageLoadFootView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.tableView.tableFooterView=_footView;
    [_footView loadFinish];
    _footView.delegate=self;
    
    _images=[NSMutableArray array];
    [_images addObject:@"http://www.tattoo77.com/uploads/allimg/121217/1-12121G43453108.jpg"];
    [_images addObject:@"http://img.photo.163.com/QNaHBfv9UpKOpSV5iT8ihQ==/2538622814953414148.jpg"];
    [_images addObject:@"http://images.china.cn/attachement/jpg/site1000/20121231/0019b91ec8e5124b2eb04d.jpg"];
    [_images addObject:@"http://www.txlz.net/Photo/UploadPhotos/201001/2010010520175322.jpg"];
    [_images addObject:@"http://img.bimg.126.net/photo/3oGY66A0fG2j_wj7CT1rXQ==/1146729055119642782.jpg"];
    [_images addObject:@"http://www.hua.com/flower_picture/meiguihua/images/r17.jpg"];
    [_images addObject:@"http://pic.jj20.com/up/allimg/411/042511033A2/110425033A2-9.jpg"];
    [_images addObject:@"http://www.mjjq.com/blog/photos/Image/mjjq-photos-903.jpg"];
    [_images addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423722.jpg"];
    [_images addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423723.jpg"];
    [_images addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423721.jpg"];
    [_images addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423722.jpg"];
    [_images addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423725.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/KJQIZSVQ013Q.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/50F271716EQV.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/QK2902POS179.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/63K864T17E2J.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/GP214390RG3V.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/L7M86I8303J3.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/Y86BKHJ2E2UH.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/6J24DA72I68Q.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/6BLP0Y3V9X3A.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/AXCO5HYK7OX0.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/B42FNUVDT7CS.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/1OEU52FTY56T.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/8L1N4G79RA65.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/0JM239P58O4O.jpg"];
    [_images addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/KT0X2XI3X9Z9.jpg"];
    
    _contents=[[NSMutableArray alloc]init];
    [_contents addObject:@"ASIHTTPRequest对CFNetwork API进行了封装，并且使用起来非常简单，用Objective-C编写，可以很好的应用在Mac OS X系统和iOS平台的应用程序中。ASIHTTPRequest适用于基本的HTTP请求，和基于REST的服务之间的交互"];
    [_contents addObject:@"15267971211本周末，中东部大部地区天气仍是晴多雨少，不过这种维持了一个多星期的天气格局即将被打破。"];
    [_contents addObject:@"http://www.weqia.com  15267971211[难过][冷汗][大哭]预计4日夜间开始，较强冷空气将从新疆启程，一路东移南下，给中东部地区带来明显降温及大范围的雨雪天气，北京、河北、山西、陕西等地将终结持续两个月左右的干燥无雨天气，北京有望迎来今冬初雪。"];
    [_contents addObject:@"预计4日夜间到5日，较强冷空气将对西北地区发威，气温普遍下降6～8℃，部分地区降温可达10～12℃；新疆北部、内蒙古西部等地有4～6级风，其中山口地区风力可达8～9级；新疆北部有小到中雪，伊犁河谷的部分地区有大雪。6日至8日，西北地区东部、华北、东北地区东部等地将陆续出现小到中雪或雨夹雪，局地大雪。1月6日，北京地区或迎来今冬初雪；上述地区并伴有6～10℃的降温，局地降温幅度可达12～14℃。"];
    [_contents addObject:@"6日至8日，西北地区东部、华北、东北地区东部等地将陆续出现小到中雪或雨夹雪，局地大雪。1月6日，北京地区或迎来今冬初雪；上述地区并伴有6～10℃的降温，局地降温幅度可达12～14℃。"];
    [_contents addObject:@"http://www.weqia.com[难过][冷汗][大哭]"];
    [_contents addObject:@"http://www.weqia.com  15267971211电视连续剧《甄嬛传》从2011年11月首播到现在，两年多时间过去，重播复重播，收视率依然高企。随着它“闯美入韩又登日”，新一轮关注也风生水起。这种现象很值得研究。"];
    [_contents addObject:@"http://www.weqia.com  15267971211《甄嬛传》走红，很大程度上是以思想的穿透力赢得了生命力，进而提升了影响力。"];
    [_contents addObject:@"[难过][冷汗][大哭]"];
    [self loadFromDb:YES];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _first=NO;
    
    UIBarButtonItem* testButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testAction)];

    self.navigationItem.rightBarButtonItem = testButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [_footView animmation];
}

// 从本地加载数据  update : 加载结束之后是否需要从后台更新数据， 第一次进入时需要更新。
-(void)loadFromDb:(BOOL)update
{
    static int msgId=0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray * array=[[NSMutableArray alloc]init];
        for (int i=0; i<8; i++)
        {
            DMCPost * data=[[DMCPost alloc]init];
            data.content=[_contents objectAtIndex:(msgId%_contents.count)];
            data.msgId=[NSString stringWithFormat:@"%d",msgId++];
            [array addObject:data];
            NSMutableArray * urls=[[NSMutableArray alloc]init];
            ObjUrlData * url=[[ObjUrlData alloc]init];
            url.url=[_images objectAtIndex:(msgId%_images.count)];
            url.mime=@"image/pic";
            [urls addObject:url];
            if (msgId%2==0)
            {
                ObjUrlData * url=[[ObjUrlData alloc]init];
                url.url=[_images objectAtIndex:(msgId*2%_images.count)];
                url.mime=@"image/pic";
                [urls addObject:url];
            }
            data.files=urls;
        }
        [self loadWeboData:array complete:nil formDb:YES];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger count=[datas count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %d, row = %d",indexPath.section,indexPath.row);
    DMCPost * weibo=[datas objectAtIndex:indexPath.row];
    DMCMomentsTableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"DMCMomentsTableViewCell" forIndexPath:indexPath];

    cell.controller=self;
    [cell setCellContent:weibo];
//    float height=[self tableView:tableView heightForRowAtIndexPath:indexPath];
//    UIView * view=[cell.contentView viewWithTag:1200];
//    if(view==nil)
//    {
//        UIImageView * line=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dv_line.png"]];
//        
//        line.frame=CGRectMake(0, height-1, 320, 1);
//        [cell.contentView  addSubview:line];
//        line.tag=1200;
//    }
//    else
//    {
//        view.frame=CGRectMake(0, height-1, 320, 1);
//    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    JSONPost * data=[datas objectAtIndex:indexPath.row];
//    return [DMCMomentsTableViewCell getHeightByContent:data];
    return 100.0;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    JSONPost * data=[datas objectAtIndex:indexPath.row];;
////    if (data) {
////        data.willDisplay=YES;
////    }
//}

//-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JSONPost * data=[datas objectAtIndex:indexPath.row];;
////    if (data) {
////        data.willDisplay=NO;
////    }
//}

#pragma -mark 回调方法

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_footView scrollViewDidEndDecelerating:scrollView];
    
}

-(void)footViewBeginLoad:(PageLoadFootView*)footView
{
//    [self loadFromDb:NO];
}

-(void)loadWeboData:(NSArray*)webos complete:(void(^)())complete formDb:(BOOL)fromDb
{
    for(DMCPost * weibo in webos)
    {
//        weibo.match=nil;
//        [weibo setMatch];
//        weibo.uploadFailed=NO;
//        [weibo getWeiboReplysByType:1];
//        weibo.linesLimit=YES;
        weibo.imageHeight=[HBShowImageControl heightForFiles:weibo.files];
        weibo.replyHeight=[DMCMomentsTableViewCell heightForReply:weibo.replys];
        
        [datas addObject:weibo];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_footView loadFinish];
//        _datas=webos;
        [self.tableView reloadData];
        if(complete)
        {
            complete();
        }
    });
    
    
    
    
    
//    NSMutableArray * ary=nil;
//    if(fromDb&&[_datas count]==0){
//        ary=[[NSMutableArray alloc]init];
//        //
//    }else{
//        if(!_first){
//            ary=[NSMutableArray arrayWithArray:_datas];
//        }else{
//            ary=[[NSMutableArray alloc]init];
//        }
//    }
//    if (!fromDb) {
//        int count=[webos count];
//        for (int i=0; i<count; i++) {
//            WeiboData * webo=[webos objectAtIndex:i];
//            BOOL has=NO;
//            for (WeiboData * data in _datas) {
//                if (data.msgId.intValue==webo.msgId.intValue&&!data.local) {
//                    if(_first){
//                        [data setMatch];
//                        [ary addObject:data];
//                    }
//                    has=YES;
//                    break;
//                }
//            }
//            if (!has) {
//                [ary addObject:webo];
//            }
//        }
//        _first=NO;
//    }else{
//        [ary addObjectsFromArray:webos];
//    }
//    //    [ary sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//    //        WeiboData *  weibo1=(WeiboData *)obj1;
//    //        WeiboData *  weibo2=(WeiboData *)obj2;
//    //        if(weibo1.msgId.intValue>weibo2.msgId.intValue){
//    //            return NSOrderedAscending;
//    //        }else if(weibo1.msgId.intValue<weibo2.msgId.intValue){
//    //            return NSOrderedDescending;
//    //        }else{
//    //            return NSOrderedSame;
//    //        }
//    //    }];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_footView loadFinish];
//        _datas=ary;
//        _lastId=((WeiboData*)[webos lastObject]).msgId.intValue;
//        [self.tableView reloadData];
//        if(complete){
//            complete();
//        }
//    });
}

- (void)loadWeboData:(NSArray *) webos {
    [self loadWeboData:webos complete:nil formDb:NO];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==102){
        if(0==buttonIndex){
            NSString * string=[NSString stringWithFormat:@"tel:%@",phoneNumber];
            if(webView==nil)
                webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
            webView.hidden=YES;
            [self.view addSubview:webView];
        }
    }else if (actionSheet.tag==103){
        if(0==buttonIndex){
            NSString * string=[NSString stringWithFormat:@"tel:%@",phoneNumber];
            if(webView==nil)
                webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
            webView.hidden=YES;
            [self.view addSubview:webView];
        }else if(1==buttonIndex){
            
        }
    }
}


#pragma mark - 私有方法

#pragma mark - 事件响应方法

-(void)update
{
//    [self loadFromDb:NO];
}


#pragma mark - DMCCommentMessageToolBarDelegate

- (void)didSendText:(NSString *)text
{
//    if (text && text.length > 0) {
//        [self sendTextMessage:text];
//    }
    
    [_chatToolBar setHidden:YES];
    [self.view endEditing:YES];

}

#pragma mark - dismiss keyboard

- (void)setupForDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [_chatToolBar setHidden:YES];
    [self.view endEditing:YES];
}

#pragma mark - test button action

- (void)testAction
{
    if(_chatToolBar == nil)
    {
        _chatToolBar = [[DMCCommentMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DMCCommentMessageToolBar defaultHeight], self.view.frame.size.width, [DMCCommentMessageToolBar defaultHeight])];
        
        _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        _chatToolBar.delegate = self;
        
        [self.view addSubview:_chatToolBar];
        [_chatToolBar.inputTextView becomeFirstResponder];
    }
    else
    {
        [_chatToolBar setHidden:NO];
        [_chatToolBar.inputTextView becomeFirstResponder];
    }
    
}


@end
