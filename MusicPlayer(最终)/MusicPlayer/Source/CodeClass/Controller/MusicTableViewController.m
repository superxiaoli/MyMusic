//
//  MusicTableViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicTableViewController.h"
#import "MusicPlayViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"


@interface MusicTableViewController ()<MBProgressHUDDelegate>// 遵循代理传值
//@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *musicListArray;
@property (nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic,strong)NSArray *dataarr;



@end

@implementation MusicTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hud = [[MBProgressHUD alloc]init];
    self.hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    self.hud.delegate = self;
    
    [self.tableView registerClass:[MusicListTableViewCell class] forCellReuseIdentifier:@"cell"];
   // [self handleData];
   
    // 数据解析
    [[GetDataTools shareGetDate] getDAtaWithUrl:KURL PassValue:^(NSArray *array) {
        
        self.dataarr = array;
        //在主线程中执行加载
        dispatch_async(dispatch_get_main_queue(), ^{
            
               [self.tableView reloadData];
        });
        
        
     
    }];
  
     //[self setUpData];
    
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_share@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(ringAction:)];
    
    
}
/*
-(void)handleData
{
//    NSURL *url = [NSURL URLWithString:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//       NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:<#(NSJSONReadingOptions)#> error:<#(NSError *__autoreleasing *)#>]
//    }];
    
    
    NSURL *url = [NSURL URLWithString:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"];
    
    // 2. request
    // timeoutInterval 如果5.0之内没有从服务器返回结果，就认为超时了
//    //
//     NSURLRequestUseProtocolCachePolicy = 0,            // 使用协议缓存策略（默认）
//     NSURLRequestReloadIgnoringLocalCacheData = 1,      // 忽略本地缓存数据（断点续传时使用）
//     NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData, == 1
//     
//     // 以下少用
//     NSURLRequestReturnCacheDataElseLoad = 2,           // 如果有缓存，就返回缓存数据，否则加载
//     NSURLRequestReturnCacheDataDontLoad = 3,           // 死活不加载远程服务器数据，如果用户没有网络连接时可以使用
//     
//     // 以下没有实现
//     NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4, // 没有实现
//     NSURLRequestReloadRevalidatingCacheData = 5, // 没有实现
//
    self.dataArr = [NSMutableArray array];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5.0];
    
    // 3. 网络异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"错误 %@", connectionError);
            return;
        }
        
        // data是一个plist数据, 对data进行反序列化，解析
        NSArray *array = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
       // NSLog(@"%@",array);
        
        for (NSDictionary *dict in array)
        {
            Model *m = [[Model alloc]init];
            [m setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:m];
            [self.tableView reloadData];
            
        }
        
        // 刷新数据，在UI线程中更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //.....
        });
    }];
}*/
/*
-(void)setUpData
{
    NSString *url = @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist";
    NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:url]];
   
    self.musicListArray = [NSMutableArray array];
    解析:
    for (NSDictionary *dict in array)
    {
        Model *musicModel = [[Model alloc]init];
        [musicModel setValuesForKeysWithDictionary:dict];
        [self.musicListArray addObject:musicModel];
        [self.tableView reloadData];
        
    }
    [self.hud hide:YES];
}
*/

-(void)ringAction:(UIBarButtonItem *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56177d9b67e58e484000361f"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:nil]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToSms,UMShareToQzone,UMShareToRenren,nil]
                                       delegate:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataarr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //Model *m = self.dataArr[indexPath.row];
    
//    Model *m = self.musicListArray[indexPath.row];
//    
//    cell.picImageView.image = [UIImage imageNamed:@"12.jpg"];
//    cell.songLable.text = m.name;
//    cell.singLable.font = [UIFont systemFontOfSize:14];
//    cell.singLable.text = m.singer;
//    NSURL *url = [NSURL URLWithString:m.picUrl];
//    [cell.picImageView sd_setImageWithURL:url];
    
    
    cell.model = self.dataarr[indexPath.row];
     [self.hud hide:YES];
    
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // 使用单例方法初始化
    MusicPlayViewController *musicVC = [MusicPlayViewController shareMusicplayer];
    [self.navigationController pushViewController:musicVC animated:YES];
    
    Model *m = self.dataarr[indexPath.row];
    
   
    musicVC.image = m.picUrl;
    musicVC.tottime = m.duration;
   
    musicVC.index = indexPath.row;
    
    self.title = @"小李音乐";
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
