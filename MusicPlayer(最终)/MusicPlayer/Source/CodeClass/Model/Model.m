//
//  Model.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Model.h"

@implementation Model
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        self.ID = value;
    }
    if ([key isEqualToString:@"lyric"])
    {
        self.timeLyric = [value componentsSeparatedByString:@"\n"];
    }
}



@end
