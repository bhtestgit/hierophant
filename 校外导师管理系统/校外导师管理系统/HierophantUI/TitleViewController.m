//
//  TitleViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "TitleViewController.h"

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
}
- (IBAction)turnToDesignTitleView:(UIButton *)sender {
}

@end
