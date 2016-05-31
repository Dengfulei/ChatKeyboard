//
//  YSComposeViewController.m
//  ChatKeyboard
//
//  Created by jiangys on 16/5/30.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "YSComposeViewController.h"
#import "YSTextView.h"
#import "YSEmoticonTool.h"
#import "YSComposeToolbar.h"
#import "YSEmoticonKeyboard.h"

@interface YSComposeViewController ()<UITextViewDelegate,YSComposeToolbarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 输入控件 */
@property (nonatomic, strong) YSTextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, strong) YSComposeToolbar *toolbar;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;
/** 表情键盘 */
@property (nonatomic, strong) YSEmoticonKeyboard *emoticonKeyboard;
@end

@implementation YSComposeViewController

#pragma mark - 懒加载
- (YSEmoticonKeyboard *)emoticonKeyboard
{
    if (!_emoticonKeyboard) {
        self.emoticonKeyboard = [[YSEmoticonKeyboard alloc] init];
        // 键盘的宽度
        self.emoticonKeyboard.width = self.view.width;
        self.emoticonKeyboard.height = 216;
    }
    return _emoticonKeyboard;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    _textView = [[YSTextView alloc] init];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    _textView.alwaysBounceVertical = YES;
    _textView.frame = self.view.bounds;
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.delegate = self;
    _textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:_textView];
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:_textView];
    
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//
//    // 表情选中的通知
//    [HWNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:HWEmotionDidSelectNotification object:nil];
//    
//    // 删除文字的通知
//    [HWNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:HWEmotionDidDeleteNotification object:nil];
}

/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘，就不要执行后面的代码
    if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.top = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.top = keyboardF.origin.y - self.toolbar.height;
        }
    }];
}

/**
 * 添加工具条
 */
- (void)setupToolbar
{
    _toolbar = [[YSComposeToolbar alloc] init];

    _toolbar.width = self.view.width;
    _toolbar.height = 44;
    _toolbar.top = self.view.height - _toolbar.height;
    _toolbar.delegate = self;
    [self.view addSubview:_toolbar];
}

#pragma mark - 其他方法
/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil : 使用的是系统自带的键盘
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
        self.textView.inputView = self.emoticonKeyboard;
        // 显示键盘按钮
        self.toolbar.showKeyboardButton = YES;
    } else { // 切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情按钮
        self.toolbar.showKeyboardButton = NO;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
    
    // 结束切换键盘
    self.switchingKeybaord = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
    });
}

#pragma mark - HWComposeToolbarDelegate
- (void)composeToolbar:(YSComposeToolbar *)toolbar didClickButton:(YSComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case YSComposeToolbarButtonTypeCamera: // 拍照
            [self openCamera];
            NSLog(@"--- 拍照");
            break;
            
        case YSComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case YSComposeToolbarButtonTypeMention: // @
            NSLog(@"--- @");
            break;
            
        case YSComposeToolbarButtonTypeTrend: // #
            NSLog(@"--- #");
            break;
            
        case YSComposeToolbarButtonTypeEmotion: // 表情\键盘
            [self switchKeyboard];
            break;
    }
}

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - YSTextView
// TextView文字改变
- (void)textViewTextDidChange
{
    // 在这里可以控制按钮变灰或者是高亮
    //self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - UITextViewDelegate
// textView拉动关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


@end
