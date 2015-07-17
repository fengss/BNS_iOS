//
//  BnsViewController.m
//  BnSBang
//
//  Created by coderss on 14-10-30.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BnsViewController.h"
#import "BnsModel.h"
#import "BnsViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"



@interface BnsViewController () <RefreshViewDelegate>
{
    UIView *_topView;
    
    UIActivityIndicatorView *_loadView;
    UILabel *_noMoreLabel;
}
@end

@implementation BnsViewController

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
    _viewStatus=0;
    _screenSize=self.view.bounds.size;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]];
    [self titleSettings];
    // Do any additional setup after loading the view.
    [self prepareData];
    [self uiconfig];
}

-(void)titleSettings
{
    _titleArr=@[@"新闻",@"活动",@"公告",@"韩服",@"更多"];
}

- (void)getUrlWithBody:(NSString *)body cachePolicy:(NSURLRequestCachePolicy)policy
{
    [[HttpRequestManager sharedManager]POSTUrl:[NSURL URLWithString:POST_URL] WithBody:body cachePolicy:policy completed:^(NSData *data) {
        NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        if (_dataArray.count!=0 && [[_dataArray[0] uid] isEqualToString:array[0][@"id"]]) {
//            NSLog(@"%@ %@",[_dataArray[0] uid],array[0][@"id"]);
//        }
//        else{
            [_dataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                BnsModel *bnsModel=[[BnsModel alloc] init];
                [bnsModel setValuesForKeysWithDictionary:dic];
                bnsModel.uid=dic[@"id"];
                [_dataArray addObject:bnsModel];
                [_tableView reloadData];
                _tableView.tableFooterView=_noMoreLabel;
            }
        //}
        [self stopLoading];
        //NSLog(@"%@",_dataArray);
    } failed:^{
        NSLog(@"load failed");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哎呀!" message:@"您的网络有些问题，请稍后再试。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [self stopLoading];
    }];
}


- (void)prepareData
{
    _scrollArray=[[NSMutableArray alloc] init];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:_scrollUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData completed:^(NSData *data) {
        NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in array) {
            BnsModel *bnsModel=[[BnsModel alloc] init];
            [bnsModel setValuesForKeysWithDictionary:dict];
            bnsModel.uid=dict[@"id"];
            [_scrollArray addObject:bnsModel];
            [self createScrollView];
        }
    } failed:^{
        NSLog(@"FAIL");
    }];
    _dataArray=[[NSMutableArray alloc] init];
    [self getUrlWithBody:_bodyArr[0] cachePolicy:NSURLRequestReturnCacheDataElseLoad];
}

- (void)uiconfig
{
    [self createTopItems];
    [self createTableView];
    
    _noMoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _noMoreLabel.font=[UIFont systemFontOfSize:15];
    _noMoreLabel.textAlignment=NSTextAlignmentCenter;
    _noMoreLabel.textColor=[UIColor darkGrayColor];
    _noMoreLabel.text=@"已经是最后一条了";
}

- (void)createTopItems
{
    _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _screenSize.width, 40)];
    _topView.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self.view addSubview:_topView];
    
    _selectedView=[[UIView alloc] initWithFrame:CGRectMake(0, 37, _screenSize.width/5, 3)];
    _selectedView.backgroundColor=TOPCOLOR;
    [_topView addSubview:_selectedView];
    
    for (int i=0; i<5; i++) {
        UIButton *topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.tag=20+i;
        topBtn.highlighted=NO;
        topBtn.frame=CGRectMake(i*_screenSize.width/5, 0, _screenSize.width/5, 40);
        topBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [topBtn setTitle:_titleArr[i] forState:UIControlStateNormal];
        topBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [topBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [topBtn setTitleColor:TOPCOLOR forState:UIControlStateSelected];
        [topBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:topBtn];
        
        if (i==0) {
            [topBtn setSelected:YES];
        }
    }
}

-(void)topBtnAction:(UIButton *)sender
{
    [self startLoading];
    _viewStatus=sender.tag-20;
    //NSLog(@"%d",_viewStatus);
    [self getUrlWithBody:_bodyArr[_viewStatus] cachePolicy:NSURLRequestReturnCacheDataElseLoad];
    
    if (_viewStatus!=0) {
        _tableView.tableHeaderView=nil;
    }
    else{
        if (!_tableView.tableHeaderView) {
            _tableView.tableHeaderView=_scrollView;
        }
    }
    
    for (int i=0; i<5; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:20+i];
        btn.selected=NO;
    }
    sender.selected=YES;
    [UIView animateWithDuration:0.4 animations:^{
        _selectedView.frame=CGRectMake((sender.tag-20)*_screenSize.width/5, 37, _screenSize.width/5, 3);
    }];
}

- (void)createScrollView
{
    _scrollView=[[MyScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160) andPictures:_scrollArray];
    _scrollView.delegate=self;
    _tableView.tableHeaderView=_scrollView;
}

#pragma mark - PushViewDelegate:
-(void)pushNextViewWithModel:(BnsModel *)model
{
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.model=model;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - UITableView:
- (void)createTableView
{
    [self createTableViewWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40-64-49)];
}

- (void)createTableViewWithFrame:(CGRect)frame
{
    _tableView=[[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    [self createRefreshView];
}

- (void)createRefreshView
{
    NSArray *nils=[[NSBundle mainBundle] loadNibNamed:@"RefreshView" owner:self options:nil];
    _refreshView=[nils firstObject];
    //_refreshView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [_refreshView setupWithOwner:_tableView delegate:self];
    [self startLoading];
}

- (void)startLoading
{
    [_refreshView startLoading];
    _isRefreshing=YES;
}

- (void)stopLoading
{
    if (_isRefreshing) {
        [_refreshView stopLoading];
        _isRefreshing=NO;
    }
}

#pragma mark - RefreshViewDelegate:
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_refreshView scrollViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshView scrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

-(void)refreshViewDidCallBack
{
    NSLog(@"call back");
    [self startLoading];
    [self getUrlWithBody:_bodyArr[_viewStatus] cachePolicy:NSURLRequestReloadIgnoringCacheData];
}

#pragma mark - UITableViewDataSource & Delegate:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    BnsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BnsViewCell" owner:self options:nil]firstObject];
        cell.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    
    if (_dataArray.count!=0) {
        cell.model=_dataArray[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC=[[DetailViewController alloc] init];
    detailVC.model=_dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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
