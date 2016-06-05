//
//  GradeViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "GradeViewController.h"
#import "StudentManager.h"
#import "TitleManager.h"
@interface GradeViewController()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *datas;
}

@end

@implementation GradeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.navigationItem setTitle:@"成绩管理"];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)reload {
    datas = [NSMutableArray array];
    //获取导师名字
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取学生数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmData:) name:@"gotStuAndTitle" object:nil];
    [StudentManager getStuAndTitleByHiero:name];
}

-(void)confirmData:(NSNotification *)notice {
    //获取全部数据
    datas = [notice.object objectForKey:@"result"];
    //刷新表格
    [self.tableView reloadData];
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotStuAndTitle" object:nil];
}

#pragma mard - 设置表
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"点击给定成绩";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (datas.count == 0) {
        return 1;
    } else {
        return datas.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (datas.count == 0) {
        cell.textLabel.text = @"没有辅导学生";
        cell.detailTextLabel.text = nil;
    } else {
        cell.textLabel.text = [[datas objectAtIndex:indexPath.row]objectAtIndex:0];
        NSString *title = [[datas objectAtIndex:indexPath.row] objectAtIndex:1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"所选题目：%@", title];
    }
    
    return cell;
}

//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (datas.count != 0) {
        //弹出窗口
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"给定成绩" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"分数";
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        __weak typeof(self)weakSelf = self;
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取题目
            NSString *title = [[datas objectAtIndex:indexPath.row] objectAtIndex:1];
            NSString *score = alert.textFields.firstObject.text;
            if ([score isEqualToString:@""]) {
                [weakSelf addAlert:@"不能为空" message:@"请输入成绩"];
            } else {
                //连接服务器
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scoreResult:) name:@"scoreResult" object:nil];
                [TitleManager confirmScoreWithTitle:title andScore:score];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"思考一下" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

-(void)scoreResult:(NSNotification *)notice {
    NSDictionary *result = [notice object];
    NSInteger s = [[result objectForKey:@"result"] integerValue];
    if (s == 1) {
        [self addAlert:@"打分成功" message:nil];
    } else {
        [self addAlert:@"服务器错误" message:nil];
    }
    
    [self reload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scoreResult" object:nil];
}

-(void)addAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
