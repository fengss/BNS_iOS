//
//  CollectLayOut.m
//  剑灵帮帮
//
//  Created by coderss on 14-11-10.
//  Copyright (c) 2014年 jyw. All rights reserved.
//

#import "CollectLayOut.h"

@implementation CollectLayOut

//返回collectionView的内容的大小
-(CGSize)collectionViewContentSize
{
    CGFloat leftHeight = 0.0;
    CGFloat rightHeight = 0.0;
    for (int i=0; i<_dataArray.count; i++) {
        CGFloat h = [_dataArray[i] cellHeight];
        if (leftHeight <= rightHeight) {
            leftHeight += h;
        }
        else
        {
            rightHeight += h;
        }
    }
    
    return CGSizeMake(0,leftHeight>rightHeight?leftHeight:rightHeight);
}


//返回某一个cell对应的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat cellHeight = [_dataArray[indexPath.row] cellHeight];
    CGFloat leftHeight = 0.0;
    CGFloat rightHeight = 0.0;
    for (int i = 0; i<indexPath.row; i++) {
        CGFloat h = [_dataArray[i] cellHeight];
        if (leftHeight <= rightHeight) {
            leftHeight += h;
        }
        else
        {
            rightHeight += h;
        }
    }
    if (leftHeight <= rightHeight) {
        attr.center = CGPointMake(80, leftHeight + cellHeight/2);
    }
    else
    {
        attr.center = CGPointMake(240, rightHeight + cellHeight/2);
    }
    attr.size = CGSizeMake(160, cellHeight);
    
    
    return attr;
}

//返回包含所有的cell的属性的数组
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [arr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return arr;
}

@end
