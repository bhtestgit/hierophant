//
//  DataController.m
//  校外导师
//
//  Created by 柏涵 on 16/3/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "DataController.h"
#import <sqlite3.h>
#import <FMDB.h>

@interface DataController(){
    FMDatabase *_db;
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
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isCreatTable"]) {
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
    
    _db = [FMDatabase databaseWithPath:dataFileName];
    return [_db open];
    
//    if (sqlite3_open([dataFileName UTF8String], &_database) == SQLITE_OK) {
//        return YES;
//    } else {
//        return NO;
//    }
}

//创建表
-(BOOL)createTable{
    //打开数据库
    BOOL r = [self openDataBase:[self getDataFilePath]];
//    char * zErr;
    
    NSString *stuSql = @"create table if not exists student(name text primary key, password text)";
    
    NSString *hieroSql = @"create table if not exists hierophant(name text primary key, password text, sex text, birthday text, PFT text, skills text, timeOfPFT text, workUnit text, positions text, phone int, email text, experience text)";
    
    NSString *titleSql = @"create table if not exists title(name text primary key, hieroId text, studentId text, score int)";
    NSString *interlayerSql = @"create table if not exists interlayer(name text primary key, hieroId text, student1Id text, student2Id text, student3Id text)";
    
    if ([_db executeUpdate:stuSql] == YES) {
        if ([_db executeUpdate:hieroSql] == YES) {
            if ([_db executeUpdate:titleSql] == YES) {
                if ([_db executeUpdate:interlayerSql] == YES) {
                    [_db close];
                    return YES;
                }
            }
        }
    }
    
    

//    if (sqlite3_exec(_database, stuSql, NULL, NULL, &zErr) == SQLITE_OK) {
//        if (sqlite3_exec(_database, hieroSql, NULL, NULL, &zErr) == SQLITE_OK) {
//            if (sqlite3_exec(_database, titleSql, NULL, NULL, &zErr) == SQLITE_OK) {
//                if (sqlite3_exec(_database, interlayerSql, NULL, NULL, &zErr) == SQLITE_OK) {
//                    sqlite3_close(_database);
//                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCreatTable"];
//                    return YES;
//                }
//            }
//        }
//    }
//    sqlite3_close(_database);
    
    [_db close];
    return NO;
}

//添加学生数据
-(BOOL)insertStudentTable:(NSMutableString *)name password:(NSMutableString *)password{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    NSString *sql = @"insert into student(name, password) values(?, ?)";
    
    if ([_db executeUpdate:sql,name, password]) {
        [_db close];
        return YES;
    }
    
    [_db close];
    return NO;
}

//添加老师数据
-(BOOL)insertHierophantTable:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(int)phone email:(NSMutableString *)email experience:(NSMutableString *)experience{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    
    NSString *sql = @"insert into hierophant(name, password, sex, birthday, PFT, skills, timeOfPFT, workUnit, positions, phone, email, experience) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    BOOL result = [_db executeUpdate:sql, name, password, self, birthday, PFT, skills, timeOfPFT, workUnit, positions, [NSNumber numberWithInt: phone], email, experience];
    
    return result;
}

//添加题目数据
-(BOOL)insertTitleTable:(NSMutableString *)name hieroId:(NSMutableString *)hieroId studentId:(NSMutableString *)studentId score:(int)score{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"insert into title values(?, ?, ?, ?)";
    
    BOOL result = [_db executeUpdate:sql, name, hieroId, studentId, score];
    
    return result;
}

//添加中间数据
-(BOOL)insertInterlayerTable:(NSMutableString *)titleId hieroId:(NSMutableString *)hieroId student1Id:(NSMutableString *)student1ID student2Id:(NSMutableString *)student2Id student3Id:(NSMutableString *)student3Id{
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"insert into interlayer(id, hieroId, student1Id, student2Id, student3Id) values(?, ?, ?, ?, ?)";
    
    BOOL result = [_db executeUpdate:sql, titleId, hieroId, student1ID, student2Id, student3Id];
    [_db close];
    return result;
    
    
//    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        sqlite3_close(_database);
//        return NO;
//    }
//    sqlite3_bind_text(_statement, 1, [titleId UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 2, [hieroId UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 3, [student1ID UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 4, [student2Id UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 5, [student3Id UTF8String], -1, SQLITE_TRANSIENT);
//    
//    int result = sqlite3_step(_statement);
//    sqlite3_finalize(_statement);
//    if (result != SQLITE_DONE) {
//        sqlite3_close(_database);
//        return NO;
//    }
//    sqlite3_close(_database);
//    return YES;
}

//获取学生数据
-(NSMutableArray *)getStudentData:(NSMutableString *)stuId{
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"select * from student where name = ?";
    
    FMResultSet *result = [_db executeQuery:sql, stuId];
    if ([result next]) {
        NSString *name = [result stringForColumnIndex:0];
        NSString *password = [result stringForColumnIndex:1];
        [datas addObject:name];
        [datas addObject:password];
    }
    
    return datas;
}
//获取老师数据
-(NSMutableArray *)getHierophantData:(NSMutableString *)hieroId {
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"select * from hierophant where name = ?";
    FMResultSet *result = [_db executeQuery:sql, hieroId];
    
    if ([result next]) {
        [datas addObject:[result stringForColumnIndex:0]];
        [datas addObject:[result stringForColumnIndex:1]];
        [datas addObject:[result stringForColumnIndex:2]];
        [datas addObject:[result stringForColumnIndex:3]];
        [datas addObject:[result stringForColumnIndex:4]];
        [datas addObject:[result stringForColumnIndex:5]];
        [datas addObject:[result stringForColumnIndex:6]];
        [datas addObject:[result stringForColumnIndex:7]];
        [datas addObject:[result stringForColumnIndex:8]];
        [datas addObject:[NSNumber numberWithInt:[result intForColumnIndex:9]]];
        [datas addObject:[result stringForColumnIndex:10]];
        [datas addObject:[result stringForColumnIndex:11]];
    }

    return datas;
}
//获取题目数据
-(NSMutableArray *)getTitleData:(NSMutableString *)titleId {
    NSMutableArray *datas = [NSMutableArray array];
    
    NSString *sql = @"select * from title where name = ?";
    datas= [NSMutableArray arrayWithArray:[self getTitleBySQL:sql message:titleId]];
    return datas;
}

-(NSMutableArray *)getTitleBySQL: (NSString *)sql message:(NSMutableString *)message{
    
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    
    FMResultSet *result = [_db executeQuery:sql, message];
    
    if ([result next]) {
        [datas addObject:[result stringForColumnIndex:0]];
        [datas addObject:[result stringForColumnIndex:1]];
        [datas addObject:[result stringForColumnIndex:2]];
        [datas addObject:[NSNumber numberWithInt:[result intForColumnIndex:3]]];
    }
    
//    int result = sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL);
//    //测试读取title
//    
//    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        //        NSLog(@"编译失败");
//        return datas;
//    }
//    sqlite3_bind_text(_statement, 1, [message UTF8String], -1, SQLITE_TRANSIENT);
//    while (sqlite3_step(_statement) == SQLITE_ROW) {
//        char *tCName = (char *)sqlite3_column_text(_statement, 0);
//        char *tHiero = (char *)sqlite3_column_text(_statement, 1);
//        char *tStudent = (char *)sqlite3_column_text(_statement, 2);
//        int score = sqlite3_column_int(_statement, 3);
//        [datas addObject:[NSString stringWithUTF8String:tCName]];
//        [datas addObject:[NSString stringWithUTF8String:tHiero]];
//        [datas addObject:[NSString stringWithUTF8String:tStudent]];
//        [datas addObject:[NSNumber numberWithInt:score]];
//    }
    
    return datas;
}

-(NSMutableArray *)getTitleByHiero:(NSMutableString *)hieroId {
    NSMutableArray *datas = [NSMutableArray array];
    
    NSString *sql = @"select * from title where hieroId = ?";
    datas = [NSMutableArray arrayWithArray:[self getTitleBySQL:sql message:hieroId]];
    return datas;
}

//获取所有题目信息
-(NSMutableArray *)getAllSubject {
//    NSMutableArray *datas = [NSMutableArray array];
    NSMutableArray *data = [NSMutableArray array];
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"select name from title";
    FMResultSet *result = [_db executeQuery:sql];
    int count = [result columnCount];
    if ([result next]) {
        for (int i = 0; i < count; i++) {
            [data addObject:[result stringForColumnIndex:i]];
        }
    }

    return data;
}

//获取中间数据
-(NSMutableArray *)getInterlayerData:(NSMutableString *)titleId{
    NSMutableArray *datas = [NSMutableArray array];
    //打开数据
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"select * from interlayer where name = ?";
    
    FMResultSet *result = [_db executeQuery:sql, titleId];
    if ([result next]) {
        [datas addObject:[result stringForColumnIndex:0]];
        [datas addObject:[result stringForColumnIndex:1]];
        [datas addObject:[result stringForColumnIndex:2]];
        [datas addObject:[result stringForColumnIndex:3]];
        [datas addObject:[result stringForColumnIndex:4]];
    }
    
//    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        return datas;
//    }
//    sqlite3_bind_text(_statement, 1, [titleId UTF8String], -1, SQLITE_TRANSIENT);
//    while (sqlite3_step(_statement) == SQLITE_ROW) {
//        char *tID = (char *)sqlite3_column_text(_statement, 0);
//        char *hID = (char *)sqlite3_column_text(_statement, 1);
//        char *s1ID = (char *)sqlite3_column_text(_statement, 2);
//        char *s2ID = (char *)sqlite3_column_text(_statement, 3);
//        char *s3ID = (char *)sqlite3_column_text(_statement, 4);
//        [datas addObject:[NSString stringWithUTF8String:tID]];
//        [datas addObject:[NSString stringWithUTF8String:hID]];
//        [datas addObject:[NSString stringWithUTF8String:s1ID]];
//        [datas addObject:[NSString stringWithUTF8String:s2ID]];
//        [datas addObject:[NSString stringWithUTF8String:s3ID]];
//    }
    
    return datas;
}

//更新学生数据
-(BOOL)updateStudentData:(NSMutableString *)name password:(NSMutableString *)password {
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    NSString *sql = @"update student set password = ? where name = ?";
    
    BOOL result = [_db executeUpdate:sql, password, name];
    
    return result;
}
//更新导师数据
-(BOOL)updateHieroData:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(int)phone email:(NSMutableString *)email experience:(NSMutableString *)experience{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    //语句
    NSString *sql = @"update hierophant set password = ? and sex = ?  and birthday = ? and PFT = ? and skills = ? and timeOfPFT = ? and workUnit = ? and positions = ? and phone = ? and email = ? and experience = ? where name = ?";
    BOOL result = [_db executeUpdate:sql, password, sex, birthday, PFT, skills, timeOfPFT, workUnit, positions, [NSNumber numberWithInt:phone], email, experience, name];
    
    return result;
}
//更新题目数据
-(BOOL)updateTitleData:(NSMutableString *)name hieroId:(NSMutableString *)hieroId studentId:(NSMutableString *)studentId score:(int)score{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"update title set hieroId = ? and studentId = ? and score = ? where name = ?";
    
    BOOL result = [_db executeUpdate:sql, hieroId, studentId,  [NSNumber numberWithInt:score], name];
    
    return result;
}
//更新中间数据
-(BOOL)updateInterlayerData:(NSMutableString *)titleId student1Id:(NSMutableString *)student1Id studnet2Id:(NSMutableString *)student2Id student3Id:(NSMutableString *)student3Id{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"update interlayer set student1Id = ? and student2Id = ? and student3Id = ? where name = ?";
    
    
    BOOL result = [_db executeUpdate:sql, student1Id, student2Id, student3Id, titleId];
    
    return result;
//    if (sqlite3_prepare_v2(_database, sql, -1, &_statement, NULL) != SQLITE_OK) {
//        sqlite3_close(_database);
//        return NO;
//    }
//    sqlite3_bind_text(_statement, 1, [student1Id UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 2, [student2Id UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 3, [student3Id UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(_statement, 3, [titleId UTF8String], -1, SQLITE_TRANSIENT);
//    
//    int result = sqlite3_step(_statement);
//    sqlite3_finalize(_statement);
//    if (result != SQLITE_DONE) {
//        sqlite3_close(_database);
//        return NO;
//    }
//    sqlite3_close(_database);
//    
//    return YES;
}
//删除题目
-(BOOL)deleteTitle:(NSMutableString *)titleId{
    //打开数据库
    [self openDataBase:[self getDataFilePath]];
    NSString *sql = @"delete from title where name = ?";
    
    BOOL result = [_db executeUpdate:sql, titleId];
    
    return result;
}

@end

