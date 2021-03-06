//
//  DataController.h
//  校外导师
//
//  Created by 柏涵 on 16/3/6.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject

//自定义初始化
-(instancetype)init;

//添加学生数据
-(BOOL)insertStudentTable:(NSMutableString *)name number:(NSMutableString *)number password:(NSMutableString *)password;
//添加老师数据
-(BOOL)insertHierophantTable:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(NSMutableString *)phone email:(NSMutableString *)email experience:(NSMutableString *)experience;
//添加题目数据
-(BOOL)insertTitleTable:(NSMutableString *)name detail:(NSMutableString *)detail hieroId:(NSMutableString *)hieroId studentId:(NSMutableString *)studentId score:(int)score;
//添加中间层数据
-(BOOL)insertInterlayerTable:(NSMutableString *)titleId detail:(NSMutableString *)detail hieroId:(NSMutableString *)hieroId student1Id:(NSMutableString *)student1ID student2Id:(NSMutableString *)student2Id student3Id:(NSMutableString *)student3Id;
//获取学生数据
-(NSMutableArray *)getStudentData :(NSMutableString *)stuId;
//获取老师数据
-(NSMutableArray *)getHierophantData :(NSMutableString *)hieroId;
//获取题目数据
-(NSMutableArray *)getTitleData :(NSMutableString *)titleId;
-(NSMutableArray *)getTitleByHiero :(NSMutableString *)hieroId;
//获取所有题目信息
-(NSMutableArray *)getAllSubject;
//获取中间数据
-(NSMutableArray *)getInterlayerData :(NSMutableString *)titleId;
//更新学生数据
-(BOOL)updateStudentData:(NSMutableString *)name password:(NSMutableString *)password;
//更新老师数据
-(BOOL)updateHieroData:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(NSMutableString *)phone email:(NSMutableString *)email experience:(NSMutableString *)experience;
//更新题目数据
-(BOOL)updateTitleData:(NSMutableString *)name newName:(NSMutableString *)newName detail:(NSMutableString *)detail hieroId:(NSMutableString *)hieroId studentId:(NSMutableString *)studentId score:(int)score;
//更新中间数据
-(BOOL)updateInterlayerData:(NSMutableString *)titleId newName:(NSMutableString *)newName detail:(NSMutableString *)detail student1Id:(NSMutableString *)student1Id studnet2Id:(NSMutableString *)student2Id student3Id:(NSMutableString *)student3Id;
//删除题目
-(BOOL)deleteTitle :(NSMutableString *)titleId;
@end
