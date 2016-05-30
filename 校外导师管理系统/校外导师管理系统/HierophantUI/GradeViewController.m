//
//  GradeViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "GradeViewController.h"
#import "DataController.h"
@interface GradeViewController()<UITableViewDelegate, UITableViewDataSource> {
    DataController *dataController;
}

@end

@implementation GradeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.navigationItem setTitle:@"成绩管理"];
    [self reloadData];
}

-(void)reloadData {
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
