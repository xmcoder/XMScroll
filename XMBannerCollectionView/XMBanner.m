//
//  XMBanner.m
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "XMBanner.h"
#import "XMFlowLayout.h"
#import "XMBannerCell.h"

@interface XMBanner ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    NSArray <NSURL *> *_xm_urls;
    NSTimer *_xm_timer;
    int _xm_index;
}

@end

@implementation XMBanner

//定义重用标示
static NSString *cellID = @"cellID";

- (instancetype)initWithUrls:(NSArray <NSURL *> *)urls {
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[XMFlowLayout alloc] init]];
    if (self) {
        _xm_urls = urls;
        self.dataSource = self;
        self.delegate = self;
        
        //注册重用标示
        [self registerClass:[XMBannerCell class] forCellWithReuseIdentifier:cellID];
        
        // 让4直接滚动到初始界面 [0.1.2.3][4.5.6.7] 此时是先调用初始化方法 _xm_urls.count还没有值 用多线程
        // 主队列异步任务： 如果主队列当前有任务,主队列暂时不会调度任务
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *index_path = [NSIndexPath indexPathForItem:_xm_urls.count inSection:0];
            [self scrollToItemAtIndexPath:index_path atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
        
        [self startTimer];
    }
    return self;
}

#pragma mark - <push next image(item)>
- (void)pushNextImage {
    _xm_index += 1;
    [self setContentOffset:CGPointMake((int)_xm_index * self.frame.size.width, 0) animated:YES];
}

- (void)startTimer {
    //定时器
    _xm_timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pushNextImage) userInfo:nil repeats:YES];
    //解决拖动其它滚动控件，定时器不执行问题
    [[NSRunLoop mainRunLoop] addTimer:_xm_timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer {
    if (_xm_timer != nil) {
        [_xm_timer invalidate];
        _xm_timer = nil;
    }
}

#pragma mark - <scrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _xm_index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //回调下标
    self.backIndex(_xm_index);
    
    if (scrollView.contentOffset.x < 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (_xm_urls.count - 1), 0) animated:YES];
    }
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //用2组实现轮播 (为了解决卡顿的问题 可以搞个100组 放大数据源)
    return _xm_urls.count * 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建带有重用标示的cell
    XMBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    cell.cell_image = _xm_urls[indexPath.item % _xm_urls.count];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
//此方法bu会被多次调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger xm_offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self startTimer];
    
    //第0页 最后一页 [0.1.2.3][4.5.6.7]
    if (xm_offset == 0 || xm_offset == [self numberOfItemsInSection:0] - 1) {
        //第0页
        if (xm_offset == 0) {
            xm_offset = _xm_urls.count;
        } else {
            //最后一页
            xm_offset = _xm_urls.count - 1;
        }
        
        //NSLog(@"%zd",xm_offset);
    }
    
    //重新调整
    scrollView.contentOffset = CGPointMake(xm_offset * scrollView.bounds.size.width, 0);
}

@end
