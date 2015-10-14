//
//  MusicPlayTools.h
//  MusicPlayer
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


// 定义协议,进行传值,如果谁想使用本类,必须遵循实现协议中的两个方法
@protocol MusicPlayToolsDelegate <NSObject>
// 播放结束方法,做什么由外界操作
-(void)endOfPlayAction;
// 外界实现这个方法的同时,也将参数的值拿走了,这样我们就实现了通过代理向外界传值的功能
-(void)getCurTime:(NSString *)curTime Totle:(NSString *)totleTime Progress:(CGFloat)progress;

@end

@interface MusicPlayTools : NSObject
// 本类中播放器指针
@property (nonatomic,strong)AVPlayer *player;
// 本类中的  播放中的"歌曲信息模型"
@property (nonatomic,strong)Model *model;
//代理
@property (nonatomic,weak)id<MusicPlayToolsDelegate> delegate;

//单例方法
+(instancetype)shareMusicPlay;


// 播放音乐
-(void)musicPlay;


// 暂停音乐
-(void)musicPause;


// 准备播放
-( void)musicPrePlay;

// 跳转
-(void)seekTotimeWithValue:(CGFloat)value;




// 返回一个歌词数组
-(NSMutableArray *)getMusicLyricArray;

// 根据当前播放时间,返回 对应歌词在数组中的位置
-(NSInteger)getIndexWithCurTime;





-(NSString *)valueToString:(NSInteger)value;
@end
