//
//  DMCLoginViewController.m
//  Demacia
//
//  Created by Hongyong Jiang on 05/11/14.
//  Copyright (c) 2014年 Demacia.cc. All rights reserved.
//

#import "DMCLoginViewController.h"
#import "EMError.h"
#import "DMCDatastore.h"
#import "DMCUserHelper.h"
#import "DMCKeyChainUtil.h"

@interface DMCLoginViewController()<IChatManagerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)doRegister:(id)sender;
- (IBAction)doLogin:(id)sender;


@end

@implementation DMCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    _usernameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doRegister:(id)sender
{
    if (![self isEmpty])
    {
        [self.view endEditing:YES];
        if ([self.usernameTextField.text isChinese])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"用户名不支持中文"
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            
            [alert show];
            
            return;
        }
        
        [self showHudInView:self.view hint:@"正在注册..."];
        
        NSString* username = _usernameTextField.text;
        NSString* password = _passwordTextField.text;
        
        [self signupWithUsername:username password:password];
     
    }
}


- (void)signupWithUsername:(NSString *)username password:(NSString *)password
{
    
    [[DMCDatastore sharedInstance] signUp:username password:password block:^(BmobObject *userInfo, BOOL isSuccessful, NSError *error) {
        
        if(isSuccessful)
        {
            [DMCUserHelper sharedInstance].userInfo = userInfo;
            
            [[DMCKeyChainUtil sharedObject] setUserName:username];
            [[DMCKeyChainUtil sharedObject] setPassword:password];
            
            TTAlertNoTitle(@"注册成功,请登录");
            
            [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userInfo.objectId password:userInfo.objectId withCompletion:
             ^(NSString *username, NSString *password, EMError *error)
             {
                 if (error)
                 {
                     [self hideHud];
                     
                     switch (error.errorCode) {
                         case EMErrorServerNotReachable:
                             TTAlertNoTitle(@"连接服务器失败!");
                             break;
                         case EMErrorServerDuplicatedAccount:
                             TTAlertNoTitle(@"您注册的用户已存在!");
                             break;
                         case EMErrorServerTimeout:
                             TTAlertNoTitle(@"连接服务器超时!");
                             break;
                         default:
                             TTAlertNoTitle(@"注册失败");
                             break;
                     }
                 }
                 else
                 {
                     //signin
                     [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userInfo.objectId password:userInfo.objectId completion:
                      ^(NSDictionary *loginInfo, EMError *error)
                      {
                          [self hideHud];
                          if (loginInfo && !error)
                          {
                              [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                          }
                          else
                          {
//                              switch (error.errorCode)
//                              {
//                                  case EMErrorServerNotReachable:
//                                      TTAlertNoTitle(@"连接服务器失败!");
//                                      break;
//                                  case EMErrorServerAuthenticationFailure:
//                                      TTAlertNoTitle(@"用户名或密码错误");
//                                      break;
//                                  case EMErrorServerTimeout:
//                                      TTAlertNoTitle(@"连接服务器超时!");
//                                      break;
//                                  default:
//                                      TTAlertNoTitle(@"登录失败");
//                                      break;
//                              }
                          }
                      } onQueue:nil];
                     
                 }
             } onQueue:nil];
            
        }
        else
        {
            [self hideHud];
            
            switch (error.code)
            {
                case DMCErrorUserNameTaken:
                    TTAlertNoTitle(@"用户名已经存在");
                    break;
                case DMCErrorConnectionFailure:
                    TTAlertNoTitle(@"连接服务器失败!");
                    break;
                default:
                {
                    NSString* msg = [NSString stringWithFormat:@"注册失败, 故障码：%ld",(long)error.code];
                    TTAlertNoTitle(msg);
                    break;
                }
            }
            
        }
        
    }];
    
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:@"正在登录..."];
    
    [[DMCDatastore sharedInstance]signIn:username password:password block:^(BmobObject *userInfo, BOOL isSuccessful, NSError *error)
    {
        if(isSuccessful)
        {
            [DMCUserHelper sharedInstance].userInfo = userInfo;
            
            [[DMCKeyChainUtil sharedObject] setUserName:username];
            [[DMCKeyChainUtil sharedObject] setPassword:password];
            
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userInfo.objectId password:userInfo.objectId completion:
                 ^(NSDictionary *loginInfo, EMError *error)
                {
                     [self hideHud];
                     if (loginInfo && !error)
                     {
                         [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                     }
                     else
                     {
                         switch (error.errorCode)
                         {
                             case EMErrorServerNotReachable:
                                 TTAlertNoTitle(@"连接服务器失败!");
                                 break;
                             case EMErrorServerAuthenticationFailure:
                                 TTAlertNoTitle(@"用户名或密码错误");
                                 break;
                             case EMErrorServerTimeout:
                                 TTAlertNoTitle(@"连接服务器超时!");
                                 break;
                             default:
                                 TTAlertNoTitle(@"登录失败");
                                 break;
                         }
                     }
                 } onQueue:nil];
            
        }
        else
        {
            [self hideHud];
            
            switch (error.code)
            {
               case DMCErrorConnectionFailure:
                   TTAlertNoTitle(@"连接服务器失败!");
                   break;
               default:
               {
                   NSString* msg = [NSString stringWithFormat:@"注册失败, 故障码：%ld",(long)error.code];
                   TTAlertNoTitle(msg);
                   break;
               }
            }
        }
        
    }];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *nameTextField = [alertView textFieldAtIndex:0];
        if(nameTextField.text.length > 0)
        {
            [[EaseMob sharedInstance].chatManager setNickname:nameTextField.text];
        }
    }
    
    [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
}

- (IBAction)doLogin:(id)sender
{
    if (![self isEmpty])
    {
        [self.view endEditing:YES];
        if ([self.usernameTextField.text isChinese])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"用户名不支持中文"
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            
            [alert show];
            
            return;
        }
#if !TARGET_IPHONE_SIMULATOR
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"填写推送消息时使用的昵称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *nameTextField = [alert textFieldAtIndex:0];
        nameTextField.text = self.usernameTextField.text;
        [alert show];
#elif TARGET_IPHONE_SIMULATOR
        [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
#endif
    }
}


- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    if (username.length == 0 || password.length == 0) {
        ret = YES;
        [WCAlertView showAlertWithTitle:@"提示"
                                message:@"请输入账号和密码"
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
    }
    
    return ret;
}


#pragma  mark - TextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _usernameTextField) {
        _passwordTextField.text = @"";
    }
    
    return YES;
}

@end