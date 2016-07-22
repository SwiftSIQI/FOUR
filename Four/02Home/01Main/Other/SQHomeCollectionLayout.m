//
//  SQHomeCollectionLayout.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/6/22.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQHomeCollectionLayout.h"

@implementation SQHomeCollectionLayout

//布局collectionView
- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake((kScreenWidht - 3 * kInsertMargin) * 0.5, (kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kInsertMargin) * 0.5 );
    //设置cell之间的间距为0
    self.minimumLineSpacing = kLargeMargin;
    self.minimumInteritemSpacing = 0;
    
    //设置滚动方向为纵向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView.pagingEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    

}



@end
