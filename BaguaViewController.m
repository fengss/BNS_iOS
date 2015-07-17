//
//  BaguaViewController.m
//  BnSBang
//
//  Created by coderss on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaguaViewController.h"
#import "BaguaDetailController.h"

@interface BaguaViewController ()

@end

@implementation BaguaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)createBgImgView
{
    UIImageView *bgImgV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgbagua"]];
    bgImgV.frame=CGRectMake(_cSize.width-100, _cSize.height-240, 160, 160);
    [self.view addSubview:bgImgV];
}

- (void)dataPrepare
{
    [self dataPrepareForResource:@"BaguaList"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor=[UIColor whiteColor];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *titleArray=@[@"白青山脉",@"水月平原",@"大漠",@"御龙林"];
    return titleArray[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaguaDetailController *baguaDtVC=[[BaguaDetailController alloc] init];
    baguaDtVC.model=_dataArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:baguaDtVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
