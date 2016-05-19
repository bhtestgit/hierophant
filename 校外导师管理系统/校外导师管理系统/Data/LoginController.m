//
//  LoginController.m
//  校外导师
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "LoginController.h"
#import "DataController.h"
#import "ConnectURL.h"
#import <AFNetworking.h>
#import "Student.h"
#import "Hierophent.h"
#import "ConnectURL.h"

@implementation LoginController

//返回0，1，2，3; 0为登陆失败，1为教务，2为校外导师，3为学生
-(int)login:(NSMutableString *)name password:(NSMutableString *)password {
    if ([name isEqualToString:@"master"] && [password isEqualToString:@"123456"]) {
        return 1;
    }
    //获取数据库
    DataController *dataController = [[DataController alloc] init];
    //获取数据
    NSMutableArray *studentMsg = [dataController getStudentData:name];
    NSMutableArray *hieroMsg = [dataController getHierophantData:name];
    //判断是否获取数据
    BOOL stuNotExist = [studentMsg isEqualToArray:[NSMutableArray array]];
    BOOL stuCountRigt = [name isEqualToString:[studentMsg firstObject]] && [password isEqualToString:[studentMsg objectAtIndex:1]];
    BOOL hieroNotExist = [hieroMsg isEqualToArray:[NSMutableArray array]];
    BOOL hieroCountRight = [name isEqualToString:[hieroMsg firstObject]] && [password isEqualToString:[hieroMsg objectAtIndex:1]];
    if (!stuNotExist && stuCountRigt) {
        //设置登陆信息
        [[NSUserDefaults standardUserDefaults] setObject:[studentMsg firstObject] forKey:@"userName"];
        return 3;
    } else if(!hieroNotExist && hieroCountRight) {
        //设置登陆信息
        [[NSUserDefaults standardUserDefaults] setObject:[hieroMsg firstObject] forKey:@"userName"];
        return 2;
    }
    //判断名字密码
    return 0;
}

@end
