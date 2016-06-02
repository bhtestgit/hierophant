//
//  InformationOfHierophant.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "InformationOfHierophant.h"
#import <Masonry.h>

@implementation InformationOfHierophant

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"交流界面"]];
    UILabel *name = [[UILabel alloc] init];
    name.bounds = CGRectMake(0, 0, 100, 40);
    name.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(60);
    }];
    //获取导师信息
    //添加联系按钮
    UIButton *connect = [[UIButton alloc] init];
    connect.bounds = CGRectMake(0, 0, 60, 40);
    if ([name.text isEqualToString:@""]) {
        connect.enabled = NO;
    } else {
        connect.enabled = YES;
    }
    connect.backgroundColor = [UIColor redColor];
    [connect setTitle:@"联系" forState:UIControlStateNormal];
    connect.layer.cornerRadius = 5.0;
    connect.layer.masksToBounds = YES;
    [self.view addSubview:connect];
    [connect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(80);
    }];
    //添加题目节 main
}

@end
