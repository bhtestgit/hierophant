//
//  CommunicateTableViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/5/26.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "CommunicateTableViewController.h"
#import "HierophentManager.h"
#import <RongIMKit/RongIMKit.h>

@interface CommunicateTableViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *names;  //所有名字
}

@end

@implementation CommunicateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    names = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

//判断是否直接联系
-(void)viewDidAppear:(BOOL)animated {
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"connetHiero"];
    if (![name isEqualToString:@""] && name) {
        [self startCommunicateWithTargetId:name];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"connetHiero"];
}

-(void)reload {
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setHieroName:) name:@"gotNames" object:nil];
    [HierophentManager getAllHiero];
}

-(void)setHieroName:(NSNotification *)notice {
    NSDictionary *allName = notice.object;
    names = [allName objectForKey:@"names"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotNames" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"点击老师名字进行联系";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [names objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取老师名字
    NSString *name = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    //建立聊天页面
    [self startCommunicateWithTargetId:name];
}

-(void)startCommunicateWithTargetId:(NSString *)name {
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = name;
    //设置聊天会话界面要显示的标题
    chat.title = [NSString stringWithFormat:@"正在和%@交流", name];
    //显示聊天会话界面
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
