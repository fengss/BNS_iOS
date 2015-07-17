//
//  VideoViewController.m
//  BnSBang
//
//  Created by coderss on 14-11-5.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "VideoViewController.h"
#import "ProViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

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

-(void)titleSettings
{
    _titleArr=@[@"所有",@"娱乐",@"攻略",@"比武",@"职业"];
}

-(void)topBtnAction:(UIButton *)sender
{
    _viewStatus=sender.tag-20;
    //NSLog(@"%d",_viewStatus);
    if (_viewStatus!=0 && _viewStatus!=4) {
        _tableView.tableHeaderView=nil;
    }
    else{
        if (!_tableView.tableHeaderView && _viewStatus==0) {
            _tableView.tableHeaderView=_scrollView;
        }
    }
    
    if (_viewStatus!=4) {
        [self startLoading];
        [self getUrlWithBody:self.bodyArr[_viewStatus] cachePolicy:NSURLRequestReturnCacheDataElseLoad];
        
        for (int i=0; i<5; i++) {
            UIButton *btn=(UIButton *)[self.view viewWithTag:20+i];
            btn.selected=NO;
        }
        sender.selected=YES;
        [UIView animateWithDuration:0.4 animations:^{
            _selectedView.frame=CGRectMake((sender.tag-20)*_screenSize.width/5, 37, _screenSize.width/5, 3);
        }];
    }
    else{
        NSLog(@"fifth btn");
        ProViewController *proVC=[[ProViewController alloc] init];
        [self.navigationController pushViewController:proVC animated:YES];
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
