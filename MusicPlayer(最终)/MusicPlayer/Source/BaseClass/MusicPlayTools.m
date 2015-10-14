//
//  MusicPlayTools.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayTools.h"

static MusicPlayTools *mp = nil;
//定时器 写在延展
@interface MusicPlayTools ()
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation MusicPlayTools

// 单例方法
+(instancetype)shareMusicPlay
{
    if (mp == nil)
    {
        static dispatch_once_t once_token;
        dispatch_once (&once_token,^{
            mp = [[MusicPlayTools alloc]init];
        });
    }
    return mp;
}

// 重写init方法
// 为什么要重写呢, 因为,我们应该得到"某首歌播放结束"这一事件,之后由外界决定播放之后采取什么操作,
// AVPlay并没有通过block或者代理返回这一状态(事件),而是向通知中心注册了一条通知,(AVPlayerItemDidPlayToEndTimeNotification),我们也只有这一条途径获取播放结束这一事件
// 所以,我们在创建一个播放器时([[AVPlayer alloc]init]), 我们立刻为通知中心添加一个观察者,来观察这一事件的发生,
// 这个动作放在init中,最合理也最及时

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _player = [[AVPlayer alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endOfPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
    
    
}
// 播放结束的方法,由代理实现

-(void)endOfPlay:(NSNotification *)sender
{
    // 为什么要先暂停一下呢?
    // 因为对于已经存在的计时器,只有musicPause方法才会使之停止和注销.
    [self musicPause];
    [self.delegate endOfPlayAction];
}

// 准备播放,我们在外部调用播放器播放的时候,不会直接播放,而是调用这个"直接播放",当它准备好时候,会直接播放
-(void)musicPrePlay
{
    // 通过下面的逻辑,只要AVPlayer有currentItem,那么一定被添加了观察者
    // 所以上来直接移除
    if (self.player.currentItem)
    {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    
    // 根据传入的url ,创建一个Item对象
    // initWithURL的初始化方法建立异步链接,什么时候连接建立完成我们不知道,但是他完成链接之后,会修改自身内部的属性status ,所以,我们要观察这个属性,当他的状态变为AVPlayerItemStatusReadyToPlay时,我们便能得知,播放器已经准备好了,可以播放了.
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.model.mp3Url]];
    //添加观察者
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
}


//
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        switch ([[change valueForKey:@"new"] integerValue])
        {
            case AVPlayerItemStatusUnknown:
                NSLog(@"不知道什么错误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                [self musicPlay];// 只有观察到status变为这种状态,才会真正的播放.
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"准备失败");// mini设备不插耳机或者某些耳机会导致准备失败.
                break;
            default:
                break;
        }
    }
}

// 播放
-(void)musicPlay
{
    // 如果计时器已经存在了,说明已经在播放中,直接返回.
    // 对于已经存在的计时器,只有musicPause方法才会使之停止和注销.
    if (self.timer != nil)
    {
        return;
    }
    
    // 播放后,我们开启一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    
    
    [self.player play];
    
}
// 实现方法
-(void)timerAction:(NSTimer *)sender
{
    // 重点!!! 计时器的处理方法中,不断的调用代理方法,将播放进度返回出去.
    // 一定要掌握这种形式.
    [self.delegate getCurTime:[self valueToString:[self getCurTime]] Totle:[self valueToString:[self getTotleTime]] Progress:[self getProgess]];
}

//暂停
-(void)musicPause
{
    [self.timer invalidate];//计时器销毁
     self.timer = nil;
    [self.player pause];
}

//跳转方法
-(void)seekTotimeWithValue:(CGFloat)value
{
    //先暂停
    [self musicPause];
    // 跳转
    
    [self.player seekToTime:CMTimeMake(value * [self getTotleTime], 1) completionHandler:^(BOOL finished) {
        
        if (finished == YES)
        {
            [self musicPlay];
        }
    }];
}




//方法获取当前时间

-(NSInteger)getCurTime
{
    if (self.player.currentItem)// 判断音乐文件是否存在
    {
        return self.player.currentTime.value / self.player.currentTime.timescale;
    }
    return 0;
}

//获取播放总时长
-(NSInteger)getTotleTime
{
    CMTime totleTime = [self.player.currentItem duration];
    if (totleTime.timescale == 0)
    {
        return 1;
    }
    else
    {
        return totleTime.value / totleTime.timescale;
    }
}

// 获取当前播放进度
-(CGFloat)getProgess
{
    return (CGFloat)[self getCurTime] / (CGFloat)[self getTotleTime];
}

//// 将整数秒转换为 00:00 格式的字符串
-(NSString *)valueToString:(NSInteger)value
{
    return [NSString stringWithFormat:@"%.2ld:%.2ld",value / 60,value % 60];
}

//处理歌词方法
-(NSMutableArray *)getMusicLyricArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in self.model.timeLyric)
    {
        if (str.length == 0)
        {
            continue;
        }
//        lyricModel *model = [[lyricModel alloc]init];
//        model.lyricTime = [str substringWithRange:NSMakeRange(1, 9)];
//        model.lyricStr = [str substringFromIndex:11];
//        [array addObject:model];
        NSRange rang = [str rangeOfString:@"]"];
        lyricModel * model = [[lyricModel alloc]init];
        model.lyricTime = [str substringWithRange:NSMakeRange(0, rang.location - 1)];
        model.lyricStr = [str substringFromIndex:rang.location + 1];
        [array addObject:model];

        
    }
    return array;
}


-(NSInteger)getIndexWithCurTime
{
    NSInteger index = 0;
    NSString *curTime = [self valueToString:[self getCurTime]];
    for (NSString *str in self.model.timeLyric)
    {
        if (str.length == 0)
        {
            continue;
        }
        if ([curTime isEqualToString:[str substringWithRange:NSMakeRange(1, 5)]])
        {
            return index;
        }
        index++;
    }
    return -1;
    
}












@end
