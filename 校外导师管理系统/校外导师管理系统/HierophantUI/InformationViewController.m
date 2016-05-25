//
//  InformationViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "InformationViewController.h"
#import "DataController.h"
#import <Masonry.h>
#import "ViewController.h"

@interface InformationViewController() {
    UIButton *quiteB;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *change;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *pft;
@property (weak, nonatomic) IBOutlet UITextField *skills;
@property (weak, nonatomic) IBOutlet UITextField *timeOfPft;
@property (weak, nonatomic) IBOutlet UITextField *workUnit;
@property (weak, nonatomic) IBOutlet UITextField *position;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (nonatomic) UILabel *experience;
@property (nonatomic) UITextField *experienceF;

@property (nonatomic) DataController *dataController;
@end

@implementation InformationViewController

-(void)viewDidLoad{
//    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"个人信息"]];
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 800);
    _change.layer.cornerRadius = 5.0;
    _change.layer.masksToBounds = YES;
    
    _experience = [[UILabel alloc] init];
    _experience.text = @"工作经验";
    _experience.bounds = CGRectMake(0, 0, 90, 37);
    _experienceF = [[UITextField alloc] init];
    _experienceF.backgroundColor = [UIColor whiteColor];
    _experienceF.layer.cornerRadius = 5.0;
    _experienceF.layer.masksToBounds = YES;
    
    quiteB = [[UIButton alloc] init];
    [quiteB setTitle:@"退出登录" forState:UIControlStateNormal];
    quiteB.layer.cornerRadius = 5.0;
    quiteB.layer.masksToBounds = YES;
    quiteB.backgroundColor = [UIColor greenColor];
    [quiteB addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quiteB];
    
    [self.view addSubview:_experience];
    [self.view addSubview:_experienceF];
    
    //添加约束
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_birthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_pft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_skills mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_timeOfPft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_workUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
    }];
    
    [_experience mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_email.mas_bottom).offset(20);
        make.centerX.offset(0);
    }];
    
    [_experienceF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_experience.mas_bottom).offset(10);
        make.right.offset(-10);
        make.height.equalTo(@60);
    }];
    
    [_change mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_experienceF.mas_bottom).offset(20);
        make.centerX.offset(-60);
    }];
    
    [quiteB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_change);
        make.centerX.offset(60);
    }];
    
//    [self loadData];
}

-(void)viewDidLayoutSubviews {
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 800);
}

-(void)loadData {
    //获取数据
    _dataController = [[DataController alloc] init];
    NSMutableArray *informations = [NSMutableArray array];
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    
    informations = [_dataController getHierophantData:(NSMutableString *)name];
    _account.text = [informations objectAtIndex:0];
    _password.text = [informations objectAtIndex:1];
    _sex.text = [informations objectAtIndex:2];
    _birthday.text = [informations objectAtIndex:3];
    _pft.text = [informations objectAtIndex:4];
    _skills.text = [informations objectAtIndex:5];
    _timeOfPft.text = [informations objectAtIndex:6];
    _workUnit.text = [informations objectAtIndex:7];
    _position.text = [informations objectAtIndex:8];
    _phone.text = [(NSNumber *)[informations objectAtIndex:9] stringValue];
    _email.text = [informations objectAtIndex:10];
    _experienceF.text = [informations objectAtIndex:11];
}

-(void)quit {
    //通知是否退出
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //退出
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
        ViewController *mainView = [[ViewController alloc] init];
        mainView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:mainView animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
