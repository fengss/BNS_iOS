//
//  WeaponDetailController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "WeaponDetailController.h"

@interface WeaponDetailController ()

@end

@implementation WeaponDetailController

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
    _scrollView=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view=_scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createUI
{
    UIImage *propertyImg=[UIImage imageNamed:self.model.name];
    _scrollView.contentSize=CGSizeMake(propertyImg.size.width, propertyImg.size.height);
    
    _propertyView=[[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, propertyImg.size.width, propertyImg.size.height)];
    _propertyView.alpha=0;
    _propertyView.image=propertyImg;
    [self.view addSubview:_propertyView];
    
    [UIView animateWithDuration:0.6 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _propertyView.frame=CGRectMake(0, 0, _propertyView.frame.size.width, _propertyView.frame.size.height);
        _propertyView.alpha=0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
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
