//
//  RootViewController.m
//  Found+Lost
//
//  Created by Bmob on 14-5-21.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "RootViewController.h"
#import "OptionView.h"
#import "FoundTableViewCell.h"
#import "News.h"
#import <BmobSDK/Bmob.h>
#import "AddViewController.h"


@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,OptionViewDelegate>{
    BOOL                _isFound;
    UIButton            *_navigationButton;
    
    NSMutableArray      *_infoMutableArray;
    UITableView         *_tableView;
    
    NSDateFormatter     *_dateFormatter;
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _navigationButton             = [UIButton buttonWithType:UIButtonTypeCustom];
        _navigationButton.frame       = CGRectMake(0, 0,88 , 88);
        [_navigationButton setTitle:@"Found" forState:UIControlStateNormal];
        [_navigationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[_navigationButton titleLabel] setFont:[UIFont boldSystemFontOfSize:18]];
        [_navigationButton setImage:[UIImage imageNamed:@"jt"] forState:UIControlStateNormal];
        [_navigationButton setImageEdgeInsets:UIEdgeInsetsMake(22, 75, 0, 0)];
        [_navigationButton addTarget:self action:@selector(choseTitle) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = _navigationButton;

        UIButton *leftBtn             = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame                 = CGRectMake(0, 0, 50, 44);
        [leftBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"add_"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(addInfo) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        if (IS_iOS7) {
            self.automaticallyAdjustsScrollViewInsets = NO;
            [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isFound                  = YES;

    _tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewOrginY, 320, ScreenHeight-ViewOrginY)];
    _tableView.dataSource     = self;
    _tableView.delegate       = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _infoMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    [self seacrhTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    _tableView.dataSource = nil;
    _tableView.delegate   = nil;
    _tableView            = nil;
    _dateFormatter        = nil;
    
}

#pragma mark - someaction


-(void)choseTitle{
    
    if (![self.navigationController.view viewWithTag:1000]) {
        OptionView *view = [[OptionView alloc] initWithOptionArray:@[@"Found",@"Lost"]];
        view.delegate    = self;
        view.frame       = CGRectMake(0, 64-StatueBarHeight-NavigationBarHeight, 320, 0);
        view.tag         = 1000;
        [self.navigationController.view addSubview:view];
        
        view.frame       = CGRectMake(0, 64-StatueBarHeight-NavigationBarHeight, 320, ScreenHeight-(64-StatueBarHeight-NavigationBarHeight));
    }
    
    

    
}

-(void)addInfo{
    AddViewController *avc = [[AddViewController alloc] initWithFoundOrNot:_isFound];
    [self.navigationController pushViewController:avc animated:YES];
}

-(void)seacrhTable{
    
    [_infoMutableArray removeAllObjects];
    
    NSString *className = @"";
    
    if (_isFound) {
        className = @"Found";
    }else
        className = @"Lost";
    
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    [query orderByDescending:@"updatedAt"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array) {
            News *info    = [[News alloc] init];
            if ([obj objectForKey:@"title"]) {
                info.title    = [obj objectForKey:@"title"];
            }
            if ([obj objectForKey:@"describe"]) {
                info.content  = [obj objectForKey:@"describe"];
            }
            if ([obj objectForKey:@"phone"]) {
                info.phoneNum = [obj objectForKey:@"phone"];
            }
            info.time     = [_dateFormatter stringFromDate:obj.updatedAt];
            [_infoMutableArray addObject:info];
        }
        
        [_tableView reloadData];
    }];
    
}



#pragma mark - UITableView Datasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = 115.0f;
    
    
    
    return cellHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_infoMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    FoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[FoundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.frame        = CGRectMake(0, 114, 320, 1);
        lineImageView.image        = [UIImage imageNamed:@"line"];
        [cell.contentView addSubview:lineImageView];
    }
    
    News *info             = (News*)[_infoMutableArray objectAtIndex:indexPath.row];
    cell.titleLabel.text   = info.title;
    cell.contentLabel.text = info.content;
    cell.timeLabel.text    = info.time;
    cell.phoneButton.tag   = indexPath.row;
    [cell.phoneButton setTitle:info.phoneNum forState:UIControlStateNormal];
    [cell.phoneButton addTarget:self action:@selector(callSb:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark option
-(void)optionDidDismiss:(NSInteger)row optionView:(OptionView *)view{
    if (row == 0) {
        [_navigationButton setTitle:@"Found" forState:UIControlStateNormal];
        _isFound = YES;
    }else{
        [_navigationButton setTitle:@"Lost" forState:UIControlStateNormal];
        _isFound = NO;
    }
    
    [self seacrhTable];
}


-(void)callSb:(UIButton*)sender{
    News *info             = (News*)[_infoMutableArray objectAtIndex:sender.tag];
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                        message:[NSString stringWithFormat:@"电话%@",info.phoneNum]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
    [alertview show];
    
}

@end
