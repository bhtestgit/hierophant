//
//  HieroViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "HieroViewController.h"
@interface HieroViewController() {
}

@property(nonatomic)UITabBarController* tabBar;

@end

@implementation HieroViewController

-(void)viewDidLoad {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _tabBar = [storyboard instantiateViewControllerWithIdentifier:@"HieroTabBar"];
    _tabBar.view.backgroundColor = [UIColor whiteColor];
    [_tabBar setSelectedIndex:0];
    
    [self.view addSubview:_tabBar.view];
}

@end
