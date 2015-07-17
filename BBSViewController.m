//
//  BBSViewController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-12.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BBSViewController.h"
#import "HttpRequestManager.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "BBSDetailController.h"
#import "BBSModel.h"

@interface BBSViewController ()
{
    UITableView *_tableView;
    UIView *_headerView;
    UIImageView *_iconView;
    UILabel *_userLabel;
    NSMutableArray *_dataArray;
}
@end

@implementation BBSViewController

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
    [self dataPrepare];
    [self createUI];
}

- (void)loginAction
{
    NSLog(@"login");
    LoginViewController *loginVC=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *loginCtrl=[[UINavigationController alloc] initWithRootViewController:loginVC];
    loginCtrl.navigationBar.barStyle=UIBarStyleBlackOpaque;
    loginCtrl.navigationBar.tintColor=[UIColor whiteColor];
    loginCtrl.navigationBar.barTintColor=[UIColor colorWithRed:0 green:0.4 blue:0 alpha:1];
    [self presentViewController:loginCtrl animated:YES completion:nil];
}

- (void)dataPrepare
{
    _dataArray=[[NSMutableArray alloc] init];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:BBS_URL] cachePolicy:NSURLRequestReturnCacheDataElseLoad completed:^(NSData *data) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *srcArray=dict[@"Variables"][@"sublist"];
        [_iconView setImageWithURL:[NSURL URLWithString:dict[@"Variables"][@"forum"][@"forumicon"]] placeholderImage:[UIImage imageNamed:@"image"]];
        for (NSDictionary *srcDic in srcArray) {
            BBSModel *model=[[BBSModel alloc] init];
            [model setValuesForKeysWithDictionary:srcDic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        _userLabel.text=@"未登录";
    } failed:^{
        NSLog(@"Oops!");
        _userLabel.text=@"加载失败";
    }];
}

- (void)createUI
{
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.alpha=0.9;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    _headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    _headerView.backgroundColor=[UIColor whiteColor];
    _tableView.tableHeaderView=_headerView;
    
    _iconView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    [_headerView addSubview:_iconView];
    
    UIImageView *logoView=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-110, 5, 100, 50)];
    logoView.image=[UIImage imageNamed:@"bglogoblack"];
    [_headerView addSubview:logoView];
    
    _userLabel=[[UILabel alloc] initWithFrame:CGRectMake(70, 5, 140, 30)];
    _userLabel.textColor=[UIColor darkGrayColor];
    _userLabel.text=@"正在加载...";
    [_headerView addSubview:_userLabel];
}

#pragma mark - UITableViewDataSource:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"bbsid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text=[_dataArray[indexPath.row] name];
    cell.detailTextLabel.text=[_dataArray[indexPath.row] todayposts];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *fidArray=@[@"1642",@"401",@"1924",@"1981",@"1848",@"2028"];
    BBSDetailController *bbsDtVC=[[BBSDetailController alloc] init];
    bbsDtVC.fid=fidArray[indexPath.row];
    bbsDtVC.bbsUrl=BBS_DETAIL_URL;
    bbsDtVC.title=[_dataArray[indexPath.row] name];
    [self.navigationController pushViewController:bbsDtVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
