//
//  ContactWithStudent.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ContactWithStudent.h"
@interface ContactWithStudent() {
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *stu1L;
@property (weak, nonatomic) IBOutlet UILabel *stu2L;
@property (weak, nonatomic) IBOutlet UILabel *stu3L;
@property (weak, nonatomic) IBOutlet UIButton *contact1;
@property (weak, nonatomic) IBOutlet UIButton *contact2;
@property (weak, nonatomic) IBOutlet UIButton *contact3;


@end

@implementation ContactWithStudent

-(void)viewDidLoad {
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"交流界面"]];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 600);
    
    _stu1L.layer.cornerRadius = 5.0;
    _stu1L.layer.masksToBounds = YES;
    _stu2L.layer.cornerRadius = 5.0;
    _stu2L.layer.masksToBounds = YES;
    _stu3L.layer.cornerRadius = 5.0;
    _stu3L.layer.masksToBounds = YES;
    _contact1.layer.cornerRadius = 5.0;
    _contact1.layer.masksToBounds = YES;
    _contact2.layer.cornerRadius = 5.0;
    _contact2.layer.masksToBounds = YES;
    _contact3.layer.cornerRadius = 5.0;
    _contact3.layer.masksToBounds = YES;
}

@end
