//
//  MusicPlayViewController.h
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicPlayViewController : UIViewController
@property (nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger number;


+(instancetype)shareMusicplayer;


@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *tottime;
@property (nonatomic,strong)NSString *lasttime;



@end
