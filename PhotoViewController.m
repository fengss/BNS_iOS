//
//  PhotoViewController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "PhotoViewController.h"
#import "ImageModel.h"
#import "PhotoDetailController.h"
#import "MyFooterView.h"
#import "MyNavController.h"
static NSInteger _page[5]={1,1,1,1,1};

@interface PhotoViewController ()
{
    UICollectionView *_collectView;
    //NSMutableArray *_dataArray;
    CollectLayOut *_layout;
}
@end

@implementation PhotoViewController

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

- (void)titleSettings
{
    _titleArr=@[@"最新",@"捏脸",@"截图",@"COS",@"手绘"];
}

-(void)prepareData
{
    _imageStatus=0;
    _dataArray=[[NSMutableArray alloc] init];
    [self loadImageViewForColumn:0 andPage:1 Policy:NSURLRequestReturnCacheDataElseLoad];
}

-(void)loadImageViewForColumn:(NSInteger)column andPage:(NSInteger)page Policy:(NSURLRequestCachePolicy)policy
{
    NSString *imgUrl=[NSString stringWithFormat:PHOTO_URL,column,page];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:imgUrl] cachePolicy:policy completed:^(NSData *data) {
        NSArray *srcArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",srcArray);
        if (page==1) {
            [_dataArray removeAllObjects];
            _page[_imageStatus]=1;
        }
        if (srcArray) {
            for (NSDictionary *dic in srcArray) {
                ImageModel *imgModel=[[ImageModel alloc] init];
                [imgModel setValuesForKeysWithDictionary:dic];
                imgModel.uid=dic[@"id"];
                //CGSize imgSize=[UIImage downloadImageSizeWithURL:imgModel.cover_url];
                imgModel.cellHeight=150;
                [_dataArray addObject:imgModel];
            }
            //_layout.dataArray=_dataArray;
            [_collectView reloadData];
            [self stopLoading];
        }
        else{
            NSLog(@"the last one");
        }
        
    } failed:^{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哎呀!" message:@"您的网络有些问题，请稍后再试。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [self stopLoading];
    }];
}

-(void)createTableView
{
    _layout=[[CollectLayOut alloc] init];
    _layout.dataArray=_dataArray;
    
    
    _collectView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-40-64-49) collectionViewLayout:_layout];
    _collectView.backgroundColor=[UIColor clearColor];
    _collectView.dataSource=self;
    _collectView.delegate=self;
    
    [_collectView registerClass:[CollectViewCell class] forCellWithReuseIdentifier:@"collectid"];
    [self.view addSubview:_collectView];
    
    [_collectView registerNib:[UINib nibWithNibName:@"MyFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footview"];
    
    [self createRefreshView];
}

-(void)createRefreshView
{
    NSArray *nils=[[NSBundle mainBundle] loadNibNamed:@"RefreshView" owner:self options:nil];
    _refreshView=[nils firstObject];
    //_refreshView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [_refreshView setupWithOwner:_collectView delegate:self];
    [self startLoading];
}

-(void)topBtnAction:(UIButton *)sender
{
    [self startLoading];
    _imageStatus=sender.tag-20;
    
    [self loadImageViewForColumn:_imageStatus andPage:1 Policy:NSURLRequestReturnCacheDataElseLoad];
    
    for (int i=0; i<5; i++) {
        UIButton *btn=(UIButton *)[self.view viewWithTag:20+i];
        btn.selected=NO;
    }
    sender.selected=YES;
    [UIView animateWithDuration:0.4 animations:^{
        _selectedView.frame=CGRectMake((sender.tag-20)*_screenSize.width/5, 37, _screenSize.width/5, 3);
    }];
}


#pragma mark - UICollectionViewDataSource:
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectid" forIndexPath:indexPath];
    cell.model=_dataArray[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==_dataArray.count-1) {
        NSLog(@"hello");
        _page[_imageStatus]++;
        [self loadImageViewForColumn:_imageStatus andPage:_page[_imageStatus] Policy:NSURLRequestReturnCacheDataElseLoad];
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionReusableView *reusableView=nil;
    if (kind==UICollectionElementKindSectionFooter) {
        MyFooterView *footView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footview" forIndexPath:indexPath];
        //reusableView=footView;
        NSLog(@"%@",footView);
        return footView;
    }
    else{
        return nil;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"row=>%d",indexPath.row);
    PhotoDetailController *photoDtVC=[[PhotoDetailController alloc] init];
    photoDtVC.model=_dataArray[indexPath.row];
    photoDtVC.status=_imageStatus;
    MyNavController *navCtrl=[[MyNavController alloc] initWithRootViewController:photoDtVC];
    navCtrl.navigationBar.barStyle=UIBarStyleBlack;
    [self presentViewController:navCtrl animated:YES completion:nil];
}


-(void)refreshViewDidCallBack
{
    NSLog(@"call");
    [self startLoading];
    [self loadImageViewForColumn:_imageStatus andPage:1 Policy:NSURLRequestReloadIgnoringLocalCacheData];
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
