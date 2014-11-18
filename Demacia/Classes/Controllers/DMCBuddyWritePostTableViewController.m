//
//  DMCBuddyWritePostTableViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DMCBuddyWritePostTableViewController.h"
#import "DMCDatastore.h"
#import "DMCUserHelper.h"
#import "DMCWritePostImageTableViewCell.h"
#import "ZYQAssetPickerController.h"
#import "TmpFilesMgr.h"
#import "DMCUploadHelper.h"
#import "Utility.h"

@interface DMCBuddyWritePostTableViewController ()<UIImagePickerControllerDelegate, DMCWritePostImageTableViewCellDelegate,
    ZYQAssetPickerControllerDelegate>

@property(nonatomic,weak) IBOutlet UITextView* textView;
@property(nonatomic,weak) IBOutlet UITableViewCell* textCell;
@property(nonatomic,weak) IBOutlet DMCWritePostImageTableViewCell* imageCell;
@property(nonatomic,weak) IBOutlet UITableViewCell* cell3;

@property(nonatomic) NSUInteger imageCellHeight;

@end

@implementation DMCBuddyWritePostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"写帖子";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(postAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    
    self.imageCell.delegate = self;
    
    _imageCellHeight = 105;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 216;
    }
    else if(indexPath.section == 1)
    {
        return _imageCellHeight;
;
    }
    else
    {
        return 44;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button Action

- (void)postAction
{
    [self showHudInView:self.view hint:@"正在发表..."];
    
    [[DMCUploadHelper sharedInstance] blockHUD];
    
    NSArray* picKeys = [[DMCUploadHelper sharedInstance]getUploadFiles];
    NSArray* thumbKeys = [[DMCUploadHelper sharedInstance]getUploadThumbs];
    
    NSString* userInfo = [DMCUserHelper sharedInstance].userInfo.objectId;
    NSString* content = self.textView.text;
    
    [[DMCDatastore sharedInstance]addPost:userInfo content:content picKeys:picKeys thumbKeys:thumbKeys block:^(BOOL isSuccessful, NSError *error) {
       
        if(isSuccessful)
        {
            [self hideHud];
            TTAlertNoTitle(@"发表成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self hideHud];
            NSString* msg = [NSString stringWithFormat:@"发表失败, 故障码：%ld",(long)error.code];
            TTAlertNoTitle(msg);
            
        }
    }];
}

- (void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DMCWritePostImageTableViewCellDelegate

- (void)addImageButtonAction
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
    
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];

    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - ZYQAssetPickerController Delegate

- (void)setCellHeight:(NSUInteger)number
{
    NSUInteger i = (number+2-1)/3 + 1;
    _imageCellHeight = 105*i;
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    [self setCellHeight:assets.count];
    
    [picker dismissViewControllerAnimated:YES completion:^(){

        [self processAssets:assets];
    }];
    
}

- (void)processAssets:(NSArray *)assets
{
    NSMutableArray* imageArray = [[NSMutableArray alloc] init];
    NSMutableArray* urlArray = [[NSMutableArray alloc] init];
    
    for(int i=0;i<assets.count;i++)
    {
        ALAsset *asset=assets[i];
        UIImage *img=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];

        NSURL* url = [asset defaultRepresentation].url;
        NSString* uti = [asset defaultRepresentation].UTI;

        DLog(@"url = %@",url);
        DLog(@"uti = %@",uti);
        
        [imageArray addObject:img];
        [urlArray addObject:url];
    }

    [[DMCUploadHelper sharedInstance] setupUpload:imageArray urls:urlArray];
    [self.imageCell setImageArray:imageArray];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
//    //关闭相册界面
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//    //当选择的类型是图片
//    if([type isEqualToString:@"public.image"]){
//        //先把图片转成NSData
//        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
////        [self reloadDataWithImage:image];
//        
//        NSData *datas;
//        if(UIImagePNGRepresentation(image)==nil){
//            datas = UIImageJPEGRepresentation(image, 1.0);
//        }else{
//            datas = UIImagePNGRepresentation(image);
//        }
//        
//        //图片保存的路径
//        //这里将图片放在沙盒的documents文件夹中
//        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //文件管理器
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        //把刚才图片转换的data对象拷贝至沙盒中,并保存为image.png
//        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:datas attributes:nil];
//        //得到选择后沙盒中图片的完整路径
//        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/image.png"];
//        
//        //创建一个选择后图片的图片放在scrollview中
//        
//        //加载scrollview中
//        
//    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
