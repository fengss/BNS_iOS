//
//  LoginViewController.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

- (IBAction)loginAction:(UIButton *)sender;

@end
