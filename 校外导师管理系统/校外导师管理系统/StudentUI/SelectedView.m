//
//  SelectedView.m
//  校外导师
//
//  Created by 柏涵 on 16/5/29.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "SelectedView.h"
#import "TitleManager.h"

@interface SelectedView ()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *titles;
}

@end

@implementation SelectedView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"已选题目";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)viewDidDisappear:(BOOL)animated {
    titles = [NSMutableArray array];
}

-(void)reload {
    titles = [NSMutableArray array];
    //获取数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotAllChoisen:) name:@"gotAllChoisen" object:nil];
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    [TitleManager getAllChosenTitleByStu:name];
}

-(void)gotAllChoisen:(NSNotification *)notice {
    titles = notice.object;
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotAllChoisen" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (titles.count == 0) {
        return 1;
    } else {
      return titles.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

//每个分区数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //设置cell的内容
    if (titles.count == 0) {
        cell.textLabel.text = @"没有选题";
    } else {
        NSString *title = [titles objectAtIndex:indexPath.row];
        cell.textLabel.text = title;
    }
    
    return cell;
}

///定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (titles.count != 0) {
        //获取删除的名字
        NSString *title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
        //删除
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteResult:) name:@"deleteChosen" object:nil];
        [TitleManager deleteChosenTitleWithTitle:title andName:name];
    }
}

-(void)deleteResult:(NSNotification *)notice {
    NSInteger result = [[notice.object objectForKey:@"result"] integerValue];
    if (result == 0) {
        [self addAlertWithTitle:@"删除失败" andDetail:nil];
    } else {
        [self addAlertWithTitle:@"删除成功" andDetail:nil];
    }
    
    [self reload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteChosen" object:nil];
}

//通知
-(void)addAlertWithTitle:(NSString *)titleA andDetail:(NSString *)detailA {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:detailA preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

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
