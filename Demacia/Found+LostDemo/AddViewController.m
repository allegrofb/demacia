//
//  AddViewController.m
//  Found+Lost
//
//  Created by Bmob on 14-5-22.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "AddViewController.h"
#import <BmobSDK/Bmob.h>
@interface AddViewController (){
    BOOL    _isFound;
}

@end

@implementation AddViewController

-(instancetype)initWithFoundOrNot:(BOOL)found{
    self = [super init];
    if (self) {
        _isFound = found;
        
        UILabel      *titleLabel   = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font            = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor       = [UIColor whiteColor];
        titleLabel.frame           = CGRectMake(100, 0, 120, 44);
        titleLabel.textAlignment   = NSTextAlignmentCenter;
        if (found) {
            titleLabel.text = @"添加招领信息";
        }else{
            titleLabel.text = @"添加失物信息";
        }
        
        self.navigationItem.titleView = titleLabel;
        
        self.navigationItem.hidesBackButton = YES;
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(240, 244, 247);
    
    UIButton *leftBtn                      = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame                          = CGRectMake(0, 0, 50, 44);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"back_"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    [rightBtn setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"yes_"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    if (IS_iOS7) {
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    }
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.frame        = CGRectMake(0, ViewOrginY+24, 320, 128);
    backgroundImageView.image        = [[UIImage imageNamed:@"add_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.view addSubview:backgroundImageView];

    UITextField *titleTextField      = [[UITextField alloc] init];
    titleTextField.tag               = 100;
    titleTextField.frame             = CGRectMake(15, ViewOrginY+35, 290, 17);
    titleTextField.font              = [UIFont systemFontOfSize:15];
    titleTextField.placeholder       = @"请输入标题";
    [self.view addSubview:titleTextField];
    
    UITextField *phoneTextField      = [[UITextField alloc] init];
    phoneTextField.tag               = 101;
    phoneTextField.frame             = CGRectMake(15, ViewOrginY+73, 290, 17);
    phoneTextField.font              = [UIFont systemFontOfSize:15];
    phoneTextField.placeholder       = @"请输入手机";
    [self.view addSubview:phoneTextField];
    
    UITextField *desTextField      = [[UITextField alloc] init];
    desTextField.tag               = 102;
    desTextField.frame             = CGRectMake(15, ViewOrginY+110, 290, 17);
    desTextField.font              = [UIFont systemFontOfSize:15];
    desTextField.placeholder       = @"请输入描述";
    [self.view addSubview:desTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save{
    UITextField *titleTextField = (UITextField*)[self.view viewWithTag:100];
    UITextField *phoneTextField = (UITextField*)[self.view viewWithTag:101];
    UITextField *desTextField   = (UITextField*)[self.view viewWithTag:102];
    
    if ([titleTextField.text length] > 0 && [phoneTextField.text length] > 0 && [desTextField.text length] > 0) {
        NSString *className = @"";
        if (_isFound) {
            className = @"Found";
        }else
            className = @"Lost";
        
        BmobObject *obj = [[BmobObject alloc] initWithClassName:className];
        
        [obj setObject:titleTextField.text forKey:@"title"];
        [obj setObject:phoneTextField.text forKey:@"phone"];
        [obj setObject:desTextField.text forKey:@"describe"];
        
        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
           
            if (!error) {
                NSLog(@"提交成功");
                [self performSelector:@selector(goback) withObject:nil afterDelay:0.7f];
            }else{
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:[[error userInfo] objectForKey:@"error"]
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"ok", nil];
                [alertview show];
            }
            
        }];
        
    }
    
}

@end
