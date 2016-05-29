//
//  TitleViewController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "TitleViewController.h"
#import "DataController.h"
#import "DesignTitleController.h"
#import "Reachability.h"
#import "GetTitlesByHieroId.h"
#import <Masonry.h>
#import "GetToken.h"

@interface TitleViewController ()<UITableViewDelegate, UITableViewDataSource> {
    DataController *dataController;
    DesignTitleController *updateView;
    NSMutableArray *titles;
    NSMutableArray *interlayers;
}
@property (nonatomic)DesignTitleController *nextView;
@property (weak, nonatomic) IBOutlet UIButton *designTitle;
@property (weak, nonatomic) IBOutlet UILabel *titleOfTitle;
@property (weak, nonatomic) IBOutlet UITableView *titleTableView;

@end

@implementation TitleViewController

-(void)viewDidLoad {
    //设置圆角
    _designTitle.layer.cornerRadius = 5.0;
    _designTitle.layer.masksToBounds = YES;
    titles = [NSMutableArray array];
    interlayers = [NSMutableArray array];
    
    _titleTableView.delegate = self;
    _titleTableView.dataSource = self;
    [_titleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(super.view.mas_centerY);
    }];
    [_titleTableView setTableFooterView:[[UIView alloc] init]];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导师申请"]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //连接融云connectViewRongyun
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if (token) {
        [[GetToken getToken] connectViewRongyun];
    }
}

//出题界面
- (IBAction)turnToDesignTitleView:(UIButton *)sender {
    //判断是否出题
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _nextView = [storyboard instantiateViewControllerWithIdentifier:@"DisignTitle"];
    _nextView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_nextView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

//通过数据库获取题目
-(void)reloadData {
    //判断是否有网络
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) {
        //没有网络
//        [self setLocalData];
    }
    //获取数据
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTitles:) name:@"gotTitles" object:nil];
    GetTitlesByHieroId *getTManager = [[GetTitlesByHieroId alloc] init];
    [getTManager getTitlesByHieroId:name];
    
}

//获取网络数据
-(void)setTitles:(NSNotification *)notice {
    NSDictionary *allTitles = notice.object;
    titles = [allTitles objectForKey:@"title"];
    interlayers = [allTitles objectForKey:@"interlayer"];
    [_titleTableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotTitles" object:nil];
}

//-(void)setLocalData {
//    //获取数据库
//    dataController = [[DataController alloc] init];
//    //获取老师名字
//    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
//    //获取题目
//    NSMutableArray *titles = [dataController getTitleByHiero:name];
//    //判断题目
//    if ([titles count] == 0) {
//        //没有出题或者获取数据失败
//        _title1.text = [NSString stringWithFormat:@"第1题："];
//        _title2.text = [NSString stringWithFormat:@"第2题："];
//        _title3.text = [NSString stringWithFormat:@"第3题："];
//    } else {
//        //设置题目
//        NSMutableArray *title = [NSMutableArray array];
//        for (int i = 0; i < [titles count]; i++) {
//            NSString *name = [[titles objectAtIndex:i] objectAtIndex:0];
//            [title addObject:[NSString stringWithFormat:@"第%d题：%@", i+1, name]];
//        }
//        _title1.text = [titles count]>0 ? [title objectAtIndex:0]:@"第1题：";
//        _title2.text = [titles count]>1 ? [title objectAtIndex:1]:@"第2题：";
//        _title3.text = [titles count]>2 ? [title objectAtIndex:2]:@"第3题：";
//    }
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"审核中题目";
            break;
            
        case 1:
            return @"已通过题目";
            break;
            
        default:
            return @"未知";
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return interlayers.count;
    }
    if (section == 1) {
        return titles.count;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //设置cell
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[interlayers objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"描述：%@", [[interlayers objectAtIndex:indexPath.row] objectForKey:@"detail"]];
            break;
            
        case 1:
            cell.textLabel.text = [[titles objectAtIndex:indexPath.row] objectForKey:@"name"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"描述：%@", [[titles objectAtIndex:indexPath.row] objectForKey:@"detail"]];
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)addAlertWithTitle:(NSString *)title andDetails:(NSString *)detail {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:aler animated:YES completion:nil];
}

-(void)dealloc {
}

@end
