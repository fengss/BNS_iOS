//
//  MyTabBarController.m
//  BnSBang
//
//  Created by coderss on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "MyTabBarController.h"
#import "BnsViewController.h"
#import "VideoViewController.h"
#import "PhotoViewController.h"
#import "EquipViewController.h"
#import "BBSViewController.h"

@interface MyTabBarController ()
{
    BnsViewController *_bnsVC;
    VideoViewController *_videoVC;
    PhotoViewController *_photoVC;
    EquipViewController *_equipVC;
    BBSViewController *_bbsVC;
}
@end

@implementation MyTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //self.tabBar.barStyle=UIBarStyleBlack;
    self.tabBar.selectedImageTintColor=TOPCOLOR;
    // Do any additional setup after loading the view.
    
    _bnsVC=[[BnsViewController alloc] init];
    _bnsVC.title=@"剑灵";
    _bnsVC.edgesForExtendedLayout=UIRectEdgeNone;
    _bnsVC.bodyArr=@[BODY_1,BODY_2,BODY_3,BODY_4,BODY_5];
    _bnsVC.scrollUrl=SCROLL_URL;
    UINavigationController *bnsCtrl=[[UINavigationController alloc] initWithRootViewController:_bnsVC];
    bnsCtrl.navigationBar.barStyle=UIBarStyleBlack;
    bnsCtrl.navigationBar.barTintColor=TOPCOLOR;
    bnsCtrl.navigationBar.tintColor=[UIColor whiteColor];
    bnsCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"剑灵" image:[UIImage imageNamed:@"tabbar_bns"] selectedImage:[UIImage imageNamed:@"tabbar_bns"]];
    
    _videoVC=[[VideoViewController alloc] init];
    _videoVC.title=@"视频";
    _videoVC.edgesForExtendedLayout=UIRectEdgeNone;
    _videoVC.bodyArr=@[BODY_VIDEO_1,BODY_VIDEO_2,BODY_VIDEO_3,BODY_VIDEO_4,BODY_VIDEO_5];
    _videoVC.scrollUrl=SCROLL_VIDEO_URL;
    UINavigationController *videoCtrl=[[UINavigationController alloc] initWithRootViewController:_videoVC];
    videoCtrl.navigationBar.barStyle=UIBarStyleBlack;
    videoCtrl.navigationBar.barTintColor=TOPCOLOR;
    videoCtrl.navigationBar.tintColor=[UIColor whiteColor];
    videoCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"视频" image:[UIImage imageNamed:@"tabbar_video"] selectedImage:[UIImage imageNamed:@"tabbar_video"]];
    
    _photoVC=[[PhotoViewController alloc] init];
    _photoVC.title=@"图集";
    _photoVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *photoCtrl=[[UINavigationController alloc] initWithRootViewController:_photoVC];
    photoCtrl.navigationBar.barStyle=UIBarStyleBlack;
    photoCtrl.navigationBar.barTintColor=TOPCOLOR;
    photoCtrl.navigationBar.tintColor=[UIColor whiteColor];
    photoCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"图集" image:[UIImage imageNamed:@"tabbar_pic"] selectedImage:[UIImage imageNamed:@"tabbar_pic"]];
    
    _equipVC=[[EquipViewController alloc] init];
    _equipVC.title=@"装备";
    _equipVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *equipCtrl=[[UINavigationController alloc] initWithRootViewController:_equipVC];
    equipCtrl.navigationBar.barStyle=UIBarStyleBlack;
    equipCtrl.navigationBar.barTintColor=TOPCOLOR;
    equipCtrl.navigationBar.tintColor=[UIColor whiteColor];
    equipCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"装备" image:[UIImage imageNamed:@"tabbar_gl"] selectedImage:[UIImage imageNamed:@"tabbar_gl"]];
    
    _bbsVC=[[BBSViewController alloc] init];
    _bbsVC.title=@"社区";
    _bbsVC.edgesForExtendedLayout=UIRectEdgeNone;
    UINavigationController *bbsCtrl=[[UINavigationController alloc] initWithRootViewController:_bbsVC];
    bbsCtrl.navigationBar.barStyle=UIBarStyleBlack;
    bbsCtrl.navigationBar.barTintColor=TOPCOLOR;
    bbsCtrl.navigationBar.tintColor=[UIColor whiteColor];
    bbsCtrl.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"社区" image:[UIImage imageNamed:@"tabbar_bbs"] selectedImage:[UIImage imageNamed:@"tabbar_bbs"]];
    
    NSArray *controllers=@[bnsCtrl,videoCtrl,photoCtrl,equipCtrl,bbsCtrl];
    self.viewControllers=controllers;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
