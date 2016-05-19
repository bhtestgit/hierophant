//
//  Subject.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "Subject.h"
#define SCREAN_WIDTH CGRectGetMaxX(self.view.frame)
#define SCREAN_HIGHT CGRectGetMaxY(self.view.frame)
#define CHOCOLATE_COLOR [UIColor colorWithRed:210/255.0 green:105/255.0 blue:30/255.0 alpha:1]
#define CANARY_COLOR [UIColor colorWithRed:245/255.0 green:222/255.0 blue:179/255.0 alpha:1]
#define GRASSGREEN_COLOR [UIColor colorWithRed:124/255.0 green:252/255.0 blue:0 alpha:1]

@implementation Subject

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
    //添加滚动视图
    UIScrollView* _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREAN_WIDTH, SCREAN_HIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREAN_WIDTH, 700);
//    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"题目信息"]];
    [self.view addSubview:_scrollView];
    
    //选择题目标签
    UILabel* _selectedtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-40, 90, 80, 37)];
    _selectedtitleLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1];
    _selectedtitleLabel.text = @"本轮已选";
    _selectedtitleLabel.textAlignment = NSTextAlignmentCenter;
    _selectedtitleLabel.textColor = [UIColor whiteColor];
    _selectedtitleLabel.layer.cornerRadius = 5.0;
    _selectedtitleLabel.layer.masksToBounds = YES;
    _selectedtitleLabel.layer.borderWidth = 1.0;
    _selectedtitleLabel.layer.borderColor = [UIColor grayColor].CGColor;
    [_scrollView addSubview:_selectedtitleLabel];
    //第一题
    UILabel* _firstTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-100, CGRectGetMaxY(_selectedtitleLabel.frame)+20, 200, 37)];
    _firstTitle.backgroundColor = CANARY_COLOR;
    _firstTitle.layer.cornerRadius = 5.0;
    _firstTitle.layer.masksToBounds = YES;
    _firstTitle.layer.borderWidth = 1.0;
    _firstTitle.layer.borderColor = [UIColor orangeColor].CGColor;
    _firstTitle.text = @"第一题";
    _firstTitle.textColor = CHOCOLATE_COLOR;
    [_scrollView addSubview:_firstTitle];
    //第二题
    UILabel* _secondTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-100, CGRectGetMaxY(_firstTitle.frame)+20, 200, 37)];
    _secondTitle.backgroundColor = CANARY_COLOR;
    _secondTitle.layer.cornerRadius = 5.0;
    _secondTitle.layer.masksToBounds = YES;
    _secondTitle.layer.borderWidth = 1.0;
    _secondTitle.layer.borderColor = [UIColor orangeColor].CGColor;
    _secondTitle.text = @"第二题";
    _secondTitle.textColor = CHOCOLATE_COLOR;
    [_scrollView addSubview:_secondTitle];
    //第三题
    UILabel* _lastTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-100, CGRectGetMaxY(_secondTitle.frame)+20, 200, 37)];
    _lastTitle.backgroundColor = CANARY_COLOR;
    _lastTitle.layer.cornerRadius = 5.0;
    _lastTitle.layer.masksToBounds = YES;
    _lastTitle.layer.borderWidth = 1.0;
    _lastTitle.layer.borderColor = [UIColor orangeColor].CGColor;
    _lastTitle.text = @"第三题";
    _lastTitle.textColor = CHOCOLATE_COLOR;
    [_scrollView addSubview:_lastTitle];
    
    //选择成功标签
    UILabel* _determinedTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-40, CGRectGetMaxY(_lastTitle.frame)+40, 80, 37)];
    _determinedTitle.backgroundColor = [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1];
    _determinedTitle.text = @"最终题目";
    _determinedTitle.textAlignment = NSTextAlignmentCenter;
    _determinedTitle.textColor = GRASSGREEN_COLOR;
    _determinedTitle.layer.cornerRadius = 5.0;
    _determinedTitle.layer.masksToBounds = YES;
    _determinedTitle.layer.borderWidth = 1.0;
    _determinedTitle.layer.borderColor = [UIColor grayColor].CGColor;
    [_scrollView addSubview:_determinedTitle];
    UILabel* _finalTitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-100, CGRectGetMaxY(_determinedTitle.frame)+20, 200, 37)];
    _finalTitle.backgroundColor = CANARY_COLOR;
    _finalTitle.layer.cornerRadius = 5.0;
    _finalTitle.layer.masksToBounds = YES;
    _finalTitle.layer.borderWidth = 1.0;
    _finalTitle.layer.borderColor = [UIColor orangeColor].CGColor;
    _finalTitle.text = @"最终题目";
    _finalTitle.textColor = CHOCOLATE_COLOR;
    [_scrollView addSubview:_finalTitle];
    
    //导师信息标签
    UILabel* _hieroLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREAN_WIDTH/2-40, CGRectGetMaxY(_finalTitle.frame)+40, 80, 37)];
    _hieroLabel.backgroundColor = [UIColor orangeColor];
    _hieroLabel.text = @"导师信息";
    _hieroLabel.textAlignment = NSTextAlignmentCenter;
    _hieroLabel.textColor = [UIColor redColor];
    _hieroLabel.layer.cornerRadius = 5.0;
    _hieroLabel.layer.masksToBounds = YES;
    _hieroLabel.layer.borderWidth = 1.0;
    _hieroLabel.layer.borderColor = [UIColor greenColor].CGColor;
    [_scrollView addSubview:_hieroLabel];
    //导师视图
    UITextView* _hieroMsgView = [[UITextView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_hieroLabel.frame)+20, SCREAN_WIDTH-32, 100)];
    _hieroMsgView.text = [NSString stringWithFormat:@"导师信息：\n姓名\n...\n...\n..."];
    _hieroMsgView.editable = NO;
    _hieroMsgView.layer.cornerRadius = 5.0;
    _hieroMsgView.layer.masksToBounds = YES;
    _hieroMsgView.layer.borderWidth = 1.0;
    _hieroMsgView.layer.borderColor = CHOCOLATE_COLOR.CGColor;
    [_scrollView addSubview:_hieroMsgView];
}

@end
