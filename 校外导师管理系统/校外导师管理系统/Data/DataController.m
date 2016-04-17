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
    
    char *stuSql = "create table if not exists student(id int primary key, name text, password text)";
    
    char *hieroSql = "create table if not exists hierophant(id int primary key, name text, password text, sex text, birthday text, PFT text, skills text, timeOfPFT text, workUnit text, positions text, phone int, email text, experience text)";
    
    char *titleSql = "create table if not exists title(id int primary key, name text, hieroId int, studentId int, score int, foreign key (hieroId) references hierophant(id) on delete cascade on update cascade, foreign key studentId references student(id) on delete set null on update cascade)";
    char *interlayerSql = "create table if not exists interlayer(id primary key, hieroId int, student1Id int, student2Id int, student3Id int foreign key (id) references title(id) on delete casecade on update cascade)";

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
-(BOOL)insertStudentTable:(int)StuId :(NSMutableString *)name :(NSMutableString *)password {
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "insert into student(id, name, password) value(?, ?, ?)";
    //编译
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    
    sqlite3_bind_int(_statement, 1, StuId);
    sqlite3_bind_text(_statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [password UTF8String], -1, SQLITE_TRANSIENT);
    
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
-(BOOL)insertHierophantTable:(int)HieroId :(NSMutableString *)name :(NSMutableString *)password :(NSMutableString *)sex :(NSMutableString *)birthday :(NSMutableString *)PFT :(NSMutableString *)skills :(NSMutableString *)timeOfPFT :(NSMutableString *)workUnit :(NSMutableString *)positions :(int)phone :(NSMutableString *)email :(NSMutableString *)experience {
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "insert into hierophant(id, name, password, sex, birthday, PFT, skills, timeOfPFT, workUnit, positions, phone, email, experience) value(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_int(_statement, 1, HieroId);
    sqlite3_bind_text(_statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 3, [password UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 4, [sex UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 5, [birthday UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 6, [PFT UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 7, [skills UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 8, [timeOfPFT UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 9, [workUnit UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 10, [positions UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 11, phone);
    sqlite3_bind_text(_statement, 12, [email UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 13, [experience UTF8String], -1, SQLITE_TRANSIENT);
    
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
-(BOOL)insertTitleTable:(int)titleId :(NSMutableString *)name :(int)hieroId :(int)studentId :(int)score{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "insert into title(id, name, hiero, student, score) value(?, ?, ?, ?, ?)";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_bind_int(_statement, 1, titleId);
    sqlite3_bind_text(_statement, 2, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 3, hieroId);
    sqlite3_bind_int(_statement, 4, studentId);
    sqlite3_bind_int(_statement, 5, score);
    
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
-(BOOL)insertInterlayerTable:(int)titleId :(int)hieroId :(int)student1ID :(int)student2Id :(int)student3Id{
    [self openDataBase:[self getDataFilePath]];
    char *sql = "insert into interlayer(id, hieroId, student1Id, student2Id, student3Id) value(?, ?, ?, ?, ?)";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_int(_statement, 1, titleId);
    sqlite3_bind_int(_statement, 2, hieroId);
    sqlite3_bind_int(_statement, 3, student1ID);
    sqlite3_bind_int(_statement, 4, student2Id);
    sqlite3_bind_int(_statement, 5, student3Id);
    
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
-(NSMutableArray *)getStudentData:(int)stuId {
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from student where id = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        NSLog(@"编译失败");
        return datas;
    }
    sqlite3_bind_int(_statement, 1, stuId);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        int sID = sqlite3_column_int(_statement, 0);
        char *sCName = (char *)sqlite3_column_text(_statement, 1);
        char *sCPassword = (char *)sqlite3_column_text(_statement, 2);
        [datas addObject:[NSNumber numberWithInt:sID]];
        [datas addObject:[NSString stringWithUTF8String:sCName]];
        [datas addObject:[NSString stringWithUTF8String:sCPassword]];
    }
    
    return datas;
    
}
//获取老师数据
-(NSMutableArray *)getHierophantData:(int)hieroId {
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from hiero where id = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        NSLog(@"编译失败");
        return datas;
    }
    sqlite3_bind_int(_statement, 1, hieroId);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        int hID = sqlite3_column_int(_statement, 0);
        char *hCName = (char *)sqlite3_column_text(_statement, 1);
        char *hCPassword = (char *)sqlite3_column_text(_statement, 2);
        char *hCSex = (char *)sqlite3_column_text(_statement, 3);
        char *hCBirthday = (char *)sqlite3_column_text(_statement, 4);
        char *hCPFT = (char *)sqlite3_column_text(_statement, 5);
        char *hCSkills = (char *)sqlite3_column_text(_statement, 6);
        char *hCTimeOfPFT = (char *)sqlite3_column_text(_statement, 7);
        char *hCWorkUnit = (char *)sqlite3_column_text(_statement, 8);
        char *hCPositions = (char *)sqlite3_column_text(_statement, 9);
        int hCPhone = sqlite3_column_int(_statement, 10);
        char *hCEmail = (char *)sqlite3_column_text(_statement, 11);
        char *hCExperience = (char *)sqlite3_column_text(_statement, 12);
        
        [datas addObject:[NSNumber numberWithInt:hID]];
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
-(NSMutableArray *)getTitleData:(int)titleId {
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from title where id = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        NSLog(@"编译失败");
        return datas;
    }
    sqlite3_bind_int(_statement, 1, titleId);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        int tID = sqlite3_column_int(_statement, 0);
        char *tCName = (char *)sqlite3_column_text(_statement, 1);
        int tHiero = sqlite3_column_int(_statement, 2);
        int tStudent = sqlite3_column_int(_statement, 3);
        int score = sqlite3_column_int(_statement, 4);
        [datas addObject:[NSNumber numberWithInt:tID]];
        [datas addObject:[NSString stringWithUTF8String:tCName]];
        [datas addObject:[NSNumber numberWithInt:tHiero]];
        [datas addObject:[NSNumber numberWithInt:tStudent]];
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
    char *sqlHiero = "select hieroId from title";
    sqlite3_prepare_v2(_database, sqlHiero, -1, &_statement, NULL);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        for (int i = 0; i<sqlite3_column_count(_statement); i++) {
            int ids = sqlite3_column_int(_statement, i);
            [hieros addObject:[NSNumber numberWithInt:ids]];
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
        sqlite3_bind_int(_statement, -1, (int)[hieros objectAtIndex:i]);
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
-(NSMutableArray *)getInterlayerData:(int)titleId{
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据
    [self openDataBase:[self getDataFilePath]];
    char *sql = "select * from interlayer where id = ?";
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        return datas;
    }
    sqlite3_bind_int(_statement, 1, titleId);
    while (sqlite3_step(_statement) == SQLITE_ROW) {
        int tID = sqlite3_column_int(_statement, 0);
        int hID = sqlite3_column_int(_statement, 1);
        int s1ID = sqlite3_column_int(_statement, 2);
        int s2ID = sqlite3_column_int(_statement, 3);
        int s3ID = sqlite3_column_int(_statement, 4);
        [datas addObject:[NSNumber numberWithInt:tID]];
        [datas addObject:[NSNumber numberWithInt:hID]];
        [datas addObject:[NSNumber numberWithInt:s1ID]];
        [datas addObject:[NSNumber numberWithInt:s2ID]];
        [datas addObject:[NSNumber numberWithInt:s3ID]];
    }
    
    return datas;
}

//更新学生数据
-(BOOL)updateStudentData:(int)StuId :(NSMutableString *)name :(NSMutableString *)password {
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "update student set name = ? and password = ? where id = ?";
    //编译
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    
    sqlite3_bind_text(_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 3, StuId);
    
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
-(BOOL)updateHieroData:(int)HieroId :(NSMutableString *)name :(NSMutableString *)password :(NSMutableString *)sex :(NSMutableString *)birthday :(NSMutableString *)PFT :(NSMutableString *)skills :(NSMutableString *)timeOfPFT :(NSMutableString *)workUnit :(NSMutableString *)positions :(int)phone :(NSMutableString *)email :(NSMutableString *)experience {
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    char *sql = "update hierophant set name = ? and password = ? and sex = ?  and birthday = ? and PFT = ? and skills = ? and timeOfPFT = ? and workUnit = ? and positions = ? and phone = ? and email = ? and experience = ? where id = ?";
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
    sqlite3_bind_text(_statement, 90, [positions UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 10, phone);
    sqlite3_bind_text(_statement, 11, [email UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(_statement, 12, [experience UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 13, HieroId);
    
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
-(BOOL)updateTitleData:(int)titleId :(NSMutableString *)name :(int)hieroId :(int)studentId :(int)score{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "update title set name = ? and hieroId = ? and studentId = ? and score = ? where id = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }
    sqlite3_bind_text(_statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(_statement, 2, hieroId);
    sqlite3_bind_int(_statement, 3, studentId);
    sqlite3_bind_int(_statement, 4, score);
    sqlite3_bind_int(_statement, 5, titleId);
    
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
-(BOOL)updateInterlayerData:(int)titleId :(int)student1Id :(int)student2Id :(int)student3Id{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "update interlayer set student1Id = ? and student2Id = ? and student3Id = ? where id = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return NO;
    }
    sqlite3_bind_int(_statement, 1, student1Id);
    sqlite3_bind_int(_statement, 2, student2Id);
    sqlite3_bind_int(_statement, 3, student3Id);
    sqlite3_bind_int(_statement, 4, titleId);
    
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
-(BOOL)deleteTitle:(int)titleId{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    char *sql = "delete from title where id = ?";
    
    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
        sqlite3_close(_database);
        return  NO;
    }

    sqlite3_bind_int(_statement, 1, titleId);
    
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

