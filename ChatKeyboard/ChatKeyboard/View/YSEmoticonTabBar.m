//
//  YSEmoticonTabBar.m
//  ChatKeyboard
//
//  Created by jiangys on 16/5/31.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSEmoticonTabBar.h"
#import "YSEmoticonTabBarButton.h"
#import "UIView+Frame.h"

@interface YSEmoticonTabBar()
@property (nonatomic, weak) YSEmoticonTabBarButton *selectedBtn;
@end

@implementation YSEmoticonTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:YSEmoticonTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:YSEmoticonTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:YSEmoticonTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:YSEmoticonTabBarButtonTypeLxh];
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (YSEmoticonTabBarButton *)setupBtn:(NSString *)title buttonType:(YSEmoticonTabBarButtonType)buttonType
{
    // 创建按钮
    YSEmoticonTabBarButton *btn = [[YSEmoticonTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        YSEmoticonTabBarButton *btn = self.subviews[i];
        btn.top = 0;
        btn.width = btnW;
        btn.left = i * btnW;
        btn.height = btnH;
    }
}

- (void)setDelegate:(id<YSEmoticonTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 选中“默认”按钮
    [self btnClick:(YSEmoticonTabBarButton *)[self viewWithTag:YSEmoticonTabBarButtonTypeDefault]];
}

/**
 *  按钮点击
 */
- (void)btnClick:(YSEmoticonTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emoticonTabBar:didSelectButton:)]) {
        [self.delegate emoticonTabBar:self didSelectButton:btn.tag];
    }
}

@end
