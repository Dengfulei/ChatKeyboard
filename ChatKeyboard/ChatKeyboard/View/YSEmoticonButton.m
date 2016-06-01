//
//  YSEmoticonButton.m
//  ChatKeyboard
//
//  Created by jiangys on 16/6/1.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSEmoticonButton.h"
#import "YSEmoticonModel.h"

@implementation YSEmoticonButton
/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

//- (void)setHighlighted:(BOOL)highlighted {
//
//}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    
    // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
    self.adjustsImageWhenHighlighted = NO;
}

/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    
}

- (void)setEmoticonModel:(YSEmoticonModel *)emoticonModel
{
    _emoticonModel = emoticonModel;
    
    if (emoticonModel.png) { // 有图片
        [self setImage:[UIImage imageNamed:emoticonModel.png] forState:UIControlStateNormal];
    } else if (emoticonModel.code) { // 是emoji表情
        // 设置emoji
        //[self setTitle:emoticonModel.code.emoji forState:UIControlStateNormal];
    }
}
@end
