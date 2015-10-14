//
//  GetDataTools.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "GetDataTools.h"

//为单例对象实现一个静态实例，并初始化，然后设置成nil，
static GetDataTools *gd = nil;

@implementation GetDataTools

//单例方法 实例构造检查静态实例是否为nil 如果为空返回本类的实例
+(instancetype)shareGetDate
{
    if (gd == nil)
    {
        //dispatch_once_t 用于检查该代码块是否已经被调度谓词
        //dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{
            gd = [[GetDataTools alloc]init];
                  
        });
    }
    return gd;
}


// 获取数据的方法
-(void)getDAtaWithUrl:(NSString *)URL PassValue:(PassValue) passValue
{
    //
    // 这里用子线程,因为这里在请求数据的;arrayWithContentsOfURL 的方法是同步请求(请求不结束,主线程什么也不能干),因此将请求动作放到子线程中
    // 创建线程队列(全局的)
    dispatch_queue_t glob_t = dispatch_get_global_queue(0, 0);
    
    // 定义子线程的内容
    dispatch_async(glob_t, ^{
        
        // 在这里面的操作不会阻塞主线程
        // 请求数据
        NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:URL]];
        // 解析 将解析好的 歌曲信息模型 加入我们的属性数组中,便于外界随时访问
        for (NSDictionary *dict in array)
        {
            Model *model = [[Model alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
            
            
            
        }
        
        //这个block 是外界传入的 (外界代码放到这里执行),但是我们的属性数组可以作为参数,传递给外界的代码块中,这样外界节能拿到我们的这个数组了
        
        passValue(self.dataArray);
    });
    
    
  
    
    
}

//懒加载初始化数组
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
     
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



-(Model *)getModelWithIndex:(NSInteger)index
{
    
    return self.dataArray[index];
}









@end
