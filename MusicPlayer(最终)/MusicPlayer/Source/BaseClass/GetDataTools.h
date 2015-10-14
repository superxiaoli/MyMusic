//
//  GetDataTools.h
//  MusicPlayer
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
// 定义一个block 用来传值
typedef void (^PassValue)(NSArray *array);



@interface GetDataTools : NSObject

// 在单例中创建一个属性,可以使这个数组在任何地方任何时间被访问
@property (nonatomic,strong)NSMutableArray *dataArray;




//单例方法111111122222
+(instancetype)shareGetDate;

// 获取数据的方法

// 根据传入的URl,通过Block返回一个数组,是Block回传值的形式
-(void)getDAtaWithUrl:(NSString *)URL PassValue:(PassValue) passValue;


-(Model *)getModelWithIndex:(NSInteger)index;


@end
