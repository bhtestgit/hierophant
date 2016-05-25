//
//  PIM.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "PIM.h"
#import <Masonry.h>
#import "ViewController.h"

@implementation PIM

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"个人信息"]];
    
    //姓名
    UILabel* _name = [[UILabel alloc] initWithFrame:CGRectMake(16, 100, 40, 37)];
//    _name.backgroundColor = [UIColor orangeColor];
    _name.layer.cornerRadius = 5.0;
    _name.layer.masksToBounds = YES;
    _name.layer.borderWidth = 1.0;
    _name.layer.borderColor = [UIColor grayColor].CGColor;
    _name.text = @"姓名";
    _name.textAlignment = NSTextAlignmentCenter;
//    _name.textColor = [UIColor whiteColor];
    [self.view addSubview:_name];
    UILabel* _nameD = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_name.frame)+30, CGRectGetMinY(_name.frame), 200, 37)];
    _nameD.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:237/255.0 alpha:1];
    _nameD.layer.cornerRadius = 5.0;
    _nameD.layer.masksToBounds = YES;
    _nameD.layer.borderWidth = 1.0;
    _nameD.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    [self.view addSubview:_nameD];
    //学号
    UILabel* _stuId = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_name.frame)+20, 40, 37)];
//    _stuId.backgroundColor = [UIColor orangeColor];
    _stuId.layer.cornerRadius = 5.0;
    _stuId.layer.masksToBounds = YES;
    _stuId.layer.borderWidth = 1.0;
    _stuId.layer.borderColor = [UIColor grayColor].CGColor;
    _stuId.text = @"学号";
    _stuId.textAlignment = NSTextAlignmentCenter;
//    _stuId.textColor = [UIColor whiteColor];
    [self.view addSubview:_stuId];
    UILabel* _stuIdD = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_stuId.frame)+30, CGRectGetMinY(_stuId.frame), 200, 37)];
    _stuIdD.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:237/255.0 alpha:1];
    _stuIdD.layer.cornerRadius = 5.0;
    _stuIdD.layer.masksToBounds = YES;
    _stuIdD.layer.borderWidth = 1.0;
    _stuIdD.layer.borderColor = [UIColor grayColor].CGColor;
    _stuIdD.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    [self.view addSubview:_stuIdD];
    
    UIButton* _comfirm = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)/2-100, CGRectGetMaxY(self.view.frame)-120, 80, 37)];
    _comfirm.backgroundColor = [UIColor orangeColor];
    _comfirm.layer.cornerRadius = 5.0;
    _comfirm.layer.masksToBounds = YES;
    _comfirm.layer.borderWidth = 1.0;
    _comfirm.layer.borderColor = [UIColor grayColor].CGColor;
    [_comfirm setTitle:@"修改信息" forState:UIControlStateNormal];
    [_comfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_comfirm];
    
    UIButton *logout = [[UIButton alloc] init];
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    logout.backgroundColor = [UIColor greenColor];
    logout.layer.cornerRadius = 5.0;
    logout.layer.masksToBounds = YES;
    logout.layer.borderWidth = 1.0;
    logout.layer.borderColor = [UIColor grayColor].CGColor;
    [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logoutAlert) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toLogout:) name:@"logout" object:nil];
    [self.view addSubview:logout];
    
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 37));
        make.topMargin.equalTo(_comfirm.mas_topMargin);
        make.left.equalTo(_comfirm.mas_right).offset(20);
    }];
}

-(void)logoutAlert {
    //通知是否退出
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"YES", @"isLogout", nil]];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)toLogout:(NSNotification *)sender {
    if ([[sender.userInfo objectForKey:@"isLogout"] isEqualToString:@"YES"]) {
        ViewController *mainView = [[ViewController alloc] init];
        mainView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:mainView animated:YES completion:^{
            //清空用户信息
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
        }];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logout" object:nil];
}

@end
