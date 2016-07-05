//
//  XMFlowLayout.m
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "XMFlowLayout.h"

@implementation XMFlowLayout

// 在collectionView开始布局的时候，调用此方法之前，self.collectionView.frame已经被设置完毕
- (void)prepareLayout {
    [super prepareLayout];
    
    //NSLog(@"%@",self.collectionView);
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
}


@end
