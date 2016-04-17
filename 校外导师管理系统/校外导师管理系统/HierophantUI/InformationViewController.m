//
//  InformationViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "InformationViewController.h"
@interface InformationViewController() {
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *change;


@end

@implementation InformationViewController

-(void)viewDidLoad{
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"个人信息"]];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 700);
    _change.layer.cornerRadius = 5.0;
    _change.layer.masksToBounds = YES;
    
}

@end
