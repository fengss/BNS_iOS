//
//  JewelryViewController.m
//  BnSBang
//
//  Created by coderss on 14-11-4.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "JewelryViewController.h"

@interface JewelryViewController ()

@end

@implementation JewelryViewController

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
    // Do any additional setup after loading the view.
}

- (void)createBgImgView
{
    UIImageView *bgImgV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgjewelry"]];
    bgImgV.frame=CGRectMake(_cSize.width-100, _cSize.height-250, 120, 210);
    [self.view addSubview:bgImgV];
}

- (void)dataPrepare
{
    [self dataPrepareForResource:@"JewelryList"];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
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
