//
//  RegistController.m
//  校外导师
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 柏涵. All rights reserved.
//

#import "RegistController.h"
#import "DataController.h"
#import <AFNetworking.h>
#import "ConnectURL.h"
#import "Student.h"
#import "Hierophent.h"
#import <SVProgressHUD.h>

@implementation RegistController {
    NSString *_name;
    NSString *_number;
    NSString *_password;
    //注册结果
    NSMutableArray *_result;
}

//注册
-(void)registWithName:(NSMutableString *)name number:(NSMutableString *)number password:(NSMutableString *)password {
    _name = name;
    _number = number;
    _password = password;
    [self registStu];
}

-(void)registStu {
    //连接服务器
    __block int r = 0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"RegisterServlet"];
    NSString *url = [ConnectURL shareURL];
    //设置对象
    Student *stu = [[Student alloc] init];
    stu.name = _name;
    stu.number = _number;
    stu.password = _password;
    NSDictionary *dic = stu.toDictionary;
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSMutableArray *result = [NSMutableArray array];
        if (responseObject) {
            r = (int)[[responseObject objectForKey:@"result"] integerValue];
        }
        if (r == 0) {
            [result insertObject:@NO atIndex:0];
        } else {
            //注册成功
            DataController *dataController = [[DataController alloc] init];
            [dataController insertStudentTable:(NSMutableString *)stu.name number:(NSMutableString *)stu.number password:(NSMutableString *)stu.password];
            [result insertObject:@YES atIndex:0];
        }
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registStu" object:result];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"获取失败");
    }];
}

-(void)registWithHieroName:(NSMutableString *)name password:(NSMutableString *)password sex:(NSMutableString *)sex birthday:(NSMutableString *)birthday PFT:(NSMutableString *)PFT skills:(NSMutableString *)skills timeOfPFT:(NSMutableString *)timeOfPFT workUnit:(NSMutableString *)workUnit positions:(NSMutableString *)positions phone:(NSMutableString *)phone email:(NSMutableString *)email experience:(NSMutableString *)experience {
    
    //连接服务器
    __block int r = 0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"HieroRegistServlet"];
    NSString *url = [ConnectURL shareURL];
    //创建对象
    Hierophent *hiero = [[Hierophent alloc] init];
    hiero.name = name;
    hiero.password = password;
    hiero.sex = sex;
    hiero.birthday = birthday;
    hiero.pft = PFT;
    hiero.skills = skills;
    hiero.timeOfPft = timeOfPFT;
    hiero.workUnit = workUnit;
    hiero.positions = positions;
    hiero.phone = phone;
    hiero.email = email;
    hiero.experience = experience;
    NSDictionary *dic = [hiero toDictionary];
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        NSMutableArray *result = [NSMutableArray array];
        if (responseObject) {
            r = (int)[[responseObject objectForKey:@"result"] integerValue];
        }
        if (r == 0) {
            [result insertObject:@NO atIndex:0];
        } else {
            //注册成功
            DataController *dataController = [[DataController alloc] init];
            [dataController insertHierophantTable:name password:password sex:sex birthday:birthday PFT:PFT skills:skills timeOfPFT:timeOfPFT workUnit:workUnit positions:positions phone:phone email:email experience:experience];
            [result insertObject:@YES atIndex:0];
        }
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registHiero" object:result];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
    }];
    
    
//    return result;
    
}

@end
