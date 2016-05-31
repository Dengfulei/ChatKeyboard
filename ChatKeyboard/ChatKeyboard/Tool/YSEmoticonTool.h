//
//  YSEmoticonTool.h
//  聊天表情键盘
//
//  Created by Jiangys on 16/5/29.
//  Copyright © 2016年 Jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSEmoticonModel;

@interface YSEmoticonTool : NSObject

+ (void)addRecentEmoticon:(YSEmoticonModel *)emoticon;
+ (NSArray *)recentEmoticons;
+ (NSArray *)defaultEmoticons;
+ (NSArray *)lxhEmoticons;
+ (NSArray *)emojiEmoticons;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (YSEmoticonModel *)emoticonWithChs:(NSString *)chs;

@end
