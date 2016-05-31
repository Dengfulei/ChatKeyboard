//
//  YSEmoticonModel.h
//  聊天表情键盘
//
//  Created by Jiangys on 16/5/29.
//  Copyright © 2016年 Jiangys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSEmoticonModel : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;

@end
