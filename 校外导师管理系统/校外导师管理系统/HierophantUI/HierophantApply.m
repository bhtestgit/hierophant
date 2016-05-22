//
//  HierophantApply.m
//  校外导师
//
//  Created by 柏涵 on 16/3/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "HierophantApply.h"
#import "HieroViewController.h"

@interface HierophantApply()<UITextFieldDelegate>

//测试界面
@property(nonatomic)HieroViewController* hieroView;
//创建scrollView
@property(nonatomic)UIScrollView *mainView;
//创建姓名、性别、生日、职称标签及textField
@property(nonatomic)UITextField* countF;
@property(nonatomic)UITextField* passwordF;
@property(nonatomic)UILabel* sexL;
@property(nonatomic)UILabel* birthdayL;
@property(nonatomic)UILabel* PFTL;
@property(atomic)UITextField* sexF;
@property(atomic)UITextField* birthdayF;
@property(atomic)UITextField* PFTF;
//创建技术专长标签及textField(比较大)
@property(nonatomic)UILabel* skillsL;
@property(atomic)UITextView* skillsF;
//创建职称获得时间、工作单位、行政职务、联系电话、email标签及其textField
@property(nonatomic)UILabel* timeOfPFTL;
@property(nonatomic)UILabel* workUnitL;
@property(nonatomic)UILabel* positionsL;
@property(nonatomic)UILabel* phoneNL;
@property(nonatomic)UILabel* emailL;
@property(atomic)UITextField* timeOfPFTF;
@property(atomic)UITextField* workUnitF;
@property(atomic)UITextField* positionsF;
@property(atomic)UITextField* phoneNF;
@property(atomic)UITextField* emailF;
//创建教师职责、创建工作或学习经历
@property(nonatomic)UITextView* duty;
@property(atomic)UITextView* experience;
//确定按钮
@property(nonatomic)UIButton* sure;
@property(nonatomic)UIButton* cancle;

@end

#define WIDTH CGRectGetMaxX(self.view.frame)
#define SKYBULUE [UIColor colorWithRed:240/255.0 green:1 blue:1 alpha:1]
#define REDDISHBLUE [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1]
#define CORNSILK [UIColor colorWithRed:1 green:248/255.0 blue:220/255.0 alpha:1]
#define WHITEALMOND [UIColor colorWithRed:1 green:235/255.0 blue:205/255.0 alpha:1]

@implementation HierophantApply

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

//初始化
-(void)initializeAppearance{
    self.view.backgroundColor = SKYBULUE;
    //创建scrollView
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, CGRectGetMaxY(self.view.bounds))];
//    _mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导师申请"]];
    _mainView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //账号密码
    UILabel* _countL = [[UILabel alloc] initWithFrame:CGRectMake(16, 54, 40, 37)];
    _countL.text = @"账号";
    _countL.textColor = [UIColor blackColor];
    _countF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_countL.frame)+30, CGRectGetMinY(_countL.frame), 200, 37)];
    _countF.layer.cornerRadius = 10;
    _countF.layer.masksToBounds = YES;
    _countF.backgroundColor = CORNSILK;
    _countF.placeholder = @"姓名";
    _countF.delegate = self;
    [_mainView addSubview:_countL];
    [_mainView addSubview:_countF];
    UILabel* _passwordL = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_countL.frame)+20, 40, 37)];
    _passwordL.text = @"密码";
    _passwordL.textColor = [UIColor blackColor];
    _passwordF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_passwordL.frame)+30, CGRectGetMinY(_passwordL.frame), 200, 37)];
    _passwordF.layer.cornerRadius = 10.0;
    _passwordF.layer.masksToBounds = YES;
    _passwordF.backgroundColor = CORNSILK;
    _passwordF.placeholder = @"创建账户密码";
    _passwordF.secureTextEntry = YES;
    _passwordF.delegate = self;
    [_mainView addSubview:_passwordL];
    [_mainView addSubview:_passwordF];
    
    //创建姓名、性别、生日标签及textField
    _sexL = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(_passwordL.frame)+30, 40, 37)];
    _sexL.text = @"性别";
    _sexL.textColor = [UIColor blackColor];
    _sexF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_sexL.frame)+40, CGRectGetMinY(_sexL.frame), (WIDTH-CGRectGetMaxX(_sexL.frame))-130, 37)];
    _sexF.backgroundColor = CORNSILK;
    _sexF.textColor = REDDISHBLUE;
    _sexF.layer.masksToBounds = YES;
    _sexF.layer.cornerRadius = 10;
    _sexF.delegate = self;
    [_mainView addSubview:_sexL];
    [_mainView addSubview:_sexF];
    
    _birthdayL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_sexL.frame), CGRectGetMaxY(_sexL.frame)+20, 40, 37)];
    _birthdayL.text = @"生日";
    _birthdayL.textColor = [UIColor blackColor];
    _birthdayF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_sexF.frame), CGRectGetMaxY(_sexF.frame)+20, CGRectGetMaxX(_sexF.bounds), CGRectGetMaxY(_sexF.bounds))];
    _birthdayF.backgroundColor = CORNSILK;
    _birthdayF.textColor = REDDISHBLUE;
    _birthdayF.layer.masksToBounds = YES;
    _birthdayF.layer.cornerRadius = 10;
    _birthdayF.delegate = self;
    [_mainView addSubview:_birthdayL];
    [_mainView addSubview:_birthdayF];
    
    _PFTL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_birthdayL.frame), CGRectGetMaxY(_birthdayL.frame)+20, 40, 37)];
    _PFTL.text = @"职称";
    _PFTL.textColor = [UIColor blackColor];
    _PFTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_birthdayF.frame), CGRectGetMaxY(_birthdayF.frame)+20, CGRectGetMaxX(_birthdayF.bounds), CGRectGetMaxY(_birthdayF.bounds))];
    _PFTF.backgroundColor = CORNSILK;
    _PFTF.textColor = REDDISHBLUE;
    _PFTF.layer.masksToBounds = YES;
    _PFTF.layer.cornerRadius = 10;
    _PFTF.delegate = self;
    [_mainView addSubview:_PFTL];
    [_mainView addSubview:_PFTF];
    
    //创建技术专长标签及textField(比较大)
    _skillsL = [[UILabel alloc] init];
    _skillsL.center = CGPointMake(WIDTH/2, CGRectGetMaxY(_PFTL.frame)+40);
    _skillsL.bounds = CGRectMake(0, 0, 80, 37);
    _skillsL.text = @"技术专长";
    _skillsL.textColor = [UIColor blackColor];
    _skillsF = [[UITextView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_skillsL.frame)+10, WIDTH-60, 100)];
    _skillsF.backgroundColor = CORNSILK;
    _skillsF.textColor = REDDISHBLUE;
    _skillsF.layer.masksToBounds = YES;
    _skillsF.layer.cornerRadius = 10;
    [_mainView addSubview:_skillsL];
    [_mainView addSubview:_skillsF];
    
    //创建职称获得时间、工作单位、行政职务、联系电话、email标签及其textField
    _timeOfPFTL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_skillsF.frame), CGRectGetMaxY(_skillsF.frame)+30, 120, 37)];
    _timeOfPFTL.text = @"职称获得时间";
    _timeOfPFTL.textColor = [UIColor blackColor];
    _timeOfPFTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_timeOfPFTL.frame)+40, CGRectGetMinY(_timeOfPFTL.frame), WIDTH-CGRectGetMaxX(_timeOfPFTL.frame)-70, 37)];
    _timeOfPFTF.backgroundColor = CORNSILK;
    _timeOfPFTF.textColor = REDDISHBLUE;
    _timeOfPFTF.layer.masksToBounds = YES;
    _timeOfPFTF.layer.cornerRadius = 10;
    _timeOfPFTF.delegate = self;
    [_mainView addSubview:_timeOfPFTL];
    [_mainView addSubview:_timeOfPFTF];
    
    _workUnitL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_timeOfPFTL.frame), CGRectGetMaxY(_timeOfPFTL.frame)+20, 80, 37)];
    _workUnitL.text = @"工作单位";
    _workUnitL.textColor = [UIColor blackColor];
    _workUnitF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_workUnitL.frame)+20, CGRectGetMaxY(_timeOfPFTF.frame)+20, WIDTH-CGRectGetMaxX(_workUnitL.frame)-50, CGRectGetMaxY(_PFTF.bounds))];
    _workUnitF.backgroundColor = CORNSILK;
    _workUnitF.textColor = REDDISHBLUE;
    _workUnitF.layer.masksToBounds = YES;
    _workUnitF.layer.cornerRadius = 10;
    _workUnitF.delegate = self;
    [_mainView addSubview:_workUnitL];
    [_mainView addSubview:_workUnitF];
    
    _positionsL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_workUnitL.frame), CGRectGetMaxY(_workUnitL.frame)+20, 80, 37)];
    _positionsL.text = @"行政职务";
    _positionsL.textColor = [UIColor blackColor];
    _positionsF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_workUnitF.frame), CGRectGetMaxY(_workUnitF.frame)+20, CGRectGetMaxX(_workUnitF.bounds), CGRectGetMaxY(_workUnitF.bounds))];
    _positionsF.backgroundColor = CORNSILK;
    _positionsF.textColor = REDDISHBLUE;
    _positionsF.layer.masksToBounds = YES;
    _positionsF.layer.cornerRadius = 10;
    _positionsF.delegate = self;
    [_mainView addSubview:_positionsL];
    [_mainView addSubview:_positionsF];
    
    _phoneNL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_positionsL.frame), CGRectGetMaxY(_positionsL.frame)+20, CGRectGetMaxX(_positionsL.bounds), CGRectGetMaxY(_positionsL.bounds))];
    _phoneNL.text = @"联系电话";
    _phoneNL.textColor = [UIColor blackColor];
    _phoneNF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_positionsF.frame), CGRectGetMaxY(_positionsF.frame)+20, CGRectGetMaxX(_positionsF.bounds), CGRectGetMaxY(_positionsF.bounds))];
    _phoneNF.backgroundColor = CORNSILK;
    _phoneNF.textColor = REDDISHBLUE;
    _phoneNF.layer.masksToBounds = YES;
    _phoneNF.layer.cornerRadius = 10;
    _phoneNF.delegate = self;
    [_mainView addSubview:_phoneNL];
    [_mainView addSubview:_phoneNF];
    
    _emailL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_phoneNL.frame), CGRectGetMaxY(_phoneNL.frame)+20, CGRectGetMaxX(_phoneNL.bounds), CGRectGetMaxY(_phoneNL.bounds))];
    _emailL.text = @"email";
    _emailL.textColor = [UIColor blackColor];
    _emailF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(_phoneNF.frame), CGRectGetMaxY(_phoneNF.frame)+20, CGRectGetMaxX(_phoneNF.bounds), CGRectGetMaxY(_phoneNF.bounds))];
    _emailF.backgroundColor = CORNSILK;
    _emailF.textColor = REDDISHBLUE;
    _emailF.layer.masksToBounds = YES;
    _emailF.layer.cornerRadius = 10;
    _emailF.delegate = self;
    [_mainView addSubview:_emailL];
    [_mainView addSubview:_emailF];
    
    //创建工作或学习经历
    _experience = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_emailL.frame), CGRectGetMaxY(_emailL.frame)+20, WIDTH-60, 100)];
    _experience.text = @"请输入工作或学习经历";
    _experience.backgroundColor = [UIColor whiteColor];
    _experience.textColor = [UIColor redColor];
    _experience.layer.masksToBounds = YES;
    _experience.layer.cornerRadius = 10;
    [_mainView addSubview:_experience];
    
    //创建教师职责
    _duty = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_experience.frame), CGRectGetMaxY(_experience.frame)+20, WIDTH-60, 150)];
    _duty.text = [NSString stringWithFormat:@"校外导师职责：\n 1、与校内导师联合执导专业学生，校内导师为第一导师，校外导师为第二导师。\n 2、负责指导学生在计算机科学与工程毕业设计过程中能力的培养、为学生提供专业指导条件，并协助校内导师做好学生的管理工作。\n 3、与校内导师共同协商指导学生，确定学生论文的选题，完成开题、中期考核等学生培养必修环节。\n 4，与校内导师对所培养的学生情况及时交流，保证培养质量。"];
    [_duty setEditable:NO];
    _duty.layer.masksToBounds = YES;
    _duty.layer.cornerRadius = 10;
    _duty.textColor = [UIColor blackColor];
    [_mainView addSubview:_duty];
    
    //确定取消按钮
    _sure = [UIButton buttonWithType:UIButtonTypeCustom];
    _sure.tag = 11;
    _sure.frame = CGRectMake(WIDTH/2-90, CGRectGetMaxY(_duty.frame)+40, 60, 37);
    [_sure setTitle:@"确定" forState:UIControlStateNormal];
    [_sure setBackgroundColor:[UIColor redColor]];
    _sure.layer.masksToBounds = YES;
    _sure.layer.cornerRadius = 10;
    [_sure addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancle.tag = 21;
    _cancle.center = CGPointMake(WIDTH/2+30, _sure.center.y);
    _cancle.bounds = CGRectMake(0, 0, 60, 37);
    [_cancle setTitle:@"取消" forState:UIControlStateNormal];
    _cancle.backgroundColor = [UIColor greenColor];
    _cancle.layer.masksToBounds = YES;
    _cancle.layer.cornerRadius = 10;
    [_cancle addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainView addSubview:_sure];
    [_mainView addSubview:_cancle];
    
    //添加点击事件
    //将所有子试图添加到ScrollView，并设置content size
    _mainView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(_sure.frame)+30);
    
    //将scroll添加到主界面
    [self.view addSubview:_mainView];
    
}

-(void)buttonPressed:(UIButton* )sender{
    if (sender.tag == 11) {
        if (![self isPureInt:_phoneNF.text]) {
            [self addAlertTitle:@"电话号码必须为数字" andDetail:nil];
        } else if ([_countF.text isEqualToString:@""] || [_passwordF.text isEqualToString:@""] || [_sexF.text isEqualToString:@""] || [_birthdayF.text isEqualToString:@""] || [_PFTF.text isEqualToString:@""] || [_skillsF.text isEqualToString:@""] || [_timeOfPFTF.text isEqualToString:@""] || [_workUnitF.text isEqualToString:@""] || [_positionsF.text isEqualToString:@""] || [_phoneNF.text isEqualToString:@""] || [_emailF.text isEqualToString:@""] || [_experience.text isEqualToString:@""]) {
            [self addAlertTitle:@"信息不完整" andDetail:@"请输入全部信息"];
        }else {
            //添加监听
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registResult:) name:@"registHiero" object:nil];
            //注册事件
            RegistController *registController = [[RegistController alloc] init];
            [registController registWithHieroName:(NSMutableString *)_countF.text password:(NSMutableString *)_passwordF.text sex:(NSMutableString *)_sexF.text birthday:(NSMutableString *)_birthdayF.text PFT:(NSMutableString *)_PFTF.text skills:(NSMutableString *)_skillsF.text timeOfPFT:(NSMutableString *)_timeOfPFTF.text workUnit:(NSMutableString *)_workUnitF.text positions:(NSMutableString *)_positionsF.text phone:(NSMutableString *)_phoneNF.text email:(NSMutableString *)_emailF.text experience:(NSMutableString *)_experience.text];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)registResult:(NSNotification *)notic {
    NSMutableArray *array = notic.object;
    BOOL s = [array objectAtIndex:0];
    if (s == 0) {
        [self addAlertTitle:@"注册失败" andDetail:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//判断是否为纯数字
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//通知
-(void)addAlertTitle:(NSString *)title andDetail:(NSString *)detail {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registHiero" object:nil];
}

//键盘上浮
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    int height = textField.frame.origin.y+286-CGRectGetHeight(self.view.bounds);
//    if (height>0) {
//        [UIView beginAnimations:@"keyboardRaiseUp" context:nil];
//        [UIView setAnimationDuration:0.3];
//        self.view.frame = CGRectMake(0, -height, self.view.bounds.size.width, self.view.bounds.size.height);
//        [UIView commitAnimations];
//    }
//    
//    return YES;
//}

//-(void)textFieldDidEndEditing:(UITextField *)textField {
//    [UIView beginAnimations:@"keyboardDown" context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    [UIView commitAnimations];
//}

@end
