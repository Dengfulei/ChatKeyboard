//
//  YSEmoticonTool.m
//  聊天表情键盘
//
//  Created by Jiangys on 16/5/29.
//  Copyright © 2016年 Jiangys. All rights reserved.
//

// 最近表情的存储路径
#define RecentEmoticonsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emoticons.archive"]

#import "YSEmoticonTool.h"
#import "YSEmoticonModel.h"
#import "MJExtension.h"

@implementation YSEmoticonTool

// 最近使用过的表情
static NSMutableArray *_recentEmoticons;
static NSArray *_emojiEmoticons, *_defaultEmoticons, *_lxhEmoticons;

+ (void)initialize
{
    _recentEmoticons = [NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmoticonsPath];
    if (_recentEmoticons == nil) {
        _recentEmoticons = [NSMutableArray array];
    }
}

+ (YSEmoticonModel *)emoticonWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmoticons];
    for (YSEmoticonModel *emoticon in defaults) {
        if ([emoticon.chs isEqualToString:chs]) return emoticon;
    }
    
    NSArray *lxhs = [self lxhEmoticons];
    for (YSEmoticonModel *emoticon in lxhs) {
        if ([emoticon.chs isEqualToString:chs]) return emoticon;
    }
    
    return nil;
}

+ (void)addRecentEmoticon:(YSEmoticonModel *)emoticon
{
    // 删除重复的表情
    [_recentEmoticons removeObject:emoticon];
    
    // 将表情放到数组的最前面
    [_recentEmoticons insertObject:emoticon atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmoticons toFile:RecentEmoticonsPath];
}

/**
 *  返回装着Emoticon模型的数组
 */
+ (NSArray *)recentEmoticons
{
    return _recentEmoticons;
}

+ (NSArray *)emojiEmoticons
{
    if (!_emojiEmoticons) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoji.plist" ofType:nil];
        _emojiEmoticons = [YSEmoticonModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmoticons;
}

+ (NSArray *)defaultEmoticons
{
    if (!_defaultEmoticons) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default.plist" ofType:nil];
        _defaultEmoticons = [YSEmoticonModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmoticons;
}

+ (NSArray *)lxhEmoticons
{
    if (!_lxhEmoticons) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lxh.plist" ofType:nil];
        _lxhEmoticons = [YSEmoticonModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmoticons;
}

@end
