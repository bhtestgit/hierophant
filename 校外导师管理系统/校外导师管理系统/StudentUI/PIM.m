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
#import "StudentManager.h"
#import "Student.h"
#import "GetToken.h"
#import <RongIMKit/RongIMKit.h>

@implementation PIM {
    UILabel* _nameD;
    UILabel* _stuIdD;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
    //连接融云connectViewRongyun
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if (token) {
        [[GetToken getToken] connectViewRongyun];
    }
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
    //姓名
    UILabel* _name = [[UILabel alloc] initWithFrame:CGRectMake(16, 100, 40, 37)];
    _name.text = @"姓名";
    _name.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_name];
    _nameD = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_name.frame)+30, CGRectGetMinY(_name.frame), 200, 37)];
    _nameD.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:237/255.0 alpha:1];
    _nameD.layer.cornerRadius = 5.0;
    _nameD.layer.masksToBounds = YES;
    _nameD.layer.borderWidth = 1.0;
    _nameD.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    [self.view addSubview:_nameD];
    //学号
    UILabel* _stuId = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_name.frame)+20, 40, 37)];
    _stuId.text = @"学号";
    _stuId.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_stuId];
    _stuIdD = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_stuId.frame)+30, CGRectGetMinY(_stuId.frame), 200, 37)];
    _stuIdD.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:237/255.0 alpha:1];
    _stuIdD.layer.cornerRadius = 5.0;
    _stuIdD.layer.masksToBounds = YES;
    _stuIdD.layer.borderWidth = 1.0;
    _stuIdD.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_stuIdD];
    
    UIButton* _comfirm = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)/2-100, CGRectGetMaxY(self.view.frame)-120, 80, 37)];
    _comfirm.backgroundColor = [UIColor orangeColor];
    _comfirm.layer.cornerRadius = 5.0;
    _comfirm.layer.masksToBounds = YES;
    _comfirm.layer.borderWidth = 1.0;
    _comfirm.layer.borderColor = [UIColor grayColor].CGColor;
    [_comfirm setTitle:@"修改密码" forState:UIControlStateNormal];
    [_comfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_comfirm addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
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

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)reload {
    //获取数据
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotMessage:) name:@"gotMessage" object:nil];
    [StudentManager getStuByName:name];
}

-(void)gotMessage:(NSNotification *)notice {
    //设置数据
    Student *stu = [[Student alloc] initWithDictionary:notice.object error:nil];
    _nameD.text = stu.name;
    _stuIdD.text = stu.number;
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotMessage" object:nil];
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
            [[RCIM sharedRCIM] disconnect:YES];
        }];
    }
}

-(void)changePassword {
    //修改密码
    __block NSString *password;
    NSString *name = _nameD.text;
    __weak typeof(self)weakSelf = self;
    //弹出框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否更改密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入新密码";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields.firstObject.text != [NSString string]) {
            password = alert.textFields.firstObject.text;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResult:) name:@"UpdateResult" object:nil];
            [StudentManager updateStuWithName:name andPassword:password];
        } else {
            [weakSelf addAlertWithTitle:@"不能为空" andDetail:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)updateResult:(NSNotification *)notice {
    NSInteger s = [[notice.object objectForKey:@"result"] integerValue];
    if (s == 0) {
        [self addAlertWithTitle:@"更新失败" andDetail:nil];
    } else {
        [self addAlertWithTitle:@"更改成功" andDetail:nil];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateResult" object:nil];
}

//通知
-(void)addAlertWithTitle:(NSString *)titleA andDetail:(NSString *)detailA {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:detailA preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"logout" object:nil];
}

@end
