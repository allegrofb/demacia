//
//  DMCBuddyMeTableViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 23/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCBuddyMeTableViewController.h"
#import "DMCBuddySettingsTableViewController.h"
#import "RootViewController.h"


@interface DMCBuddyMeTableViewController ()

@end

@implementation DMCBuddyMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0)
    {
        return 1;
    }
    else if(section == 1)
    {
        return 6;
    }
    else
    {
        return 1;
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    DMCStrokeRectTableViewCell* cell = nil;
    UITableViewCell* cell = nil;
    
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DMCBuddyMeTableCell1" forIndexPath:indexPath];
        
        cell.textLabel.text = @"北斗星";
        cell.detailTextLabel.text = @"车陌号：957";
    }
    else if(indexPath.section == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DMCBuddyMeTableCell2" forIndexPath:indexPath];
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"角色选择";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"相册";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"收藏";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 3)
        {
            cell.textLabel.text = @"表情";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 4)
        {
            cell.textLabel.text = @"设置";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 5)
        {
            cell.textLabel.text = @"钱包";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 116;
    }
    else
    {
        return 44;
    }
    
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0)
    {
        
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 4)
        {
            DMCBuddySettingsTableViewController*vc = [[DMCBuddySettingsTableViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(indexPath.row == 5)
        {
            RootViewController *rvc        = [[RootViewController alloc] init];
            [self.navigationController pushViewController: rvc animated:YES];
            
            
            
        }
    }
    
}




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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
