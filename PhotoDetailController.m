//
//  PhotoDetailController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-11.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "PhotoDetailController.h"
#import "MoreViewController.h"

@interface PhotoDetailController ()
{
    UICollectionView *_collectView;
    NSMutableArray *_srcArray;
    CollectLayOut *_layout;
    UIView *_tabBarView;
    
    UILabel *_titleLabel;
    UILabel *_authorLabel;
}
@end

@implementation PhotoDetailController

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
    self.title=@"图集详情";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backAction)];
    // Do any additional setup after loading the view.
    //_collectView.frame=self.view.bounds;
    
    [self createTabBarView];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createTabBarView
{
    _tabBarView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 49)];
    _tabBarView.backgroundColor=[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.9];
    [self.view addSubview:_tabBarView];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 3, 240, 35)];
    //_titleLabel.backgroundColor=[UIColor redColor];
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _titleLabel.textColor=[UIColor whiteColor];
    _titleLabel.numberOfLines=2;
    _titleLabel.text=_model.title;
    [_tabBarView addSubview:_titleLabel];
    
    _authorLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-70, 30, 60, 15)];
    //_authorLabel.backgroundColor=[UIColor yellowColor];
    _authorLabel.textColor=[UIColor whiteColor];
    _authorLabel.text=[@"No." stringByAppendingString:_model.uid];
    _authorLabel.font=[UIFont systemFontOfSize:12];
    [_tabBarView addSubview:_authorLabel];
    
    [UIView animateWithDuration:0.6 delay:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _tabBarView.frame=CGRectMake(0, self.view.bounds.size.height-49, self.view.bounds.size.width, 49);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)uiconfig
{
    [self createTableView];
}

-(void)createTableView
{
    _layout=[[CollectLayOut alloc] init];
    _layout.dataArray=_srcArray;
    
    
    _collectView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_layout];
    _collectView.backgroundColor=[UIColor clearColor];
    _collectView.dataSource=self;
    _collectView.delegate=self;
    
    [_collectView registerClass:[CollectViewCell class] forCellWithReuseIdentifier:@"collectdtid"];
    [self.view addSubview:_collectView];
    
    [self createRefreshView];
}


-(void)prepareData
{
    _srcArray=[[NSMutableArray alloc] init];
    [self loadImageViewForColumn:_status andPage:[_model.uid intValue] Policy:NSURLRequestReturnCacheDataElseLoad];
}

-(void)loadImageViewForColumn:(NSInteger)column andPage:(NSInteger)page Policy:(NSURLRequestCachePolicy)policy
{
    NSString *imgUrl=[NSString stringWithFormat:PHOTO_DETAIL_URL,column,page];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:imgUrl] cachePolicy:policy completed:^(NSData *data) {
        NSArray *srcArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",srcArray);
        if (srcArray) {
            for (NSDictionary *dic in srcArray) {
                ImageModel *imgModel=[[ImageModel alloc] init];
                [imgModel setValuesForKeysWithDictionary:dic];
                imgModel.uid=dic[@"pic_id"];
                imgModel.cellHeight = [imgModel.file_height floatValue]/[imgModel.file_width floatValue]*150 + 10;
                [_srcArray addObject:imgModel];
            }
            
            [_collectView reloadData];
        }
        else{
            NSLog(@"no data");
        }
        
    } failed:^{
        NSLog(@"fffff");
    }];
}

#pragma mark - UICollectionViewDataSource:
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _srcArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectdtid" forIndexPath:indexPath];
    cell.model=_srcArray[indexPath.row];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"row=>%d",indexPath.row);
    MoreViewController *moreVC=[[MoreViewController alloc] init];
    moreVC.dataArray=_srcArray;
    moreVC.imgNum=indexPath.row;
    moreVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    UINavigationController *moreCtrl=[[UINavigationController alloc] initWithRootViewController:moreVC];
    moreCtrl.navigationBar.barStyle=UIBarStyleBlack;
    moreCtrl.navigationBar.tintColor=[UIColor whiteColor];
    [self presentViewController:moreCtrl animated:YES completion:nil];
}







-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createRefreshView
{
    
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
