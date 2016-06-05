//
//  Subject.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "Subject.h"
#import <Masonry.h>
#import "TitleManager.h"
#import "Title.h"

#define SCREAN_WIDTH CGRectGetMaxX(self.view.frame)
#define SCREAN_HIGHT CGRectGetMaxY(self.view.frame)
#define CHOCOLATE_COLOR [UIColor colorWithRed:210/255.0 green:105/255.0 blue:30/255.0 alpha:1]
#define CANARY_COLOR [UIColor colorWithRed:245/255.0 green:222/255.0 blue:179/255.0 alpha:1]
#define GRASSGREEN_COLOR [UIColor colorWithRed:124/255.0 green:252/255.0 blue:0 alpha:1]
@interface Subject()
@property (nonatomic)UILabel *titleL;
@property (nonatomic)UILabel *titleName;

@property (nonatomic)UILabel *detail;
@property (nonatomic)UITextView *detailName;

@property (nonatomic)UILabel *scoreL;
@property (nonatomic)UILabel *score;

@end
@implementation Subject

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
    _titleL = [[UILabel alloc] init];
    _titleName = [[UILabel alloc] init];
    _titleName.hidden = YES;
    _titleName.backgroundColor = [UIColor lightGrayColor];
    _titleName.textAlignment = NSTextAlignmentCenter;
    _titleName.layer.cornerRadius = 5.0;
    _titleName.layer.masksToBounds = YES;
    
    _detail = [[UILabel alloc] init];
    _detail.text = @"题目描述";
    _detail.hidden = YES;
    _detailName = [[UITextView alloc] init];
    _detailName.editable = NO;
    _detailName.backgroundColor = [UIColor lightGrayColor];
    _detailName.hidden = YES;
    _detailName.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _detailName.layer.cornerRadius = 5.0;
    _detailName.layer.masksToBounds = YES;
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.text = @"成绩";
    _scoreL.hidden = YES;
    _score = [[UILabel alloc] init];
    _score.hidden = YES;
    _score.backgroundColor = [UIColor lightGrayColor];
    _score.textAlignment = NSTextAlignmentCenter;
    _score.layer.cornerRadius = 5.0;
    _score.layer.masksToBounds = YES;
    
    [self.view addSubview:_titleL];
    [self.view addSubview:_titleName];
    [self.view addSubview:_detail];
    [self.view addSubview:_detailName];
    [self.view addSubview:_scoreL];
    [self.view addSubview:_score];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(100);
    }];
    
    [_titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleL.mas_bottom).offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.equalTo(@40);
    }];
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleName.mas_bottom).offset(20);
        make.centerX.offset(0);
    }];
    
    [_detailName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detail.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.equalTo(@120);
    }];
    
    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailName.mas_bottom).offset(20);
        make.centerX.offset(0);
    }];
    
    [_score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreL.mas_bottom).offset(10);
        make.centerX.offset(0);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    //加载数据
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTitle:) name:@"gotFinalTitle" object:nil];
    [TitleManager getTitleByStu:name];
}

-(void)setTitle:(NSNotification *)notice {
    NSDictionary *data = notice.object;
    if (![data objectForKey:@"name"]) {
        _titleL.text = @"没有选题";
        _titleName.hidden = YES;
        _detail.hidden = YES;
        _detailName.hidden = YES;
        _scoreL.hidden = YES;
        _score.hidden = YES;
    } else {
        _titleL.text = @"题目名";
        _titleName.text = [data objectForKey:@"name"];
        _titleName.hidden = NO;
        _detail.hidden = NO;
        _detailName.text = [data objectForKey:@"detail"];
        _detailName.hidden = NO;
        _scoreL.hidden = NO;
        _score.hidden = NO;
        NSInteger score = [[data objectForKey:@"score"] integerValue];
        if (score != 0) {
            _score.text = [NSString stringWithFormat:@"%ld", (long)score];
        } else {
            _score.text = @"没有给定成绩";
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotFinalTitle" object:nil];
}

@end
