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

@interface InformationViewController() {
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

@property (nonatomic) DataController *dataController;
@end

@implementation InformationViewController

-(void)viewDidLoad{
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"个人信息"]];
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 700);
    _change.layer.cornerRadius = 5.0;
    _change.layer.masksToBounds = YES;
    
    //添加约束
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_birthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_pft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_skills mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_timeOfPft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_workUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
    }];
    
    [_change mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_email.mas_bottom).offset(20);
    }];
    
    [self loadData];
}

-(void)viewDidLayoutSubviews {
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 700);
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
}

@end
