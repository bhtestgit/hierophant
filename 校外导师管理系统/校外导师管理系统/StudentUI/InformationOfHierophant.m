//
//  InformationOfHierophant.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "InformationOfHierophant.h"
#import <Masonry.h>
#import "HierophantManager.h"
#import <RongIMKit/RongIMKit.h>

@implementation InformationOfHierophant {
    UILabel *name;
    UIButton *connect;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"交流界面"]];
    name = [[UILabel alloc] init];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(100);
    }];
    
    //添加联系按钮
    connect = [[UIButton alloc] init];
    connect.bounds = CGRectMake(0, 0, 60, 40);
    connect.hidden = YES;
    connect.layer.cornerRadius = 5;
    connect.layer.masksToBounds = YES;
    connect.backgroundColor = [UIColor redColor];
    [connect setTitle:@"联系" forState:UIControlStateNormal];
    connect.layer.cornerRadius = 5.0;
    connect.layer.masksToBounds = YES;
    [connect addTarget:self action:@selector(connectWithHiero) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connect];
    [connect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-100);
        make.width.equalTo(@80);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    //获取导师信息
    NSString *stu = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotHiero:) name:@"gotHiero" object:nil];
    [HierophantManager getHieroByStu:stu];
}

-(void)gotHiero:(NSNotification *)notice {
    if (notice.object == [NSArray array]) {
        name.text = @"还没有选题";
    } else {
        NSString *n = [[notice object] objectAtIndex:0];
        name.text = n;
        connect.hidden = NO;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"goHiero" object:nil];
}

-(void)connectWithHiero {
    NSString *hiero = name.text;
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = hiero;
    chat.title = [NSString stringWithFormat:@"正在和%@交流", hiero];
    //显示聊天会话界面
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

@end
