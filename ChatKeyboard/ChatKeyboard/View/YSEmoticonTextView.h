//
//  YSEmoticonTextView.h
//  ChatKeyboard
//
//  Created by jiangys on 16/6/1.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSTextView.h"
@class YSEmoticonModel;

@interface YSEmoticonTextView : YSTextView

- (void)insertEmoticon:(YSEmoticonModel *)emoticon;

- (NSString *)fullText;

@end
