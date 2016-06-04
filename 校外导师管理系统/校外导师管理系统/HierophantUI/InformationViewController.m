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
#import "HierophentManager.h"
#import "Hierophent.h"
#import "ConnectURL.h"
#import <RongIMKit/RongIMKit.h>
#import "HierophantManager.h"

@interface InformationViewController()<UITextViewDelegate> {
    UIButton *quiteB;
    UIButton *agreeB;
    UIButton *refuseB;
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
@property (nonatomic) UITextView *experienceF;

@property (nonatomic) DataController *dataController;
@end

@implementation InformationViewController

-(void)viewDidLoad{
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"个人信息"]];
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 800);
    _change.layer.cornerRadius = 5.0;
    _change.layer.masksToBounds = YES;
    [_change addTarget:self action:@selector(changeInfo) forControlEvents:UIControlEventTouchUpInside];
    
    _experience = [[UILabel alloc] init];
    _experience.text = @"工作经验";
    _experience.bounds = CGRectMake(0, 0, 90, 37);
    _experienceF = [[UITextView alloc] init];
    _experienceF.backgroundColor = [UIColor whiteColor];
    _experienceF.layer.cornerRadius = 5.0;
    _experienceF.layer.masksToBounds = YES;
    _experienceF.delegate = self;
    
    quiteB = [[UIButton alloc] init];
    [quiteB setTitle:@"退出登录" forState:UIControlStateNormal];
    quiteB.layer.cornerRadius = 5.0;
    quiteB.layer.masksToBounds = YES;
    quiteB.backgroundColor = [UIColor greenColor];
    [quiteB addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quiteB];
    
    agreeB = [[UIButton alloc] init];
    [agreeB setTitle:@"同意" forState:UIControlStateNormal];
    agreeB.layer.cornerRadius = 5.0;
    agreeB.layer.masksToBounds = YES;
    agreeB.backgroundColor = [UIColor redColor];
    [agreeB addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchUpInside];
    agreeB.hidden = YES;
    [self.view addSubview:agreeB];
    
    refuseB = [[UIButton alloc] init];
    [refuseB setTitle:@"拒绝" forState:UIControlStateNormal];
    refuseB.layer.cornerRadius = 5.0;
    refuseB.layer.masksToBounds = YES;
    refuseB.backgroundColor = [UIColor greenColor];
    [refuseB addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
    refuseB.hidden = YES;
    [self.view addSubview:refuseB];
    
    [self.view addSubview:_experience];
    [self.view addSubview:_experienceF];
    
    __weak typeof (self)weakSelf = self;
    //添加约束
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_birthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_pft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_skills mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_timeOfPft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_workUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
    }];
    
    [_experience mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_email.mas_bottom).offset(10);
        make.centerX.offset(0);
    }];
    
    [_experienceF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(_experience.mas_bottom).offset(10);
        make.right.offset(-10);
        make.height.equalTo(@80);
    }];
    
    [_change mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_experienceF.mas_bottom).offset(20);
        make.centerX.offset(-60);
    }];
    
    [agreeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_experienceF.mas_bottom).offset(20);
        make.centerX.offset(-60);
    }];
    
    [quiteB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_change);
        make.centerX.offset(60);
    }];
    
    [refuseB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_change);
        make.centerX.offset(60);
    }];
    
    [self loadData];
}

//修改个人信息
-(void)changeInfo {
    //设置信息
    Hierophent *h = [[Hierophent alloc] init];
    h.name  = _account.text;
    h.password = _password.text;
    h.sex = _sex.text;
    h.birthday = _birthday.text;
    h.pft = _pft.text;
    h.skills = _skills.text;
    h.timeOfPft = _timeOfPft.text;
    h.workUnit = _workUnit.text;
    h.positions = _position.text;
    h.phone = _phone.text;
    h.email = _email.text;
    h.experience = _experienceF.text;
    //连接服务器
    NSDictionary *data = h.toDictionary;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResult:) name:@"updateResult" object:nil];
    [HierophantManager updateHierophantWithData:data];
}

-(void)updateResult:(NSNotification *)notice {
    NSInteger result = [[notice.object objectForKey:@"result"] integerValue];
    if (result == 0) {
        [self addAlertWithTitle:@"更新失败" andDetail:nil];
    } else {
        [self addAlertWithTitle:@"更新成功" andDetail:nil];
    }
    [self loadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateResult" object:nil];
}

-(void)viewDidLayoutSubviews {
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 840);
}

-(void)loadData {
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    NSString *url;
    if ([name isEqualToString:@"HierophantManager"]) {
        name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"hieroId"];
        [ConnectURL appendUrl:@"GetInterHieroByNameServlet"];
        [self.navigationItem setTitle:@"信息"];
        [self changeButton];
    } else {
        [ConnectURL appendUrl:@"GetHieroByNameServlet"];
    }
    url = [ConnectURL shareURL];
    //获取数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInfo:) name:@"gotOneHiero" object:nil];
    
    [HierophentManager getInterHieroByName:name withUrl:url];
}

-(void)updateInfo:(NSNotification *)notice {
    NSDictionary *dic = notice.object;
    if ([dic isEqualToDictionary:[NSDictionary dictionary]]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotOneHiero" object:nil];
        //获取导师信息
        [ConnectURL appendUrl:@"GetHieroByNameServlet"];
        NSString *url = [ConnectURL shareURL];
        NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"hieroId"];
        //获取数据
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAgain:) name:@"gotOneHiero" object:nil];
        
        [HierophentManager getInterHieroByName:name withUrl:url];
    } else {
        Hierophent *hiero = [[Hierophent alloc] initWithDictionary:dic error:nil];
        //设置信息
        _account.text = hiero.name;
        _password.text = hiero.password;
        _sex.text = hiero.sex;
        _birthday.text = hiero.birthday;
        _pft.text = hiero.pft;
        _skills.text = hiero.skills;
        _timeOfPft.text = hiero.timeOfPft;
        _workUnit.text = hiero.workUnit;
        _position.text = hiero.positions;
        _phone.text = hiero.phone;
        _email.text = hiero.email;
        _experienceF.text = hiero.experience;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotOneHiero" object:nil];
    }
}

-(void)updateAgain:(NSNotification *)notice {
    NSDictionary *dic = notice.object;
    Hierophent *hiero = [[Hierophent alloc] initWithDictionary:dic error:nil];
    //设置信息
    _account.text = hiero.name;
    _password.text = hiero.password;
    _sex.text = hiero.sex;
    _birthday.text = hiero.birthday;
    _pft.text = hiero.pft;
    _skills.text = hiero.skills;
    _timeOfPft.text = hiero.timeOfPft;
    _workUnit.text = hiero.workUnit;
    _position.text = hiero.positions;
    _phone.text = hiero.phone;
    _email.text = hiero.email;
    _experienceF.text = hiero.experience;
    //隐藏按钮
    agreeB.hidden = YES;
    refuseB.hidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotOneHiero" object:nil];
}

//管理员查看时
-(void)setButtonByManagerWithName:(NSString *)hieroId {
    [[NSUserDefaults standardUserDefaults] setObject:hieroId forKey:@"hieroId"];
}

-(void)changeButton {
    //隐藏按钮
    _change.hidden = YES;
    quiteB.hidden = YES;
    agreeB.hidden = NO;
    refuseB.hidden = NO;
    //设置信息不可输入
    _account.userInteractionEnabled = NO;
    _password.userInteractionEnabled = NO;
    _sex.userInteractionEnabled = NO;
    _birthday.userInteractionEnabled = NO;
    _pft.userInteractionEnabled = NO;
    _skills.userInteractionEnabled = NO;
    _timeOfPft.userInteractionEnabled = NO;
    _workUnit.userInteractionEnabled = NO;
    _position.userInteractionEnabled = NO;
    _phone.userInteractionEnabled = NO;
    _email.userInteractionEnabled = NO;
    _experienceF.userInteractionEnabled = NO;
}

-(void)quit {
    //通知是否退出
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //退出
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
        [[RCIM sharedRCIM] disconnect:YES];
        ViewController *mainView = [[ViewController alloc] init];
        mainView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:mainView animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//同意申请
-(void)agree {
    //获取name
    NSString *name = _account.text;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(agreeResult:) name:@"agreeResult" object:nil];
    [HierophentManager agreeHieroApplyWithName:name];
}

-(void)agreeResult:(NSNotification *)notice {
    NSInteger r = [[[notice object] objectForKey:@"result"] integerValue];
    NSString *title;
    NSString *detail;
    if (r == 1) {
        title = @"成功";
        detail = [NSString stringWithFormat:@"同意%@为校外导师",_account.text];
    } else {
        title = @"失败";
        detail = @"服务器错误";
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", detail, @"detail", nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"agreeResult" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"configResult" object:dic];
}


//拒绝申请
-(void)refuse {
    //获取name
    NSString *name = _account.text;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refuseResult:) name:@"refuseResult" object:nil];
    [HierophentManager refuseHieroApplyWithName:name];
}

-(void)refuseResult:(NSNotification *)notice {
    NSInteger r = [[[notice object] objectForKey:@"result"] integerValue];
    NSString *title;
    NSString *detail;
    if (r == 1) {
        title = @"成功";
        detail = [NSString stringWithFormat:@"不同意%@为校外导师",_account.text];
    } else {
        title = @"失败";
        detail = @"服务器错误";
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", detail, @"detail", nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refuseResult" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"configResult" object:dic];
}

//键盘上浮
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    int height = textField.frame.origin.y+286-CGRectGetHeight(self.view.bounds);
    int height = 200;
    if (height>0) {
        [UIView beginAnimations:@"keyboardRaiseUp" context:nil];
        [UIView setAnimationDuration:0.3];
        self.view.frame = CGRectMake(0, -height, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }

    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [UIView beginAnimations:@"keyboardDown" context:nil];
    [UIView setAnimationDuration:0.1];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}

//通知
-(void)addAlertWithTitle:(NSString *)titleA andDetail:(NSString *)detailA {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:detailA preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
