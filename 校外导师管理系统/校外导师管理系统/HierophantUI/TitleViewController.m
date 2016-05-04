//
//  TitleViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "TitleViewController.h"
#import "DataController.h"

@interface TitleViewController () {
    
}
@property (weak, nonatomic) IBOutlet UIButton *designTitle;
@property (weak, nonatomic) IBOutlet UILabel *titleOfTitle;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;

@end

@implementation TitleViewController

-(void)viewDidLoad {
    //设置圆角
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导师申请"]];
    
    [self reloadData];
}
- (IBAction)turnToDesignTitleView:(UIButton *)sender {
}

//通过数据库获取题目
-(void)reloadData {
    //获取数据库
    DataController *dataController = [[DataController alloc] init];
    //获取老师名字
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取题目
    NSMutableArray *titles = [dataController getTitleByHiero:name];
    //判断题目
    if ([titles count] == 0) {
        //没有出题或者获取数据失败
        
    } else {
        //设置题目
    }
}
@end
