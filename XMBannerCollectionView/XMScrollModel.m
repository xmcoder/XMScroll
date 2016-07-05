//
//  XMScrollModel.m
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "XMScrollModel.h"
#import "XMBanner.h"

#define PAGE_CONTROL_HEIGHT 8
#define PAGE_MARGIN 8

@interface XMScrollModel () {
    int _xm_index;
    UIPageControl *_xm_pageControl;
}

@end


@implementation XMScrollModel

- (instancetype)initWithURLArray:(NSArray <NSURL *> *)images_arr {
    self = [super init];
    if (self) {
        self.xm_images = images_arr;
        //为了解决 collectionViewCell的contentView的frame为nil
        //主队列 异步任务 ：当主队列中有任务时，会先执行完其它任务，再来调度此任务
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpUI];
        });
    }
    return self;
}




- (void)setUpUI {
    XMBanner *banner = [[XMBanner alloc] initWithUrls:self.xm_images];
    banner.frame = self.bounds;
    banner.center = self.center;
    
    [self addSubview:banner];
    
    //设置pageControll
    _xm_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, PAGE_CONTROL_HEIGHT)];
    _xm_pageControl.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height -PAGE_CONTROL_HEIGHT - PAGE_MARGIN);
    _xm_pageControl.numberOfPages = self.xm_images.count;
    
   // [_xm_pageControl setValue:[UIImage imageNamed:@"other.png"] forKeyPath:@"pageImage"];
  //  [_xm_pageControl setValue:[UIImage imageNamed:@"current.png"] forKeyPath:@"currentPageImage"];
    
    [self addSubview:_xm_pageControl];
    
    //获取当前图片的索引
    banner.backIndex = ^(int xm_index_page){
        _xm_index = xm_index_page % self.xm_images.count;
        //NSLog(@"%d",_xm_index);
        _xm_pageControl.currentPage = _xm_index;
    };
    
    
    
}

@end
