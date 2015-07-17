//
//  BBSDetailController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-13.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BBSDetailController.h"
#import "BBSDetailModel.h"
#import "BBSDetailViewCell.h"
#import "LoginViewController.h"
#import "BBSMoreController.h"


@interface BBSDetailController ()

@end

@implementation BBSDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createTopItems
{
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    count=0;
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(writeBBSArticle)];
    [self createLoadingBtn];
}

-(void)writeBBSArticle
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"需要登录多玩通行证才可发帖" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"登录" otherButtonTitles:nil, nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark - ActionSheetDelegate:
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        LoginViewController *loginVC=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *loginCtrl=[[UINavigationController alloc] initWithRootViewController:loginVC];
        loginCtrl.navigationBar.barStyle=UIBarStyleBlackOpaque;
        loginCtrl.navigationBar.tintColor=[UIColor whiteColor];
        loginCtrl.navigationBar.barTintColor=[UIColor colorWithRed:0 green:0.4 blue:0 alpha:1];
        [self presentViewController:loginCtrl animated:YES completion:nil];
    }
}

#pragma mark - Continue:
-(void)createLoadingBtn
{
    _indV=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _indV.frame=CGRectMake(0, 5, 30, 40);
    _tableView.tableFooterView=_indV;
    
    _loadBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loadBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [_loadBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _loadBtn.frame=CGRectMake(0, 0, self.view.bounds.size.width, 40);
    _loadBtn.backgroundColor=[UIColor whiteColor];
    _loadBtn.alpha=0.9;
    [_loadBtn addTarget:self action:@selector(onClickLoad) forControlEvents:UIControlEventTouchUpInside];
    //_tableView.tableFooterView=_loadBtn;
}

- (void)onClickLoad
{
    NSLog(@"loading");
    _BBSPage++;
    [self loadBBSDataWithPage:_BBSPage andFid:_fid];
    _tableView.tableFooterView=_indV;
    [_indV startAnimating];
}

- (void)prepareData
{
    _dataArray=[[NSMutableArray alloc] init];
    NSLog(@"%@",_fid);
    [self loadBBSDataWithPage:1 andFid:_fid];
}

- (void)loadBBSDataWithPage:(NSInteger)page andFid:(NSString *)fid
{
    NSString *urlStr=[NSString stringWithFormat:_bbsUrl,page,fid];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData completed:^(NSData *data) {
        NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (mainDic) {
            if (page==1) {
                [_dataArray removeAllObjects];
            }
            NSArray *srcArr=mainDic[@"Variables"][@"forum_threadlist"];
            for (NSDictionary *dic in srcArr) {
                BBSDetailModel *model=[[BBSDetailModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                if (_dataArray.count!=0) {
                    if ([model.subject isEqual:[_dataArray[0] subject]]) {
                        _tableView.tableFooterView=_loadBtn;
                        [_loadBtn setTitle:@"没有更多了" forState:UIControlStateNormal];
                        return;
                    }
                }
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        _tableView.tableFooterView=_loadBtn;
        [self stopLoading];
    } failed:^{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哎呀!" message:@"您的网络有些问题，请稍后再试。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        if (_BBSPage>1) {
            _BBSPage--;
        }
        _tableView.tableFooterView=_loadBtn;
        [self stopLoading];
    }];
}

- (void)createTableView
{
    [self createTableViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-49)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BBScellID=@"BBScellID";
    BBSDetailViewCell *cell=[tableView dequeueReusableCellWithIdentifier:BBScellID];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BBSDetailViewCell" owner:self options:nil] firstObject];
        cell.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    //cell.frame.size
    if (_dataArray.count!=0) {
        cell.model=_dataArray[indexPath.row];
    }
    
    NSString *str=cell.subjectLabel.text;
    CGSize newSize=[str sizeWithFont:cell.subjectLabel.font constrainedToSize:CGSizeMake(cell.subjectLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    //根据计算结果重新设置UILabel的尺寸
    cell.subjectLabel.frame=CGRectMake(cell.subjectLabel.frame.origin.x, cell.subjectLabel.frame.origin.y, cell.subjectLabel.frame.size.width, newSize.height);
    cell.headerView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row%10]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=[_dataArray[indexPath.row] subject];
    CGSize newSize=[str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(255, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    //根据计算结果重新设置UILabel的尺寸
    if (newSize.height<20) {
        return 50+([[_dataArray[indexPath.row] imagelist] count]==0?0:100);
    }
    else{
        return 30+newSize.height+([[_dataArray[indexPath.row] imagelist] count]==0?0:100);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBSMoreController *bbsMoreVC=[[BBSMoreController alloc] init];
    bbsMoreVC.fid=[_dataArray[indexPath.row] tid];
    bbsMoreVC.bbsUrl=BBS_MORE_URL;
    [self.navigationController pushViewController:bbsMoreVC animated:YES];
}

static NSInteger count=0;
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //count=indexPath.row;
    if (indexPath.row==_dataArray.count-1) {
        [self onClickLoad];
    }
    if (indexPath.row>count) {
        cell.alpha=0;
        cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y+10, cell.frame.size.width, cell.frame.size.height+20);
        [UIView animateWithDuration:0.5 animations:^{
            cell.alpha=1;
            cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y-10, cell.frame.size.width, cell.frame.size.height-20);
        }];
        count=indexPath.row;
    }
    
}

-(void)refreshViewDidCallBack
{
    //NSLog(@"call back");
    [self startLoading];
    [self loadBBSDataWithPage:1 andFid:_fid];
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
