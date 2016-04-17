//
//  PIM.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "PIM.h"

@implementation PIM

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"个人信息"]];
    
    //姓名
    UILabel* _name = [[UILabel alloc] initWithFrame:CGRectMake(16, 100, 40, 37)];
    _name.backgroundColor = [UIColor orangeColor];
    _name.layer.cornerRadius = 5.0;
    _name.layer.masksToBounds = YES;
    _name.layer.borderWidth = 1.0;
    _name.layer.borderColor = [UIColor grayColor].CGColor;
    _name.text = @"姓名";
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor whiteColor];
    [self.view addSubview:_name];
    UILabel* _nameD = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_name.frame)+30, CGRectGetMinY(_name.frame), 200, 37)];
    _nameD.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:237/255.0 alpha:1];
    _nameD.layer.cornerRadius = 5.0;
    _nameD.layer.masksToBounds = YES;
    _nameD.layer.borderWidth = 1.0;
    _nameD.text = @"俄乌佛 i 然后跟 i 哦韩国 i";
    [self.view addSubview:_nameD];
    //学号
    UILabel* _stuId = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_name.frame)+20, 40, 37)];
    _stuId.backgroundColor = [UIColor orangeColor];
    _stuId.layer.cornerRadius = 5.0;
    _stuId.layer.masksToBounds = YES;
    _stuId.layer.borderWidth = 1.0;
    _stuId.layer.borderColor = [UIColor grayColor].CGColor;
    _stuId.text = @"学号";
    _stuId.textAlignment = NSTextAlignmentCenter;
    _stuId.textColor = [UIColor whiteColor];
    [self.view addSubview:_stuId];
    UILabel* _stuIdD = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_stuId.frame)+30, CGRectGetMinY(_stuId.frame), 200, 37)];
    _stuIdD.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:237/255.0 alpha:1];
    _stuIdD.layer.cornerRadius = 5.0;
    _stuIdD.layer.masksToBounds = YES;
    _stuIdD.layer.borderWidth = 1.0;
    _stuIdD.layer.borderColor = [UIColor grayColor].CGColor;
    _stuIdD.text = @"学...............号";
    [self.view addSubview:_stuIdD];
    
    UIButton* _comfirm = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame)/2-40, CGRectGetMaxY(self.view.frame)-120, 80, 37)];
    _comfirm.backgroundColor = [UIColor orangeColor];
    _comfirm.layer.cornerRadius = 5.0;
    _comfirm.layer.masksToBounds = YES;
    _comfirm.layer.borderWidth = 1.0;
    _comfirm.layer.borderColor = [UIColor grayColor].CGColor;
    [_comfirm setTitle:@"修改信息" forState:UIControlStateNormal];
    [_comfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_comfirm];
}

@end
