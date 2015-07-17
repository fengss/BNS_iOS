//
//  SrcViewController.m
//  BnSBang
//
//  Created by coderss on 14-10-20.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "SrcViewController.h"
#import "DtViewController.h"

@interface SrcViewController ()

@end

@implementation SrcViewController

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
    self.title=@"成长树";
    // Do any additional setup after loading the view.
    
}

-(void)createBarBtns
{
    //[self.navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"tabbar_gl"]];
}

-(void)configBtns
{
    CGSize screenSize=CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    CGPoint middlePoint=CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-64-49)/2);
    CGSize btnSize=CGSizeMake(screenSize.width, (screenSize.height-64-49-80)/2);
    //NSLog(@"%.2f,%.2f",middlePoint.x,middlePoint.y);
    UIButton *baseBtn;
    [self createBtns:baseBtn withFrame:CGRectMake(screenSize.width, middlePoint.y-40, screenSize.width, 40) angImage:@"shuiyue" Tag:0 Delay:0 Enabled:NO];
    [self createBtns:baseBtn withFrame:CGRectMake(-screenSize.width, middlePoint.y, screenSize.width, 40) angImage:@"baiqing" Tag:0 Delay:0 Enabled:NO];
    //水月
    [self createBtns:baseBtn withFrame:CGRectMake(-screenSize.width, 0, screenSize.width/2, btnSize.height) angImage:@"shuiyuezx" Tag:130 Delay:0.4 Enabled:YES];
    [self createBtns:baseBtn withFrame:CGRectMake(screenSize.width, 0, screenSize.width/2, btnSize.height) angImage:@"shuiyuecs" Tag:131 Delay:0.4 Enabled:YES];
    //白青
    [self createBtns:baseBtn withFrame:CGRectMake(-screenSize.width, middlePoint.y+40, screenSize.width/2, btnSize.height) angImage:@"baiqingzx" Tag:132 Delay:0.6 Enabled:YES];
    [self createBtns:baseBtn withFrame:CGRectMake(screenSize.width, middlePoint.y+40, screenSize.width/2, btnSize.height) angImage:@"baiqingcs" Tag:133 Delay:0.6 Enabled:YES];
    
}

-(void)clickAction:(UIButton *)sender
{
    NSInteger i=sender.tag-130;
    //NSLog(@"%d",i);
    if (i==3) {
        [self createNewBtn];
    }
    else{
        [self openGrowthTree:i];
    }
}

- (void)openGrowthTree:(NSInteger)tree
{
    DtViewController *dtVC=[[DtViewController alloc] init];
    dtVC.tree=[NSString stringWithFormat:@"jinhua%ld",(long)tree];
    dtVC.treeNum=tree;
    [self.navigationController pushViewController:dtVC animated:YES];
}

- (void)createNewBtn
{
    UIButton *mainBtn=(UIButton *)[self.view viewWithTag:133];
    
    for (NSInteger i=0; i<3; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, mainBtn.frame.size.height/3*i, mainBtn.frame.size.width, mainBtn.frame.size.height/3);
        btn.backgroundColor=[UIColor blackColor];
        btn.alpha=0;
        btn.tag=140+i;
        [btn setTitleColor:[UIColor colorWithRed:0.9176 green:0.2863 blue:0.2118 alpha:1] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"S%d神兵成长树",i+1] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnbgimg"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shenbingGrowthTree:) forControlEvents:UIControlEventTouchUpInside];
        [mainBtn addSubview:btn];
        
        [UIView animateWithDuration:0.5 delay:0.3*i options:UIViewAnimationOptionCurveEaseOut animations:^{
            for (NSInteger i=0; i<3; i++) {
                UIButton *thebtn=(UIButton *)[self.view viewWithTag:140+i];
                thebtn.alpha=0.8;
            }
        } completion:nil];
    }
    
}

- (void)shenbingGrowthTree:(UIButton *)sender
{
    NSInteger i=sender.tag-140;
    DtViewController *dtVC=[[DtViewController alloc] init];
    dtVC.tree=[NSString stringWithFormat:@"bqs%ld",(long)i];
    dtVC.treeNum=3;
    [self.navigationController pushViewController:dtVC animated:YES];
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
