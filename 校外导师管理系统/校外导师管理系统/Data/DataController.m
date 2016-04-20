//
//  DataController.m
//  校外导师
//
//  Created by 柏涵 on 16/3/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "DataController.h"
#import <sqlite3.h>

@interface DataController(){
    sqlite3 *_database;
    sqlite3_stmt *_statement;
}

@end

@implementation DataController{
    
}

//自定义初始化
-(instancetype)init{
    if (!self) {
        self = [super init];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunched"]) {
        [self createTable];
    }
    return self;
}

//创建学生、导师、题目及中间数据数据库路径
-(NSString *)getDataFilePath{
    //获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString *documentdirectory = [paths objectAtIndex:0];
    
    return [documentdirectory stringByAppendingPathComponent:@"data.db"];
}

//打开数据库
-(BOOL)openDataBase : (NSString *)dataFileName{
    NSString *dataPath =[self getDataFilePath];
    
    if (sqlite3_open([dataPath UTF8String], &_database) == SQLITE_OK) {
        return YES;
    } else {
        return NO;
    }
}

//创建表
-(BOOL)createTable{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char * zErr;
    
    char *stuSql = "create table if not exists student(name text primary key, password text)";
    
    char *hieroSql = "create table if not exists hierophant(name text primary key, password text, sex text, birthday text, PFT text, skills text, timeOfPFT text, workUnit text, positions text, phone int, email text, experience text)";
    
    char *titleSql = "create table if not exists title(name text primary key, hieroId text, studentId text, score int, foreign key (hieroId) references hierophant(name) on delete cascade on update cascade, foreign key studentId references student(name) on delete set null on update cascade)";
    char *interlayerSql = "create table if not exists interlayer(name text primary key, hieroId text, student1Id text, student2Id text, student3Id text foreign key (name) references title(name) on delete casecade on update cascade)";

    if (sqlite3_exec(_database, stuSql, NULL, NULL, &zErr) == SQLITE_OK) {
        if (sqlite3_exec(_database, hieroSql, NULL, NULL, &zErr) == SQLITE_OK) {
            if (sqlite3_exec(_database, titleSql, NULL, NULL, &zErr) == SQLITE_OK) {
                if (sqlite3_exec(_database, interlayerSql, NULL, NULL, &zErr) == SQLITE_OK) {
                    sqlite3_close(_database);
                    return YES;
                }
            }
        }
    }
    sqlite3_close(_database);
    return NO;
}

//添加学生数据
-(BOOL)insertStudentTable:(NSMutableString *)name password:(NSMutableString *)password{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "insert into student(name, password) values(?, ?)";
    //编译
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    
    sqlite3_bind_text(_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
    
    int result = sqlite3_step(_statement);
    //释放statment
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    
    sqlite3_close(_database);
    return YES;
}

//添加老师数据
-(BOOL)insertHierophantTable:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(int)phone email:(NSMutableString *)email experience:(NSMutableString *)experience{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "insert into hierophant(name, password, sex, birthday, PFT, skills, timeOfPFT, workUnit, positions, phone, email, experience) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_text(_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [sex UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 4, [birthday UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 5, [PFT UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 6, [skills UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 7, [timeOfPFT UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 8, [workUnit UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 9, [positions UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 10, phone);
    sqlite3_bind_text(_statement, 11, [email UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 12, [experience UTF8String], -1, SQLITE_TRANSIENT);
    
    int  result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_close(_database);
    return YES;
}

//添加题目数据
-(BOOL)insertTitleTable:(NSMutableString *)name :(NSMutableString *)hieroId :(NSMutableString *)studentId :(int)score{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "insert into title(name, hiero, student, score) values(?, ?, ?, ?)";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_bind_text(_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [hieroId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [studentId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 4, score);
    
    int result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_close(_database);
    
    return YES;
}

//添加中间数据
-(BOOL)insertInterlayerTable:(NSMutableString *)titleId hieroId:(NSMutableString *)hieroId student1Id:(NSMutableString *)student1ID student2Id:(NSMutableString *)student2Id student3Id:(NSMutableString *)student3Id{
    [self openDataBase:[self getDataFilePath]];
    char *sql = "insert into interlayer(id, hieroId, student1Id, student2Id, student3Id) value(?, ?, ?, ?, ?)";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_text(_statement, 1, [titleId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [hieroId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [student1ID UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 4, [student2Id UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 5, [student3Id UTF8String], -1, SQLITE_TRANSIENT);
    
    int result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_close(_database);
    return YES;
}

//获取学生数据
-(NSMutableArray *)getStudentData:(NSMutableString *)stuId{
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from student where name = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        NSLog(@"编译失败");
        return datas;
    }
    sqlite3_bind_text(_statement, 1, [stuId UTF8String], -1, SQLITE_TRANSIENT);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        char *sCName = (char *)sqlite3_column_text(_statement, 0);
        char *sCPassword = (char *)sqlite3_column_text(_statement, 1);
        [datas addObject:[NSString stringWithUTF8String:sCName]];
        [datas addObject:[NSString stringWithUTF8String:sCPassword]];
    }
    
    return datas;
    
}
//获取老师数据
-(NSMutableArray *)getHierophantData:(NSMutableString *)hieroId {
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from hiero where name = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        NSLog(@"编译失败");
        return datas;
    }
    sqlite3_bind_text(_statement, 1, [hieroId UTF8String], -1, SQLITE_TRANSIENT);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        char *hCName = (char *)sqlite3_column_text(_statement, 0);
        char *hCPassword = (char *)sqlite3_column_text(_statement, 1);
        char *hCSex = (char *)sqlite3_column_text(_statement, 2);
        char *hCBirthday = (char *)sqlite3_column_text(_statement, 3);
        char *hCPFT = (char *)sqlite3_column_text(_statement, 4);
        char *hCSkills = (char *)sqlite3_column_text(_statement, 5);
        char *hCTimeOfPFT = (char *)sqlite3_column_text(_statement, 6);
        char *hCWorkUnit = (char *)sqlite3_column_text(_statement, 7);
        char *hCPositions = (char *)sqlite3_column_text(_statement, 8);
        int hCPhone = sqlite3_column_int(_statement, 9);
        char *hCEmail = (char *)sqlite3_column_text(_statement, 10);
        char *hCExperience = (char *)sqlite3_column_text(_statement, 11);
        
        [datas addObject:[NSString stringWithUTF8String:hCName]];
        [datas addObject:[NSString stringWithUTF8String:hCPassword]];
        [datas addObject:[NSString stringWithUTF8String:hCSex]];
        [datas addObject:[NSString stringWithUTF8String:hCBirthday]];
        [datas addObject:[NSString stringWithUTF8String:hCPFT]];
        [datas addObject:[NSString stringWithUTF8String:hCSkills]];
        [datas addObject:[NSString stringWithUTF8String:hCTimeOfPFT]];
        [datas addObject:[NSString stringWithUTF8String:hCWorkUnit]];
        [datas addObject:[NSString stringWithUTF8String:hCPositions]];
        [datas addObject:[NSNumber numberWithInt:hCPhone]];
        [datas addObject:[NSString stringWithUTF8String:hCEmail]];
        [datas addObject:[NSString stringWithUTF8String:hCExperience]];
    }
    
    return datas;
}
//获取题目数据
-(NSMutableArray *)getTitleData:(NSMutableString *)titleId {
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from title where name = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        NSLog(@"编译失败");
        return datas;
    }
    sqlite3_bind_text(_statement, 1, [titleId UTF8String], -1, SQLITE_TRANSIENT);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        char *tCName = (char *)sqlite3_column_text(_statement, 0);
        char *tHiero = (char *)sqlite3_column_text(_statement, 1);
        char *tStudent = (char *)sqlite3_column_text(_statement, 2);
        int score = sqlite3_column_int(_statement, 3);
        [datas addObject:[NSString stringWithUTF8String:tCName]];
        [datas addObject:[NSString stringWithUTF8String:tHiero]];
        [datas addObject:[NSString stringWithUTF8String:tStudent]];
        [datas addObject:[NSNumber numberWithInt:score]];
    }
    
    return datas;
}

//获取所有题目信息
-(NSMutableDictionary *)getAllSubject {
//    NSMutableArray *datas = [NSMutableArray array];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    NSMutableArray *hieros = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //获取导师id
    char *sqlHiero = "select name from hierophant";
    sqlite3_prepare_v2(_database, sqlHiero, -1, &_statement, NULL);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        for (int i = 0; i<sqlite3_column_count(_statement); i++) {
            char *ids = (char *)sqlite3_column_text(_statement, i);
            [hieros addObject:[NSString stringWithUTF8String:ids]];
        }
    }
    //获取题目
    char *sqlSub = "select name from title where hieroId = ?";
    sqlite3_prepare_v2(_database, sqlSub, -1, &_statement, NULL);
//    //用数组的方式
//    for (int i = 0; i<hieros.count; i++) {
//        sqlite3_bind_int(_statement, 1, (int)[hieros objectAtIndex:i]);
//        //存储题目
//        NSMutableArray *hieroAndSub = [NSMutableArray array];
//        [hieroAndSub addObject:[hieros objectAtIndex:i]];
//        while (sqlite3_step(_statement) == SQLITE_ROW) {
//            for (int j = 0; j<sqlite3_column_count(_statement); j++) {
//                char *names = (char *)sqlite3_column_text(_statement, j);
//                [hieroAndSub addObject:[NSString stringWithUTF8String:names]];
//            }
//        }
//        //将导师和题目信息整合
//        [datas addObject:hieroAndSub];
//    }
    //用字典的方式
    for (int i = 0; i<hieros.count; i++) {
        sqlite3_bind_text(_statement, 1, [[hieros objectAtIndex:i] UTF8String], -1, SQLITE_TRANSIENT);
        while (sqlite3_step(_statement)==SQLITE_ROW) {
            //添加题目
            for (int j = 0; j<sqlite3_column_count(_statement); j++) {
                [titles addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(_statement, j)]];
            }
        }
        [data setObject:titles forKey:[hieros objectAtIndex:i]];
    }
    
    //将数据存入字典
    return data;
}

//获取中间数据
-(NSMutableArray *)getInterlayerData:(NSMutableString *)titleId{
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from interlayer where name = ?";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        return datas;
    }
    sqlite3_bind_text(_statement, 1, [titleId UTF8String], -1, SQLITE_TRANSIENT);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        char *tID = (char *)sqlite3_column_text(_statement, 0);
        char *hID = (char *)sqlite3_column_text(_statement, 1);
        char *s1ID = (char *)sqlite3_column_text(_statement, 2);
        char *s2ID = (char *)sqlite3_column_text(_statement, 3);
        char *s3ID = (char *)sqlite3_column_text(_statement, 4);
        [datas addObject:[NSString stringWithUTF8String:tID]];
        [datas addObject:[NSString stringWithUTF8String:hID]];
        [datas addObject:[NSString stringWithUTF8String:s1ID]];
        [datas addObject:[NSString stringWithUTF8String:s2ID]];
        [datas addObject:[NSString stringWithUTF8String:s3ID]];
    }
    
    return datas;
}

//更新学生数据
-(BOOL)updateStudentData:(NSMutableString *)name :(NSMutableString *)password {
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "update student set password = ? where name = ?";
    //编译
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    
    sqlite3_bind_text(_statement, 1, [password UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
    
    int result = sqlite3_step(_statement);
    //释放statment
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    
    sqlite3_close(_database);
    return YES;
}
//更新导师数据
-(BOOL)updateHieroData:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(int)phone email:(NSMutableString *)email experience:(NSMutableString *)experience{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "update hierophant set password = ? and sex = ?  and birthday = ? and PFT = ? and skills = ? and timeOfPFT = ? and workUnit = ? and positions = ? and phone = ? and email = ? and experience = ? where name = ?";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_text(_statement, 1, [password UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [sex UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [birthday UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 4, [PFT UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 5, [skills UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 6, [timeOfPFT UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 7, [workUnit UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 8, [positions UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 9, phone);
    sqlite3_bind_text(_statement, 10, [email UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 11, [experience UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 12, [name UTF8String], -1, SQLITE_TRANSIENT);
    
    int  result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_close(_database);
    return YES;
}
//更新题目数据
-(BOOL)updateTitleData:(NSMutableString *)name hieroId:(NSMutableString *)hieroId studentId:(NSMutableString *)studentId score:(int)score{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "update title set hieroId = ? and studentId = ? and score = ? where name = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_bind_text(_statement, 1, [hieroId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [studentId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 3, score);
    sqlite3_bind_text(_statement, 4, [name UTF8String], -1, SQLITE_TRANSIENT);
    
    int result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_close(_database);
    
    return YES;
}
//更新中间数据
-(BOOL)updateInterlayerData:(NSMutableString *)titleId student1Id:(NSMutableString *)student1Id studnet2Id:(NSMutableString *)student2Id student3Id:(NSMutableString *)student3Id{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "update interlayer set student1Id = ? and student2Id = ? and student3Id = ? where name = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_text(_statement, 1, [student1Id UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [student2Id UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [student3Id UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [titleId UTF8String], -1, SQLITE_TRANSIENT);
    
    int result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_close(_database);
    
    return YES;
}
//删除题目
-(BOOL)deleteTitle:(NSMutableString *)titleId{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "delete from title where name = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }

    sqlite3_bind_text(_statement, 3, [titleId UTF8String], -1, SQLITE_TRANSIENT);
    
    int result = sqlite3_step(_statement);
    sqlite3_finalize(_statement);
    if (result != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_close(_database);
    
    return YES;
}

@end

