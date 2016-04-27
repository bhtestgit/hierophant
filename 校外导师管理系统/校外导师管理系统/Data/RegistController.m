//
//  RegistController.m
//  校外导师
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "RegistController.h"
#import "DataController.h"

@implementation RegistController

//注册
-(BOOL)registWithName:(NSMutableString *)name password:(NSMutableString *)password {
    //打开数据库
    DataController *dataController = [[DataController alloc] init];
    //保存数据
    BOOL result = [dataController insertStudentTable:name password:password];
    
    return result;
}

-(BOOL)registWithHieroName:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(int)phone email:(NSMutableString *)email experience:(NSMutableString *)experience {
    DataController *dataController = [[DataController alloc] init];
    
    BOOL result = [dataController insertHierophantTable:name password:password sex:sex birthday:birthday PFT:PFT skills:skills timeOfPFT:timeOfPFT workUnit:workUnit positions:positions phone:phone email:email experience:experience];
    return result;
    
}

@end
