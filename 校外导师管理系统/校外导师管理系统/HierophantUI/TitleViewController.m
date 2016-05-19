//
//  TitleViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "TitleViewController.h"
#import "DataController.h"
#import "DesignTitleController.h"

@interface TitleViewController () {
    DataController *dataController;
    DesignTitleController *updateView;
    int type;
}
@property (nonatomic)DesignTitleController *nextView;
@property (weak, nonatomic) IBOutlet UIButton *designTitle;
@property (weak, nonatomic) IBOutlet UILabel *titleOfTitle;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;

@end

@implementation TitleViewController

-(void)viewDidLoad {
    //设置圆角
    NSString *title = [[NSUserDefaults standardUserDefaults] stringForKey:@"buttonName"];
    [_designTitle setTitle:title forState:UIControlStateNormal];
    _designTitle.layer.cornerRadius = 5.0;
    _designTitle.layer.masksToBounds = YES;
    _titleOfTitle.layer.cornerRadius = 5.0;
    _titleOfTitle.layer.masksToBounds = YES;
    _title1.layer.cornerRadius = 5.0;
    _title1.layer.masksToBounds = YES;
    _title2.layer.cornerRadius = 5.0;
    _title2.layer.masksToBounds = YES;
    _title3.layer.cornerRadius = 5.0;
    _title3.layer.masksToBounds = YES;
    type = 1;
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导师申请"]];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonTitle) name:@"postedTitle" object:nil];
}

-(void)changeButtonTitle {
    type = 2;
    [_designTitle setTitle:@"更新" forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:@"更新" forKey:@"buttonName"];
}

//出题界面
- (IBAction)turnToDesignTitleView:(UIButton *)sender {
    //判断是否出题
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _nextView = [storyboard instantiateViewControllerWithIdentifier:@"DisignTitle"];
    [_nextView setType:type];
    _nextView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_nextView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

//通过数据库获取题目
-(void)reloadData {
    //获取数据库
    dataController = [[DataController alloc] init];
    //获取老师名字
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取题目
    NSMutableArray *titles = [dataController getTitleByHiero:name];
    //判断题目
    if ([titles count] == 0) {
        //没有出题或者获取数据失败
        _title1.text = [NSString stringWithFormat:@"第1题："];
        _title2.text = [NSString stringWithFormat:@"第2题："];
        _title3.text = [NSString stringWithFormat:@"第3题："];
    } else {
        //设置题目
        NSMutableArray *title = [NSMutableArray array];
        for (int i = 0; i < [titles count]; i++) {
            NSString *name = [[titles objectAtIndex:i] objectAtIndex:0];
            [title addObject:[NSString stringWithFormat:@"第%d题：%@", i+1, name]];
        }
        _title1.text = [titles count]>0 ? [title objectAtIndex:0]:@"第1题：";
        _title2.text = [titles count]>1 ? [title objectAtIndex:1]:@"第2题：";
        _title3.text = [titles count]>2 ? [title objectAtIndex:2]:@"第3题：";
    }
}

-(void)addAlertWithTitle:(NSString *)title andDetails:(NSString *)detail {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:aler animated:YES completion:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"postedTitle" object:nil];
}

@end
