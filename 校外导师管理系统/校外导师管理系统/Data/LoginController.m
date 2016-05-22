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
#import <RongIMKit/RongIMKit.h>

@implementation LoginController

//返回0，1，2，3; 0为登陆失败，1为教务，2为校外导师，3为学生
-(void)login:(NSMutableString *)name password:(NSMutableString *)password {
    if ([name isEqualToString:@"master"] && [password isEqualToString:@"123456"]) {
    }
    __block int r = 0;
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //初始化manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //获取url
    [ConnectURL appendUrl:@"LonginServlet"];
    NSString *url = [ConnectURL shareURL];
    //初始化对象
    Student *stu = [[Student alloc] init];
    stu.name = name;
    stu.password = password;
    //将对象转换为json
    NSDictionary *dic = stu.toDictionary;
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSMutableArray *result = [NSMutableArray array];
        if (responseObject) {
            //登录结果
            r = (int)[[responseObject objectForKey:@"result"] integerValue];
            if (r == 0) {
                [result insertObject:[NSNumber numberWithInt:0] atIndex:0];
            } else if (r == 1) {
                //教务
                [result insertObject:[NSNumber numberWithInt:1] atIndex:0];
//                [self connectViewRongyunWithToken:[responseObject objectForKey:@"token"]];
            } else if (r == 2) {
                //老师
                [result insertObject:[NSNumber numberWithInt:2] atIndex:0];
                //设置登录信息
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userName"];
//                [self connectViewRongyunWithToken:[responseObject objectForKey:@"token"]];
                //连接融云
            } else if (r == 3) {
                //学生
                [result insertObject:[NSNumber numberWithInt:3] atIndex:0];
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userName"];
//                [self connectViewRongyunWithToken:[responseObject objectForKey:@"token"]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isLogin" object:result];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

-(void)connectViewRongyunWithToken:(NSString *)token {
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

@end
