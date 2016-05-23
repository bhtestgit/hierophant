//
//  ContactWithStudent.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ContactWithStudent.h"
#import <RongIMKit/RongIMKit.h>
@interface ContactWithStudent() {
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *stu1L;
@property (weak, nonatomic) IBOutlet UILabel *stu2L;
@property (weak, nonatomic) IBOutlet UILabel *stu3L;
@property (weak, nonatomic) IBOutlet UIButton *contact1;
@property (weak, nonatomic) IBOutlet UIButton *contact2;
@property (weak, nonatomic) IBOutlet UIButton *contact3;


@end

@implementation ContactWithStudent

-(void)viewDidLoad {
//    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"交流界面"]];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 600);
    
    _stu1L.layer.cornerRadius = 5.0;
    _stu1L.layer.masksToBounds = YES;
    _stu2L.layer.cornerRadius = 5.0;
    _stu2L.layer.masksToBounds = YES;
    _stu3L.layer.cornerRadius = 5.0;
    _stu3L.layer.masksToBounds = YES;
    _contact1.layer.cornerRadius = 5.0;
    _contact1.layer.masksToBounds = YES;
    _contact2.layer.cornerRadius = 5.0;
    _contact2.layer.masksToBounds = YES;
    _contact3.layer.cornerRadius = 5.0;
    _contact3.layer.masksToBounds = YES;
}

- (IBAction)connectS1:(UIButton *)sender {
    NSString *sid = _stu1L.text;
    [self initChatViewWithSid:sid];
}
- (IBAction)connectS2:(UIButton *)sender {
    NSString *sid = _stu2L.text;
    [self initChatViewWithSid:sid];
}
- (IBAction)connectS3:(UIButton *)sender {
    NSString *sid = _stu3L.text;
    [self initChatViewWithSid:sid];
}

- (void)initChatViewWithSid:(NSString *)sid {
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = sid;
    //设置聊天会话界面要显示的标题
    chat.title = [NSString stringWithFormat:@"正在和%@交流", sid];
    //显示聊天会话界面
    
    [self.navigationController pushViewController:chat animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    //判断学生是否有学生
}

@end
