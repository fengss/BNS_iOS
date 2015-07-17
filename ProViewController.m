//
//  ProViewController.m
//  BnSBang
//
//  Created by coderss on 14-11-6.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "ProViewController.h"
#import "ProViewCell.h"
#import "ProModel.h"
#import "ListViewController.h"

@interface ProViewController () <PushViewControllerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation ProViewController

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
    self.title=@"职业视频";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
    // Do any additional setup after loading the view.
    [self dataSettings];
    [self createUI];
}

- (void)dataSettings
{
    _dataArray=[[NSMutableArray alloc] init];
    NSString *strPath=[[NSBundle mainBundle] pathForResource:@"ProList" ofType:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:strPath];
    for (NSDictionary *dic in array) {
        ProModel *model=[[ProModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
}

- (void)createUI
{
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableView:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"proID";
    ProViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ProViewCell" owner:self options:nil]firstObject];
        cell.delegate=self;
    }
    cell.model=_dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - PushViewControllerDelegate:

-(void)pushNextViewControllerWithUrl:(NSString *)url andName:(NSString *)name andType:(NSString *)type
{
    ListViewController *listVC=[[ListViewController alloc] init];
    listVC.bodyArr=@[url];
    listVC.title=[NSString stringWithFormat:@"%@-%@",name,type];
    [self.navigationController pushViewController:listVC animated:YES];
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
