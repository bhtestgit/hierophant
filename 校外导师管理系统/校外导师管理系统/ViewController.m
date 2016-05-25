//
//  ViewController.m
//  校外导师管理系统
//
//  Created by 柏涵 on 16/2/22.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ViewController.h"
#import "RegistView.h"
#import "HierophantApply.h"
#import "StudentViewController.h"
#import "HieroViewController.h"
#import "LoginController.h"
#import <AFNetworking.h>
#import "Student.h"
#import "ConnectURL.h"
#import <SVProgressHUD.h>

@interface ViewController (){
    UIButton *_login;
    UIButton *_regist;
    UIButton *_employ;
    NSMutableString *_name;
    NSMutableString *_password;
}

@property(nonatomic)StudentViewController *stuVC;

@end
#define MIDX CGRectGetMidX(self.view.bounds)
#define MAXY CGRectGetMaxY(self.view.bounds)
#define IMAGEMAXY CGRectGetMaxY(_image.frame)

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeAppearance];
}

//初始化
- (void)initializeAppearance {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //图片
    UIImageView *_image = [[UIImageView alloc] init];
    _image.center = CGPointMake(CGRectGetMidX(self.view.frame), 124);
    _image.bounds = CGRectMake(0, 0, 200, 200);
    [_image setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:_image];
    
    //登陆按钮
    _login = [UIButton buttonWithType:UIButtonTypeCustom];
    _login.tag = 11;
    [_login setTitle:@"登陆" forState:UIControlStateNormal];
    [_login setBackgroundColor:[UIColor redColor]];
    _login.center = CGPointMake(MIDX, IMAGEMAXY+(MAXY-IMAGEMAXY)/3);
    _login.bounds = CGRectMake(0, 0, 100, 37);
    _login.layer.cornerRadius = 10;
    //点击事件
    [_login addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_login];
    
    //注册按钮
    _regist = [UIButton buttonWithType:UIButtonTypeCustom];
    _regist.tag = 12;
    _regist.center = CGPointMake(MIDX, CGRectGetMaxY(_login.frame)+(MAXY-CGRectGetMaxY(_login.frame))/4);
    _regist.bounds = CGRectMake(0, 0, 100, 37);
    _regist.layer.cornerRadius = 10;
    [_regist setTitle:@"学生注册" forState:UIControlStateNormal];
    [_regist setBackgroundColor:[UIColor greenColor]];
    [_regist addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_regist];
    
    //应聘导师按钮
    _employ = [UIButton buttonWithType:UIButtonTypeCustom];
    _employ.tag = 13;
    _employ.center = CGPointMake(MIDX, CGRectGetMaxY(_regist.frame)+(MAXY-CGRectGetMaxY(_login.frame))/4);
    _employ.bounds = CGRectMake(0, 0, 100, 37);
    [_employ setTitle:@"导师申请" forState:UIControlStateNormal];
    _employ.layer.cornerRadius = 10;
    [_employ setBackgroundColor:[UIColor blackColor]];
    [_employ addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_employ];
}

//点击事件
- (void)buttonPressed:(UIButton *)sender {
    //登陆弹窗
    if (sender.tag == 11) {
        UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [loginAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"用户名";
        }];
        [loginAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"密码";
            textField.secureTextEntry = YES;
        }];
        [loginAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        __weak typeof(self)weakSelf = self;
        [loginAlert addAction:[UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([loginAlert.textFields.firstObject.text isEqualToString:@""] || [loginAlert.textFields.lastObject.text isEqualToString:@""]) {
                [weakSelf addAlert:(NSMutableString *)@"不能为空" message:(NSMutableString *)@"用户名和密码不能为空"];
            } else {
                //登陆过程
                _name = (NSMutableString *)loginAlert.textFields.firstObject.text;
                _password = (NSMutableString *)loginAlert.textFields.lastObject.text;
                LoginController *loginController = [[LoginController alloc] init];
                [loginController login:_name password:_password];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toLogin:) name:@"isLogin" object:nil];
            }
        }
        ]];
        
        [self presentViewController:loginAlert animated:YES completion:nil];
    } else if (sender.tag == 12) {
        //注册界面
        //添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(success) name:@"success" object:nil];
        RegistView *registView = [[RegistView alloc] init];
        registView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:registView animated:YES completion:nil];
    } else {
        //导师申请界面
        HierophantApply *hierophant = [[HierophantApply alloc] init];
        hierophant.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:hierophant animated:YES completion:nil];
    }
}

//跳转界面
-(void)toLogin:(NSNotification *)notice {
    NSMutableArray *array = notice.object;
    int s = (int)[[array objectAtIndex:0] integerValue];
    
    if (s == 0) {
        [self addAlert:(NSMutableString *)@"登录失败" message:nil];
    } else if (s == 1) {
        
    } else if (s == 2) {
        //老师
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HieroViewController *hieroView = [storyboard instantiateViewControllerWithIdentifier:@"HieroTabBar"];
        [self presentViewController:hieroView animated:YES completion:nil];
    } else if (s == 3) {
        //学生
        StudentViewController *studentView = [[StudentViewController alloc] init];
        studentView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:studentView animated:YES completion:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isLogin" object:nil];
}

-(void)success {
    [self addAlert:(NSMutableString *)@"注册成功" message:(NSMutableString *)@"现在可以登陆了"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"success" object:nil];
}

-(void)addAlert:(NSMutableString *)title message:(NSMutableString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"success" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isLogin" object:nil];
}

@end
