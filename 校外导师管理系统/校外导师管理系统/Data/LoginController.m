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
#import <SVProgressHUD.h>
#import <CommonCrypto/CommonDigest.h>
#import "GetToken.h"

@implementation LoginController

//返回0，1，2，3; 0为登陆失败，1为教务，2为校外导师，3为学生
-(void)login:(NSMutableString *)name password:(NSMutableString *)password {
    if ([name isEqualToString:@"master"] && [password isEqualToString:@"123456"]) {
    }
    __block int r = 0;
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD show];
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
        [SVProgressHUD dismiss];
        NSMutableArray *result = [NSMutableArray array];
        if (responseObject) {
            //登录结果
            r = (int)[[responseObject objectForKey:@"result"] integerValue];
            if (r == 0) {
                [result insertObject:[NSNumber numberWithInt:0] atIndex:0];
            } else if (r == 1) {
                //教务
                [result insertObject:[NSNumber numberWithInt:1] atIndex:0];
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userName"];
                [[GetToken getToken] getTokenWithUid:name];
            } else if (r == 2) {
                //老师
                [result insertObject:[NSNumber numberWithInt:2] atIndex:0];
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userName"];
                [[GetToken getToken] getTokenWithUid:name];
            } else if (r == 3) {
                //学生
                [result insertObject:[NSNumber numberWithInt:3] atIndex:0];
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"userName"];
                [[GetToken getToken] getTokenWithUid:name];
            } else if (r == 4) {
                [result insertObject:[NSNumber numberWithInt:4] atIndex:0];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isLogin" object:result];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
    }];
}
@end
