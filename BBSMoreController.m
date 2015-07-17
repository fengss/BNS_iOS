//
//  BBSMoreController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-14.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BBSMoreController.h"
#import "BBSMoreModel.h"
#import "BBSMoreViewCell.h"

@interface BBSMoreController ()
{
    UIView *_tableHeader;
    UILabel *_titleLabel;
    UILabel *_infoLabel;
}
@end

@implementation BBSMoreController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)createTopItems
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"帖子详情";
    // Do any additional setup after loading the view.
    [self createHeaderItems];
}

-(void)createHeaderItems
{
    _tableHeader=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 75)];
    _tableHeader.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    _tableView.tableHeaderView=_tableHeader;
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 8, self.view.bounds.size.width-20, 40)];
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines=2;
    [_tableHeader addSubview:_titleLabel];
    
    _infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 55, 200, 12)];
    _infoLabel.font=[UIFont systemFontOfSize:12];
    _infoLabel.textColor=[UIColor darkGrayColor];
    [_tableHeader addSubview:_infoLabel];
}

- (void)loadBBSDataWithPage:(NSInteger)page andFid:(NSString *)fid
{
    NSString *urlStr=[NSString stringWithFormat:self.bbsUrl,page,fid];
    [[HttpRequestManager sharedManager] GETUrl:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData completed:^(NSData *data) {
        NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (mainDic) {
            if (page==1) {
                [_dataArray removeAllObjects];
            }
            
            _titleLabel.text=mainDic[@"Variables"][@"thread"][@"subject"];
            _infoLabel.text=[NSString stringWithFormat:@"浏览: %@  评论: %@",mainDic[@"Variables"][@"thread"][@"views"],mainDic[@"Variables"][@"thread"][@"replies"]];
            
            NSArray *srcArr=mainDic[@"Variables"][@"postlist"];
            for (NSDictionary *dic in srcArr) {
                BBSMoreModel *model=[[BBSMoreModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                if (_dataArray.count!=0) {
                    NSInteger newValue=[[model.number stringByReplacingOccurrencesOfString:@"楼" withString:@""] integerValue];
                    NSInteger oldValue=[[[_dataArray.lastObject number] stringByReplacingOccurrencesOfString:@"楼" withString:@""] integerValue];
                    if ([model.message isEqual:[_dataArray[0] message]] || (oldValue>5 && newValue<=oldValue)) {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BBScellID=@"BBSMorecellID";
    BBSMoreViewCell *cell=[tableView dequeueReusableCellWithIdentifier:BBScellID];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BBSMoreViewCell" owner:self options:nil] firstObject];
        cell.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    //cell.frame.size
    if (_dataArray.count!=0) {
        //NSLog(@"%@",_dataArray);
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
    NSString *str=[Tools replaceUnicodeStr:[_dataArray[indexPath.row] message]];
    CGSize newSize=[str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(255, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    //根据计算结果重新设置UILabel的尺寸
    if (newSize.height<20) {
        return 70;
    }
    else{
        return 50+newSize.height;
    }
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
