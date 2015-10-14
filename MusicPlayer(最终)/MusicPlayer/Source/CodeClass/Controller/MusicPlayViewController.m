//
//  MusicPlayViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicPlayViewController.h"
#import "MusicPlayView.h"
#import "UIImageView+WebCache.h"

static MusicPlayViewController *mt = nil;

@interface MusicPlayViewController ()<MusicPlayToolsDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)MusicPlayView *rv;
@property (nonatomic,strong)NSArray *lyricArray;
@property (nonatomic,strong)AVAudioPlayer *player;


@end

@implementation MusicPlayViewController

-(void)loadView
{
    
    self.rv = [[MusicPlayView alloc]init];
    self.view = _rv;
}


+(instancetype)shareMusicplayer
{
    if (mt == nil)
    {
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{ mt = [[MusicPlayViewController alloc]init];
        });
    }
    return mt;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MusicPlayTools shareMusicPlay].delegate = self;
    
    //设置scrollow不上下滑动
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.rv.lyricTableView.delegate = self;
    self.rv.lyricTableView.dataSource = self;
    
    // 设置播放暂停
    [self.rv.playButton setTitle:@"暂停" forState:UIControlStateNormal];
    [self.rv.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.rv.lastSongButton setTitle:@"上一曲" forState:UIControlStateNormal];
    [self.rv.lastSongButton addTarget:self action:@selector(lastSongButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.rv.nextSongButton setTitle:@"下一曲" forState:UIControlStateNormal];
    [self.rv.nextSongButton addTarget:self action:@selector(nextSongButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rv.progressSlideer addTarget:self action:@selector(progressSlideerAction:) forControlEvents:UIControlEventValueChanged];
    
    self.number = 1;
    [self.rv.playPatternButton setTitle:@"顺序播放" forState:UIControlStateNormal];
    [self.rv.playPatternButton addTarget:self action:@selector(playPatternButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.rv.lyricTableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.rv.lyricTableView.backgroundColor = [UIColor clearColor];
    
   // [self rotate];
    
    
    //为player添加观察者
    [[MusicPlayTools shareMusicPlay].player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"rate"])
    {
        if ([[change valueForKey:@"new"]integerValue] == 0)
        {
            [self.rv.playButton setTitle:@"播放" forState:UIControlStateNormal];
            
        }
        else
        {
            [self.rv.playButton setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }
}


-(void)getCurTime:(NSString *)curTime Totle:(NSString *)totleTime Progress:(CGFloat)progress
{
    
    self.rv.currentTimeLable.text = curTime;
    self.rv.progressSlideer.value = progress;
    self.rv.totleTimeLable.text = totleTime;
    
//    if ([curTime isEqualToString:totleTime])
//    {
//        [self nextSongButtonAction];
//    }
    
    // 让图片转起来
    self.rv.headImageView.transform = CGAffineTransformRotate(self.rv.headImageView.transform, M_PI/360);
    
    
    NSInteger index = [[MusicPlayTools shareMusicPlay]getIndexWithCurTime];
    if (index == -1)
    {
        return;
    }
    NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.rv.lyricTableView selectRowAtIndexPath:tempIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    

    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self p_play];
    
   // [self setUp:self.index];
//    [MusicPlayTools shareMusicPlay].model = [[GetDataTools shareGetDate] getModelWithIndex:self.index];
//    
//    [[MusicPlayTools shareMusicPlay]musicPrePlay];
//    
    
    
    
    
}

-(void)p_play
{
    if ([[MusicPlayTools shareMusicPlay].model isEqual:[[GetDataTools shareGetDate] getModelWithIndex:self.index]])
    {
        return;
    }
    [MusicPlayTools shareMusicPlay].model = [[GetDataTools shareGetDate] getModelWithIndex:self.index];
    
    [[MusicPlayTools shareMusicPlay] musicPrePlay];
    
    // 设置歌曲封面
    [self.rv.headImageView sd_setImageWithURL:[NSURL URLWithString:[MusicPlayTools shareMusicPlay].model.picUrl]];
    
    
    //设置歌词
    self.lyricArray = [[MusicPlayTools shareMusicPlay]getMusicLyricArray];
    
    self.title = [MusicPlayTools shareMusicPlay].model.name;
    
    [self.rv.lyricTableView reloadData];
    
}


-(void)single
{
    [MusicPlayTools shareMusicPlay].model = [[GetDataTools shareGetDate] getModelWithIndex:self.index];
    
    [[MusicPlayTools shareMusicPlay] musicPrePlay];
    
    // 设置歌曲封面
    [self.rv.headImageView sd_setImageWithURL:[NSURL URLWithString:[MusicPlayTools shareMusicPlay].model.picUrl]];
    
    //设置歌词
    self.lyricArray = [[MusicPlayTools shareMusicPlay]getMusicLyricArray];
    [self.rv.lyricTableView reloadData];
    
}


-(void)playPatternButtonAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"单曲循环"])
    {
        
        [sender setTitle:@"顺序播放" forState:UIControlStateNormal];
        
        self.number = 1;
        
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"随机播放"])
    {
        [sender setTitle:@"单曲循环" forState:UIControlStateNormal];
        self.number = 0;
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"顺序播放"])
    {
        [sender setTitle:@"随机播放" forState:UIControlStateNormal];
        self.number = 2;
    }

    
}

-(void)nextSongButtonAction
{
    
    //    if (self.index != 199)
    //    {
    //        [MusicPlayTools shareMusicPlay].model = [[GetDataTools shareGetDate] getModelWithIndex:self.index++];
    //
    //        [[MusicPlayTools shareMusicPlay]musicPrePlay];
    //
    //        //[self setUp:self.index];
    //
    //    }
    //    else
    //    {
    //        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是最后一首了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [view show];
    //    }
    
    
    if (self.index == [GetDataTools shareGetDate].dataArray.count - 1)
    {
        self.index = 0;
    }
    
    else
    {
        self.index ++;
    }
    [self p_play];
}


-(void)endOfPlayAction
{
    // 处理播放模式
    if (self.number == 0)
    {
        self.index ++;
        self.index --;
        [self single];
    }
    else if (self.number == 1)
    {
        [self nextSongButtonAction];
    }
    
    else if (self.number == 2)
    {
        self.index = arc4random()%(199 - 0 + 1) +1;
        [self single];
    }
    
}



-(void)progressSlideerAction:(UISlider *)sender
{
    
    [[MusicPlayTools shareMusicPlay]seekTotimeWithValue:sender.value];
}


// 暂停方法
-(void)playButtonAction:(UIButton *)sender
{
    
    
    //    if ([sender.titleLabel.text isEqualToString:@"暂停"])
    //    {
    //        [[MusicPlayTools shareMusicPlay] musicPause];
    //        [sender setTitle:@"播放" forState:UIControlStateNormal];
    //    }
    //
    //    if ([sender.titleLabel.text isEqualToString:@"播放"])
    //    {
    //        [[MusicPlayTools shareMusicPlay] musicPlay];
    //        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    //    }
    //
    
    // 判断播放器速率
    if ([MusicPlayTools shareMusicPlay].player.rate == 0)
    {
        [self.rv.playButton setTitle:@"暂停" forState:UIControlStateNormal];
        [[MusicPlayTools shareMusicPlay] musicPlay];
    }
    else
    {
        [self.rv.playButton setTitle:@"播放" forState:UIControlStateNormal];
        [[MusicPlayTools shareMusicPlay] musicPause];
        
    }
    
    
    
    
    
}





//-(void)rotate
//{
//    self.rv.headImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
//}

-(void)timeAction
{
    self.rv.headImageView.layer.transform = CATransform3DRotate(self.rv.headImageView.layer.transform, M_PI / 60, 0, 0, 1);
    
}









//
//-(void)setUp:(NSInteger)index
//{
//    Model *m = [[GetDataTools shareGetDate]getModelWithIndex:index];
//    NSURL *url = [NSURL URLWithString:m.picUrl];
//    [self.rv.headImageView sd_setImageWithURL:url];
//    //NSInteger number = [m.duration intValue] / 1000;
//    
//   // NSString *tot = [[MusicPlayTools shareMusicPlay]valueToString:number];
//    
//    //self.rv.totleTimeLable.text = tot;
//}



// 上一曲方法

-(void)lastSongButtonAction:(UIButton *)sender
{
    if (self.index > 0)
    {
//        [MusicPlayTools shareMusicPlay].model = [[GetDataTools shareGetDate] getModelWithIndex:self.index--];
//        
//        [[MusicPlayTools shareMusicPlay]musicPrePlay];
       
        self.index -- ;
    }
    else
    {
//        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是第一首了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [view show];
        self.index = [GetDataTools shareGetDate].dataArray.count - 1;
    }
    
    [self p_play];
    
}
// 下一曲方法

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lyricArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view;
    
    cell.textLabel.text = [self.lyricArray[indexPath.row]valueForKey:@"lyricStr"];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}





@end
