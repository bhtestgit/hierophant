//
//  StudentViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/3/2.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "StudentViewController.h"
#import "PIM.h"
#import "Choose.h"
#import "Subject.h"
#import "InformationOfHierophant.h"

@interface StudentViewController()<UITabBarControllerDelegate>

@property(nonatomic)UITabBarController* mainView;

@end

@implementation StudentViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeAppearance];
}

//初始化界面
-(void)initializeAppearance{
//    self.view.backgroundColor = [UIColor whiteColor];
    //设置加载四个界面,创建navigateView
    PIM *pimView = [[PIM alloc] initWithTitle:@"个人" image:@"icon_person" selectedImage:@"icon_person_selected" tag:0];
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:pimView];
    
    Choose *chooseView = [[Choose alloc] initWithTitle:@"选择" image:@"icon_choose" selectedImage:@"icon_choose_selected" tag:1];
    UINavigationController *chooseNav = [[UINavigationController alloc] initWithRootViewController:chooseView];
    
    Subject *subjectView = [[Subject alloc] initWithTitle:@"题目" image:@"icon_subject" selectedImage:@"icon_subject_selected" tag:2];
    UINavigationController *sujectNav = [[UINavigationController alloc] initWithRootViewController:subjectView];
    
    InformationOfHierophant *IHView = [[InformationOfHierophant alloc] initWithTitle:@"导师信息" image:@"icon_Hierophant" selectedImage:@"icon_Hierophant_selected" tag:3];
    UINavigationController *IHNav = [[UINavigationController alloc] initWithRootViewController:IHView];
    
    //创建tabBarView
    _mainView = [[UITabBarController alloc] init];
    _mainView.delegate = self;
    [_mainView setSelectedIndex:0];
    _mainView.view.backgroundColor = [UIColor whiteColor];
    _mainView.viewControllers = @[personNav, chooseNav, sujectNav, IHNav];
    
    [self.view addSubview:_mainView.view];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
        
    }
}

@end
