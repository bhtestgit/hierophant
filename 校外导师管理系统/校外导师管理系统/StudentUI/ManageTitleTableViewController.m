//
//  ManageTitleTableViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/5/26.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "ManageTitleTableViewController.h"
#import "TitleManager.h"

@interface ManageTitleTableViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *interTitles; //缓存题目
    NSMutableArray *titles; //正式题目
}

@end

@implementation ManageTitleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    interTitles = [NSMutableArray array];
    titles = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)viewWillDisappear:(BOOL)animated {
    interTitles = [NSMutableArray array];
    titles = [NSMutableArray array];
}

//加载数据
-(void)reload {
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCellData:) name:@"gotTitles" object:nil];
    [TitleManager getAllTitle];
}

-(void)setCellData:(NSNotification *)notice {
    NSDictionary *allTitles = [notice object];
    interTitles = [allTitles objectForKey:@"interlayerTitles"];
    titles = [allTitles objectForKey:@"titles"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotTitles" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"未审核";
            break;
            
        default:
            return @"已通过";
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return interTitles.count;
            break;
            
        default:
            return titles.count;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text = [[interTitles objectAtIndex:indexPath.row] objectAtIndex:0];
                cell.detailTextLabel.text = [[interTitles objectAtIndex:indexPath.row] objectAtIndex:1];
                break;
                
            default:
                cell.textLabel.text = [[titles objectAtIndex:indexPath.row] objectAtIndex:0];
                cell.detailTextLabel.text = [[titles objectAtIndex:indexPath.row] objectAtIndex:1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
        }
    
    return cell;
}

//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //创建通知
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否通过" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取题目名字
            NSString *title = [[interTitles objectAtIndex:indexPath.section] objectAtIndex:0];
            //连接服务器
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmResult:) name:@"confirmTitle" object:nil];
            [TitleManager confirmTitleWithName:title];
            
        }]];
        __weak typeof(self) weakSelf = self;
        [alert addAction:[UIAlertAction actionWithTitle:@"联系导师" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //获取导师名字
            NSString *name = [[interTitles objectAtIndex:indexPath.row] objectAtIndex:2];
            //跳转联系导师界面
            [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"connetHiero"];
            weakSelf.tabBarController.selectedIndex = 3;
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)confirmResult:(NSNotification *)notice {
     NSInteger r = [[notice.object objectForKey:@"result"] integerValue];
    if (r == 0) {
        //出题失败
        [self addAlertWithTitle:@"服务器出题失败" andDetail:nil];
    } else {
        [self addAlertWithTitle:@"出题发布成功" andDetail:nil];
        //刷新
        [self reload];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"confirmTitle" object:nil];
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

//通知
-(void)addAlertWithTitle:(NSString *)titleA andDetail:(NSString *)detailA {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:detailA preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
