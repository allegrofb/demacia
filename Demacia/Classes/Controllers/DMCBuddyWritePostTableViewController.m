//
//  DMCBuddyWritePostTableViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 06/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCBuddyWritePostTableViewController.h"
#import "DMCDatastore.h"
#import "DMCUserHelper.h"
#import "DMCWritePostImageTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZYQAssetPickerController.h"

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
    NSString* userInfo = [DMCUserHelper sharedInstance].userInfo.objectId;
    NSString* content = self.textView.text;
    
    [[DMCDatastore sharedInstance]addPost:userInfo content:content picKeys:nil thumbKeys:nil block:^(BOOL isSuccessful, NSError *error) {
       
        if(isSuccessful)
        {
            TTAlertNoTitle(@"发表成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
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
        
        [self.imageCell setImageArray:assets];
        //TODO
    }];
    
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
