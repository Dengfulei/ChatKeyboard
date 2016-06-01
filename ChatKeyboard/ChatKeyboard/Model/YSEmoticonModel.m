//
//  YSEmoticonModel.m
//  聊天表情键盘
//
//  Created by Jiangys on 16/5/29.
//  Copyright © 2016年 Jiangys. All rights reserved.
//

#import "YSEmoticonModel.h"

@implementation YSEmoticonModel
/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}
@end
