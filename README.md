# WJKChannelSelectorView
点击导航栏上的选择频道,从顶部下拉展示频道选择页,点击频道选择页的某个频道会更新频道以及头部样式,并且有子分类选择器,点击标签控制器可切换不同的视图控制器,可左右滑动,效果图如下:

![5a7d61f776fe6.gif](https://i.loli.net/2018/02/09/5a7d61f776fe6.gif)
## Features
* 如图封装头部,通过选择器的点击控制频道集合视图出现和消失;
* 默认第一次下载打开频道选择;
* 选择的频道本地缓存,记录用户的选择;
* 实现基本动画;
* 子分类选择基于 TYPagerController,配合 TYTabPagerBar 实现,点击标签控制器切换到不同的试图控制器,可以左右滑动

>嵌入不同试图控制器

```
- (NSInteger)numberOfControllersInPagerController;
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching;
```
## How to use
### Initialization
##### create subviews
```
@interface ViewController () <WJKChannelSelectorViewDelegate>
@property (nonatomic, strong) WJKChannelSelectorView *channelSelecotorView;
@end

- (WJKChannelSelectorView *)channelSelecotorView {
    if (!_channelSelecotorView) {
        _channelSelecotorView = [[WJKChannelSelectorView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WJKChannelSelectorViewHeight)];
        _channelSelecotorView.delegate = self;
    }
    return _channelSelecotorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] addSubview:[self channelSelecotorView]];
}
```
##### WJKChannelSelectorViewDelegate
```
#pragma mark - WJKChannelSelectorViewDelegate
- (NSUInteger)numberOfItemsInSelector:(WJKChannelSelectorView *)selector;{
    return [[self categories] count];
}

- (UIView *)containerViewForExpendInSelector:(WJKChannelSelectorView *)selector;{
    return [self view];
}

- (NSString *)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView titleAtIndex:(NSUInteger)index {
    WJKChannelModel *channel = [self categories][index];
    return channel.title;
}

- (NSString *)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView coverAtIndex:(NSUInteger)index {
    WJKChannelModel *channel = [self categories][index];
    return fmts(@"channel_img_%@", channel.objectId);
}

// 频道选择
- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didSelectAtIndex:(NSUInteger)index {
    [self didSelectAtItemIndex:index];
}

// 子分类选择
- (void)classificationPagerBar:(TYTabPagerBar *)classificationPagerBar didSelectAtIndex:(NSInteger)selectedSegmentIndex {
    [[self classificationPagerController] scrollToControllerAtIndex:selectedSegmentIndex animate:NO];
}

```
## Thank you for reviewing




