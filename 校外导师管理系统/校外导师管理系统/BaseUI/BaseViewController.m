//
//  BaseViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/3/2.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

//自定义初始化
- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        _currentTitle = title;
        _imageName = image;
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:tag];
        [item setSelectedImage:[UIImage imageNamed:selectedImage]];
        
        self.tabBarItem = item;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

-(void)initializeAppearance{
    self.navigationItem.title = _currentTitle;
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
