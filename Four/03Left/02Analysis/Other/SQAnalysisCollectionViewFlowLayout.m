//
//  SQAnalysisCollectionViewFlowLayout.m
//  Ten-Thousand-Hours
//
//  Created by 张思琦 on 16/7/13.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "SQAnalysisCollectionViewFlowLayout.h"

@implementation SQAnalysisCollectionViewFlowLayout

//布局collectionView
- (void)prepareLayout{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kScreenWidht , (kScreenHeight - kStatusBarHeight - kNavigationBarHeight));
    //设置cell之间的间距为0
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    //设置滚动方向为纵向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;    
}

@end
