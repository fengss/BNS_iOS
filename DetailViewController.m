//
//  DetailViewController.m
//  BnSBang
//
//  Created by coderss on 14-11-3.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"资讯详情";
    // Do any additional setup after loading the view.
    //NSLog(@"%@",_model.uid);
    [self configUI];
    [self loadWebView];
}

- (void)configUI
{
    _webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate=self;
    _webView.scalesPageToFit=YES;
    [self.view addSubview:_webView];
    
    
    _actView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _actView.center=CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    _actView.alpha=0.8;
    _actView.backgroundColor=[UIColor blackColor];
    _actView.layer.cornerRadius=10;
    _actView.layer.masksToBounds=YES;
    [self.view addSubview:_actView];
    
    UIActivityIndicatorView *theActivityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    theActivityView.frame=CGRectMake(0, 0, 80, 80);
    theActivityView.center=CGPointMake(_actView.bounds.size.width/2, _actView.bounds.size.height/2);
    [_actView addSubview:theActivityView];
    [theActivityView startAnimating];
}

- (void)loadWebView
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:ARTICLE_URL,_model.uid]];
    [[HttpRequestManager sharedManager] GETUrl:url cachePolicy:NSURLRequestReturnCacheDataElseLoad completed:^(NSData *data) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *webUrl=dic[@"url"];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20]];
        
    } failed:^{
        NSLog(@"load fail");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"哎呀!" message:@"您的网络有些问题，请稍后再试" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [_actView removeFromSuperview];
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_actView removeFromSuperview];
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
