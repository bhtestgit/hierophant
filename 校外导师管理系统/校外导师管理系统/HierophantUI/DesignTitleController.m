//
//  DesignTitleController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "DesignTitleController.h"
#import "DataController.h"

#define SCREANWIDTH CGRectGetMaxX(self.view.frame)
@interface DesignTitleController(){
    DataController *dataController;
}

@property (nonatomic)int type;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *firstTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstTitleF;
@property (weak, nonatomic) IBOutlet UITextField *firstDetailF;
@property (weak, nonatomic) IBOutlet UITextField *secondTitleF;
@property (weak, nonatomic) IBOutlet UITextField *secondDetailF;
@property (weak, nonatomic) IBOutlet UITextField *thirdTitleF;
@property (weak, nonatomic) IBOutlet UITextField *thirdDetailF;
@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (nonatomic) BOOL isNill;
@property (nonatomic) BOOL firstYet;
@property (nonatomic) BOOL secondYet;
@property (nonatomic) BOOL thirdYet;

@end

@implementation DesignTitleController

-(void)setType:(int)type {
    _type = type;
}

-(void)viewDidLoad {
    if (_type == 1) {
        self.navigationItem.title = @"出题";
    } else {
        self.navigationItem.title = @"修改";
    }
    _scrollView.contentSize = CGSizeMake(SCREANWIDTH, 700);
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"选择题目"]];
    _firstTitleLabel.layer.cornerRadius = 5.0;
    _firstTitleLabel.layer.masksToBounds = YES;
    _secondTitleLabel.layer.cornerRadius = 5.0;
    _secondTitleLabel.layer.masksToBounds = YES;
    _thirdTitleLabel.layer.cornerRadius = 5.0;
    _thirdTitleLabel.layer.masksToBounds = YES;
    [_firstTitleF addTarget:self action:@selector(textOnEdite) forControlEvents:UIControlEventEditingChanged];
    [_secondTitleF addTarget:self action:@selector(textOnEdite) forControlEvents:UIControlEventEditingChanged];
    [_thirdTitleF addTarget:self action:@selector(textOnEdite) forControlEvents:UIControlEventEditingChanged];
    _confirm.layer.cornerRadius = 5.0;
    _confirm.layer.masksToBounds = YES;
    _isNill = YES;
    [_confirm addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self reloadData];
}

//确定按钮
-(void)buttonPressed:(UIButton *)sender {
    if (_isNill) {
        [self addAlertWithTitle:@"每个题目不能为空白" andDetail:nil];
    } else {
    //获取数据
        NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
        NSMutableString *title1 = (NSMutableString *)_firstTitleF.text;
        NSMutableString *detail1 = (NSMutableString *)_firstDetailF.text;
        NSMutableString *title2 = (NSMutableString *)_secondTitleF.text;
        NSMutableString *detail2 = (NSMutableString *)_secondDetailF.text;
        NSMutableString *title3 = (NSMutableString *)_thirdTitleF.text;
        NSMutableString *detail3 = (NSMutableString *)_thirdDetailF.text;
        //添加到数据库
        dataController = [[DataController alloc] init];
        BOOL rslt1 = false;
        BOOL rslt2 = false;
        BOOL rslt3 = false;
        NSString *successT;
        NSString *falseT;
        if (_type == 1) {
            rslt1 = _firstYet?[dataController insertTitleTable:title1 detail:detail1 hieroId:name studentId:[NSMutableString string] score:0]:YES;
            rslt2 = _secondYet?[dataController insertTitleTable:title2 detail:detail2 hieroId:name studentId:[NSMutableString string] score:0]:YES;
            rslt3 = _thirdYet?[dataController insertTitleTable:title3 detail:detail3 hieroId:name studentId:[NSMutableString string] score:0]:YES;
            successT = @"出题成功";
            falseT = @"出题失败";
        } else {
            rslt1 = [dataController updateTitleData:title1 detail:detail1 hieroId:name studentId:[NSMutableString string] score:0];
            rslt2 = [dataController updateTitleData:title1 detail:detail1 hieroId:name studentId:[NSMutableString string] score:0];
            rslt3 = [dataController updateTitleData:title1 detail:detail1 hieroId:name studentId:[NSMutableString string] score:0];
            successT = @"更新成功";
            falseT = @"更新失败";
        }
        
        if (rslt1 && rslt2 && rslt3) {
            [self addAlertWithTitle:successT andDetail:nil];
        } else {
            [self addAlertWithTitle:falseT andDetail:nil];
        }
    }
    
}

-(void)reloadData {
    //获取数据库
    dataController = [[DataController alloc] init];
    //获取老师名字
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取题目
    NSMutableArray *titles = [dataController getTitleByHiero:name];
    NSMutableArray *title = [NSMutableArray array];
    //判断题目
    if ([titles count] == 0) {
        //没有出题或者获取数据失败
    } else {
        //设置题目
        for (int i = 0; i < [titles count]; i++) {
            NSString *name = [[titles objectAtIndex:i] objectAtIndex:0];
            NSString *detail = [[titles objectAtIndex:i] objectAtIndex:1];
            [title addObject:name];
            [titles addObject:detail];
        }
    }
    _firstTitleF.text = [titles count]>0 ? [title objectAtIndex:0]:@"";
    _firstDetailF.text = [titles count]>0 ? [title objectAtIndex:1]:@"";
    _secondTitleF.text = [titles count]>1 ? [title objectAtIndex:2]:@"";
    _secondDetailF.text = [titles count]>1 ? [title objectAtIndex:3]:@"";
    _thirdTitleF.text = [titles count]>2 ? [title objectAtIndex:4]:@"";
    _thirdDetailF.text = [titles count]>2 ? [title objectAtIndex:5]:@"";
    _firstYet = [_firstTitleF.text isEqualToString:@""];
    _secondYet = [_secondTitleF.text isEqualToString:@""];
    _thirdYet = [_thirdTitleF.text isEqualToString:@""];
}

//通知
-(void)addAlertWithTitle:(NSString *)title andDetail:(NSString *)detail {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)textOnEdite {
    _isNill = [_firstTitleF.text isEqualToString:[NSString string]] || [_secondTitleF.text isEqualToString:[NSString string]] || [_thirdTitleF.text isEqualToString:[NSString string]];
}

@end
