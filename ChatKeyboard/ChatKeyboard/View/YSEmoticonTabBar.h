//
//  YSEmoticonTabBar.h
//  ChatKeyboard
//
//  Created by jiangys on 16/5/31.
//  Copyright © 2016年 jiangys. All rights reserved.
//  表情底部TabBar

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YSEmoticonTabBarButtonType)
{
    YSEmoticonTabBarButtonTypeRecent, // 最近
    YSEmoticonTabBarButtonTypeDefault, // 默认
    YSEmoticonTabBarButtonTypeEmoji, // emoji
    YSEmoticonTabBarButtonTypeLxh, // 浪小花
};

@class YSEmoticonTabBar;

@protocol YSEmoticonTabBarDelegate <NSObject>

@optional
- (void)emoticonTabBar:(YSEmoticonTabBar *)tabBar didSelectButton:(YSEmoticonTabBarButtonType)buttonType;
@end

@interface YSEmoticonTabBar : UIView
@property (nonatomic, weak) id<YSEmoticonTabBarDelegate> delegate;
@end
