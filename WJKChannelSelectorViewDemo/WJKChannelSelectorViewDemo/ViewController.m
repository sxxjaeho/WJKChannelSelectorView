//
//  ViewController.m
//  WJKChannelSelectorViewDemo
//
//  Created by Zeaho on 2018/2/9.
//  Copyright © 2018年 Zeaho. All rights reserved.
//

#import "ViewController.h"
#import "TYPagerController.h"
#import "TabViewController.h"
#import "SearchViewController.h"

// view
#import "WJKChannelSelectorView.h"

const CGFloat WJKChannelSelectorViewHeight = 115.f;

@interface ViewController () <TYPagerControllerDataSource, TYPagerControllerDelegate, WJKChannelSelectorViewDelegate>

@property (nonatomic, strong) WJKChannelSelectorView *channelSelecotorView;

@property (nonatomic, strong) TYPagerController *classificationPagerController;

@property (nonatomic, strong) TabViewController *performViewController;

@property (nonatomic, strong) TabViewController *cultureViewController;

@property (nonatomic, strong) TabViewController *teachViewController;

@property (nonatomic, strong) TabViewController *matchViewController;

@property (nonatomic, strong) NSArray<WJKChannelModel *> *categories;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self view] addSubview:[self channelSelecotorView]];
    
    [self addChildViewController:[self classificationPagerController]];
    [[self view] addSubview:[[self classificationPagerController] view]];
    
    [[self classificationPagerController] reloadData];
    
    [self _initializeDefaultData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navigationController.childViewControllers.count > 1) {
        [[self navigationController] setNavigationBarHidden:NO animated:animated];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.classificationPagerController.view.frame = CGRectMake(0, WJKChannelSelectorViewHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-WJKChannelSelectorViewHeight);
}

#pragma mark - private
- (void)_initializeDefaultData{
    
    // 网络请求来的频道数据
    WJKChannelModel *channelOne = [[WJKChannelModel alloc] init];
    channelOne.objectId = fmts(@"%lu", (unsigned long)WJKChannelTypeHiphop);
    
    WJKChannelModel *channelTwo = [[WJKChannelModel alloc] init];
    channelTwo.objectId = fmts(@"%lu", (unsigned long)WJKChannelTypeUrbandance);
    
    WJKChannelModel *channelThree = [[WJKChannelModel alloc] init];
    channelThree.objectId = fmts(@"%lu", (unsigned long)WJKChannelTypePopping);
    
    self.categories = @[channelOne, channelTwo, channelThree];
    
    [self _clearAndReloadData];
    [self _setupDefaultSelectSetting];
    
    // 如果是第一次启动应用则展开频道选择页面
    if (![self _checkFirstLaunchApplication]) {
        
        self.channelSelecotorView.isExpand = YES;
    }
}

- (void)_clearAndReloadData{
    
    self.categories = [self dataSourceWithCategories:[self categories]];
}

- (void)_setupDefaultSelectSetting{
    
    NSString *lastSelectedCategoryID = [self lastSelectedCategoryID];
    
    self.channelSelecotorView.channelId = lastSelectedCategoryID;
    
    // 找到默认选择的分类是第几个
    NSMutableArray *filterCategoryArray = [NSMutableArray arrayWithArray:[self categories]];
    int i = (int)[filterCategoryArray count]-1;
    for(; i >= 0; i--){
        if(![[(WJKChannelModel *)filterCategoryArray[i] objectId] isEqualToString:lastSelectedCategoryID]) {
            [filterCategoryArray removeObjectAtIndex:i];
        }
    }
    WJKChannelModel *category = [filterCategoryArray firstObject];
    NSInteger selectedIndex = 0;
    if (category) {
        selectedIndex = [[self categories] indexOfObject:category];
    }
    self.currentIndex = selectedIndex;
}

- (BOOL)_checkFirstLaunchApplication {
    return [[NSUserDefaults standardUserDefaults] boolForKey:WJKFirstShowChannelSelectorViewUserDefaultKey];
}

- (void)_transitSearchViewController {
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [[self navigationController] pushViewController:searchViewController animated:YES];
}

#pragma mark - accessor
- (WJKChannelSelectorView *)channelSelecotorView {
    if (!_channelSelecotorView) {
        _channelSelecotorView = [[WJKChannelSelectorView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WJKChannelSelectorViewHeight)];
        _channelSelecotorView.delegate = self;
    }
    return _channelSelecotorView;
}

- (TYPagerController *)classificationPagerController {
    if (!_classificationPagerController) {
        _classificationPagerController = [[TYPagerController alloc]init];
        _classificationPagerController.view.backgroundColor = [UIColor clearColor];
        _classificationPagerController.layout.prefetchItemCount = 0;
        _classificationPagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
        _classificationPagerController.scrollView.scrollEnabled = YES;
        _classificationPagerController.dataSource = self;
        _classificationPagerController.delegate = self;
    }
    return _classificationPagerController;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    _currentIndex = currentIndex;
}

- (NSArray *)dataSourceWithCategories:(NSArray<WJKChannelModel *> *)categories {
    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:categories];
    WJKChannelModel *comingSoon = [[WJKChannelModel alloc] init];
    comingSoon.objectId = fmts(@"%d", 0);
    comingSoon.title = fmts(@"%@", @"敬请期待");
    [dataSource insertObject:comingSoon atIndex:[categories count]];
    return dataSource;
}

- (NSString *)lastSelectedCategoryID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:WJKVideoLibraryChannelIdUserDefaultKey] ? [[NSUserDefaults standardUserDefaults] objectForKey:WJKVideoLibraryChannelIdUserDefaultKey] : fmts(@"%lu", (unsigned long)WJKChannelTypeHiphop);
}

- (void)setLastSelectedCategoryID:(NSString *)lastSelectedCategoryID {
    [[NSUserDefaults standardUserDefaults] setObject:lastSelectedCategoryID forKey:WJKVideoLibraryChannelIdUserDefaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - action
- (void)didSelectAtItemIndex:(NSUInteger)itemIndex {
    WJKChannelModel *channel = [self categories][itemIndex];
    NSLog(@"频道:%@", channel.objectId);
    
    // 本地存储记录最后选择的舞种
    self.lastSelectedCategoryID = [channel objectId];
    
    // 修改头部舞种背景和名称
    self.channelSelecotorView.channelId = channel.objectId;
}

#pragma mark - WJKChannelSelectorViewDelegate
- (void)classificationPagerBar:(TYTabPagerBar *)classificationPagerBar didSelectAtIndex:(NSInteger)selectedSegmentIndex {
    [[self classificationPagerController] scrollToControllerAtIndex:selectedSegmentIndex animate:NO];
}

- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didClickedSearchButton:(UIButton *)searchButton {
    [self _transitSearchViewController];
}

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

- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didSelectAtIndex:(NSUInteger)index {
    [self didSelectAtItemIndex:index];
}

- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didChangeSortType:(WJKChannelSortType)sortType {
    NSLog(@"排序:%ld", sortType);
}

#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return 4;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    switch (index) {
        case 0:
            self.performViewController = [[TabViewController alloc] init];
            self.performViewController.view.backgroundColor = [UIColor greenColor];
            self.performViewController.params = self.params;
            return self.performViewController;
            break;
        case 1:
            self.cultureViewController = [[TabViewController alloc] init];
            self.cultureViewController.view.backgroundColor = [UIColor blueColor];
            self.cultureViewController.params = self.params;
            return self.cultureViewController;
            break;
        case 2:
            self.teachViewController = [[TabViewController alloc] init];
            self.teachViewController.view.backgroundColor = [UIColor purpleColor];
            self.teachViewController.params = self.params;
            return self.teachViewController;
            break;
        case 3:
            self.matchViewController = [[TabViewController alloc] init];
            self.matchViewController.view.backgroundColor = [UIColor cyanColor];
            self.matchViewController.params = self.params;
            return self.matchViewController;
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - TYPagerControllerDelegate
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [[[[self channelSelecotorView] subclassificationSegmentView] subclassificationSegment] scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [[[[self channelSelecotorView] subclassificationSegmentView] subclassificationSegment] scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
