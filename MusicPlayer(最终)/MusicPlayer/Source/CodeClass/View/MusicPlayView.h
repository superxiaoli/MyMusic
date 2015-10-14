//
//  MusicPlayView.h
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayView : UIView
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UITableView *lyricTableView;
@property (nonatomic,strong)UILabel *currentTimeLable;
@property (nonatomic,strong)UISlider *progressSlideer;
@property (nonatomic,strong)UILabel *totleTimeLable;
@property (nonatomic,strong)UIButton *lastSongButton;
@property (nonatomic,strong)UIButton *playButton;
@property (nonatomic,strong)UIButton *nextSongButton;

@property (nonatomic,strong)UIImageView *backView;

@property (nonatomic,strong)UIButton *playPatternButton;






@end
