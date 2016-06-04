//
//  SelectSubject.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "Choose.h"
#import "DataController.h"
#import "TitleManager.h"
#import <Masonry.h>
#import "SelectedView.h"

@interface Choose()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *datas; //总数据
    UITableView *mainView;
}

@property (nonatomic)UIButton *showTitles;

@end

@implementation Choose

-(void)viewDidLoad{
    [super viewDidLoad];
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-120)];
    mainView.delegate = self;
    mainView.dataSource = self;
    [self.view addSubview:mainView];
    
    _showTitles = [[UIButton alloc] init];
    _showTitles.backgroundColor = [UIColor orangeColor];
    _showTitles.layer.cornerRadius = 25.0;
    _showTitles.layer.masksToBounds = YES;
    [_showTitles setTitle:@"查看所选题目" forState:UIControlStateNormal];
    [_showTitles addTarget:self action:@selector(showSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showTitles];
    
    [_showTitles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 50));
        make.centerX.offset(0);
        make.bottom.offset(-60);
    }];
    
    datas = [NSMutableArray array];
}

//跳转显示所有界面
-(void)showSelected {
    UIStoryboard *main =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelectedView *selectedView = [main instantiateViewControllerWithIdentifier:@"showSelected"];
    selectedView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectedView animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self reload];
}

-(void)viewDidDisappear:(BOOL)animated {
    datas = [NSMutableArray array];
}

-(void)reload {
    //获取数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTitleAndHiero:) name:@"gotTitlesAndHieros" object:nil];
    [TitleManager getAllTitleAndHiero];
}

-(void)setTitleAndHiero:(NSNotification *)notice {
    //判断是否被选
    NSArray *r = [notice object];
    for (int i = 0; i<r.count; i++) {
        NSMutableArray *titleMessage = [NSMutableArray array];
        for (NSMutableDictionary *oneData in [r objectAtIndex:i]) {
            NSInteger isSelected = [[oneData objectForKey:@"selected"] integerValue];
            if (isSelected == 0) {
                [titleMessage addObject:oneData];
            }
        }
        if (![titleMessage isEqualToArray:[NSArray array]]) {
            [datas addObject:titleMessage];
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"gotTitlesAndHieros" object:nil];
    [mainView reloadData];
}

//分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return datas.count;
}

//每个分区的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[datas objectAtIndex:section] count];
}

//设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

//标题：导师名字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *hieroName = [[[datas objectAtIndex:section] objectAtIndex:0] objectForKey:@"hieroId"];
    return [NSString stringWithFormat:@"导师：%@",hieroName];
}

//每个分区数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //设置cell的内容
    NSString *title = [[[datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString *detail = [[[datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"detail"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"描述：%@",detail];
    
    return cell;
}

//选择课程
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取题目名字和自己名字
    NSString *title = [[tableView cellForRowAtIndexPath:indexPath] textLabel].text;
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    UIAlertController *chooceAlert = [UIAlertController alertControllerWithTitle:@"是否选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [chooceAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //发送数据
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseTitle:) name:@"chooseTitle" object:nil];
        [TitleManager selectTitleWithName:name andTitle:title];
        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    }]];
    [chooceAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:chooceAlert animated:YES completion:nil];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

-(void)chooseTitle:(NSNotification *)notice {
    NSInteger result = [[notice.object objectForKey:@"result"] integerValue];
    if (result == 0) {
        [self addAlertWithTitle:@"选题失败" andDetails:@"题目已经被选"];
    } else if (result == 1){
        [self addAlertWithTitle:@"选题成功" andDetails:nil];
    } else if (result == 2){
        [self addAlertWithTitle:@"你已经选择" andDetails:@"已经选择改题"];
    } else if (result == 3) {
        [self addAlertWithTitle:@"你已经选满" andDetails:@"选满3个题目"];
    }else {
        [self addAlertWithTitle:@"你已经选题" andDetails:@"不需要选题"];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"chooseTitle" object:nil];
}


-(void)addAlertWithTitle:(NSString *)title andDetails:(NSString *)detail {
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    [aler addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:aler animated:YES completion:nil];
}
@end
