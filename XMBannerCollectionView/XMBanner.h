//
//  XMBanner.h
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackIndex)(int xm_index_page);

@interface XMBanner : UICollectionView

@property (nonatomic, copy) BackIndex backIndex;

- (instancetype)initWithUrls:(NSArray <NSURL *> *)urls;

@end
