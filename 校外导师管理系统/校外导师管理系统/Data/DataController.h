//
//  DataController.h
//  校外导师
//
//  Created by 柏涵 on 16/3/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject

//添加学生数据
-(BOOL)insertStudentTable:(int)StuId :(NSMutableString *)name :(NSMutableString *)password;
//添加老师数据
-(BOOL)insertHierophantTable:(int)HieroId :(NSMutableString *)name :(NSMutableString *)password :(NSMutableString *)sex :(NSMutableString *)birthday :(NSMutableString *)PFT :(NSMutableString *)skills :(NSMutableString *)timeOfPFT :(NSMutableString *)workUnit :(NSMutableString *)positions :(int)phone :(NSMutableString *)email :(NSMutableString *)experience;
//添加题目数据
-(BOOL)insertTitleTable:(int)titleId :(NSMutableString *)name :(int)hieroId :(int)studentId :(int)score;
//添加中间层数据
-(BOOL)insertInterlayerTable:(int)titleId :(int)hieroId :(int)student1ID :(int)student2Id :(int)student3Id;
//获取学生数据
-(NSMutableArray *)getStudentData :(int)stuId;
//获取老师数据
-(NSMutableArray *)getHierophantData :(int)hieroId;
//获取题目数据
-(NSMutableArray *)getTitleData :(int)titleId;
//获取所有题目信息
-(NSMutableDictionary *)getAllSubject;
//获取中间数据
-(NSMutableArray *)getInterlayerData :(int)titleId;
//更新学生数据
-(BOOL)updateStudentData :(int)StuId :(NSMutableString *)name :(NSMutableString *)password;
//更新老师数据
-(BOOL)updateHieroData :(int)HieroId :(NSMutableString *)name :(NSMutableString *)password :(NSMutableString *)sex :(NSMutableString *)birthday :(NSMutableString *)PFT :(NSMutableString *)skills :(NSMutableString *)timeOfPFT :(NSMutableString *)workUnit :(NSMutableString *)positions :(int)phone :(NSMutableString *)email :(NSMutableString *)experience;
//更新题目数据
-(BOOL)updateTitleData :(int)titleId :(NSMutableString *)name :(int)hieroId :(int)studentId :(int)score;
//更新中间数据
-(BOOL)updateInterlayerData :(int)titleId :(int)student1Id :(int)student2Id :(int)student3Id;
//删除题目
-(BOOL)deleteTitle :(int)titleId;
@end
