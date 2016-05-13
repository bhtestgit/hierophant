//
//  GradeViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "GradeViewController.h"
#import "DataController.h"
@interface GradeViewController() {
    DataController *dataController;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *firstScore;
@property (weak, nonatomic) IBOutlet UITextField *secondScore;
@property (weak, nonatomic) IBOutlet UITextField *thirdScore;
@property (weak, nonatomic) IBOutlet UILabel *firstStudent;
@property (weak, nonatomic) IBOutlet UILabel *secondStudent;
@property (weak, nonatomic) IBOutlet UILabel *thirdStudent;
@property (weak, nonatomic) IBOutlet UIButton *confirm1;
@property (weak, nonatomic) IBOutlet UIButton *confirm2;
@property (weak, nonatomic) IBOutlet UIButton *confirm3;

@end

@implementation GradeViewController

-(void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"题目信息"]];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 700);
    _confirm1.layer.cornerRadius = 5.0;
    _confirm1.layer.masksToBounds = YES;
    _confirm2.layer.cornerRadius = 5.0;
    _confirm2.layer.masksToBounds = YES;
    _confirm3.layer.cornerRadius = 5.0;
    _confirm3.layer.masksToBounds = YES;
    
    
    [self reloadData];
}

-(void)reloadData {
    //获取数据库
    dataController = [[DataController alloc] init];
    //获取老师名字
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取题目
    NSMutableArray *titles = [dataController getTitleByHiero:name];
    NSMutableArray *message = [NSMutableArray array];
    //判断题目
    if ([titles count] == 0) {
        //没有选题
        _firstStudent.text = @"还没有选题";
        _secondStudent.text = @"还没有选题";
        _thirdStudent.text = @"还没有选题";
        _confirm1.enabled = NO;
        _confirm2.enabled = NO;
        _confirm3.enabled = NO;
    } else {
        //设置学生
        for (int i = 0; i < [titles count]; i++) {
            NSString *stuName = [[titles objectAtIndex:i] objectAtIndex:3];
            NSString *score = [[titles objectAtIndex:i] objectAtIndex:4];
            [message addObject:stuName];
            [message addObject:score];
        }
        
        
        _confirm1.enabled = YES;
        _confirm2.enabled = YES;
        _confirm3.enabled = YES;
    }
    
}

@end
