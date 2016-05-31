//
//  YSTextView.h
//  ChatKeyboard
//
//  Created by jiangys on 16/5/31.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
