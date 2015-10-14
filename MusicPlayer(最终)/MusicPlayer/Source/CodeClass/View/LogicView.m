//
//  LogicView.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "LogicView.h"

@implementation LogicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    self.userLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, 100, 50)];
    self.userLable.text = @"用户名:";
    //self.userLable.backgroundColor = [UIColor redColor];
    [self addSubview:_userLable];
    
    
    self.passLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLable.frame), CGRectGetMaxY(self.userLable.frame) + 20, 100, 50)];
    self.passLable.text = @"密码:";
    [self addSubview:_passLable];
    
    self.userTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLable.frame) + 20, CGRectGetMinY(self.userLable.frame), 150, 40)];
    //self.userTextField.backgroundColor = [UIColor grayColor];
    self.userTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.userTextField.placeholder = @"请输入用户名";
    [self addSubview:_userTextField];
    
    
    self.passTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLable.frame) + 20, CGRectGetMaxY(self.userLable.frame) + 20, 150, 40)];
    //self.passTextField.backgroundColor = [UIColor grayColor];
    self.passTextField.placeholder = @"请输入密码";
    self.passTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passTextField.secureTextEntry = YES;
    [self addSubview:_passTextField];
    
    
    self.logButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.logButton.frame = CGRectMake(CGRectGetMaxX(self.userLable.frame) - 50, CGRectGetMaxY(self.userLable.frame) + 110, 100, 50);
     //self.logButton.backgroundColor = [UIColor redColor];
    //[self.logButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.logButton  setBackgroundImage:[UIImage imageNamed:@"login_button.png"] forState:UIControlStateNormal];
    [self addSubview:_logButton];
    
    
    
    
    self.registButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registButton.frame = CGRectMake(CGRectGetMaxX(self.userLable.frame) + 70, CGRectGetMaxY(self.userLable.frame) + 110, 100, 50);
    //self.registButton.backgroundColor = [UIColor yellowColor];
    [self.registButton setBackgroundImage:[UIImage imageNamed:@"register_button.png"] forState:UIControlStateNormal];
    
    //[self.registButton setTitle:@"注册" forState:UIControlStateNormal];
    [self addSubview:_registButton];
    
    
    
}


@end
