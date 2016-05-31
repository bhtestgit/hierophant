//
//  ContactWithStudent.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ContactWithStudent.h"
#import <RongIMKit/RongIMKit.h>
#import <Masonry.h>
#import "StudentManager.h"
#import "ChooseStuController.h"
@interface ContactWithStudent()<UITableViewDelegate, UITableViewDataSource> {
    UIButton *connectWithDean;
    UIView *bottomView;
    NSMutableArray *names;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ContactWithStudent

-(void)viewDidLoad {
    names = [NSMutableArray array];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    
    //教务按钮
    connectWithDean = [[UIButton alloc] init];
    [connectWithDean setTitle:@"联系教务" forState:UIControlStateNormal];
    connectWithDean.layer.cornerRadius = 5.0;
    connectWithDean.layer.masksToBounds = YES;
    connectWithDean.backgroundColor = [UIColor orangeColor];
    [connectWithDean addTarget:self action:@selector(connectDean:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tableview addSubview:connectWithDean];
    [_tableview setTableFooterView:bottomView];
    
    [connectWithDean mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

- (void)connectDean:(UIButton *)sender {
    NSString *dID = @"HierophantManager";
    [self initChatViewWithSid:dID];
}

- (void)initChatViewWithSid:(NSString *)sid {
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = sid;
    //设置聊天会话界面要显示的标题
    if ([sid isEqualToString:@"HierophantManager"]) {
        chat.title = @"正在和教务交流";
    } else {
        chat.title = [NSString stringWithFormat:@"正在和%@交流", sid];
    }
    //显示聊天会话界面
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [self load];
}

-(void)load {
    //获取导师名字
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取学生数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmData:) name:@"gotStuAndTitle" object:nil];
    [StudentManager getStuAndTitleByHiero:name];
}

-(void)confirmData:(NSNotification *)notice {
    //获取全部数据
    names = [notice.object objectForKey:@"result"];
    //筛选出有学生名字的数据
    //刷新表格
    [_tableview reloadData];
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotStuAndTitle" object:nil];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"联系学生";
    } else {
        return @"选择学生";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (names.count == 0) {
            return 1;
        } else {
            return names.count;
        }
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 60.0;
    } else {
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        if (names.count == 0) {
            cell.textLabel.text = @"没有辅导学生";
        } else {
            cell.textLabel.text = [[names objectAtIndex:indexPath.row] objectAtIndex:0];
            NSString *title = [[names objectAtIndex:indexPath.row] objectAtIndex:1];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"所选题目：%@", title];
        }
    } else {
        cell.textLabel.text = @"点击选择学生";
    }
    
    return cell;
}

//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && names.count != 0) {
        //获取名字
        NSString *name = [[names objectAtIndex:indexPath.row] objectAtIndex:0];
        //跳转聊天界面
        [self initChatViewWithSid:name];
    } else if (indexPath.section == 1) {
        //跳转选择学生界面
        ChooseStuController *chooseView = [[ChooseStuController alloc] init];
        chooseView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chooseView animated:YES];
    }
    
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

@end
