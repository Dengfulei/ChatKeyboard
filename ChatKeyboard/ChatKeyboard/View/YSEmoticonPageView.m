//
//  YSEmoticonPageView.m
//  ChatKeyboard
//
//  Created by jiangys on 16/6/1.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSEmoticonPageView.h"
#import "YSEmoticonButton.h"
#import "YSEmoticonTool.h"
#import "YSEmoticonModel.h"

@interface YSEmoticonPageView()
/** 点击表情后弹出的放大镜 */
//@property (nonatomic, strong) HWEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation YSEmoticonPageView

//- (HWEmotionPopView *)popView
//{
//    if (!_popView) {
//        self.popView = [HWEmotionPopView popView];
//    }
//    return _popView;
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 2.添加长按手势
        //[self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

/**
 *  根据手指位置所在的表情按钮
 */
//- (HWEmotionButton *)emotionButtonWithLocation:(CGPoint)location
//{
//    NSUInteger count = self.emotions.count;
//    for (int i = 0; i<count; i++) {
//        HWEmotionButton *btn = self.subviews[i + 1];
//        if (CGRectContainsPoint(btn.frame, location)) {
//            
//            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
//            return btn;
//        }
//    }
//    return nil;
//}
//
///**
// *  在这个方法中处理长按手势
// */
//- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
//{
//    CGPoint location = [recognizer locationInView:recognizer.view];
//    // 获得手指所在的位置\所在的表情按钮
//    HWEmotionButton *btn = [self emotionButtonWithLocation:location];
//    
//    switch (recognizer.state) {
//        case UIGestureRecognizerStateCancelled:
//        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
//            // 移除popView
//            [self.popView removeFromSuperview];
//            
//            // 如果手指还在表情按钮上
//            if (btn) {
//                // 发出通知
//                [self selectEmotion:btn.emotion];
//            }
//            break;
//            
//        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
//        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
//            [self.popView showFrom:btn];
//            break;
//        }
//            
//        default:
//            break;
//    }
//}

- (void)setEmoticonArray:(NSArray *)emoticonArray
{
    _emoticonArray = emoticonArray;
    
    NSUInteger count = emoticonArray.count;
    for (int i = 0; i<count; i++) {
        YSEmoticonButton *btn = [[YSEmoticonButton alloc] init];
        [self addSubview:btn];
        
        // 设置表情数据
        btn.emoticonModel = emoticonArray[i];
        
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
// 警告原因：尝试去加载的图片不存在

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emoticonArray.count;
    CGFloat btnW = (self.width - 2 * inset) / YSEmoticonMaxCols;
    CGFloat btnH = (self.height - inset) / YSEmoticonMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.left = inset + (i%YSEmoticonMaxCols) * btnW;
        btn.top = inset + (i/YSEmoticonMaxCols) * btnH;
    }
    
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.top = self.height - btnH;
    self.deleteButton.left = self.width - inset - btnW;
}

/**
 *  监听删除按钮点击
 */
- (void)deleteClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YSEmoticonDidDeleteNotification object:nil];
}

/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */
- (void)btnClick:(YSEmoticonButton *)btn
{
    // 显示popView
//    [self.popView showFrom:btn];
//    
//    // 等会让popView自动消失
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.popView removeFromSuperview];
//    });
    
    // 发出通知
    [self selectEmoticon:btn.emoticonModel];
}

/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */
- (void)selectEmoticon:(YSEmoticonModel *)emotion
{
    // 将这个表情存进沙盒
    [YSEmoticonTool addRecentEmoticon:emotion];
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[YSSelectEmoticonKey] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:YSEmoticonDidSelectNotification object:nil userInfo:userInfo];
}
@end
