//
//  EquipViewController.m
//  BnSBang
//
//  Created by coderss on 14-11-5.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "EquipViewController.h"
#import "SrcViewController.h"
#import "MainViewController.h"
#import "JewelryViewController.h"
#import "BaguaViewController.h"

@interface EquipViewController ()
{
    UIButton *_weaponBtn;
    UIButton *_jewelryBtn;
    UIButton *_baguaBtn;
}
@end

@implementation EquipViewController

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
    // Do any additional setup after loading the view.
    [self createBarBtns];
    [self configBtns];
}

- (void)createBarBtns
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_gl"] style:UIBarButtonItemStylePlain target:self action:@selector(switchToGrowthTree)];
}

- (void)switchToGrowthTree
{
    SrcViewController *srcVC=[[SrcViewController alloc] init];
    srcVC.edgesForExtendedLayout=UIRectEdgeNone;
    [self.navigationController pushViewController:srcVC animated:YES];
}

- (void)configBtns
{
    CGFloat height1,height2,height3;
    CGFloat screenWidth=self.view.bounds.size.width;
    CGFloat screenHeight=self.view.bounds.size.height;
    BOOL is4_inch=screenHeight==568;
    NSLog(@"%.2f %d",screenHeight,is4_inch);
    
    height1=is4_inch?76:16.5;
    height2=is4_inch?208:133;
    height3=is4_inch?340:249.5;
    
    UIButton *bgBtn;
    
    if (is4_inch) {
        [self createBtns:bgBtn withFrame:CGRectMake(-screenWidth, 0, screenWidth, 60) angImage:nil Tag:0 Delay:2 Enabled:NO];
    }
    
    [self createBtns:bgBtn withFrame:CGRectMake(-screenWidth, height1-16, screenWidth, 132) angImage:@"btnbgimg" Tag:0 Delay:1.2 Enabled:NO];
    [self createBtns:bgBtn withFrame:CGRectMake(screenWidth, height2-16, screenWidth, 132) angImage:@"btnbgimg" Tag:0 Delay:1.2 Enabled:NO];
    [self createBtns:bgBtn withFrame:CGRectMake(-screenWidth, height3-16, screenWidth, 132) angImage:@"btnbgimg" Tag:0 Delay:1.2 Enabled:NO];
    
    
    [self createBtns:_weaponBtn withFrame:CGRectMake(-screenWidth, height1, screenWidth, 100) angImage:@"weaponimg" Tag:300 Delay:0 Enabled:YES];
    [self createBtns:_jewelryBtn withFrame:CGRectMake(screenWidth, height2, screenWidth, 100) angImage:@"jewelryimg" Tag:301 Delay:0.3 Enabled:YES];
    [self createBtns:_baguaBtn withFrame:CGRectMake(-screenWidth, height3, screenWidth, 100) angImage:@"baguaimg" Tag:302 Delay:0.6 Enabled:YES];
    
}

- (void)createBtns:(UIButton *)button withFrame:(CGRect)frame angImage:(NSString *)imgName Tag:(NSInteger)tag Delay:(NSTimeInterval)delay Enabled:(BOOL)enabled
{
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.alpha=0;
    button.tag=tag;
    button.userInteractionEnabled=enabled;
    if (imgName) {
        [button setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    else{
        [button setBackgroundColor:[UIColor colorWithRed:0.2353 green:0.2353 blue:0.2353 alpha:1]];
        UIImageView *logoView=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-120, 0, 120, 60)];
        logoView.image=[UIImage imageNamed:@"bglogo"];
        [button addSubview:logoView];
    }
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [UIView animateWithDuration:0.8 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (button.frame.origin.x==self.view.bounds.size.width && button.frame.size.width==self.view.bounds.size.width/2) {
            button.frame=CGRectMake(self.view.bounds.size.width/2, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
        }
        else{
            button.frame=CGRectMake(0, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
        }
        button.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            button.alpha=0.9;
        }];
    }];
}

- (void)clickAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        sender.frame=CGRectMake(self.view.bounds.size.width, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
    } completion:^(BOOL finished) {
        if (sender.tag==300) {
            MainViewController *mainVC=[[MainViewController alloc] init];
            mainVC.title=@"武器";
            mainVC.edgesForExtendedLayout=UIRectEdgeNone;
            [self.navigationController pushViewController:mainVC animated:YES];
        }
        else if(sender.tag==301){
            JewelryViewController *jewelVC=[[JewelryViewController alloc] init];
            jewelVC.title=@"首饰";
            jewelVC.edgesForExtendedLayout=UIRectEdgeNone;
            [self.navigationController pushViewController:jewelVC animated:YES];
        }
        else if(sender.tag==302){
            BaguaViewController *baguaVC=[[BaguaViewController alloc] init];
            baguaVC.title=@"八卦牌";
            baguaVC.edgesForExtendedLayout=UIRectEdgeNone;
            [self.navigationController pushViewController:baguaVC animated:YES];
        }
        [UIView animateWithDuration:0.8 animations:^{
            sender.frame=CGRectMake(0, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height);
        }];
    }];
    
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
