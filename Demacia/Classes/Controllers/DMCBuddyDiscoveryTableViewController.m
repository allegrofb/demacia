
//
//  DMCBuddyDiscoveryTableViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 23/10/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCBuddyDiscoveryTableViewController.h"

@interface DMCBuddyDiscoveryTableViewController ()

@end

@implementation DMCBuddyDiscoveryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0)
    {
        return 3;
    }
    else if(section == 1)
    {
        return 3;
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
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DMCBuddyDiscoveryTableCell1" forIndexPath:indexPath];
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"啦啦啦...德玛西亚";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"热门德玛";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"附近留言";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"附近的人";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"好友地图";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = @"车主社区";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
    }
    else if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"游戏";
            cell.imageView.image = [UIImage imageNamed:@"icon_settings"];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
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

