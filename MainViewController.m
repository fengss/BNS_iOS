//
//  MainViewController.m
//  BnSBang
//
//  Created by coderss on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "MainViewController.h"
#import "WeaponDetailController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    _cSize=[[UIScreen mainScreen] bounds].size;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=BG_COLOR;
    [self dataPrepare];
    [self createUI];
}

- (void)dataPrepare
{
    [self dataPrepareForResource:@"WeaponList"];
}

- (void)dataPrepareForResource:(NSString *)resource
{
    _dataArray=[[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] init],[[NSMutableArray alloc] init],[[NSMutableArray alloc] init],[[NSMutableArray alloc] init], nil];
    NSString *filePath=[[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@",array);
    for (NSDictionary *dic in array) {
        MainModel *model=[[MainModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray[[model.type intValue]] addObject:model];
    }
}




- (void)createUI
{
    UIImageView *bgLogoV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bglogo"]];
    bgLogoV.frame=CGRectMake(5, 0, 105, 52.5);
    [self.view addSubview:bgLogoV];
    
    [self createBgImgView];
    [self createTableView];
}

- (void)createBgImgView
{
    UIImageView *bgImgV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgweapon"]];
    bgImgV.frame=CGRectMake(_cSize.width-120, _cSize.height-300, 120, 210);
    [self.view addSubview:bgImgV];
}

- (void)createTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, _cSize.width, _cSize.height-49-50-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"weaponId";
    MainViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MainViewCell" owner:self options:nil] firstObject];
        //cell.backgroundColor=[UIColor clearColor];
    }
    cell.model=_dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    tableView.sectionIndexColor=[UIColor whiteColor];
    NSArray *titleArray=@[@"水月",@"白青S1",@"白青S2",@"白青S3"];
    return titleArray[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeaponDetailController *weaponDtVC=[[WeaponDetailController alloc] init];
    weaponDtVC.model=_dataArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:weaponDtVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
