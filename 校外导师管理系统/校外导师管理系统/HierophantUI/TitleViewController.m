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
    
}
@property (weak, nonatomic) IBOutlet UIButton *designTitle;
@property (weak, nonatomic) IBOutlet UILabel *titleOfTitle;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@end

@implementation TitleViewController

-(void)viewDidLoad {
    //设置圆角
    _designTitle.layer.cornerRadius = 5.0;
    _designTitle.layer.masksToBounds = YES;
    _titleOfTitle.layer.cornerRadius = 5.0;
    _titleOfTitle.layer.masksToBounds = YES;
    _updateButton.layer.cornerRadius = 5.0;
    _updateButton.layer.masksToBounds = YES;
    _updateButton.layer.cornerRadius = 5.0;
    _updateButton.layer.masksToBounds = YES;
    _title1.layer.cornerRadius = 5.0;
    _title1.layer.masksToBounds = YES;
    _title2.layer.cornerRadius = 5.0;
    _title2.layer.masksToBounds = YES;
    _title3.layer.cornerRadius = 5.0;
    _title3.layer.masksToBounds = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导师申请"]];
}

//更新界面
- (IBAction)updateView:(UIButton *)sender {
    //修改数据
}

- (IBAction)turnToDesignTitleView:(UIButton *)sender {
    //判断是否出题
    if (![_title1.text isEqualToString:@"第1题："]&& ![_title2.text isEqualToString:@"第2题："]&&![_title1.text isEqualToString:@"第3题："]) {
        [self addAlertWithTitle:@"你已经出题" andDetails:nil];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DesignTitleController *nextView = [storyboard instantiateViewControllerWithIdentifier:@"DisignTitle"];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
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


@end
