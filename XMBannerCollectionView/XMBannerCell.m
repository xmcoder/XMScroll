//
//  XMBannerCell.m
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "XMBannerCell.h"

@interface XMBannerCell () {
    UIImageView *_cell_imageView;
}

@end

@implementation XMBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //此时collectionViewCell的frame是根据之前的flowlayout 已经设置完毕
        //NSLog(@"%@",NSStringFromCGRect(self.frame));
        _cell_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_cell_imageView];
        
    }
    return self;
}

- (void)setCell_image:(NSURL *)cell_image {
    _cell_image = cell_image;
    
    NSData *data = [NSData dataWithContentsOfURL:_cell_image];
    _cell_imageView.image = [UIImage imageWithData:data];
    
}

@end
