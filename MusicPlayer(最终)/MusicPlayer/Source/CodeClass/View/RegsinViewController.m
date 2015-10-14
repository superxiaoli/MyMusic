//
//  RegsinViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "RegsinViewController.h"
#import "RegsinView.h"

@interface RegsinViewController ()
@property (nonatomic,strong)RegsinView *rgv;

@end

@implementation RegsinViewController

-(void)loadView
{
    self.rgv = [[RegsinView alloc]init];
    self.rgv.backgroundColor = [UIColor whiteColor];
    self.view = _rgv;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
