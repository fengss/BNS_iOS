//
//  BaguaDetailController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BaguaDetailController.h"

@interface BaguaDetailController ()
{
    UIImageView *_baguaView;
}
@end

@implementation BaguaDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    CGRect mainBounds=[[UIScreen mainScreen] bounds];
    _scrollView=[[UIScrollView alloc] initWithFrame:mainBounds];
    _scrollView.contentSize=CGSizeMake(mainBounds.size.width, 600);
    self.view=_scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_model.name;
    self.view.backgroundColor=[UIColor colorWithRed:0.1294 green:0.1647 blue:0.2353 alpha:1];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI
{
    _propertyView=[[UIImageView alloc] initWithFrame:CGRectMake(300-self.view.bounds.size.width, 180, 240, 410)];
    _propertyView.image=[UIImage imageNamed:_model.name];
    _propertyView.alpha=0;
    [self.view addSubview:_propertyView];
    
    _baguaView=[[UIImageView alloc] initWithFrame:CGRectMake(80 , 10, 160, 160)];
    _baguaView.image=[UIImage imageNamed:[_model.name stringByAppendingString:@"img"]];
    _baguaView.alpha=0;
    [self.view addSubview:_baguaView];
    
    
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _baguaView.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            _propertyView.frame=CGRectMake(40, 180, _propertyView.frame.size.width, _propertyView.frame.size.height);
            _propertyView.alpha=1;
        }];
    }];
    
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
