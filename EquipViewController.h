//
//  EquipViewController.h
//  BnSBang
//
//  Created by coderss on 14-11-5.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipViewController : UIViewController

- (void)configBtns;
- (void)createBarBtns;
- (void)createBtns:(UIButton *)button withFrame:(CGRect)frame angImage:(NSString *)imgName Tag:(NSInteger)tag Delay:(NSTimeInterval)delay Enabled:(BOOL)enabled;
- (void)clickAction:(UIButton *)sender;

@end
