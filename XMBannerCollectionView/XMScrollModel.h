//
//  XMScrollModel.h
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMScrollModel : UIView

@property (nonatomic, strong) NSArray *xm_images;

- (instancetype)initWithURLArray:(NSArray <NSURL *> *)images_arr;

@end
