//
//  MusicListTableViewCell.h
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Model.h"
@interface MusicListTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *picImageView;
@property (nonatomic,strong)UILabel *songLable;
@property (nonatomic,strong)UILabel *singLable;

@property (nonatomic,strong)Model *model;


@end
