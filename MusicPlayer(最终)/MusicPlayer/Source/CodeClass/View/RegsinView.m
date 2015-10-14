//
//  RegsinView.m
//  MusicPlayer
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "RegsinView.h"

@implementation RegsinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    
    self.userLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, 100, 30)];
    self.userLab.text = @"用户名:";
    //self.userLab.backgroundColor = [UIColor redColor];
    [self addSubview:_userLab];
    
    
    self.passLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLab.frame), CGRectGetMaxY(self.userLab.frame) + 20, 100, 30)];
    self.passLab.text = @"密码:";
    //self.passLab.backgroundColor = [UIColor yellowColor];
    [self addSubview:_passLab];
    
    self.confirmPasswordLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLab.frame), CGRectGetMaxY(self.userLab.frame) + 70, 100, 30)];
    self.confirmPasswordLab.text = @"确认密码:";
    //self.confirmPasswordLab.backgroundColor = [UIColor greenColor];
    [self addSubview:_confirmPasswordLab];
    
    self.emailLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLab.frame), CGRectGetMaxY(self.userLab.frame) + 120, 100, 30)];
    self.emailLab.text = @"邮箱:";
    //self.emailLab.backgroundColor = [UIColor greenColor];
    [self addSubview:_emailLab];
    
    
    self.telephoneLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userLab.frame), CGRectGetMaxY(self.userLab.frame) + 170, 100, 30)];
    self.telephoneLab.text = @"联系方式:";
    //self.telephoneLab.backgroundColor = [UIColor greenColor];
    [self addSubview:_telephoneLab];
    
    
    self.userText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLab.frame) + 20, CGRectGetMinY(self.userLab.frame), 150, 30)];
    self.userText.placeholder = @"请输入用户名:";
    self.userText.borderStyle = UITextBorderStyleRoundedRect;
    // ≈çself.userText.
    //self.userText.backgroundColor = [UIColor orangeColor];
    [self addSubview:_userText];
    
    
    self.passText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLab.frame) + 20, CGRectGetMinY(self.userLab.frame) + 50, 150, 30)];
    self.passText.placeholder = @"请输入密码";
    self.passText.secureTextEntry = YES;
    self.passText.borderStyle = UITextBorderStyleRoundedRect;
    //self.passText.backgroundColor = [UIColor orangeColor];
    [self addSubview:_passText];
    
    
    self.confirmPassText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLab.frame) + 20, CGRectGetMinY(self.userLab.frame) + 100, 150, 30)];
    self.confirmPassText.placeholder = @"请再次输入密码";
    self.confirmPassText.secureTextEntry = YES;
    self.confirmPassText.borderStyle = UITextBorderStyleRoundedRect;
    //self.confirmPassText.backgroundColor = [UIColor orangeColor];
    [self addSubview:_confirmPassText];
    
    
    self.emailText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLab.frame) + 20, CGRectGetMinY(self.userLab.frame) + 150, 150, 30)];
    self.emailText.placeholder = @"请输入邮箱";
    self.emailText.borderStyle = UITextBorderStyleRoundedRect;
    //self.emailText.backgroundColor = [UIColor orangeColor];
    [self addSubview:_emailText];
    
    
    self.telephoneText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userLab.frame) + 20, CGRectGetMinY(self.userLab.frame) + 200, 150, 30)];
    self.telephoneText.placeholder = @"请输入联系方式";
    self.telephoneText.borderStyle = UITextBorderStyleRoundedRect;
    //self.telephoneText.backgroundColor = [UIColor orangeColor];
    [self addSubview:_telephoneText];
    
    
    self.regsinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.regsinBtn.frame = CGRectMake(CGRectGetMaxX(self.userLab.frame) - 10, CGRectGetMinY(self.userLab.frame) + 260, 100, 50);
    [self.regsinBtn setBackgroundImage:[UIImage imageNamed:@"register_button.png"] forState:UIControlStateNormal];
    [self addSubview:_regsinBtn];

    
    
}

@end
