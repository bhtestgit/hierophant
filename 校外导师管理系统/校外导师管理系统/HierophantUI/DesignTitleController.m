//
//  DesignTitleController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "DesignTitleController.h"
#define SCREANWIDTH CGRectGetMaxX(self.view.frame)
@interface DesignTitleController(){
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *firstTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirm;

@end

@implementation DesignTitleController

-(void)viewDidLoad {
    self.navigationItem.title = @"出题";
    _scrollView.contentSize = CGSizeMake(SCREANWIDTH, 700);
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"选择题目"]];
    _firstTitleLabel.layer.cornerRadius = 5.0;
    _firstTitleLabel.layer.masksToBounds = YES;
    _secondTitleLabel.layer.cornerRadius = 5.0;
    _secondTitleLabel.layer.masksToBounds = YES;
    _thirdTitleLabel.layer.cornerRadius = 5.0;
    _thirdTitleLabel.layer.masksToBounds = YES;
    _confirm.layer.cornerRadius = 5.0;
    _confirm.layer.masksToBounds = YES;
    //添加题目描述
    
}

@end
