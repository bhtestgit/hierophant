//
//  InfoTableViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/6/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "InfoTableViewController.h"
#import "HierophentManager.h"
#import "StudentManager.h"
#import "InformationViewController.h"

@interface InfoTableViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *hieroNames; //所有导师
    InformationViewController *subview;
    NSMutableArray *titles; //所有有成绩的题目
}

@end

@implementation InfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    hieroNames = [NSMutableArray array];
    titles = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)viewWillDisappear:(BOOL)animated {
    hieroNames = [NSMutableArray array];
    titles = [NSMutableArray array];
}

-(void)reload {
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setHieroName:) name:@"gotNames" object:nil];
    [HierophentManager getAllHiero];
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotAllStu:) name:@"getAllStuInTitle" object:nil];
    [StudentManager getAllStudentInTitle];
}

-(void)setHieroName:(NSNotification *)notice {
    NSDictionary *allName = notice.object;
    hieroNames = [allName objectForKey:@"names"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotNames" object:nil];
}

-(void)gotAllStu:(NSNotification *)notice {
    NSArray *datas = notice.object;
    for (NSDictionary *one in datas) {
        if ([[one objectForKey:@"score"] integerValue] != 0) {
            [titles addObject:one];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getAllStuInTitle" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"导师信息";
            break;
            
        default:
            return @"学生成绩";
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return hieroNames.count;
    } else {
        return titles.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [hieroNames objectAtIndex:indexPath.row];
            break;
            
        default:
            cell.textLabel.text = [[titles objectAtIndex:indexPath.row] objectForKey:@"studentId"];
            
            break;
    }
    
    return cell;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //跳转到详情界面
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        subview = [storyboard instantiateViewControllerWithIdentifier:@"HcommunicateView"];
        NSString *name = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [subview setButtonByManagerWithName:name];
        subview.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subview animated:YES];
    } else {
        NSInteger score = [[[titles objectAtIndex:indexPath.row] objectForKey:@"score"] integerValue];
        NSString *s = [NSString stringWithFormat:@"%ld分", score];
        [self addAlertWithTitle:@"成绩" andDetail:s];
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

//通知
-(void)addAlertWithTitle:(NSString *)titleA andDetail:(NSString *)detailA {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:detailA preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
