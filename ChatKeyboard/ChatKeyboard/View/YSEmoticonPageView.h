//
//  YSEmoticonPageView.h
//  ChatKeyboard
//
//  Created by jiangys on 16/6/1.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define YSEmoticonMaxRows 3
// 一行中最多7列
#define YSEmoticonMaxCols 7
// 每一页的表情个数
#define YSEmoticonPageSize ((YSEmoticonMaxRows * YSEmoticonMaxCols) - 1)

@interface YSEmoticonPageView : UIView
/** 这一页显示的表情（里面都是YSEmotcionModel模型） */
@property (nonatomic, strong) NSArray *emoticonArray;

@end
