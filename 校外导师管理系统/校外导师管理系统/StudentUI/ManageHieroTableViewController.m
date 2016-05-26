//
//  ManageHieroTableViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/5/26.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ManageHieroTableViewController.h"
#import "HierophentManager.h"
#import "InformationViewController.h"

@interface ManageHieroTableViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *names;  //所有名字
    InformationViewController *subview;
}

@end

@implementation ManageHieroTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    names = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

//加载数据
-(void)reload {
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setHieroName:) name:@"gotHieros" object:nil];
    [HierophentManager getAllInterHiero];
}

-(void)setHieroName:(NSNotification *)notice {
    NSDictionary *allName = notice.object;
    names = [allName objectForKey:@"names"];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotHieros" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [names objectAtIndex:indexPath.row];
    
    return cell;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //跳转到详情界面
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    subview = [storyboard instantiateViewControllerWithIdentifier:@"HcommunicateView"];
    NSString *name = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [subview setButtonByManagerWithName:name];
    subview.hidesBottomBarWhenPushed = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configResult:) name:@"configResult" object:nil];
    [self.navigationController pushViewController:subview animated:YES];
}

-(void)configResult:(NSNotification *)notice {
    NSString *title = [notice.object objectForKey:@"title"];
    NSString *detail = [notice.object objectForKey:@"detail"];
    [self addAlertWithTitle:title andDetails:detail];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"configResult" object:nil];
}

-(void)addAlertWithTitle:(NSString *)title andDetails:(NSString *)detail {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:aler animated:YES completion:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"configResult" object:nil];
}

// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}


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
