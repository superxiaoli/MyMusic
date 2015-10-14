//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h
#import "MusicTableViewController.h"
#import "MusicListTableViewCell.h"
#import "Model.h"
#import "lyricModel.h"
#import "GetDataTools.h"
#import "MusicPlayTools.h"
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHight CGRectGetHeight([UIScreen mainScreen].bounds)

#define KlableX 20
#define Klabley CGRectGetMaxY(self.mainScrollView.frame) + 20
#define KlableW 80
#define KlableH 30



#define KbuttonX 10
#define KbuttonY CGRectGetMaxY([UIScreen mainScreen].bounds) - 104
#define KbuttonW 60
#define KbuttonH 30












































//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif
