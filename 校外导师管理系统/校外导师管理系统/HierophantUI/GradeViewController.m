//
//  GradeViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "GradeViewController.h"
@interface GradeViewController() {
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
}

@end
