//
//  RegistView.m
//  校外导师管理系统
//
//  Created by 柏涵 on 16/2/22.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "RegistView.h"
#import "LoginController.h"
#import "HieroViewController.h"
#import "RegistController.h"
#import <SVProgressHUD.h>

@interface RegistView ()<UITextFieldDelegate>{
}

@property(nonatomic)UITextField* countTextField;
@property(nonatomic)UITextField* numberTextField;
@property(nonatomic)UITextField* passwordTextField;
@property(nonatomic)BOOL isNill;
@end

#define MIDY CGRectGetMidY(self.view.frame)
#define MIDX CGRectGetMidX(self.view.frame)
#define SCREEN_W CGRectGetWidth(self.view.bounds)
#define SCREEN_H CGRectGetHeight(self.view.bounds)
@implementation RegistView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeAppearance];
}

//初始化界面
- (void)initializeAppearance {
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"注册界面"]];
    self.view.backgroundColor = [UIColor whiteColor];
    //登陆图片
    UIImageView *_imageView = [[UIImageView alloc] init];
    _imageView.center = CGPointMake(CGRectGetMidX(self.view.frame), 125);
    _imageView.bounds = CGRectMake(0, 0, 200, 200);
    _imageView.layer.masksToBounds = YES;
    _imageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_imageView];
    
    //账户、密码标签
    UILabel *_countLable = [[UILabel alloc] initWithFrame:CGRectMake(30, MIDY, 40, 37)];
    _countLable.text = @"账户";
    _countLable.textColor = [UIColor greenColor];
    //学号
    UILabel *_numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, MIDY + 60, 40, 37)];
    _numberLabel.text = @"学号";
    _numberLabel.textColor = [UIColor greenColor];
    //密码
    UILabel *_passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, MIDY + 120, 40, 37)];
    _passwordLabel.text = @"密码";
    _passwordLabel.textColor = [UIColor greenColor];
    
    [self.view addSubview:_countLable];
    [self.view addSubview:_numberLabel];
    [self.view addSubview:_passwordLabel];
    
    //账户、密码输入框
    _countTextField = [[UITextField alloc] init];
    _countTextField.delegate = self;
    _countTextField.bounds = CGRectMake(0, 0, SCREEN_W *0.62, 40);
    _countTextField.center = CGPointMake(MIDX+20, _countLable.center.y);
    _countTextField.borderStyle = UITextBorderStyleRoundedRect;  //圆角
    _countTextField.placeholder = @"之后不能修改";
    [_countTextField addTarget:self action:@selector(textOnEdit) forControlEvents:UIControlEventEditingChanged];
    //学号
    _numberTextField = [[UITextField alloc] init];
    _numberTextField.delegate = self;
    _numberTextField.bounds = CGRectMake(0, 0, SCREEN_W *0.62, 40);
    _numberTextField.center = CGPointMake(MIDX+20, _numberLabel.center.y);
    _numberTextField.borderStyle = UITextBorderStyleRoundedRect;  //圆角
    _numberTextField.placeholder = @"之后不能修改";
    _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_numberTextField addTarget:self action:@selector(textOnEdit) forControlEvents:UIControlEventEditingChanged];
    //密码
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.delegate = self;
    _passwordTextField.center = CGPointMake(MIDX+20, _passwordLabel.center.y);
    _passwordTextField.bounds = CGRectMake(0, 0, SCREEN_W *0.62, 40);
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    [_passwordTextField addTarget:self action:@selector(textOnEdit) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_countTextField];
    [self.view addSubview:_numberTextField];
    [self.view addSubview:_passwordTextField];
    
    //确定按钮
    UIButton *_loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.tag = 11;
    _loginButton.frame = CGRectMake(MIDX-90, CGRectGetMaxY(_passwordLabel.frame)+40, 60, 37);
    [_loginButton setTitle:@"确定" forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor orangeColor];
    _loginButton.layer.cornerRadius = 10;
    _isNill = YES;
    [_loginButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* _cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancle.tag = 21;
    _cancle.frame = CGRectMake(MIDX+30, CGRectGetMinY(_loginButton.frame), 60, 37);
    [_cancle setTitle:@"取消" forState:UIControlStateNormal];
    _cancle.backgroundColor = [UIColor greenColor];
    _cancle.layer.cornerRadius = 10;
    [_cancle addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cancle];
    [self.view addSubview:_loginButton];
}

//连接数据库,判断并跳转
- (void)buttonPressed:(UIButton *)sender {
    if (sender.tag == 11) {
        if (_isNill) {
            [self addAlert:(NSMutableString *)@"不能为空" message:(NSMutableString *)@"密码或名字不能为空"];
        } else {
            //添加监听
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toStuView:) name:@"registStu" object:nil];
            RegistController *registController = [[RegistController alloc] init];
            [SVProgressHUD show];
            [registController registWithName:(NSMutableString *)_countTextField.text number:(NSMutableString *)_numberTextField.text password:(NSMutableString *)_passwordTextField.text
             ];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)toStuView:(NSNotification *)notic{
    NSMutableArray *array = [notic object];
    BOOL s = [array objectAtIndex:0];
    
    if (s == NO) {
        //提示注册失败
        [self addAlert:(NSMutableString *)@"用户已存在，注册失败" message:nil];
    } else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:nil];
        }];
    }
    //删除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registStu" object:nil];
}

-(void)addAlert:(NSMutableString *)title message:(NSMutableString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//监听
-(void)textOnEdit {
    _isNill = [_countTextField.text isEqualToString:[NSString string]] || [_passwordTextField.text isEqualToString:[NSString string]]|| [_numberTextField.text isEqualToString:[NSString string]];
}

//回收键盘

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:@"keyboardDown" context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_countTextField resignFirstResponder];
    [_numberTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

//判断键盘上浮
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //获取文本距离底部高度
    int height = textField.frame.origin.y+286-SCREEN_H;
    //判断是否遮挡
    if (height>0) {
        [UIView beginAnimations:@"keyboardRaiseUp" context:nil];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, -height, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        
    }
    return YES;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registStu" object:nil];
}

@end
