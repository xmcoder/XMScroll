//
//  ViewController.m
//  XMBannerCollectionView
//
//  Created by XM on 16/7/5.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "ViewController.h"
#import "XMScrollModel.h"

#define SCROLL_MODEL_HEIGHT 180

@interface ViewController (){
    // <NSURL *> 范型  表示此数组只能承载NSURL类型的元素
    NSArray <NSURL *> *_xm_urls;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [board instantiateInitialViewController];
    nav.automaticallyAdjustsScrollViewInsets = NO;
    nav.navigationBar.translucent = NO;
    self.title = @"XMScrollBanner";
    
    //解决 导航视图 使子控件自动下沉64像素
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self xm_loadData];
    [self xm_setUpUI];
}

- (void)xm_loadData {

    NSMutableArray *mutArr = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        NSString *fileName = [NSString stringWithFormat:@"MKScrollBanner-%02d.png",i];
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        [mutArr addObject:url];
    }
    _xm_urls = mutArr;
}

- (void)xm_setUpUI {
    XMScrollModel *model = [[XMScrollModel alloc] initWithURLArray:_xm_urls];
    model.frame = CGRectMake(0, 0, self.view.bounds.size.width, SCROLL_MODEL_HEIGHT);
    model.center = CGPointMake(self.view.center.x, SCROLL_MODEL_HEIGHT * 0.5);
    
    [self.view addSubview:model];
}

@end
