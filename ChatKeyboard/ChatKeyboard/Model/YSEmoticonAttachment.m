//
//  YSEmoticonAttachment.m
//  ChatKeyboard
//
//  Created by jiangys on 16/6/1.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSEmoticonAttachment.h"

@implementation YSEmoticonAttachment

- (void)setEmoticonModel:(YSEmoticonModel *)emoticonModel
{
    _emoticonModel = emoticonModel;
    
    self.image = [UIImage imageNamed:emoticonModel.png];
}

@end
