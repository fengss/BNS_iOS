//
//  LoginViewController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.title=@"登录";
    // Do any additional setup after loading the view from its nib.
    _userField.delegate=self;
    _pwdField.delegate=self;
    [self createBarBtnItems];
}

- (void)createBarBtnItems
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(registerAction)];
}

- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAction
{
    RegisterViewController *registerVC=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(UIButton *)sender
{
    if (_userField.text.length==0 || _pwdField.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSLog(@"login Ok");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"0_0!" message:@"由于多玩登录请求数据被加密，该功能暂无法实现，尽情谅解。" delegate:self cancelButtonTitle:@"去死吧，大骗子!" otherButtonTitles:nil, nil];
        [alert show];
        [_userField resignFirstResponder];
        [_pwdField resignFirstResponder];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userField resignFirstResponder];
    [_pwdField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_userField) {
        [_pwdField becomeFirstResponder];
    }
    else if (textField==_pwdField){
        [_pwdField resignFirstResponder];
    }
    return YES;
}

@end
