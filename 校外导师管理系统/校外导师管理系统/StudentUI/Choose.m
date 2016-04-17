//
//  SelectSubject.m
//  校外导师
//
//  Created by 柏涵 on 16/3/3.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "Choose.h"
#import "DataController.h"
#define SCREAN_WIDTH CGRectGetMaxX(self.view.frame)
#define SCREAN_HIGHT CGRectGetMaxY(self.view.frame)

@interface Choose()<UITableViewDelegate, UITableViewDataSource>{
}

//题目数据
@property(nonatomic)NSMutableDictionary *datas;
@property(nonatomic)NSMutableArray *dataArray;
@property(nonatomic)UIView* headerView;

@end

@implementation Choose

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeAppearance];
}

-(void)initializeAppearance{
    [super initializeAppearance];
    //判断导师是否发布题目
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isReleaseSubject"]) {
        //tableView
//        [self initDataSource];
        UITableView *_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 28, SCREAN_WIDTH, SCREAN_HIGHT) style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"选择题目"]];
        
        [self.view addSubview:_table];
    } else {
        //提示没有发布表
        UILabel *hint = [[UILabel alloc] init];
        hint.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        hint.bounds = CGRectMake(0, 0, 160, 37);
        hint.layer.cornerRadius = 10;
        hint.layer.masksToBounds = YES;
        hint.backgroundColor = [UIColor yellowColor];
        hint.textColor = [UIColor redColor];
        hint.text = @"导师没有发布题目!";
        [self.view addSubview:hint];
    }
    

}
//初始化数据
-(void)initDataSource{
    //创建数据管理对象
    DataController *dataController = [[DataController alloc] init];
    //获取数据
    _datas = [NSMutableDictionary dictionaryWithDictionary:[dataController getAllSubject]];
    
    _dataArray = (NSMutableArray *)[[_datas allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

//分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //为导师数量
    if (_datas.count != 0) {
        return _datas.count;
    } else {
        return 1;
    }
}

//每个分区的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //获取section的个数
    int numberOfCell = 1;
    //导师的题目数量
    NSMutableString *title = [_dataArray objectAtIndex:section];
    
    if ([_datas objectForKey:title]!=NULL) {
        return [[_datas objectForKey:title] count];
    }
    else {
        return numberOfCell;
    }
}

//标题
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (_dataArray!=NULL) {
        return _dataArray;
    }
    else{
        return NULL;
    }
}
//页脚
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSMutableString *title = [_dataArray objectAtIndex:section];
    return [NSString stringWithFormat:@"有%lu个题目",[[_datas objectForKey:title] count]];
}
//每个分区数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    //设置cell的内容
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.text = @"题目";
    cell.detailTextLabel.text=@"详细数据";
    
    return cell;
}

//选择课程
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
