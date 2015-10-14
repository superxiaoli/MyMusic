//
//  LogicViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LogicViewController.h"
#import "LogicView.h"
#import "RegsinViewController.h"

@interface LogicViewController ()
@property (nonatomic,strong)LogicView *lv;

@end

@implementation LogicViewController
-(void)loadView
{
    self.lv = [[LogicView alloc]init];
    self.lv.backgroundColor = [UIColor whiteColor];
    self.view = _lv;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    [self.lv.logButton addTarget:self action:@selector(logButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.lv.registButton addTarget:self action:@selector(registButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logButtonAction:(UIButton *)sender
{
    MusicListTableViewController * MusicListVC = [[MusicListTableViewController alloc] init];
    
    [self.navigationController pushViewController:MusicListVC animated:YES];
}

-(void)registButtonAction:(UIButton *)sender
{
    RegsinViewController *reginVC = [[RegsinViewController alloc]init];
    [self.navigationController pushViewController:reginVC animated:YES];
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
