//
//  PhotoViewController.h
//  剑灵帮帮
//
//  Created by coderss on 14-11-9.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "BnsViewController.h"
#import "CollectLayOut.h"
#import "CollectViewCell.h"


@interface PhotoViewController : BnsViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger _imageStatus;
}

-(void)createRefreshView;
-(void)loadImageViewForColumn:(NSInteger)column andPage:(NSInteger)page Policy:(NSURLRequestCachePolicy)policy;

@end
