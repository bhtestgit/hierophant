//
//  ChooseStuController.m
//  校外导师
//
//  Created by 柏涵 on 16/5/29.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ChooseStuController.h"
#import "StudentManager.h"

@interface ChooseStuController ()<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *students; //所有学生
}

@end

@implementation ChooseStuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    students = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)reload {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setStudentData:) name:@"gotStudents" object:nil];
    NSString *hieroId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    [StudentManager getAllInterlayerStuWithHieroId:hieroId];
}

-(void)setStudentData:(NSNotification *)notice {
    students = notice.object;
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotStudents" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return students.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[students objectAtIndex:section] count];
}

//设置标题，题目名
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *titleName = [[[students objectAtIndex:section] objectAtIndex:0] objectAtIndex:0];
    return [NSString stringWithFormat:@"题目：%@", titleName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *oneName = [[[students objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1];
    NSString *number = [[[students objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:2];
    
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@", oneName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"学号：%@", number];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
