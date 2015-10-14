//
//  MusicPlayView.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayView.h"


@implementation MusicPlayView


-(instancetype)init
{
    if (self = [super init])
    {
        [self p_setup];
    }
    return self;
}
-(void)p_setup
{
    self.backView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self addSubview:_backView];
    
    
    //1 Scrollow
    self.mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    self.mainScrollView.contentSize = CGSizeMake(2 * kScreenWidth, CGRectGetHeight(self.mainScrollView.frame));
    //self.mainScrollView.backgroundColor = [UIColor redColor];
    self.mainScrollView.alwaysBounceHorizontal = YES;// 水平
    self.mainScrollView.alwaysBounceVertical = NO;// 垂直
    [self addSubview:self.mainScrollView];
    
    //2 headImageView
    self.headImageView = [[UIImageView alloc]init];
    self.headImageView.frame = CGRectMake(0, 0, kScreenWidth  , CGRectGetHeight(self.mainScrollView.frame) - 20);
    self.headImageView.backgroundColor = [UIColor redColor];
    self.headImageView.layer.cornerRadius = kScreenWidth / 2 ;
 
    self.headImageView.layer.masksToBounds = YES;// 设置图片居中
    [self.mainScrollView addSubview:_headImageView];
    
    
    
    //3 lyricTableView
    self.lyricTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, CGRectGetHeight(self.mainScrollView.frame)) style:UITableViewStylePlain];
    [self.mainScrollView addSubview:_lyricTableView];
    
    //4 currentTimeLable
    self.currentTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(KlableX, Klabley, KlableW, KlableH)];
    //self.currentTimeLable.backgroundColor = [UIColor greenColor];
    [self addSubview:_currentTimeLable];
    
    // 5 progressSlideer
    self.progressSlideer = [[UISlider alloc]initWithFrame:CGRectMake(KlableX + 70, Klabley, 175, KlableH)];
    
    //self.progressSlideer.backgroundColor = [UIColor orangeColor];
    [self addSubview:_progressSlideer];
    
    //6 totleTimeLable
    self.totleTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(KlableX + 275, Klabley, KlableW, KlableH)];
    //self.totleTimeLable.backgroundColor = [UIColor blueColor];
    [self addSubview:_totleTimeLable];
    
    self.playPatternButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playPatternButton.frame = CGRectMake(KlableX + 275, Klabley + 80 , 80, 50);
    [self addSubview:_playPatternButton];
    
    //7 lastSongButton
    self.lastSongButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.lastSongButton.frame = CGRectMake(KbuttonX, KbuttonY, KbuttonW, KbuttonH);
    //self.lastSongButton.backgroundColor = [UIColor redColor];
    [self addSubview:_lastSongButton];
    
    //8 playButton
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2 - 30, KbuttonY, KbuttonW, KbuttonH);
    //self.playButton.backgroundColor = [UIColor blueColor];
  
    [self addSubview:_playButton];
    
    //9 nextSongButton
    self.nextSongButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextSongButton.frame = CGRectMake(CGRectGetMaxX([UIScreen mainScreen].bounds) - 70, KbuttonY, KbuttonW, KbuttonH);
    //self.nextSongButton.backgroundColor = [UIColor redColor];
    [self addSubview:_nextSongButton];
    
    
}



@end
