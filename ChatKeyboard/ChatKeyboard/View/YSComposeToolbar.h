//
//  YSComposeToolbar.h
//  ChatKeyboard
//
//  Created by jiangys on 16/5/31.
//  Copyright © 2016年 jiangys. All rights reserved.
//  键盘顶部的工具条

#import <UIKit/UIKit.h>
@class YSComposeToolbar;

typedef NS_ENUM(NSUInteger,YSComposeToolbarButtonType)
{
    YSComposeToolbarButtonTypeCamera, // 拍照
    YSComposeToolbarButtonTypePicture, // 相册
    YSComposeToolbarButtonTypeMention, // @
    YSComposeToolbarButtonTypeTrend, // #
    YSComposeToolbarButtonTypeEmotion // 表情
};

@protocol YSComposeToolbarDelegate <NSObject>
@optional

- (void)composeToolbar:(YSComposeToolbar *)toolbar didClickButton:(YSComposeToolbarButtonType)buttonType;

@end

@interface YSComposeToolbar : UIView

@property (nonatomic, weak) id<YSComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

@end
