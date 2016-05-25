//
//  DesignTitleController.m
//  校外导师
//
//  Created by 柏涵 on 16/4/4.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "DesignTitleController.h"
#import "DataController.h"
#import "InsertTitleController.h"
#import "Reachability.h"
#import "GetTitlesByHieroId.h"
#import <Masonry.h>
#import "InterlayerTitle.h"

#define SCREANWIDTH CGRectGetMaxX(self.view.frame)
@interface DesignTitleController()<UITableViewDelegate, UITableViewDataSource>{
    DataController *dataController;
    NSMutableArray *titles;
    NSMutableArray *interlayers;
    NSMutableString *title;
    NSMutableString *detail;
    NSMutableString *oldTitle;
}

@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (weak, nonatomic) IBOutlet UITableView *titleTableView;

@end

@implementation DesignTitleController

-(void)viewDidLoad {
    self.navigationItem.title = @"管理";
    
    _titleTableView.delegate = self;
    _titleTableView.dataSource = self;
    titles = [NSMutableArray array];
    interlayers = [NSMutableArray array];
    _confirm.layer.cornerRadius = 5.0;
    _confirm.layer.masksToBounds = YES;
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-20);
    }];
    [_confirm addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self reloadData];
}

//确定按钮
-(void)buttonPressed {
    //弹出窗口
    UIAlertController *insertAlert = [UIAlertController alertControllerWithTitle:@"出题" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [insertAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"题目";
        //字数限制
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldIsNotNil:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [insertAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"描述";
        //字数限制
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldIsNotNil:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [insertAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }]];
    [insertAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取数据
        title = (NSMutableString *)insertAlert.textFields.firstObject.text;
        detail = (NSMutableString *)insertAlert.textFields.lastObject.text;
        [self insertTitleWithTitle:title andDetail:detail];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }]];
    [self presentViewController:insertAlert animated:YES completion:nil];
    
        
    //设置本地数据
//        [self insertLocalTitle];
}

-(void)insertTitleWithTitle:(NSString *)titleD andDetail:(NSString *)detailD {
    //发送数据
    InsertTitleController *insertController = [[InsertTitleController alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inserResult:) name:@"insertResult" object:nil];
    InterlayerTitle *titleObject = [[InterlayerTitle alloc] init];
    titleObject.name = titleD;
    titleObject.detail = detailD;
    titleObject.hieroId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    [insertController insertTitleIntServersWithTitle:titleObject];
    
}

//判断出题结果
-(void)inserResult:(NSNotification *)notice {
    NSInteger r = [[notice.object objectForKey:@"result"] integerValue];
    if (r == 0) {
        //出题失败
        [self addAlertWithTitle:@"服务器出题失败" andDetail:nil];
    } else {
        [self addAlertWithTitle:@"出题成功" andDetail:nil];
        //刷新
        [self reloadData];
    }
    //撤销监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"insertResult" object:nil];
}

//判断出题结果
-(void)updateResult:(NSNotification *)notice {
    NSInteger r = [[notice.object objectForKey:@"result"] integerValue];
    if (r == 0) {
        //出题失败
        [self addAlertWithTitle:@"服务器修改失败" andDetail:nil];
    } else {
        [self addAlertWithTitle:@"修改成功" andDetail:nil];
        //刷新
        [self reloadData];
    }
    //撤销监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateResult" object:nil];
}

//设置本地数据
-(void)insertLocalTitle {
    //获取数据
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
//    NSMutableString *title1 = (NSMutableString *)_firstTitleF.text;
//    NSMutableString *detail1 = (NSMutableString *)_firstDetailF.text;
    //添加到数据库
    dataController = [[DataController alloc] init];
    BOOL rslt1 = false;
    BOOL rslt2 = false;
    BOOL rslt3 = false;
    NSString *successT;
    NSString *falseT;
//    rslt1 = _firstYet?[dataController insertTitleTable:title1 detail:detail1 hieroId:name studentId:[NSMutableString string] score:0]:YES;
        successT = @"出题成功";
        falseT = @"出题失败";
    
    if (rslt1 && rslt2 && rslt3) {
        [self addAlertWithTitle:successT andDetail:nil];
    } else {
        [self addAlertWithTitle:falseT andDetail:nil];
    }
}

//加载数据
-(void)reloadData {
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

//加载本地数据
-(void)loadLocalData {
    //获取数据库
    dataController = [[DataController alloc] init];
    //获取老师名字
    NSMutableString *name = (NSMutableString *)[[NSUserDefaults standardUserDefaults] stringForKey:@"userName"];
    //获取题目
    titles = [dataController getTitleByHiero:name];
    NSMutableArray *title = [NSMutableArray array];
    //判断题目
    if ([titles count] == 0) {
        //没有出题或者获取数据失败
    } else {
        //设置题目
        for (int i = 0; i < [titles count]; i++) {
            NSString *name = [[titles objectAtIndex:i] objectAtIndex:0];
            NSString *detail = [[titles objectAtIndex:i] objectAtIndex:1];
            [title addObject:name];
            [title addObject:detail];
        }
    }
}

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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return YES;
            break;
            
        default:
            return NO;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //弹出窗口
        UIAlertController *insertAlert = [UIAlertController alertControllerWithTitle:@"修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [insertAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            //字数限制
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldIsNotNil:) name:UITextFieldTextDidChangeNotification object:textField];
        }];
        [insertAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text;
            //字数限制
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextFieldIsNotNil:) name:UITextFieldTextDidChangeNotification object:textField];
        }];
        [insertAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        }]];
        [insertAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取数据
            oldTitle = (NSMutableString *)[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            title = (NSMutableString *)insertAlert.textFields.firstObject.text;
            detail = (NSMutableString *)insertAlert.textFields.lastObject.text;
            InsertTitleController *updateController = [[InsertTitleController alloc] init];
            //发送数据
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResult:) name:@"updateResult" object:nil];
            [updateController updateTitleInServletWithOldTitle:oldTitle andNewTitle:title andNewDetail:detail];
            
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        }]];
        [self presentViewController:insertAlert animated:YES completion:nil];
        //设置选中
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    }
}

//定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}

//进入编辑模式，按下出现的编辑按钮后
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView setEditing:NO animated:YES];
//}

//通知
-(void)addAlertWithTitle:(NSString *)titleA andDetail:(NSString *)detailA {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:detailA preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

//用户名及密码数量观察者
- (void)TextFieldIsNotNil:(NSNotification *)notifacation{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *name = alertController.textFields.firstObject;
        UITextField *password = alertController.textFields.lastObject;
        UIAlertAction *okAction = alertController.actions.firstObject;
        if (name.text.length > 2 && password.text.length > 2) {
            okAction.enabled = YES;
        }   else {
            okAction.enabled = NO;
        }
    }
}

@end
