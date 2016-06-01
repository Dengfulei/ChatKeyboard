//
//  YSEmoticonKeyboard.m
//  ChatKeyboard
//
//  Created by jiangys on 16/5/31.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSEmoticonKeyboard.h"
#import "YSEmoticonListView.h"
#import "YSEmoticonTabBar.h"
#import "YSEmoticonTool.h"

@interface YSEmoticonKeyboard() <YSEmoticonTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) YSEmoticonListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) YSEmoticonListView *recentListView;
@property (nonatomic, strong) YSEmoticonListView *defaultListView;
@property (nonatomic, strong) YSEmoticonListView *emojiListView;
@property (nonatomic, strong) YSEmoticonListView *lxhListView;
/** tabbar */
@property (nonatomic, weak) YSEmoticonTabBar *tabBar;
@end

@implementation YSEmoticonKeyboard

#pragma mark - 懒加载
- (YSEmoticonListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[YSEmoticonListView alloc] init];
        self.recentListView.emoticonArray = [YSEmoticonTool recentEmoticons];
    }
    return _recentListView;
}

- (YSEmoticonListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[YSEmoticonListView alloc] init];
        self.defaultListView.emoticonArray = [YSEmoticonTool defaultEmoticons];
    }
    return _defaultListView;
}

- (YSEmoticonListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[YSEmoticonListView alloc] init];
        self.emojiListView.emoticonArray = [YSEmoticonTool emojiEmoticons];
    }
    return _emojiListView;
}

- (YSEmoticonListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[YSEmoticonListView alloc] init];
        self.lxhListView.emoticonArray = [YSEmoticonTool lxhEmoticons];
    }
    return _lxhListView;
}

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        YSEmoticonTabBar *tabBar = [[YSEmoticonTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emoticonDidSelect) name:YSEmoticonDidSelectNotification object:nil];
    }
    return self;
}

- (void)emoticonDidSelect
{
    self.recentListView.emoticonArray = [YSEmoticonTool recentEmoticons];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.left = 0;
    self.tabBar.top = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.left = self.showingListView.top = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.top;
}

#pragma mark - YSEmoticonTabBarDelegate
- (void)emoticonTabBar:(YSEmoticonTabBar *)tabBar didSelectButton:(YSEmoticonTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case YSEmoticonTabBarButtonTypeRecent: { // 最近
            // 加载沙盒中的数据
            [self addSubview:self.recentListView];
            break;
        }
            
        case YSEmoticonTabBarButtonTypeDefault: { // 默认
            [self addSubview:self.defaultListView];
            break;
        }
            
        case YSEmoticonTabBarButtonTypeEmoji: { // Emoji
            [self addSubview:self.emojiListView];
            break;
        }
            
        case YSEmoticonTabBarButtonTypeLxh: { // Lxh
            [self addSubview:self.lxhListView];
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}

@end
