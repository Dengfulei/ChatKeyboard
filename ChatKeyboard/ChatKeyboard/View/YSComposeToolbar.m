//
//  YSComposeToolbar.m
//  ChatKeyboard
//
//  Created by jiangys on 16/5/31.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSComposeToolbar.h"

@interface YSComposeToolbar()
@property (nonatomic, strong) UIButton *emotionButton;
@end

@implementation YSComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 初始化按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:YSComposeToolbarButtonTypeCamera];
        
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:YSComposeToolbarButtonTypePicture];
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:YSComposeToolbarButtonTypeMention];
        
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:YSComposeToolbarButtonTypeTrend];
        
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:YSComposeToolbarButtonTypeEmotion];
    }
    return self;
}

- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

/**
 * 创建一个按钮
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(YSComposeToolbarButtonType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}

// 设置所有按钮的frame
- (void)layoutSubviews
{
    [super layoutSubviews];

    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.top = 0;
        btn.width = btnW;
        btn.left = i * btnW;
        btn.height = btnH;
    }
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}

@end