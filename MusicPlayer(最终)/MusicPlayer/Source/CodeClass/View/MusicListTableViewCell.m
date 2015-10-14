//
//  MusicListTableViewCell.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicListTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MusicListTableViewCell


-(void)setModel:(Model *)model
{
    self.songLable.text = model.name;
    self.singLable.text = model.singer;
    self.singLable.font = [UIFont systemFontOfSize:12];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
}



-(UIImageView *)picImageView
{
    if (_picImageView == nil)
    {
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80,80)];
        //self.picImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_picImageView];
    }
    return _picImageView;
}


-(UILabel *)songLable
{
    if (_songLable == nil)
    {
        self.songLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame), CGRectGetMinY(self.picImageView.frame), 200, 40)];
        //self.songLable.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_songLable];
    }
    return _songLable;
  
}

-(UILabel *)singLable
{
    if (_singLable == nil)
    {
        self.singLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame), CGRectGetMinY(self.picImageView.frame) + 25, 200, 40)];
        //self.songLable.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_singLable];
    }
    return _singLable;
    
}










- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
