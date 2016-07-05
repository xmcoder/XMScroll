### XMScrollBanner

I like to use the most convenient wording to implement a demand function, which is achieved by using the c a carousel view pictures

```
用UICollectionView编码的一个简单的图片轮播Demo

```


### Demo

![gif](https://github.com/xmcoder/XMScroll/blob/master/gif.gif)


### Method

```
ViewController.m

- (void)xm_setUpUI {
    XMScrollModel *model = [[XMScrollModel alloc] initWithURLArray:_xm_urls];
    model.frame = CGRectMake(0, 0, self.view.bounds.size.width, SCROLL_MODEL_HEIGHT);
    model.center = CGPointMake(self.view.center.x, SCROLL_MODEL_HEIGHT * 0.5);
    
    [self.view addSubview:model];
}

如果想替换轮播图片 请直接拖进项目进行替换即可

```
