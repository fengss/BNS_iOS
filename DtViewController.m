//
//  DtViewController.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-12.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "DtViewController.h"

@interface DtViewController ()
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    UIImage *_image;
}
@end

@implementation DtViewController

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
    [self createTitle];
    // Do any additional setup after loading the view.
    [self createImageView];
    [self createControlBtn];
}

- (void)createTitle
{
    NSArray *array=@[@"水月主线成长树",@"水月传说成长树",@"白青主线成长树",@"白青传说成长树"];
    self.title=array[_treeNum];
}

- (void)createImageView
{
    _image=[UIImage imageNamed:_tree];
    _scrollView=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _scrollView.backgroundColor=[UIColor darkGrayColor];
    _scrollView.contentSize=_image.size;
    [self.view addSubview:_scrollView];
   
    _imageView=[[UIImageView alloc] initWithImage:_image];
    _imageView.userInteractionEnabled=YES;
    _imageView.alpha=0.8;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideStepper)]];
    [_scrollView addSubview:_imageView];
}

- (void)hideStepper
{
    UIStepper *stepper=(UIStepper *)[self.view viewWithTag:180];
    BOOL ishidden=stepper.hidden;
    if (ishidden) {
        stepper.hidden=NO;
        [UIView animateWithDuration:0.5 animations:^{
            stepper.alpha=0.8;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            stepper.alpha=0;
        } completion:^(BOOL finished) {
            stepper.hidden=YES;
        }];
    }
}

- (void)createControlBtn
{
    UIStepper *stepper=[[UIStepper alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-105, self.view.bounds.size.height-90, 30, 30)];
    stepper.backgroundColor=[UIColor whiteColor];
    stepper.tag=180;
    stepper.alpha=0.8;
    stepper.maximumValue=2.5;
    stepper.minimumValue=1;
    stepper.stepValue=0.5;
    stepper.value=1;
    stepper.layer.cornerRadius=5;
    stepper.layer.masksToBounds=YES;
    [stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stepper];
}

- (void)valueChanged:(UIStepper *)sender
{
    NSLog(@"%.2f",sender.value);
    _imageView.frame=CGRectMake(0, 0, _image.size.width*sender.value, _image.size.height*sender.value);
    _scrollView.contentSize=_imageView.frame.size;
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
